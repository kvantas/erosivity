#' Five minutes precipitation time series
#'
#' This time series come from the a wether station from the Greek National Data
#' Bank for Hydrological and Meteorological Information, Hydroscope.
#' Precipitation's units of measurement is in mm and the time step is five
#' minutes.
#'
#' @format A data frame with 48,209 rows and 2 variables:
#' \describe{
#'   \item{date}{The time series' dates}
#'   \item{prec}{precipitation, in mm}
#' }
#' @source \url{http://kyy.hydroscope.gr/timeseries/d/1432/}
"prec5min"

#' Ten minutes precipitation time series
#'
#' This time series come from a weather station in Switzerland (station ID, HER).
#' Precipitation's units of measurement is in mm and the time step is ten
#' minutes.
#'
#' @format A data frame with 52,116 rows and 2 variables:
#' \describe{
#'   \item{date}{The time series' dates}
#'   \item{prec}{precipitation, in mm}
#' }
#' @source Meusburger, K., Steel, A., Panagos, P., Montanarella, L., Alewell, C.
#' Spatial and temporal variability of rainfall erosivity factor for Switzerland.
#'  Hydrology and Earth System Sciences, 16, 167-177, 2012, URL:
#' \url{https://esdac.jrc.ec.europa.eu/content/spatial-and-temporal-variability-rainfall-erosivity-factor-switzerland}
"prec10min"
