### choose a subset of variables based on their correlation: the function
### minimizes the sum of absolute correlation values of a combination of k
### variables in a matrix X of n variables (n being the number of columns in the
### original matrix). The function returns the column numbers of the selected
### variables. A threshold can be set so that no correlation is above this
### value. If there are not enough variables with correlation < threshold, the
### function returns NA.

choose_vars <- function(X, k, threshold = 1) {
  ## select 3 variables
  combs = combn(ncol(X), k)
  
  corc = apply(combs, 2, function(x) {
    mxc = X[, x]
    mcor = abs(cor(mxc))
    for (i in 1:nrow(mcor))
      mcor[i, 1:i] = 0
    if (all(mcor < threshold)) {
      return(sum(mcor))
    } else return(NA)
  })
  
  if (any(!is.na(corc))) {
    return(combs[, which.min(corc)])
  } else return(NA)
}



# example
mx = matrix(rnorm(80), ncol = 8)
choose_vars(mx, 3, 0.5)
cor(mx[, choose_vars(mx, 3, 0.5)])
