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
rain_energy <- function(intensity, en_equation = "brown_foster") {
  if (is.null(intensity)) return(NA)

  if (en_equation == "brown_foster") {
    0.29 * (1 - 0.72 * exp(-0.05 * intensity))
  } else if (en_equation == "wisch_smith") {
    if (intensity > 76) {
      0.283
    } else {
      0.119 + 0.0873 * log10(intensity)
    }
  } else if (en_equation == "mcgregor_mutch") {
    0.273 + 0.2168 * exp(-0.048 * intensity) - 0.4126 * exp(-0.072 * intensity)
  }
}

#' Calculate the maximum aggregated value in an hyetograph
#' @noRd
max_aggr <- function(hyet, time_step, units = "mins") {
  hyet_aggr <- util_aggr(hyet, time_step, units)
  max(hyet_aggr$prec)
}

#' Utility function for hyetograph aggregation
#' max_prec_1hr = max_aggr(hyet_create(.data$date, .data$prec), 60),

#' @noRd
util_aggr <- function(hyet, time_step_minutes, units = "mins") {

  # create aggredated date
  hyet$date <- lubridate::ceiling_date(
    hyet$date,
    paste(time_step_minutes, units)
  )

  # group by date
  hyet <- dplyr::group_by(hyet, .data$date)

  # summarise values
  dplyr::summarise(hyet, prec = sum(.data$prec))
}
