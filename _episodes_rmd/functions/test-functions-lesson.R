# read the file with the functions we want to test
source('./functions-lesson.R')

# Test for custom_mean
test_that('Testing the custom_mean function', {
  a = c(1, 2, 3)
  expect_that(custom_mean(a), equals(2))
})

# Test for center
test_that('Testing the center function', {
  z <- c(0, 0, 0, 0)
  centered = center(z, 3)
  expect_that(centered, equals(rep(3, 4)))
  # testing the standard deviation
  expect_that(sd(centered), equals(sd(z)))
})

test_that('Testing the kelvin_to_celsius error message', {
  # aboslut zero
  expect_equal(kelvin_to_celsius(temp_k = 273.15), 0)
  # testing whether an error is given in case we use character
  expect_error(kelvin_to_celsius("a"), "Numeric input required")
  # testing whether an error is given in case we use temp below absolute zero
  expect_error(kelvin_to_celsius(temp_k = -10),
               "Can not process temperatures below absolute zero")
  expect_error(kelvin_to_celsius(temp_k = -0.0001),
               "Can not process temperatures below absolute zero")
})
