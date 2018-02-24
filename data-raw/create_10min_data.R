# HER;201001010020;0

tm_format <- "%Y%m%d%H%M"
prec10min <- readr::read_delim(file = "./data-raw/HER01.txt",
                        delim = ";",
                        col_names = c("station_id", "date", "prec"),
                        col_types = list(
                          readr::col_character(),
                          readr::col_datetime(format = tm_format),
                          readr::col_double()))

prec10min$station_id <- NULL

devtools::use_data(prec10min, overwrite = TRUE)
