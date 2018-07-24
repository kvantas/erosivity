#' @title Aggregate a hyetograph using a time step
#'
#' @description \code{hyet_aggregate} uses a predefined time step value to
#' aggregate precipitation records in a hyetograph
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#' @param time_step an integer specifying the time step value.
#' @param units a character string specifying a time unit. Valid units are
#' "mins" and "hours"
#'
#' @return a tibble with the aggregated hyetograph
#' @export hyet_aggregate
#'
#' @examples
#'
#' prec30min <- prec5min %>% hyet_aggregate(30)
#'
hyet_aggregate <- function(hyet, time_step, units = "mins") {

  # check values
  hyet_check(hyet)
  if (!assertthat::is.count(time_step)) {
    stop("`time_step` must be a positive number.", call. = FALSE)
  }

  # check units
  valid_units <- c("mins", "hours")
  if (!(units %in% valid_units)) {
    stop("`units` must be either `mins` or `hours`.", call. = FALSE)
  }

  # check supported time_steps and units
  if (time_step > 60 & units == "mins") {
    stop("`time_step` > 60 is not supported for time units in `mins`.",
         call. = FALSE)
  }
  if (time_step > 24 & units == "hours") {
    stop("`time_step` > 24 is not supported for time units in `hours`.",
         call. = FALSE)
  }

  # call utility function
  util_aggr(hyet, time_step, units)
}
