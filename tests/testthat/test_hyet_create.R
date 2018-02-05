context("hyet_create related tests")

test_that("hyet_create returns errors", {

  # unequal lengths
  prec <- c(1.1, 2.1, 3.1)
  dates <- c("a", "b")
  expect_error(hyet_create(dates, prec, 5))

  # non numeric prec
  prec <- c("a", "b")
  expect_error(hyet_create(dates, prec, 5))

  # non POSIXct dates
  prec <- c(1.1, 2.1)
  expect_error(hyet_create(dates, prec, 5))

})
