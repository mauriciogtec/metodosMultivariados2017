## ------------------------------------------------------------------------
library(knitr)

## ------------------------------------------------------------------------
data(iris)
X <- scale(iris[1:5, 1:2], center = TRUE)
X

## ------------------------------------------------------------------------
# Matriz de productos puntos
X %*% t(X)

## ------------------------------------------------------------------------
dist_squared = as.matrix(dist(X))^2 # cada elemento elevado al cuadrado
n_ind <- nrow(X)
for (i in 1:n_ind) {
  dist_squared[i, ] <- dist_squared[i, ] - mean(dist_squared[i, ])
}
for (j in 1:n_ind) {
  dist_squared[ ,j] <- dist_squared[ ,j] - mean(dist_squared[ ,j])
}
B = -0.5 * dist_squared
B

## ------------------------------------------------------------------------
library(metodosMultivariados2017)
data(senado_votacion)
data(senado_partidos)

## ---- eval = FALSE-------------------------------------------------------
#  help(senado_votacion)

## ---- eval = FALSE-------------------------------------------------------
#  help(senado_partidos)

## ------------------------------------------------------------------------
votos <- senado_votacion[ ,-(1:3)]
disagreement <- matrix(0, nrow = ncol(votos), ncol = ncol(votos))
for (i in 1:(ncol(votos)-1)) {
  for (j in (i+1):ncol(votos)) {
    disagreement[i, j] <- 1 - sum(votos[ ,i] == votos[ ,j], na.rm = TRUE) / ncol(votos)
    disagreement[j, i] <-  disagreement[i, j]
  }
}
disagreement[1:4, 1:4] # ejemplo

## ------------------------------------------------------------------------
dist_squared = disagreement^2 # cada elemento elevado al cuadrado
n_ind <- nrow(disagreement)
for (i in 1:n_ind) {
  dist_squared[i, ] <- dist_squared[i, ] - mean(dist_squared[i, ])
}
for (j in 1:n_ind) {
  dist_squared[ ,j] <- dist_squared[ ,j] - mean(dist_squared[ ,j])
}
B = -0.5 * dist_squared
B[1:4, 1:4] # ejemplo

## ------------------------------------------------------------------------
decomp <- eigen(B)
k <- 2
Pk <- decomp$vectors[ ,1:k]
Deltarootk <- diag(sqrt(decomp$values[1:k]))
X <- Pk %*% Deltarootk

## ---- warning=FALSE, message=FALSE---------------------------------------
library(dplyr)
library(plotly)

## ------------------------------------------------------------------------
plot_data <- data.frame(
  SENADOR = names(votos),
  comp1 = X[ ,1],
  comp2 = X[ ,2],
  stringsAsFactors = FALSE
)
plot_data <- left_join(plot_data, senado_partidos, by = "SENADOR")
head(plot_data)

## ---- fig.width = 6------------------------------------------------------
p <- plot_ly(plot_data, x = ~comp1, y = ~comp2, color = ~PARTIDO, text =~SENADOR,
             colors = c("blue", "yellow", "green","red","orange","gray","black")) %>%
  add_markers()
p


