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
