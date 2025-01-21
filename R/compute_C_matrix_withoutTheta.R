#' Compute C_matrix withoutTheta
#'
#' Computes the C_withoutTheta matrix for natural spline extrapolation.
#' @param x_support Numeric vector of support x-values.
#' @return A numeric matrix representing the C_withoutTheta matrix.
#' @export
compute_C_matrix_withoutTheta <- function(x_support) {
  m <- length(x_support)
  C_withoutTheta <- matrix(0, nrow = m, ncol = m)
  for (t in 1:m) {
    for (w in 1:t) {
      denominator <- 1
      for (u in 1:t) {
        if (u != w) {
          denominator <- denominator * (x_support[w] - x_support[u])
        }
      }
      C_withoutTheta[t, w] <- 1 / denominator
    }
  }
  return(C_withoutTheta)
}
