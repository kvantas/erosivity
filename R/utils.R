#' Check for a valid hyetograph
#' @noRd
hyet_check <- function(hyet) {

  # check if hyet exists
  if (!exists(deparse(substitute(hyet)))) {
    stop("`hyet` does not exist. Please use the function `hyet_create` to create a hyetogrpah.", # nolint
         call. = FALSE)
  }

  # check for expected names and values
  suppressWarnings(
    if (!(tibble::is.tibble(hyet) & (all(names(hyet) %in% c("dates", "prec"))) &
          lubridate::is.POSIXct(hyet$dates) & is.numeric(hyet$prec))) {
      stop("`hyet` is not a valid hyetograph. Please use the function `hyet_create` to create one.", # nolint
           call. = FALSE)
    }
  )
}
