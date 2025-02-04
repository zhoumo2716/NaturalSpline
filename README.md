
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

Computes the polynomial $`P`$ matrix based on the target and support
points for the specified boundary (`"left"` or `"right"`).

### `compute_C_matrix_withoutTheta(x, m, side)`

Computes the coefficient $`C`$ matrix (without $`\theta`$) using the
natural spline formula.

### `compute_A_matrix(P, C_withoutTheta)`

Combines the $`P`$ matrix and $`C`$ matrix (without $`\theta`$) to
compute the $`A`$ matrix, which will be multiplied with the $`\theta`$)
vector.

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
m <- 3

# Perform extrapolation using the compact formula
left_result <- extrapolate_compact(x, theta, m, side = "left")
right_result <- extrapolate_compact(x, theta, m, side = "right")
print(left_result)
#> [1] -12.0  -4.0   1.5
print(right_result)
#> [1] 12.5 25.0 42.0

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
#> + NaturalSpline 0.0.0.9000 → 0.0.0.9000 👷‍♀️🔧 ⬇ (GitHub: d756494)
#> 
#> ! NaturalSpline is loaded in the current R session, you probably need to
#> restart R after the installation.
#> 
#> ℹ Getting 1 pkg with unknown size
#> ✔ Got NaturalSpline 0.0.0.9000 (source) (46.17 kB)
#> ℹ Packaging NaturalSpline 0.0.0.9000
#> ✔ Packaged NaturalSpline 0.0.0.9000 (598ms)
#> ℹ Building NaturalSpline 0.0.0.9000
#> ✔ Built NaturalSpline 0.0.0.9000 (744ms)
#> ✔ Installed NaturalSpline 0.0.0.9000 (github::zhoumo2716/NaturalSpline@d756494) (21ms)
#> ✔ 1 pkg: upd 1, dld 1 (NA B) [10.7s]
```

Or with `devtools`

``` r
# Install the devtools package if not already installed
install.packages("devtools")
#> Installing package into '/private/var/folders/74/4fh__5010_l3tp8fpsft2ft00000gn/T/RtmpiaGPmS/temp_libpathe7c335a90161'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/74/4fh__5010_l3tp8fpsft2ft00000gn/T//RtmpAL5Dvs/downloaded_packages

# Install the NaturalSpline package from GitHub
devtools::install_github("zhoumo2716/NaturalSpline")
#> Skipping install of 'NaturalSpline' from a github remote, the SHA1 (d7564940) has not changed since last install.
#>   Use `force = TRUE` to force installation
```
