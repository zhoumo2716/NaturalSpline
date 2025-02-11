library(testthat)
library(NaturalSpline)

test_that("C++ ns_matrix matches R full_A_matrix for multiple cases", {
  # Example 1: Simple evenly spaced x values
  x1 <- seq(1, 10, length.out = 10)  # Test case 1: 10 evenly spaced points
  m1 <- 3  # Extrapolation order
  A_R1 <- full_A_matrix(x1, m1)   # From R implementation
  A_Cpp1 <- ns_matrix(x1, m1)     # From C++ implementation
  
  # Example 2: Non-uniform x values
  x2 <- c(1, 3, 5, 7, 10, 12, 15, 18, 20, 22)  # Test case 2: Non-uniform spacing
  m2 <- 2  # Extrapolation order
  A_R2 <- full_A_matrix(x2, m2)   # From R implementation
  A_Cpp2 <- ns_matrix(x2, m2)     # From C++ implementation
  
  # Check dimensions
  expect_equal(dim(A_R1), dim(A_Cpp1), info = "Matrix dimensions should match for test case 1.")
  expect_equal(dim(A_R2), dim(A_Cpp2), info = "Matrix dimensions should match for test case 2.")
  
  # Check numerical values
  diff_matrix1 <- abs(A_R1 - A_Cpp1)
  diff_matrix2 <- abs(A_R2 - A_Cpp2)
  max_diff1 <- max(diff_matrix1)
  max_diff2 <- max(diff_matrix2)
  
  # Allow for small numerical tolerance
  expect_true(max_diff1 < 1e-10, info = paste("Max difference in test case 1:", max_diff1))
  expect_true(max_diff2 < 1e-10, info = paste("Max difference in test case 2:", max_diff2))
  
  # Print results for debugging
  cat("\nMax absolute difference between A_R1 and A_Cpp1:", max_diff1, "\n")
  cat("\nMax absolute difference between A_R2 and A_Cpp2:", max_diff2, "\n")
})
