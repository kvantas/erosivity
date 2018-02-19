#' @title Fill a hyetograph with missing date values
#'
#' @description  \code{hyet_fill} fills missing date values in a hyetograph
#' with NA values.  Returns an error if \code{hyet} is not a valid hyetograph or
#' \code{time_step} is a not a numeric value.
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#' @param time_step hyetograph's time-step
#'
#' @return a tibble with the variables \code{date} and \code{prec}
#' @export hyet_fill
#'
#' @examples
#'
#' # create date and precipitation values using 5 minutes time-step
#' prec_date <- seq(from = as.POSIXct(0, origin = "2018-01-01"),
#'                   length.out =  100,
#'                   by = "5 mins")
#' set.seed(1)
#' prec_values <-round(runif(100,0,10),1)
#'
#' # create hyetograph
#' hyet <- hyet_create(prec_date, prec_values)
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
  empty_ts <- tibble::tibble(date = seq(from = min(hyet$date),
                                         to   = max(hyet$date),
                                         by   = paste0(time_step, " mins")))
  # merge time series
  dplyr::left_join(empty_ts, hyet, by = "date")

}
