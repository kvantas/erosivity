#' @title  Compute raifall erosivity
#'
#' @description \code{prec_eros} computes erosivity values using an hyetograph
#' from the \code{hyet_create} function and its timestep.
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#' @param time_step hyetograph's time-step, integer
#' precipitation, boolean
#'
#' @return a tibble with erosive rainstorms values
#' @export hyet_erosivity
#'
#' @examples
#'
#' # load data
#' data(prec5min)
#'
#' # compute EI
#' time_step <- 5
#' ei_values <- prec5min %>%
#'  hyet_fill(time_step) %>%
#'  hyet_erosivity(time_step)
#'
hyet_erosivity <- function(hyet, time_step) {

  # check values ---------------------------------------------------------------
  if (!(time_step %in%  c(5, 10, 15, 30))) {
    stop("`time_step` must have one of the values: 5, 10, 15 or 30 minutes.",
         call. = FALSE)
  }
  hyet_check(hyet)

  # calc rolling-window sums ---------------------------------------------------
  step_per60 <- 60 / time_step

  # six hours sum
  hyet <- dplyr::mutate(hyet,
                        six_hr = hyet_window_sum(.data$prec, 6 * step_per60))

  # 15 minutes sum
  if (time_step == 5) {
    hyet <- dplyr::mutate(hyet,
                          fifteen_minutes = hyet_window_sum(.data$prec, 3))
  } else {
    hyet <- dplyr::mutate(hyet,
                          fifteen_minutes = NA)
  }

  # 30 minutes sum
  if (time_step != 30) {
    step_per30 <- 30 / time_step
    hyet <-
      dplyr::mutate(hyet,
                    thirty_minutes = hyet_window_sum(.data$prec, step_per30))
  } else {
    hyet <-  dplyr::mutate(hyet,
                           thirty_minutes = .data$prec)
  }

  # extract rain-storms  -------------------------------------------------------
  hyet <- dplyr::filter(hyet, .data$prec > 0)

  if (NROW(hyet) == 0) {
    stop("All precipitation values are zero or NA", call. = FALSE)
  }

  # use the 6-hours-no-precipitation rule to extract rain-storms
  hyet <-
    dplyr::mutate(hyet,
                  dif = c(time_step, diff(.data$date, units = "mins")),
                  new_storm = c(TRUE, utils::tail(.data$dif > 360, -1)),
                  storm = cumsum(.data$new_storm))

  # split rain-storms using the six-hour-less-than-1,27 mm rule
  hyet <- dplyr::group_by(hyet, .data$storm)
  hyet <-
    dplyr::mutate(hyet,
                  storm_time = cumsum(.data$dif) - .data$dif[1],
                  break_strorms = hyet_break(.data$storm_time, .data$six_hr))

  # ungroup storms and re-extract  storms
  hyet <- dplyr::ungroup(hyet)
  hyet <-
    dplyr::mutate(hyet,
                  extract_storm = cumsum(.data$new_storm | .data$break_strorms))

  # calulate rainfall energy
  hyet <- dplyr::mutate(hyet,
                        energy = rain_energy(.data$prec * step_per60))

  # calc EI and rain-storms statistics -----------------------------------------

  # group again storms
  hyet <- dplyr::group_by(hyet, .data$extract_storm)

  # return EI values
  dplyr::summarise(hyet,
                   start_date = min(.data$date),
                   end_date  = max(.data$date),
                   duration = difftime(.data$end_date, .data$start_date,
                                       units = "mins") + time_step,
                   cum_prec = sum(.data$prec),
                   max_i30 = max(.data$thirty_minutes) * 2,
                   max_prec_15_min = max(.data$fifteen_minutes),
                   max_prec = max(.data$prec),
                   erosivity = sum(.data$energy * .data$prec) * .data$max_i30)
}
