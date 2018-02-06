context("hyet_fill related tests")

test_that("hyet_fill returns error", {

  time_step <- "a"
  expect_error(hyet_fill(prec5min, time_step))

})

test_that("hyet_fill fills time series", {

  # create time series with 10 minutes time step
  time_step <- 10

  hyet <- tibble::tibble(
    dates = seq(from = as.POSIXct(0, origin = "2018-01-01"), length.out =  100,
                by = paste(time_step, "mins")),
    prec = runif(100, 0, 5))

  # remove some records
  hyet_miss <-  hyet[-c(2:10, 14, 31, 70:80), ]

  # fill time series
  hyet_filled <- hyet_fill(hyet_miss, 10)

  # dates must match
  expect_equal(object = hyet_filled$dates, expected = hyet$dates)


})
