## ----echo=FALSE,warning=FALSE,error=FALSE,include=FALSE-----------------------
#install.packages('tidyverse')
#install.packages("factoextra")
library("factoextra")
library(FactoMineR)
library(Rcmdr)
library(tidyverse)
library(knitr)

## ----echo=FALSE---------------------------------------------------------------
data_orig<-read.csv("./FactoMineR_extras/cwurData.csv")
data15 <- data_orig[data_orig$year==2015,]
data<-data15[c(-2,-3,-4,-14)] #  ¬[institution,country,rank_nac,year]
kable(x=names(data),row.names=T,format = "html")

## ----echo=F, fig.width=8, fig.height=4----------------------------------------
#row.names(data)=data$institution

PeCA<-PCA(data, scale.unit=T,graph=F,quanti.sup=c(1,10))
par(mfrow=c(1,2))
plot.PCA(PeCA, choix="var", axes = c(1,2))
plot.PCA(PeCA, choix="var", axes = c(3,5))

## ----fig.width=8, fig.height=4------------------------------------------------
par(mfrow=c(1,2))
plot.PCA(PeCA, choix="ind",label = "none",axes = c(1,2))
plot.PCA(PeCA, choix="ind",label = "none",axes = c(3,5))

## -----------------------------------------------------------------------------
summary(PeCA)

## ----fig.width=8, fig.height=4------------------------------------------------
library("factoextra")
res.pca <- prcomp(data,  scale = TRUE)
#get_eig(res.pca)
  par(mfrow=c(1,2))
  fviz_eig(res.pca, addlabels=TRUE, hjust = -0.3) +
    ylim(0, 80)
  fviz_eig(res.pca, choice = "eigenvalue", 
                 addlabels = TRUE)

