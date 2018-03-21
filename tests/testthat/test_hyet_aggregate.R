context("hyet_aggregate related tests")

test_that("hyet_aggregate returns errors", {

  # wrong time step
  expect_error(hyet_aggregate(prec5min, 0))
  expect_error(hyet_aggregate(prec5min, 1.2))

  # not valid hyetograph
  hyet <- tibble::tibble(date = c("a", "b"), prec = c(1, 2))
  expect_error(hyet_aggregate(hyet, 30))
})

test_that("hyet_aggregate summarises values", {
  hyet <- hyet_create(
    seq(
      from = as.POSIXct(0, origin = "2018-01-01 00:01", tz = "UTC"),
      length.out = 30,
      by = "mins"
    ),
    rep(1, 30)
  )

  # 30 minutes time-step returns one value equal to 30
  expect_true(nrow(hyet_aggregate(hyet, 30)) == 1)
  expect_true(hyet_aggregate(hyet, 30)[, 2] == 30)

  # 15 minutes time-step returns two values with sum equal to 30
  expect_true(nrow(hyet_aggregate(hyet, 15)) == 2)
  expect_true(sum(hyet_aggregate(hyet, 15)[, 2]) == 30)
})
