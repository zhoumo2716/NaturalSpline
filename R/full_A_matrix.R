#' Compute Full A Matrix
#'
#' Constructs the full A matrix combining left and right boundary extrapolations.
#' @param x Numeric vector of x-values (ordered).
#' @param m Integer specifying the extrapolation order.
#' @return A full A matrix (n x n).
#' @export
full_A_matrix <- function(x, m) {
  n <- length(x)
  if (m > n / 2) stop("m must be less than or equal to half the length of x")
  
  x_target_left <- x[1:m]
  x_support_left <- x[(m + 1):(2 * m)]
  x_target_right <- x[(n - m + 1):n]
  x_support_right <- x[(n - 2 * m + 1):(n - m)]

  
  # Compute the A matrix using compute_A_matrix
  A_left <- compute_A_matrix(x_target_left, x_support_left)
  A_right <- compute_A_matrix(x_target_right, x_support_right)
  A_middle <- diag(1, n-2*m, n-2*m)
  
  # Construct full A matrix
  A <- matrix(0, n, n)
  
  #cat("A_left: ")
  #print(A_left)
  #cat("\nA_right: ")
  #print(A_right)
  #cat("\nA_middle: ")
  #print(A_middle)
  
  A[1:m, (m+1):(2*m)] <- A_left  # Left boundary
  A[(m+1):(n-m), (m+1):(n-m)] <- A_middle
  A[(n-m+1):n, (n-2*m + 1):(n-m)] <- A_right  # Right boundary
  
  return(A)
}
