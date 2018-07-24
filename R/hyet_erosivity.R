#' @title  Compute raifall erosivity
#'
#' @description \code{prec_eros} computes erosivity values using an hyetograph.
#'
#' @param hyet an hyetograph from \code{hyet_create} function. Precipitation
#' values must be in (mm).
#' @param time_step hyetograph's time-step in minutes. Must have one of the
#' values: \code{[5, 10, 15, 30]}.
#' @param en_equation a character string specifying the equation to be used
#' for calculating kinetic energy of rainfall. Must have one of the values:
#' \code{"brown_foster", "mcgregor_mutch", "wisch_smith"}.
#' Default value is \code{"brown_foster"}.
#'
#' The rainfall's kinetic energy equations are:
#' \itemize{
#' \item{\emph{Brown and Foster (1987)},
#'
#'       \eqn{e = 0.29(1 - 0.72  exp(-0.05i))}}
#' \item{\emph{McGregor and Mutchler (1976)},
#'
#'       \eqn{e = 0.273 + 0.2168exp(-0.048i) - 0.4126exp(-0.072i)}}
#' \item{\emph{Wischmeier and Smith (1958)},
#'
#'       \eqn{e = 0.119 + 0.0873 * log10(i)},
#'
#'       with the upper limit of 0.283  MJ/ha/mm if \eqn{i} > 76 mm/h.}
#' }
#' In the above equations \eqn{i} is rainfall intensity (mm/hr) and \eqn{e} is
#' the kinetic energy per unit of rainfall (MJ/ha/mm).
#'
#' @note \code{hyet} must not contain missing dates. Please use the
#' \code{hyet_fill} function before using \code{prec_eros}.
#'
#' @references
#' Brown, L. C., & Foster, G. R. (1987). Storm erosivity using idealized
#' intensity distributions. Transactions of the ASAE, 30(2), 379-0386.
#'
#' McGregor, K. C., Bingner, R. L., Bowie, A. J., & Foster, G. R. (1995).
#' Erosivity index values for northern Mississippi. Transactions of the ASAE,
#' 38(4), 1039-1047.
#'
#' Wischmeier, W. H., & Smith, D. D. (1958). Rainfall energy and its
#' relationship to soil loss. Eos, Transactions American Geophysical Union,
#' 39(2), 285-291.
#'
#' @return a tibble with values.
#'
#' @export hyet_erosivity
#'

#'
#' @examples
#'
#' # load libraries
#' library(dplyr)
#' library(tibble)
#'
#' # load data
#' data(prec5min)
#'
#' # remove near zero values
#' prec5min$prec <- round(prec5min$prec , 1)
#'
#' # compute EI
#' time_step <- 5
#' ei_values <- prec5min %>%
#'  hyet_fill(time_step) %>%
#'  hyet_erosivity(time_step)
#'
#'  # filter erosivity events based on total rainfall height
#'  ei_values %>%
#'   filter(cum_prec >= 12.7)
#'
hyet_erosivity <- function(hyet, time_step, en_equation = "brown_foster") {

  # check values ---------------------------------------------------------------
  if (!(time_step %in% c(5, 10, 15, 30))) {
    stop(
      "`time_step` must have one of the values: 1, 5, 10, 15 or 30 minutes.",
      call. = FALSE
    )
  }

  valid_equat <- c("brown_foster", "mcgregor_mutch", "wisch_smith")
  error_msg <- paste("`en_equation` must have one of the values:",
                     "`brown_foster`, `mcgregor_mutch`, `wisch_smith`")
  if (!(en_equation %in% valid_equat)) {
    stop(error_msg, call. = FALSE)
  }

  hyet_check(hyet)

  # calc rolling-window sums ---------------------------------------------------
  step_per60 <- 60 / time_step

  # six hours sum
  hyet <- dplyr::mutate(
    hyet,
    six_hr = hyet_window_sum(.data$prec, 6 * step_per60)
  )

  # 15 minutes sum
  if (time_step == 5) {
    hyet <- dplyr::mutate(
      hyet,
      fifteen_minutes = hyet_window_sum(.data$prec, 3)
    )
  } else if (time_step == 1) {
    hyet <- dplyr::mutate(
      hyet,
      fifteen_minutes = hyet_window_sum(.data$prec, 15)
    )
  } else {
    hyet <- dplyr::mutate(
      hyet,
      fifteen_minutes = NA
    )
  }

  # 30 minutes sum
  if (time_step != 30) {
    step_per30 <- 30 / time_step
    hyet <-
      dplyr::mutate(
        hyet,
        thirty_minutes = hyet_window_sum(.data$prec, step_per30)
      )
  } else {
    hyet <- dplyr::mutate(
      hyet,
      thirty_minutes = .data$prec
    )
  }

  # extract rain-storms  -------------------------------------------------------
  hyet <- dplyr::filter(hyet, .data$prec > 0)

  if (NROW(hyet) == 0) {
    stop("All precipitation values are zero or NA", call. = FALSE)
  }

  # use the 6-hours-no-precipitation rule to extract rain-storms
  hyet <- dplyr::mutate(
    hyet,
    dif = c(time_step, diff(.data$date, units = "mins")),
    new_storm = c(TRUE, utils::tail(.data$dif > 360, -1)),
    storm = cumsum(.data$new_storm)
  )

  # group storms
  hyet <- dplyr::group_by(hyet, .data$storm)

  # calculate breaks using the 1,27 mm rule
  hyet <- dplyr::mutate(
    hyet,
    break_storms = c(FALSE, utils::head(.data$six_hr < 1.27, -1))
  )

  # replace NA values of break_storms with FALSE
  hyet$break_storms <- dplyr::if_else(
    is.na(hyet$break_storms), FALSE, hyet$break_storms
  )

  # ungroup storms and re-extract  storms
  hyet <- dplyr::ungroup(hyet)
  hyet <-
    dplyr::mutate(
      hyet,
      extract_storm = cumsum(.data$new_storm | .data$break_storms)
    )

  # calulate rainfall energy
  hyet <- dplyr::mutate(
    hyet,
    energy = rain_energy(.data$prec * step_per60, en_equation)
  )

  # calc EI and rain-storms statistics -----------------------------------------

  # group using breaked storms
  hyet <- dplyr::group_by(hyet, .data$extract_storm)

  # return EI values
  dplyr::summarise(
    hyet,
    start_date = min(.data$date),
    end_date = max(.data$date),
    duration = difftime(
      .data$end_date, .data$start_date,
      units = "mins"
    ) + time_step,
    cum_prec = sum(.data$prec),
    max_i30 = max(.data$thirty_minutes) * 2,
    max_prec_15min = max(.data$fifteen_minutes),
    max_prec = max(.data$prec),
    max_agr_1hr = max_aggr(hyet_create(.data$date, .data$prec),time_step =  1,
                           units = "hours"),
    max_agr_3hr = max_aggr(hyet_create(.data$date, .data$prec),time_step =  3,
                           units = "hours"),
    erosivity = sum(.data$energy * .data$prec) * .data$max_i30
  )
}
