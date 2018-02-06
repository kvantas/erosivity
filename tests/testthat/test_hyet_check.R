context("hyet_check related tests")

test_that("hyet_check returns errors", {

  # not a tibble
  hyet <- list(c = "1", b = 2)
  expect_error(hyet_check(hyet))

  # a tibble without dates
  hyet <- tibble::tibble(fates = 1:4, prec = 1:4)
  expect_error(hyet_check(hyet))

  # a tibble without prec
  hyet <- tibble::tibble(dates = 1:4, xrec = 1:4)
  expect_error(hyet_check(hyet))

  # dates are not POSIXct
  hyet <- tibble::tibble(dates = 1:4, prec = 1:4)
  expect_error(hyet_check(hyet))

  # prec is not numeric
  hyet <- tibble::tibble(
    dates = seq(from = as.POSIXct(0, origin = "2018-01-01"), length.out =  4,
                by = "mins"),
    prec = c("a", "b", "c", "d"))
  expect_error(hyet_check(hyet))

})

test_that("hyet_check returns NULL", {

  # all ok
  hyet2 <- tibble::tibble(
    dates = seq(from = as.POSIXct(0, origin = "2018-01-01"), length.out =  4,
                by = "mins"),
    prec = 1:4)
  expect_null(hyet_check(hyet2))

})
