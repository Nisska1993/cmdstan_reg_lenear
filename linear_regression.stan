
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

