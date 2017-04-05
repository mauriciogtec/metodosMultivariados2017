## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- include=FALSE------------------------------------------------------
library(psych)
library(ltm)
library(mirt)

## ---- include=TRUE-------------------------------------------------------
#Cargamos los datos. Revisamos que se hayan cargado correctamente. 
data(LSAT)
head(LSAT)

## ---- include=TRUE-------------------------------------------------------
#Corremos el modelo.
IRTmodelo<-ltm(LSAT ~ z1, IRT.param = TRUE)

## ---- include=TRUE-------------------------------------------------------
coef(IRTmodelo)

## ----include=TRUE--------------------------------------------------------
plot(IRTmodelo, type= "ICC")

## ----include=TRUE--------------------------------------------------------
plot(IRTmodelo, type= "IIC",items=0)

## ---- include=TRUE-------------------------------------------------------
factor.scores(IRTmodelo)


## ----include=FALSE-------------------------------------------------------
person.fit(IRTmodelo)

## ----include=FALSE-------------------------------------------------------
test_irt <- irt.fa(LSAT)

## ------------------------------------------------------------------------

plot(test_irt,type="ICC")


## ------------------------------------------------------------------------
plot(test_irt,type="IIC")

## ------------------------------------------------------------------------
lsat_ltm <- ltm(LSAT~z1)
round(coefficients(lsat_ltm)/1.702,3) 

## ------------------------------------------------------------------------
ls_fa <- irt.fa(LSAT,plot=FALSE)
ls_fa$tau

