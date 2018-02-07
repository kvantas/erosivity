#' Create a hyetograph
#'
#' \code{hyet_create} uses precipitation and dates values to create a tibble
#' that represents the distribution of rainfall over time. Returns an error if:
#' \itemize{
#'  \item \code{prec} and \code{date} values don't have the same length.
#'  \item \code{prec} is not a numeric vector.
#'  \item \code{date} is not a POSIXct (times) vector.
#' }
#'
#' This function checks
#' the validity of precipitation and date values and returns an error if: a)
#' they don't have the same length, b) precipitation is not numeric or c) dates
#' is not POSIXct.
#'
#' @param dates a numeric vector of precipitation values
#' @param prec a POSIXct vector with dates values
#'
#' @return a tibble with the variables \code{dates} and \code{prec}
#' @export hyet_create
#'
#' @examples
#'
#' # create dates and precipitation values
#' dates <- seq(from = as.POSIXct(0, origin = "2018-01-01"),
#'                   length.out =  100,
#'                   by = "mins")
#' set.seed(1)
#' prec <-round(runif(100,0,10),1)
#'
#' # create hyetograph
#' hyet <- hyet_create(dates, prec)
#'
hyet_create <- function(dates, prec) {

  if (!is.null(dates)) {
    if (length(prec) != length(dates)) {
      stop("Error: `prec` and  `dates` lenghts must be equal.",
           call. = FALSE)
    }
    if (!lubridate::is.POSIXct(dates)) {
      stop("Error: `prec` must be a POSIXct vector.", call. = FALSE)
    }
  }
  if (!is.numeric(prec)) {
    stop("Error: `prec` must be a numeric vector.", call. = FALSE)
  }

  tibble::tibble(dates = dates, prec = prec)
}
