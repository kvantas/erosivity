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

#' calculate rainfall energy
#' @noRd
rain_energy <- function(intensity) {
  if (is.null(intensity)) return(NA)
  0.29 * (1 - 0.72 * exp(-0.05 * intensity))
}
