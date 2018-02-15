#' @title Replace repeated, non-zero, precipitation values with NA
#'
#' @description \code{hyet_remove_rep} sets to \code{NA} repeated values
#' precipitation values in a hyetograph. Returns an error if \code{hyet} is not
#' a valid hyetograph.
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#'
#' @return a tibble with the variables \code{dates} and \code{prec}
#' @export hyet_remove_rep
#'
#' @examples
#'
#' # create a hyetograph
#' dates <- seq(from = as.POSIXct(0, origin = "2018-01-01"),
#'                   length.out =  11,
#'                   by = "30 mins")
#' prec <- c(0.001, 0.2, 0.5, 0.21, 0.21, 0.21, 0.21, 0.21, 0.0005, 0, 0)
#' hyet <- hyet_create(dates, prec)
#'
#' # remove repeated values
#' hyet_remove_rep(hyet)
#'
hyet_remove_rep <- function(hyet) {

  # check parameters
  hyet_check(hyet)

  # replace consecutively, non-zero, repeated values with NA
  dplyr::mutate(
    hyet,
    prec = ifelse(c(FALSE, diff(.data$prec) == 0 & .data$prec[-1] != 0),
                  NA, .data$prec))

}
