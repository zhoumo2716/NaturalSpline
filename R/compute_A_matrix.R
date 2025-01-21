#' Compute A Matrix
#'
#' Computes the A matrix for natural spline extrapolation.
#' @param x_target Numeric vector of target x-values.
#' @param x_support Numeric vector of support x-values.
#' @return A numeric matrix representing the A matrix.
#' @export
compute_A_matrix <- function(x_target, x_support) {
  # Step 1: Compute the P matrix
  P <- compute_P_matrix(x_target, x_support)
  
  # Step 2: Compute the C_withoutTheta matrix
  C_withoutTheta <- compute_C_matrix_withoutTheta(x_support)
  
  # Step 3: Compute the A matrix
  A <- P %*% C_withoutTheta
  
  # Return the A matrix
  return(A)
}
