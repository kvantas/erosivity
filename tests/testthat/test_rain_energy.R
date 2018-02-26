context("rain_energy related tests")


test_that("rain_energy returns correct values", {

  # NA or NULL value return NA
  expect_true(is.na(rain_energy(NA)))
  expect_true(is.na(rain_energy(NULL)))

  # some values
  expect_equal(rain_energy(1), 0.0913833)
  expect_equal(rain_energy(0), 0.0812)
})
