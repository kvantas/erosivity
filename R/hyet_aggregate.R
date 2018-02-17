#' @title Aggregate a hyetofraph using a time step
#'
#' @description \code{hyet_aggregate} uses a predefined time step value to
#' aggregate precipitation records in a hyetograph
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#' @param time_step the time step value in minutes
#'
#' @return a tibble with the aggregated hyetograph
#' @export hyet_aggregate
#'
#' @examples
#'
#' prec30min <- prec5min %>% hyet_aggregate(30)
#'
hyet_aggregate <- function(hyet, time_step) {

  # check values
  hyet_check(hyet)
  if (! assertthat::is.count(time_step)) {
    stop("`time_step` must be a positive number.", call. = FALSE)
  }

  # create aggredated dates
  hyet$dates <- lubridate::ceiling_date(hyet$dates,
                                        paste0(time_step, " mins"))

  # group by dates
  hyet <- dplyr::group_by(hyet, .data$dates)

  # summarise values
  dplyr::summarise(hyet, prec = sum(.data$prec))

}
