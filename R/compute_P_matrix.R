#' Compute P Matrix
#'
#' Computes the P matrix for natural spline extrapolation.
#' @param x_target Numeric vector of target x-values.
#' @param x_support Numeric vector of support x-values.
#' @return A numeric matrix representing the P matrix.
#' @export
compute_P_matrix <- function(x_target, x_support) {
  P <- matrix(0, nrow = length(x_target), ncol = length(x_support))
  for (i in 1:length(x_target)) {
    for (j in 1:length(x_support)) {
      if (j == 1) {
        P[i, j] <- 1
      } else {
        product <- 1
        for (k in 1:(j - 1)) {
          product <- product * (x_target[i] - x_support[k])
        }
        P[i, j] <- product
      }
    }
  }
  return(P)
}
