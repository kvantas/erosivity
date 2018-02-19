library(hydroscoper)

# get a 5 min step precipitation time series
prec5min <- get_data(subdomain = "kyy", time_id = 1431)
prec5min$Value <- ifelse(prec5min$Value < 0.01, 0, prec5min$Value)

prec5min$Comment <- NULL
names(prec5min) <-c("date", "prec")

devtools::use_data(prec5min, overwrite = TRUE)
