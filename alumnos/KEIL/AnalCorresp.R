install.packages("dummies")
library(dummies)
install.packages("FactoMineR")
library(FactoMineR)

data <- datasets::HairEyeColor
summary(data)
HairEye <- apply(data,c(1,2),sum)
HairEye

# Convert from data frame of counts to data frame of cases.
# `countcol` is the name of the column containing the counts
countsToCases <- function(x, countcol = "Freq") {
  # Get the row indices to pull from x
  idx <- rep.int(seq_len(nrow(x)), x[[countcol]])
  
  # Drop count column
  x[[countcol]] <- NULL
  
  # Get the rows from x
  x[idx, ]
}

df <- countsToCases(as.data.frame(as.table(HairEye)))
df.dummies <- dummy.data.frame(df, sep = ".")
cor(df.dummies)
res <- FactoMineR::PCA(df.dummies)
par(mfrow=c(1,1))

chisq.test(HairEye) 
curve(dchisq(x,df=9),from=0,to=20)


prop.table(HairEye)-(prop.table(margin.table(HairEye,1)) %*% t(prop.table(margin.table(HairEye,2))))


x <- as.matrix(df.dummies[,1:4])
y <- as.matrix(df.dummies[,5:8])

### Obtener tabla de contingencia 
P <- t(x) %*% y

### Probabilidad marginal
t(x) %*% x
t(y) %*% y

### Probabilidad condicional

P1 <- P / sum(as.numeric(P))

apply(P1,c(1,2),scales::percent)

#### Perfiles por renglon, probabilidad de tener color de pelo si tengo algun color de ojos
#### P(ojos|pelo)
Dr <- t(x) %*% x /sum(as.numeric(P))
apply(Dr,c(1,2),scales::percent)

Drinv <- diag(1/diag(Dr))
dimnames(Drinv) <- dimnames(Dr)
Pr <- Drinv %*% P1
apply(Pr,c(1,2),scales::percent)

#Prob(pelo|ojos)
Dc <- t(y) %*% y /sum(as.numeric(P))
apply(Dc,c(1,2),scales::percent)

Dcinv <- diag(1/diag(Dc))
dimnames(Dcinv) <- dimnames(Dc)
Pc <- P1 %*% Dcinv
apply(Pc,c(1,2),scales::percent)
