# ---------------------------------------------------------
# Régression Linéaire avec CmdStanR
# ---------------------------------------------------------

# 1. Installer et configurer CmdStanR
if (!require("cmdstanr")) install.packages("cmdstanr")
library(cmdstanr)

# Installer CmdStan si nécessaire
if (!cmdstan_version()) install_cmdstan()

# ---------------------------------------------------------
# 2. Créer un modèle Stan
# ---------------------------------------------------------

# Définir le modèle Stan dans une chaîne de caractères
stan_code <- "
data {
  int<lower=0> N;          // Nombre de points de données
  vector[N] x;             // Variable indépendante
  vector[N] y;             // Variable dépendante
}

parameters {
  real alpha;              // Intercept
  real beta;               // Pente
  real<lower=0> sigma;     // Écart-type
}

model {
  y ~ normal(alpha + beta * x, sigma);  // Distribution des observations
}
"

# Sauvegarder le modèle dans un fichier
writeLines(stan_code, "linear_regression.stan")

# ---------------------------------------------------------
# 3. Générer des données pour la régression
# ---------------------------------------------------------

# Exemple de données
set.seed(123)
N <- 100
x <- rnorm(N, mean = 0, sd = 1)
y <- 2.5 + 0.9 * x + rnorm(N, sd = 0.5)

# Préparer une liste compatible avec Stan
data_list <- list(N = N, x = x, y = y)

# ---------------------------------------------------------
# 4. Compiler le modèle
# ---------------------------------------------------------

# Charger et compiler le modèle
mod <- cmdstan_model("linear_regression.stan")

# ---------------------------------------------------------
# 5. Échantillonner les valeurs postérieures
# ---------------------------------------------------------

# Échantillonnage avec CmdStanR
fit <- mod$sample(
  data = data_list, 
  seed = 123, 
  chains = 4, 
  parallel_chains = 4, 
  iter_warmup = 500, 
  iter_sampling = 1000
)

# ---------------------------------------------------------
# 6. Analyser les résultats
# ---------------------------------------------------------

# Résumé des résultats
print(fit)

# Résumé des paramètres principaux
summary <- fit$summary()
print(summary)

# Tracer les diagnostics
fit$cmdstan_diagnose()

# ---------------------------------------------------------
# 7. Visualiser les résultats
# ---------------------------------------------------------

# Charger bayesplot pour la visualisation
if (!require("bayesplot")) install.packages("bayesplot")
library(bayesplot)

# Tracer les traces MCMC des paramètres
posterior <- fit$draws()
mcmc_trace(posterior, pars = c("alpha", "beta", "sigma"))

# Tracer les données et la régression
posterior_samples <- fit$draws(format = "df")
alpha_samples <- posterior_samples$alpha
beta_samples <- posterior_samples$beta

plot(x, y, main = "Régression linéaire bayésienne")
abline(mean(alpha_samples), mean(beta_samples), col = "red", lwd = 2)
