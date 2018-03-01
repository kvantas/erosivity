#' @title Aggregate a hyetograph using a time step
#'
#' @description \code{hyet_aggregate} uses a predefined time step value to
#' aggregate precipitation records in a hyetograph
#'
#' @param hyet a hyetograph from \code{hyet_create} function
#' @param time_step_minutes the time step value in minutes
#'
#' @return a tibble with the aggregated hyetograph
#' @export hyet_aggregate
#'
#' @examples
#'
#' prec30min <- prec5min %>% hyet_aggregate(30)
#'
hyet_aggregate <- function(hyet, time_step_minutes) {

  # check values
  hyet_check(hyet)
  if (!assertthat::is.count(time_step_minutes)) {
    stop("`time_step` must be a positive number.", call. = FALSE)
  }

  # create aggredated date
  hyet$date <- lubridate::ceiling_date(
    hyet$date,
    paste0(time_step_minutes, " mins")
  )

  # group by date
  hyet <- dplyr::group_by(hyet, .data$date)

  # summarise values
  dplyr::summarise(hyet, prec = sum(.data$prec))
}
