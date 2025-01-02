# cmdstan_reg_linear
# Bayesian Linear Regression with CmdStanR
This repository demonstrates a complete workflow for Bayesian linear regression using CmdStanR, the R interface to CmdStan. The script is self-contained and covers all steps, from data generation to results visualization.

# Workflow Steps
# Model Definition

The Stan model is defined in the script and saved as linear_regression.stan.
It implements a simple linear regression:
𝑦
∼
𝑁
(
𝛼
+
𝛽
𝑥
,
𝜎
)
y∼N(α+βx,σ)
# Data Generation

Synthetic data is generated in R with known parameters (α = 2.5, β = 0.9, σ = 0.5).
# Model Compilation

The Stan model is compiled using CmdStanR for efficient sampling.
Posterior Sampling

Markov Chain Monte Carlo (MCMC) is used to sample from the posterior distribution.
Parameters are estimated using 4 chains, with 500 warm-up and 1000 sampling iterations.
Results Analysis

Results include posterior summaries, convergence diagnostics, and visualizations:
Trace plots for MCMC diagnostics.
Scatter plot of data points with the regression line based on posterior means.
# How to Run
Install the required R packages:

R

install.packages("cmdstanr")
cmdstanr::install_cmdstan()
install.packages("bayesplot")
Run the script:

R
Copier le code
source("linear_regression_cmdstanr.R")
View outputs in the R console and graphical window:

Posterior summaries are displayed in the console.
Trace plots and the regression plot are generated as graphical outputs.
# Requirements
R (≥ 4.0)
CmdStan (installed via CmdStanR)
# Visualization
The script uses the bayesplot library to display:

MCMC trace plots for key parameters (α, β, σ).
Scatter plot with posterior regression line.
