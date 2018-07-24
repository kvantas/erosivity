context("hyet_erosivity related tests")

test_that("hyet_erosivity returns errors", {
  hyet <- list(a = 1, b = "a")
  expect_error(hyet_erosivity(hyet, 5))
  expect_error(hyet_erosivity(prec5min, "a"))

  # time-step not in c(1, 5, 10, 15, 30)
  expect_error(hyet_erosivity(prec5min, 60))

  # en_equation not in  c("brown_foster", "mcgregor_mutch", "wisch_smith")
  expect_error(hyet_erosivity(prec5min, 5, "other"))

})

test_that("hyet_erosivity returns error if all precipitation values are zero", {
  date <- seq(
    from = as.POSIXct(0, origin = "2018-01-01"),
    length.out = 12,
    by = "30 mins"
  )
  prec <- rep(0, 12)

  expect_error(hyet_erosivity(hyet_create(date, prec), 30))
})

test_that("hyet_erosivity returns correct values for a given rainstorm", {

  # create hyetograph

  prec <- c(1.1, 2.3, 3.2, 1.9, 4.1, 5.9, 2.5, 3.1, 2.9, 1.2, 0.5, 0.2)
  date <- seq(
    from = as.POSIXct(0, origin = "2018-01-01"),
    length.out = 12,
    by = "30 mins")

  hyet <- hyet_create(date, prec)

  # compute EI values
  ei_values <- hyet_erosivity(hyet, 30)

  # check values
  expect_equal(as.numeric(ei_values$duration, units = "mins"), 360)
  expect_equal(ei_values$cum_prec, sum(prec))
  expect_equal(ei_values$max_i30, max(prec)*2)

  ei <- sum(prec * rain_energy(intensity = prec * 2)) * max(prec)*2
  expect_equal(ei_values$erosivity, ei)

})
