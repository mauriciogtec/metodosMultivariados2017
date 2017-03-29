library(metodosMultivariados2017)
library(dplyr)
data("senado_votacion")
library(plotly)
library(ggplot2)
data('senado_partidos')
help("senado_votacion")
help("senado_partidos")

votos <- senado_votacion[ ,-(1:3)]
agreement <- matrix(0, nrow = ncol(votos), ncol = ncol(votos))
for (i in 1:(ncol(votos)-1)) {
  for (j in (i+1):ncol(votos)) {
<<<<<<< HEAD
    agreement[i, j] <- sum(votos[ ,i] == votos[ ,j], na.rm = TRUE) / ncol(votos)
=======
    agreement[i, j] <- sum(na.omit(votos[ ,i] == votos[ ,j])) / length(!is.na(votos[ ,i] == votos[ ,j]))
>>>>>>> origin/master
    agreement[j, i] <-  agreement[i, j]
  }
}
diag(agreement) <-  1

dist_sq <- (1-agreement)^2
for (i in 1:nrow(dist_sq)) {
  dist_sq[i, ] <-   dist_sq[i, ] - mean(dist_sq[i, ])
}
for (i in 1:nrow(dist_sq)) {
  dist_sq[ ,j] <-   dist_sq[ ,j] - mean(dist_sq[ ,j])
}
B = -0.5 * dist_sq
eigen_decomp <- eigen(B)

X <- eigen_decomp$vectors[ ,1:3] %*% diag(sqrt(eigen_decomp$values[1:3]))
sum(eigen_decomp$values[1:3]) / sum(diag(B))
data <- data.frame(
  SENADOR = names(votos),
  comp1 = X[ ,1],
  comp2 = X[ ,2],
  comp3 = X[ ,3],
  stringsAsFactors = FALSE
)
data <- left_join(data, senado_partidos, by = "SENADOR")
p <- ggplot(data, aes(x=comp1, y=comp2, colour=PARTIDO, group = SENADOR)) +
  scale_color_manual(values=c("blue", "yellow", "green","red","orange","gray","black")) +
  geom_point(size = 4, alpha = 0.3) +
  theme_dark()
ggplotly(p)

p <- plot_ly(data, x = ~comp1, y = ~comp2, z = ~comp3, color = ~PARTIDO, text =~SENADOR,
             colors = c("blue", "yellow", "green","red","orange","gray","black")) %>%
  add_markers()
p
