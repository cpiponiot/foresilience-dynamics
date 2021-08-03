
data {
  int<lower=0> N;
  vector[N] n;
  vector[N] b;
  vector[N] dndt;
  vector[N] dbdt;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0> r_n; 
  real<lower=0> K_n; 
  real a_n;
  real<lower=0> r_b; 
  real<lower=0> K_b; 
  real a_b;
  
  real<lower=0> sigma_n;
  real<lower=0> sigma_b;
}

transformed parameters {
  vector[N] mu_n;
  vector[N] mu_b;
  
  for (i in 1:N ) {
  mu_n[i] = r_n * n[i] * ( 1 - n[i] / K_n + a_n / K_n * b[i] ) ;
  mu_b[i] = r_b * b[i] * ( 1 - b[i] / K_b + a_b / K_b * n[i] ) ;
  }
  
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  dndt ~ normal(mu_n, sigma_n);
  dbdt ~ normal(mu_b, sigma_b);
  
  // priors
  K_n ~ normal(1000, 500);
  K_b ~ normal(400, 100);
  a_n ~ normal(0,1);
  a_b ~ normal(0,1);
  sigma_n ~ normal(0,1);
  sigma_b ~ normal(0,1);
}

