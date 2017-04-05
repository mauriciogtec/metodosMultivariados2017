## ---- message=FALSE------------------------------------------------------
# Cargamos paquetes
library(metodosMultivariados2017)
library("FactoMineR")
library("factoextra")
library("gplots")

## ---- include=TRUE-------------------------------------------------------
# Cargamos data set
data(STUDENT)
MyData <- STUDENT
MyData <- (MyData)[,1:13]

## ------------------------------------------------------------------------
# Revisamos datos
head(MyData)

## ------------------------------------------------------------------------
summary(MyData)

## ------------------------------------------------------------------------
cats = apply(MyData, 2, function(x) nlevels(as.factor(x)))
cats

## ------------------------------------------------------------------------
# MCA
mca1 = MCA(MyData, graph = FALSE)

# Tabla de eigenvalores y % de varianza
mca1$eig

## ------------------------------------------------------------------------
head(mca1$var$coord)

## ------------------------------------------------------------------------
head(mca1$ind$coord)

## ------------------------------------------------------------------------
mca1_vars_df = data.frame(mca1$var$coord, Variable = rep(names(cats), 
    cats))
mca1_obs_df = data.frame(mca1$ind$coord)

## ---- fig.width=8, fig.height=6------------------------------------------
# Grafica de las categorias de las variables
ggplot(data = mca1_vars_df, aes(x = Dim.1, y = Dim.2, label = rownames(mca1_vars_df))) + 
    geom_hline(yintercept = 0, colour = "gray70") + geom_vline(xintercept = 0, 
    colour = "gray70") + geom_text(aes(colour = Variable)) + ggtitle("Grafica de ACM de variables de STUDENT en R con FactoMineR")

## ----fig.width=8, fig.height=6-------------------------------------------
fviz_contrib(mca1, choice ="var", axes = 1:2)

## ----fig.width=8, fig.height=6-------------------------------------------
fviz_mca_var(mca1, repel = TRUE)

## ----fig.width=8, fig.height=6-------------------------------------------
fviz_mca_var(mca1, alpha.var="contrib")+
  theme_minimal()

## ------------------------------------------------------------------------
dichotom <- function(data,out='numeric') {
  if(!is.data.frame(data)) data <- data.frame(data)
  res <- matrix(nrow=nrow(data),ncol=length(levels(data[,1])))
  for(i in 1:ncol(data)) {
    if(is.factor(data[,i])==FALSE) data[,i] <- factor(data[,i])
    nlevels <- length(levels(data[,i]))
    temp <- matrix(nrow=nrow(data),ncol=nlevels)
    for(j in 1:nlevels) temp[,j] <- ifelse(data[,i]==levels(data[,i])[j],1,0)
    colnames(temp) <- paste(names(data)[i],levels(data[,i]),sep=".")
    if(i==1) res <- temp else res <- cbind(res,temp)
  }
  res <- as.data.frame(res)
  if(out=='factor') for(i in 1:ncol(res)) res[,i] <- as.factor(res[,i])
  res
}

burt <- function(data) {
  disj <- dichotom(data,out='numeric')
  res <- as.matrix(t(disj)) %*% as.matrix(disj)
  return(res)
}

## ------------------------------------------------------------------------
Z<-dichotom(MyData) 
head(Z)

## ----fig.width=8, fig.height=6-------------------------------------------
res.ca<-CA(Z,graph = FALSE) #corresponcias simples para la matriz Z
res.ca 


# Graficamos 
mca1_vars_df = data.frame(res.ca$col$coord, Variable = rep(names(cats), cats))
mca1_obs_df = data.frame(res.ca$row$coord)

# Grafica de las categorías de las variables
ggplot(data = mca1_vars_df, aes(x = Dim.1, y = Dim.2, label = rownames(mca1_vars_df))) + 
    geom_hline(yintercept = 0, colour = "gray70") + geom_vline(xintercept = 0, 
    colour = "gray70") + geom_text(aes(colour = Variable)) + ggtitle("Grafica de ACM de variables de STUDENT en R con FactoMineR")

## ------------------------------------------------------------------------
B<-burt(MyData)
head(B)

## ---- fig.width=8, fig.height=6------------------------------------------
res.ca<-CA(B,graph = FALSE) 
res.ca 


# Graficamos 
mca1_vars_df = data.frame(res.ca$col$coord, Variable = rep(names(cats),
    cats))
mca1_obs_df = data.frame(res.ca$row$coord)

# Grafica de las categorias de las variables
ggplot(data = mca1_vars_df, aes(x = Dim.1, y = Dim.2, label = rownames(mca1_vars_df))) + 
    geom_hline(yintercept = 0, colour = "gray70") + geom_vline(xintercept = 0, 
    colour = "gray70") + geom_text(aes(colour = Variable)) + ggtitle("Grafica de ACM de variables de STUDENT en R con FactoMineR")

