context("max_aggr related tests")


test_that("max_aggr return correct values", {
  hyet <- hyet_create(
    seq(
      from = as.POSIXct(0, origin = "2018-01-01 00:01", tz = "UTC"),
      length.out = 30,
      by = "mins"
    ),
    1:30
  )

  expect_equal(max_aggr(hyet, 5), sum(26:30))
  expect_equal(max_aggr(hyet, 10), sum(21:30))

})
