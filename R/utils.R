#' Check for a valid hyetograph
#' @noRd
hyet_check <- function(hyet) {
  # check for expected names and values
  suppressWarnings(
    if (!(tibble::is.tibble(hyet) & (all(names(hyet) %in% c("date", "prec"))) &
      lubridate::is.POSIXct(hyet$date) & is.numeric(hyet$prec))) {
      error_msg <- paste(
        "Error: `hyet` is not a valid hyetograph. Please use",
        "function `hyet_create`."
      )
      stop(error_msg, call. = FALSE)
    }
  )
}

#' Calculate rainfall energy
#' @noRd
rain_energy <- function(intensity) {
  if (is.null(intensity)) return(NA)
  0.29 * (1 - 0.72 * exp(-0.05 * intensity))
}

#' Calculate the maximum aggregated value in a hyetograph
#' @noRd
max_aggr <- function(hyet, time_step_minutes) {
  hyet_aggr <- util_aggr(hyet, time_step_minutes)
  max(hyet_aggr$prec)
}

#' Utility function for hyetograph aggregation
#' @noRd
util_aggr <- function(hyet, time_step_minutes) {

  # create aggredated date
  hyet$date <- lubridate::ceiling_date(
    hyet$date,
    paste0(time_step_minutes, " mins")
  )

  # group by date
  hyet <- dplyr::group_by(hyet, .data$date)

  # summarise values
  dplyr::summarise(hyet, prec = sum(.data$prec))
}
