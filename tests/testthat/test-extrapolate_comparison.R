test_that("extrapolate_noncompact matches extrapolate_compact", {
  # Inputs
  x <- c(1, 2, 2.5, 3, 4, 5)
  theta <- c(2.5, 2.5, 2.5, 3, 4, 4)
  m <- 3
  
  # Left boundary comparison
  result_noncompact_left <- extrapolate_noncompact(x, theta, m, side = "left")
  result_compact_left <- extrapolate_compact(x, theta, m, side = "left")
  expect_equal(result_noncompact_left, result_compact_left)
  
  # Right boundary comparison
  result_noncompact_right <- extrapolate_noncompact(x, theta, m, side = "right")
  result_compact_right <- extrapolate_compact(x, theta, m, side = "right")
  expect_equal(result_noncompact_right, result_compact_right)
})
