context("hyet_erosivity related tests")

test_that("hyet_erosivity returns errors", {
  hyet <- list(a = 1, b = "a")
  expect_error(hyet_erosivity(hyet, 5))
  expect_error(hyet_erosivity(prec5min, "a"))

  # time-step not in [5, 10, 15, 30]
  expect_error(hyet_erosivity(prec5min, 60))
})

test_that("hyet_erosivity returns error if all precipitation values are zero", {
  date <- seq(
    from = as.POSIXct(0, origin = "2018-01-01"),
    length.out = 100,
    by = "5 mins"
  )
  prec <- rep(0, 100)

  expect_error(hyet_erosivity(hyet_create(date, prec), 5))
})


test_that("hyet_erosivity returns correct events for a give rainstorm", {
  hyet <- hyet_fill(prec10min, 10)

  test1 <- dplyr::filter(
    hyet,
    date >= "2010-01-17 00:00:00 UTC" & date <= "2010-01-18 14:00:00 UTC"
  )

  # expect a tibble
  expect_is(hyet_erosivity(test1, 10), "tbl_df")

  eros_10min <- hyet_erosivity(test1, 10)

  # expected values
  eros_10min <- subset(eros_10min, cum_prec >= 12.7)
  expect_true(nrow(eros_10min) == 1)

  skip_on_cran()
  skip_on_appveyor()
  skip_on_travis()
  expect_equal(eros_10min$max_i30, 58.8)

  skip_on_cran()
  skip_on_appveyor()
  skip_on_travis()
  expect_equal(eros_10min$cum_prec, 46.4)

  skip_on_cran()
  skip_on_appveyor()
  skip_on_travis()
  expect_equal(round(eros_10min$erosivity), 630)
})
