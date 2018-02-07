context("hyet_remove_rep related tests")

test_that("hyet_remove_rep returns errors", {
  hyet <- list(c = "1", b = 2)
  expect_error(hyet_remove_rep(hyet_check(hyet)))
})


test_that("hyet_remove_rep change to NA non zero repeated values", {

  dates <- seq(from = as.POSIXct(0, origin = "2018-01-01"),
               length.out =  20,
               by = "5 mins")
  prec <- c(0, 0, 0, 0, 0.01, 0.2, 0.5, 0.21, 0.21, 0.21, 0.21, 0.21, 0.05, 0, 0,
            0.01, 0.01, 0, 0, 0)
  prec_exp <- c(0, 0, 0, 0, 0.01, 0.2, 0.5, 0.21, NA, NA, NA, NA, 0.05, 0, 0,
                0.01, NA, 0, 0, 0)
  hyet <- hyet_create(dates, prec)
  hyet_cl <- hyet_remove_rep(hyet)

  # remove repeated values
  expect_equal(object = hyet_cl$prec, expected = prec_exp)


})

