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
