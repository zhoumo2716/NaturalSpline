#include <RcppArmadillo.h>
using namespace Rcpp;
// [[Rcpp::depends(RcppArmadillo)]]
using namespace arma;

// Function to compute the P matrix
// [[Rcpp::export]]
arma::mat compute_P_matrix(const arma::vec& x_target, const arma::vec& x_support) {
  int m = x_target.n_elem;
  int n = x_support.n_elem;
  arma::mat P(m, n, fill::zeros);
  
  for (int i = 0; i < m; i++) {
    P(i, 0) = 1.0;
    for (int j = 1; j < n; j++) {
      P(i, j) = P(i, j - 1) * (x_target(i) - x_support(j - 1));
    }
  }
  return P;
}

// Function to compute the C matrix without Theta
// [[Rcpp::export]]
arma::mat compute_C_withoutTheta(const arma::vec& x_support) {
  int n = x_support.n_elem;
  arma::mat C(n, n, fill::zeros);
  
  for (int t = 0; t < n; t++) {
    for (int w = 0; w <= t; w++) {
      double prod_denom = 1.0;
      for (int u = 0; u <= t; u++) {
        if (u != w) {
          prod_denom *= (x_support(w) - x_support(u));
        }
      }
      C(t, w) = 1.0 / prod_denom;
    }
  }
  return C;
}

// Function to compute the A matrix (P * C_withoutTheta)
// [[Rcpp::export]]
arma::mat compute_A_matrix(const arma::vec& x_target, const arma::vec& x_support) {
  arma::mat P = compute_P_matrix(x_target, x_support);
  arma::mat C_withoutTheta = compute_C_withoutTheta(x_support);
  return P * C_withoutTheta;  // Matrix multiplication
}

// Function to compute the full A matrix
// [[Rcpp::export]]
arma::mat ns_matrix(const arma::vec& x, int m) {
  int n = x.n_elem;
  if (m > n / 2) stop("m must be <= half the length of x");
  
  // Define target and support points
  arma::vec x_target_left = x.subvec(0, m - 1);
  arma::vec x_support_left = x.subvec(m, 2*m - 1);
  arma::vec x_target_right = x.subvec(n - m, n - 1);
  arma::vec x_support_right = x.subvec(n - 2*m, n - m - 1);
  
  // Compute A matrices for left and right
  arma::mat A_left = compute_A_matrix(x_target_left, x_support_left);
  arma::mat A_right = compute_A_matrix(x_target_right, x_support_right);
  arma::mat A_middle = arma::eye(n - 2*m, n - 2*m);
  
  // Initialize full A matrix
  arma::mat A(n, n, fill::zeros);
  
  // Fill left, middle, and right portions
  A.submat(0, m, m-1, 2*m - 1) = A_left;  // Left boundary
  A.submat(m, m, n - m - 1, n - m - 1) = A_middle;  // Middle identity part
  A.submat(n - m, n - 2*m, n - 1, n - m - 1) = A_right;  // Right boundary
  
  return A;
}
