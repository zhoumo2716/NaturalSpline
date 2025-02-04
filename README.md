
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NaturalSpline

<!-- badges: start -->

<!-- badges: end -->

# Overview

This package provides tools for performing natural spline polynomial
extrapolations on the boundary points of a given input vector **x** and
a given corresponding vector **f(x)**. In methods like **trend
filtering**, boundary points often fail to converge well at the two
ends. This package addresses the issue by replacing the boundary values
with natural spline polynomial extrapolations.

The package includes functions to compute extrapolation matrices and
perform compact and non-compact extrapolations. It is especially useful
for denoising applications where **trend filtering** results in
inaccurate boundary estimates.

------------------------------------------------------------------------

# Core Functions

## Extrapolation Functions

### `extrapolate_compact(x, theta, m, side)`

Performs natural spline extrapolation in a **compact** form using a
formula-based approach.

- **Inputs:**
  - `x`: A numeric vector of inputs.
  - `theta`: A numeric vector corresponding to `f(x)`.
  - `m`: Degree of the polynomial extrapolation.
  - `side`: `"left"` or `"right"` indicating which boundary to
    extrapolate.
- **Output:**
  - A vector of extrapolated values.

### `extrapolate_noncompact(x, theta, m, side)`

Uses matrix multiplication for extrapolation. The matrices are
precomputed from helper functions.

- **Inputs and outputs:** Same as `extrapolate_compact`.

------------------------------------------------------------------------

## Matrix Construction Functions

### `compute_P_matrix(x, m, side)`

Computes the polynomial $`P`$ matrix at one side based on the target and support
points for the specified boundary (`"left"` or `"right"`).

### `compute_C_matrix_withoutTheta(x, m, side)`

Computes the coefficient $`C`$ matrix (without $`\theta`$) at one side using the natural spline formula.

### `compute_A_matrix(P, C_withoutTheta)`

Combines the $`P`$ matrix and $`C`$ matrix (without $`\theta`$) to
compute the $`A`$ matrix, which will be multiplied with the left or right $`\theta`$ vector.

### `full_A_matrix(x, m)`

Combines the left and right matrix with diagonals in between, which will be multiplied with the whole $`\theta`$ vector.

------------------------------------------------------------------------

## Visualization

### `plot_extrapolation(x, theta, left_result, right_result)`

Creates a plot comparing the original signal (`x`), the denoised signal
(`theta`), and the extrapolated values at the boundary.

- **Features:**
  - Plots `x` (blue line), `theta` (red line), and extrapolated points
    (green line for the boundary).

------------------------------------------------------------------------

# Usage Example

``` r
library(NaturalSpline)

# Input signal
x <- c( 1, 2, 3, 4, 5, 6, 7)
theta <- c( 7, 2, 1, 4.5, 5, 3, 9)
m <- 2

# Perform extrapolation using different formula
left_result1 <- extrapolate_compact(x, theta, m, side = "left")
right_result1 <- extrapolate_compact(x, theta, m, side = "right")

left_result2 <- extrapolate_noncompact(x, theta, m, side = "left")
right_result2 <- extrapolate_noncompact(x, theta, m, side = "right")

A <- full_A_matrix(x, m)
result3 <- A %*% theta

cat("left_result1: ", left_result1)
#> left_result1:  -6 -2.5
cat(" left_result2: ", left_result2)
#>  left_result2:  -6 -2.5

cat("\nright_result1: ", right_result1)
#> 
#> right_result1:  5.5 6
cat(" right_result2: ", right_result2)
#>  right_result2:  5.5 6

cat("\nresult3: ", result3)
#> 
#> result3:  -6 -2.5 1 4.5 5 5.5 6

# Visualize results
plot_extrapolation(x, theta, m)
```

<img src="man/figures/README-example-1.png" width="100%" />

## Installation

You can install the development version of NaturalSpline from
[GitHub](https://github.com/zhoumo2716/NaturalSpline) with:

``` r
# install.packages("pak")
pak::pak("zhoumo2716/NaturalSpline")
#> ! Using bundled GitHub PAT. Please add your own PAT using `gitcreds::gitcreds_set()`.
#> 
#> → Will update 1 package.
#> → Will download 1 package with unknown size.
#> + NaturalSpline 0.0.0.9000 → 0.0.0.9000 👷🏻🔧 ⬇ (GitHub: aebc3e7)
#> 
#> ! NaturalSpline is loaded in the current R session, you probably need to
#> restart R after the installation.
#> 
#> ℹ Getting 1 pkg with unknown size
#> ✔ Got NaturalSpline 0.0.0.9000 (source) (40.42 kB)
#> ℹ Packaging NaturalSpline 0.0.0.9000
#> ✔ Packaged NaturalSpline 0.0.0.9000 (429ms)
#> ℹ Building NaturalSpline 0.0.0.9000
#> ✔ Built NaturalSpline 0.0.0.9000 (1.2s)
#> ✔ Installed NaturalSpline 0.0.0.9000 (github::zhoumo2716/NaturalSpline@aebc3e7) (26ms)
#> ✔ 1 pkg: upd 1, dld 1 (NA B) [6.7s]
```

Or with `devtools`

``` r
# Install the devtools package if not already installed
install.packages("devtools")
#> Installing package into '/private/var/folders/74/4fh__5010_l3tp8fpsft2ft00000gn/T/RtmpiaGPmS/temp_libpathe7c32b81ea51'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/74/4fh__5010_l3tp8fpsft2ft00000gn/T//RtmppgxI8o/downloaded_packages

# Install the NaturalSpline package from GitHub
devtools::install_github("zhoumo2716/NaturalSpline")
#> Skipping install of 'NaturalSpline' from a github remote, the SHA1 (aebc3e7e) has not changed since last install.
#>   Use `force = TRUE` to force installation
```
