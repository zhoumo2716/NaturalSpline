test_that("Extrapolation handles basic erros such invalid inputs", {
  x <- c(1, 2, 3, 4)
  theta <- c(1, 2, 3, 4)
  m <- 2
  
  # Test for invalid side
  expect_error(extrapolate_noncompact(x, theta, m, side = "invalid"))
  
  # Test for m >= n / 2
  expect_error(extrapolate_noncompact(x, theta, m = 3, side = "left"))
  
  # Test for mismatched lengths
  expect_error(extrapolate_noncompact(c(1, 2, 3), theta, m, side = "left"))
  
  # Dummy test with constant values
  x <- c(1, 2, 3, 4)
  theta <- c(5, 5, 5, 5)
  m <- 2
  result_left <- extrapolate_noncompact(x, theta, m, side = "left")
  result_right <- extrapolate_noncompact(x, theta, m, side = "right")
  expect_equal(result_left, rep(5, m))
  expect_equal(result_right, rep(5, m))
})
