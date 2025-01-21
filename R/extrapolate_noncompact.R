#' Extrapolate Non-Compact
#'
#' Computes the extrapolated points by generating the A matrix using x and theta.
#' @param x Numeric vector of x-values (ordered).
#' @param theta Numeric vector of theta values corresponding to x.
#' @param m Integer, degree of the polynomial extrapolation.
#' @param side Character, "left" or "right" boundary extrapolation.
#' @return A numeric vector of extrapolated points.
#' @export
extrapolate_noncompact <- function(x, theta, m, side = "left") {
  # Validate inputs
  n <- length(x)
  if (m > n / 2) stop("m must be less than or equal to half the length of x")
  
  # Select target and support points
  if (side == "left") {
    x_target <- x[1:m]
    x_support <- x[(m + 1):(2 * m)]
    theta_support <- theta[(m + 1):(2 * m)]
  } else if (side == "right") {
    x_target <- x[(n - m + 1):n]
    x_support <- x[(n - 2 * m + 1):(n - m)]
    theta_support <- theta[(n - 2 * m + 1):(n - m)]
  } else {
    stop("Invalid side. Choose 'left' or 'right'.")
  }
  
  # Compute the A matrix using compute_A_matrix
  A <- compute_A_matrix(x_target, x_support)
  
  # Compute the extrapolated points
  result <- A %*% theta_support
  
  # Return the result as a vector
  return(as.vector(result))
}
