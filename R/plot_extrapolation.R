#' Plot Extrapolation Results
#'
#' Plots three lines:
#' 1. Index vs. x (original values)
#' 2. Index vs. theta (smoothed theta values)
#' 3. Index vs. extrapolated values (first m and last m points extrapolated)
#' @param x Numeric vector of x-values.
#' @param theta Numeric vector of theta values.
#' @param left_result Numeric vector of left-side extrapolated points.
#' @param right_result Numeric vector of right-side extrapolated points.
#' @param m Degree of polynomial extrapolation.
#' @export
plot_extrapolation <- function(x, theta, m) {
  # Compute extrapolation results
  left_result <- extrapolate_compact(x, theta, m, side = "left")
  right_result <- extrapolate_compact(x, theta, m, side = "right")
  
  # Indices
  n <- length(x)
  index <- seq(1, n)
  result <- theta
  result[1:m] <- left_result[1:m]
  #result[n-m+1:n] <- right_result
  result[(n-m+1):n] <- right_result[1:m]
  
  
  # Plot the original x
  plot(index, x, type = "b", col = "blue", pch = 19, lwd = 2,
       xlab = "Index", ylab = "Values",
       main = "Results")
  
  # Add theta points
  points(index, theta, col = "red", pch = 19)
  lines(index, theta, col = "red", lwd = 2, lty = 2)
  
  # Add left extrapolated points
  #points(left_index, left_result, col = "green", pch = 19)
  #lines(left_index, left_result, col = "green", lwd = 2, lty = 2)
  
  # Add right extrapolated points
  points(index, result, col = "green", pch = 19)
  lines(index, result, col = "green", lwd = 2, lty = 2)
  
  # Add a legend
  legend("topright", legend = c("Original x", "Smoothed Theta", "Extrapolated"),
         col = c("blue", "red", "green"), pch = 19, lty = c(1, 2, 2), lwd = 2, inset = c(0, -0.485), xpd=TRUE)
  
}