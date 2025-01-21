#' Extrapolate Boundary Points
#' @param x Numeric vector of x-values (ordered).
#' @param theta Numeric vector of theta values corresponding to x.
#' @param m Degree of the polynomial extrapolation.
#' @param side String indicating "left" or "right" boundary extrapolation.
#' @return Numeric vector of extrapolated points.
#' @export
extrapolate_compact <- function(x, theta, m, side = "left") {
  # x: vector of x-values (ordered).
  # theta: vector of theta values corresponding to x.
  # m: degree of the polynomial extrapolation (number of extrapolated points).
  # side: "left" for left boundary extrapolation or "right" for right boundary extrapolation.
  
  n <- length(x)
  
  if (side == "left") {
    # Points for extrapolation
    x_target <- x[1:m]
    x_support <- x[(m + 1):(2 * m)]
    theta_support <- theta[(m + 1):(2 * m)]
  } else if (side == "right") {
    # Points for extrapolation
    x_target <- x[(n - m + 1):n]
    x_support <- x[(n - 2 * m + 1):(n - m)]
    theta_support <- theta[(n - 2 * m + 1):(n - m)]
  } else {
    stop("Invalid side. Choose 'left' or 'right'.")
  }
  
  if (length(x) != length(theta)){
    stop("The sizes of x and theta do not match.")
  }
  
  # Initialize result vector
  result <- numeric(length(x_target))
  #cat("original result empty: ", result, " original result vector length: ", length(result), "\n")
  
  # Loop over each target point
  for (i in seq_along(x_target)) {
    x_i <- x_target[i]
    #cat("current i:", i, " x_target_",i,": ", x_i, "\n")
    
    
    # Outer summation over t (corresponding to each theta_t)
    sum_t <- 0
    for (t in 1:length(theta_support)) {
      # Inner summation over w starting from t to 2m
      sum_w <- 0
      for (w in t:length(x_support)) {
        #cat("current t: ", t, " current w: ", w, "\n")
        
        # Compute the numerator product
        prod_numerator <- 1
        if (w-1 >= 1) {
          for (j in 1:(w-1)) {
            prod_numerator <- prod_numerator * (x_i - x_support[j])
            #cat("current j for prod_nu: ", j, " current x_i - x_j: ", x_i, " - ", x_support[j], " = ", x_i - x_support[j], "\n")
            
          }
        }
        #cat("current prod numerator: ", prod_numerator , "\n")
        # Compute the denominator product
        prod_denominator <- 1
        for (u in 1:w) {
          if (u != t) {
            prod_denominator <- prod_denominator * (x_support[t] - x_support[u])
            #cat("current u for prod_de: ", u, " current x_t - x_u: ", x_support[t], " - ", x_support[u], " = ", x_support[t] - x_support[u], "\n")
            
          }
        }
        #cat("current prod denominator: ", prod_denominator , "\n")
        
        # Add this term to the inner summation
        sum_w <- sum_w + (prod_numerator / prod_denominator)
        #cat("current sum_w: ", sum_w , "\n")
      }
      
      # Scale the inner summation by theta_t and add to the outer summation
      sum_t <- sum_t + sum_w * theta_support[t]
      #cat("current sum_t multipied with theta: ", sum_t , "\n")
      
    }
    
    # Store the result for this target point
    result[i] <- sum_t
    #cat("\n")
    #cat("\n")
  }
  
  return(result)
}


