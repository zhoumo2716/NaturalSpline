test_that("extrapolate_noncompact matches hand-calculated values", {
  x2 <- c(1, 2, 2, 3, 4, 5)
  theta2 <- c(2.5, 2.5, 2.5, 3, 4, 4)
  m1 <- 1
  m2 <- 2
  m3 <- 3
  
  expected_left1 <- c(2.5)
  expected_right1 <- c(4)
  
  result_left1 <- extrapolate_compact(x, theta, m1, side = "left")
  expect_equal(result_left1, expected_left1)
  result_right1 <- extrapolate_compact(x, theta, m1, side = "right")
  expect_equal(result_right1, expected_right1)
  
  result_left1_ <- extrapolate_noncompact(x, theta, m1, side = "left")
  expect_equal(result_left1_, expected_left1)
  result_right1_ <- extrapolate_noncompact(x, theta, m1, side = "right")
  expect_equal(result_right1_, expected_right1)
  
  expected_left2 <- c(1, 2)
  expected_right2 <- c(4, 5)
  
  result_left2 <- extrapolate_compact(x, theta, m2, side = "left")
  expect_equal(result_left2, expected_left2)
  result_right2 <- extrapolate_compact(x, theta, m2, side = "right")
  expect_equal(result_right2, expected_right2)
  
  result_left2_ <- extrapolate_noncompact(x, theta, m2, side = "left")
  expect_equal(result_left2_, expected_left2)
  result_right2_ <- extrapolate_noncompact(x, theta, m2, side = "right")
  expect_equal(result_right2_, expected_right2)
  
  expected_left3 <- c(-2, 1, 2.125)
  expected_right3 <- c(2.5,2.5,2.5)
  
  result_left3 <- extrapolate_compact(x, theta, m3, side = "left")
  expect_equal(result_left3, expected_left3)
  result_right3 <- extrapolate_compact(x, theta, m3, side = "right")
  expect_equal(result_right3, expected_right3)
  
  result_left3_ <- extrapolate_noncompact(x, theta, m3, side = "left")
  expect_equal(result_left3_, expected_left3)
  result_right3_ <- extrapolate_noncompact(x, theta, m3, side = "right")
  expect_equal(result_right3_, expected_right3)
  
  
})
