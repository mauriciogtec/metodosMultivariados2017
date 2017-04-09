## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo=FALSE, include=FALSE-------------------------------------------
require("candisc")

## ----echo=FALSE----------------------------------------------------------
attach(iris)

## ------------------------------------------------------------------------
iris.std <- sweep(iris[,-5], 2, sqrt(apply(iris[,-5],2,var)), FUN="/")
sepal.meas <- iris.std[,1:2]
petal.meas <- iris.std[,3:4]

## ------------------------------------------------------------------------
R11 <- cor(sepal.meas)
R22 <- cor(petal.meas)
R12 <- c(cor(sepal.meas[,1], petal.meas[,1]), cor(sepal.meas[,1], petal.meas[,2]),
         cor(sepal.meas[,2], petal.meas[,1]), cor(sepal.meas[,2], petal.meas[,2]))
R12 <- matrix(R12, ncol=ncol(R22), byrow=T) # R12 has q2 columns, same as number of petal measurements
R21 <- t(R12)  # R21=transpose of R12


## ------------------------------------------------------------------------
E1 <- solve(R11) %*% R12 %*% solve(R22) %*% R21
E2 <- solve(R22) %*% R21 %*% solve(R11) %*% R12
print("E1")
print("E2")

## ------------------------------------------------------------------------
eigen(E1)
eigen(E2)

## ------------------------------------------------------------------------
canon.corr <- sqrt(eigen(E1)$values)
canon.corr

## ------------------------------------------------------------------------
a1=eigen(E1)$vectors[,1]
b1=eigen(E2)$vectors[,1]
a2=eigen(E1)$vectors[,2]
b2=eigen(E2)$vectors[,2]

## ------------------------------------------------------------------------
a1
b1
a2
b2

## ------------------------------------------------------------------------
u1 = a1[1]*Sepal.Length + a1[2]*Sepal.Width
v1 = b1[1]*Sepal.Length + b1[2]*Sepal.Width

## ------------------------------------------------------------------------
u1
v1

## ----echo=FALSE----------------------------------------------------------
u1 <- as.matrix(iris.std[,1:2]) %*% as.matrix(eigen(E1)$vectors[,1])
v1 <- as.matrix(iris.std[,3:4]) %*% as.matrix(eigen(E2)$vectors[,1])
plot(u1,v1)

## ----echo=FALSE----------------------------------------------------------
u2 <- as.matrix(iris.std[,1:2]) %*% as.matrix(eigen(E1)$vectors[,2])
v2 <- as.matrix(iris.std[,3:4]) %*% as.matrix(eigen(E2)$vectors[,2])
plot(u2,v2)

## ----echo=FALSE----------------------------------------------------------
#cc <- cancor(sepal.meas, petal.meas, set.names = c("Sepal","Petal"))
#Wilks(cc)

## ----echo=FALSE, include=FALSE-------------------------------------------
require("ggplot2")
require("GGally")
require("CCA")
require("candisc")

## ------------------------------------------------------------------------
datos <- read.csv("CCAData/DATABASE.csv")
datos$Money <- as.numeric(datos$Money)
datos <- sweep(datos, 2, sqrt(apply(datos,2,var)), FUN="/")

levels <- datos[1:3]
cont <- datos[4:6]

## ----echo=FALSE----------------------------------------------------------
ggpairs(levels)
ggpairs(cont)

## ------------------------------------------------------------------------
CCA::matcor(levels, cont)

## ------------------------------------------------------------------------
cc1 <- candisc::cancor(levels,cont, set.names = c("Behavioural","Financial"))
cc2 <- CCA::cc(levels,cont)

zapsmall(cor(candisc::scores(cc1, type="x"), candisc::scores(cc1, type="y")))

coef(cc1, type="both")

## ------------------------------------------------------------------------
cc3 <- comput(levels, cont, cc2)

cc3[3:6]

## ------------------------------------------------------------------------
Wilks(cc1)

## ------------------------------------------------------------------------
coef(cc1, type="both", standardize=TRUE)

