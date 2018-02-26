#' @title  Calculate rolling window sum
#'
#' @description \code{hyet_window_sum} computes the rolling sum of precipitation
#' values.  Returns an error if \code{prec} is not a numeric vector or
#' \code{rolling_window} not a positive integer.
#'
#'
#' @param prec a vector with precipitation values
#' @param rolling_window the rolling window as a number of time steps.
#'
#' Computing time depends on \code{rolling_window}. \code{hyet_window_sum}
#' use R's base \code{rowSums} function with \code{na.rm = TRUE}.
#'
#' @return a numeric vector with summed precipitation values. These values are
#' filled with NAs at the end.
#'
#' @export hyet_window_sum
#'
#' @examples
#'
#' # load data
#' data(prec5min)
#'
#' # fill hyetograph
#' hyet <- hyet_fill(prec5min, 5)
#'
#' # set rolling window sum to 6 values
#' rolling_window <- 6
#'
#' # compute values
#' hyet_window_sum(hyet$prec, rolling_window)
hyet_window_sum <- function(prec, rolling_window) {

  # check prec values
  if (!is.numeric(prec[stats::complete.cases(prec)])) {
    stop("`prec` must be numeric vector.", call. = FALSE)
  }

  # check rolling window value
  if (!assertthat::is.count(rolling_window)) {
    stop("`rolling_window` must be a positive integer.", call. = FALSE)
  }

  append(
    rowSums(stats::embed(prec, rolling_window), na.rm = TRUE),
    rep(NA, rolling_window - 1)
  )
}
