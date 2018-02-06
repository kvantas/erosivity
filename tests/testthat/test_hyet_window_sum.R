context("hyet_window_sum related tests")

test_that("hyet_window_sum returns errors", {

  prec <- c("a", "b")
  win <- 2
  expect_error(hyet_window_sum(prec, win))

  prec <- 1:5
  win <- -1
  expect_error(hyet_window_sum(prec, win))

})

test_that("hyet_window_sum returns summed values", {

  # using time windows = 1 returns the same prec values
  prec <- 1:5
  win <- 1
  expect_equal(hyet_window_sum(prec, win), prec)

  # time window = 2
  prec <- 1:10
  win <- 2
  exp_prec <- c(seq(from = 3, to = 19, by = 2), NA)
  expect_equal(hyet_window_sum(prec, win), exp_prec)

  # time window = 3
  win <- 3
  exp_prec <- c(seq(from = 6, to = 27, by = 3), NA, NA)
  expect_equal(hyet_window_sum(prec, win), exp_prec)

})
