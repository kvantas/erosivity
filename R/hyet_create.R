#' Create a hyetograph
#'
#' \code{hyet_create} uses precipitation and dates values to create a tiblle
#' that represents the distribution of rainfall over time. This function checks
#' the validity of precipitation and date values and returns an error if: a)
#' they don't have the same length, b) precipitation is not numeric or c) dates
#' is not POSIXct.
#'
#' @param prec_dates a numeric vector of precipitation values
#' @param prec_values a POSIXct vector with dates values
#'
#' @return a tibble
#' @export hyet_create
#'
#' @examples
#'
#' # create dates and precipitation values
#' prec_dates <- seq(from = as.POSIXct(0, origin = "2018-01-01"),
#'                   length.out =  100,
#'                   by = "mins")
#' set.seed(1)
#' prec_values <-round(runif(100,0,10),1)
#'
#' # create hyetograph
#' hyet <- hyet_create(prec_dates, prec_values)
#'
hyet_create <- function(prec_dates, prec_values) {

  if(!is.null(prec_dates)) {
    if (length(prec_values) != length(prec_dates)) {
      stop("prec_values and  prec_dates lenghts must be equal.")
    }
    if (!lubridate::is.POSIXct(prec_dates)) {
      stop("prec_values must be a POSIXct vector.")
    }
  }
  if (!is.numeric(prec_values)) {
    stop("prec_values must be a numeric vector.")
  }

  tibble::tibble(dates = prec_dates, prec = prec_values)
}
