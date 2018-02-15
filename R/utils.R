#' Check for a valid hyetograph
#' @noRd
hyet_check <- function(hyet) {
  # check for expected names and values
  suppressWarnings(
    if (!(tibble::is.tibble(hyet) & (all(names(hyet) %in% c("dates", "prec"))) &
          lubridate::is.POSIXct(hyet$dates) & is.numeric(hyet$prec))) {

      error_msg <- paste("Error: `hyet` is not a valid hyetograph. Please use",
                         "function `hyet_create`.")
      stop(error_msg, call. = FALSE)

    }
  )
}

#' find breaks to divide rainstorms using the six-hours < 1.27 mm precipitation
#' rule from hyetographs time and six hours window sum
#' @noRd
hyet_break <- function(storm_time, six_hr){

  # find duration in storm_time
  duration <- utils::tail(storm_time, 1)

  # vector to return
  n_values <- length(storm_time)
  hyet_breaks <- rep(FALSE, n_values)

  # don't search for breaks if duration is less than 6 hours
  if (duration <= 360) {
    return(hyet_breaks)
  }

  # helper vars
  breaks <- 0
  i <- 1

  # add a break if a six hours cumulative value < 1.27 is found
  repeat {
    if (i > n_values) break ()
    if (six_hr[i] < 1.27) {
      breaks <- breaks + 1
      # find which index corresponds to the next break
      i <- which(storm_time > breaks * 360)[1]
      # add a break only if can be within the storms time values
      if (is.na(i)) break ()
      hyet_breaks[i] <- TRUE
    } else {
      i <- i + 1
    }
  }
  hyet_breaks
}

#' window sum function without checks for use in `hyet_eros` function
#' @noRd
window_sum <- function(prec, rolling_window){
  append(rowSums(stats::embed(prec, rolling_window), na.rm = TRUE),
         rep(NA, rolling_window - 1))
}
