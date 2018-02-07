#' Fill a hyetograph with missing dates values
#'
#' \code{hyet_fill} fills missing dates values in a hyetograph with NA values.
#' Returns an error if \code{hyet} is not a valid hyetograph or
#' \code{time_step} is a not a numeric value.
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#' @param time_step a numeric value
#'
#' @return a tibble with the variables \code{dates} and \code{prec}
#' @export hyet_fill
#'
#' @examples
#'
#' # create dates and precipitation values using 5 minutes time-step
#' prec_dates <- seq(from = as.POSIXct(0, origin = "2018-01-01"),
#'                   length.out =  100,
#'                   by = "5 mins")
#' set.seed(1)
#' prec_values <-round(runif(100,0,10),1)
#'
#' # create hyetograph
#' hyet <- hyet_create(prec_dates, prec_values)
#'
#' # remove some random values from hyetograph
#' hyet_miss <- hyet[-sample(100,30), ]
#'
#' # fill hyetograph
#' hyet_fill(hyet_miss, 5)

hyet_fill <- function(hyet, time_step) {

  # check parameters
  hyet_check(hyet)

  if (! assertthat::is.count(time_step)) {
    stop("`time_step` must be a positive number.", call. = FALSE)
  }

  # create an empty time series
  empty_ts <- tibble::tibble(dates = seq(from = min(hyet$dates),
                                         to   = max(hyet$dates),
                                         by   = paste0(time_step, " mins")))
  # merge time series
  dplyr::left_join(empty_ts, hyet, by = "dates")

}
