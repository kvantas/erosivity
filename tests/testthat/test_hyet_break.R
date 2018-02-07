context("hyet_break related tests")


test_that("hyet_window_sum returns summed values", {

  # single values return FALSE
  storm_time <- 0
  six_hr <- 0
  expect_false(hyet_break(six_hr, storm_time))

  # a storm with duration of 6 hours does not break
  storm_time <- seq(0, 360, 30)
  six_hr <- rep(0.01, 13)
  expect_false(any(hyet_break(storm_time, six_hr)))

  # a rainstorm  of 720 minutes duration with one break at t = 365
  storm_time <- seq(0, 720, 5)
  six_hr <- rep(0.0, 145)

  breaks <- hyet_break(storm_time, six_hr)
  expect_equal(storm_time[which(breaks)], 360 + 5)

  # a rainstorm of one day duration without breaks
  storm_time <- seq(30, 24*60, 30)
  six_hr <- runif(48, 1.27, 1.5)
  expect_false(any(hyet_break(storm_time, six_hr)))

  # a rainstorm of one day duration with 3 breaks
  storm_time <- seq(30, 24*60, 30)
  six_hr <- rep(1, 48)

  brk_index <- which(hyet_break(storm_time, six_hr))
  expect_equal(storm_time[brk_index], seq(360, 1090, 360) + 30)

})
