## ---- results ='hide'----------------------------------------------------
library(metodosMultivariados2017)
library(datasets)
library(knitr)

## ------------------------------------------------------------------------
data("HairEyeColor")
tbl <- apply(HairEyeColor, c(1,2), sum)
dimnames(tbl) <- list(paste(dimnames(tbl)[[1]], "Hair"),
                      paste(dimnames(tbl)[[2]], "Eyes"))
kable(tbl)

## ------------------------------------------------------------------------
X <- contingency_dummies(tbl)[[1]]
Y <- contingency_dummies(tbl)[[2]]

## ------------------------------------------------------------------------
kable(head(X))

## ------------------------------------------------------------------------
kable(tail(Y))


## ------------------------------------------------------------------------
kable(t(X) %*% Y)

## ------------------------------------------------------------------------
kable(t(X) %*% X)

## ------------------------------------------------------------------------
kable(t(Y) %*% Y)

## ------------------------------------------------------------------------
kable(t(X) %*% Y / sum(as.numeric(t(X) %*% Y)))

## ------------------------------------------------------------------------
ones_row <- rep(1, ncol(X))
ones_col <- rep(1, ncol(Y))
N <- as.numeric(ones_row %*% t(X) %*% Y %*% ones_col)
P <- t(X) %*% Y / N
kable(P)


## ------------------------------------------------------------------------
# (X'X)^(-1)X'Y
Pr <- solve(t(X) %*% X, t(X) %*% Y)
kable(Pr)

## ---- results='hide', message=FALSE, warning=FALSE-----------------------
library(ggtern)

## ---- fig.width=4--------------------------------------------------------
plot_dat <- data.frame(Pr, check.names = FALSE)
ggtern(plot_dat, aes(x = `Brown Eyes`,
               y = `Green Eyes`,
               z = `Hazel Eyes`,
                colour = `Blue Eyes`)) +
  geom_point() + 
  geom_text(aes(label = row.names(plot_dat)))

## ------------------------------------------------------------------------
chi_dist <-  function(row1, row2, tbl) {
  col_masses <-  as.numeric(apply(tbl, 2, sum)) / 
    sum(as.numeric(tbl))
  Pr <- solve(t(X) %*% X, t(X) %*% Y)
  dif <- as.numeric(Pr[row1, ]) - as.numeric(Pr[row2, ])
  sqrt(sum((1 / col_masses)*dif^2))
}

## ------------------------------------------------------------------------
col_mass <- apply(tbl, 2, sum) / 
  sum(as.numeric(tbl))
kable(col_mass)

## ------------------------------------------------------------------------
chi_dist(1, 2, tbl)


## ------------------------------------------------------------------------
chi_dist(1, 4, tbl)

## ------------------------------------------------------------------------
hair_types <- dimnames(tbl)[[1]]
n_types <- length(hair_types) 
row_dist_mat <- matrix(0, 
                       ncol = n_types, 
                       nrow = n_types,
                       dimnames = list(hair_types, hair_types))
for (i in 1:(n_types - 1)) {
  for (j in i:n_types) {
    row_dist_mat[i, j] <- chi_dist(i, j, tbl)
    row_dist_mat[j, i] <-  row_dist_mat[i, j]
  }
}
kable(row_dist_mat)

## ------------------------------------------------------------------------
col_mass <- apply(tbl, 2, sum) / 
  sum(as.numeric(tbl))
kable(col_mass)

## ------------------------------------------------------------------------
 # restar a cada columna su masa (el porcentaje obsevado de ese color de ojos)
Pr_tilde <- Pr - ones_col %*% t(col_mass)
kable(Pr_tilde)

## ------------------------------------------------------------------------
kable(ones_col %*% t(col_mass))


## ------------------------------------------------------------------------
apply(tbl, 2, sum) / sum(as.numeric(tbl))

## ------------------------------------------------------------------------
n <- sum(as.numeric(tbl))
P <- tbl/n
row_mass <- as.numeric(apply(P, 1, sum)) 
col_mass <- as.numeric(apply(P, 2, sum)) 
Dr <- diag(row_mass) 
Dc <- diag(col_mass)
RowProfile <- solve(Dr, P) 
RowProfileC <- RowProfile
for (i in 1:nrow(RowProfile)) 
  RowProfileC[i, ] <- RowProfileC[i, ] -col_mass
covR <- RowProfileC %*% solve(Dc) %*% t(RowProfileC)
res <- eigen(covR)
row_factor1 <- res$vectors[ ,1] * sqrt(res$values[1])
row_factor2 <- res$vectors[ ,2] * sqrt(res$values[2])
row_names <- dimnames(tbl)[[1]]

## ------------------------------------------------------------------------
data <- data.frame(row_factor1, 
                   row_factor2,
                   row_names)
ggplot(data, aes(x = row_factor1, y= row_factor2, colour = row_names)) +
  geom_point(size = 2, alpha = 0.6) +
  geom_text(aes(x = row_factor1, y= row_factor2, label = row_names))


## ------------------------------------------------------------------------
# varianza explicada
var_exp <- cumsum(res$values) / sum(res$values)
scales::percent(var_exp)

## ------------------------------------------------------------------------
ColProfile <- P %*% solve(Dc) 
ColProfileC <- ColProfile
for (j in 1:ncol(ColProfileC)) 
  ColProfileC[ ,j] <- ColProfileC[ ,j] - row_mass
covC <- t(ColProfileC) %*% solve(Dr) %*% ColProfileC
res <- eigen(covC)
col_factor1 <- res$vectors[ ,1] * sqrt(res$values[1])
col_factor2 <- res$vectors[ ,2] * sqrt(res$values[2])
col_names <- dimnames(tbl)[[2]]


## ------------------------------------------------------------------------
data <- data.frame(col_factor1, 
                   col_factor2,
                   col_names)
ggplot(data, aes(x = col_factor1, y= col_factor2, colour = col_names)) +
  geom_point(size = 2, alpha = 0.6) +
  geom_text(aes(x = col_factor1, y= col_factor2, label = col_names))


## ------------------------------------------------------------------------
data_row <- data.frame(factor1 = row_factor1, 
                   factor2 = row_factor2,
                   variable = row_names, type = "hair")
data_col <- data.frame(factor1 = - col_factor1, 
                   factor2 = col_factor2,
                   variable = col_names, type = "eyes")
data_all <- rbind(data_row, data_col)

ggplot(data_all, aes(x = factor1, y= factor2, colour = variable, shape = type)) +
  geom_point(size = 2, alpha = 0.6) +
  geom_text(aes(x = factor1, y= factor2, label = variable))

