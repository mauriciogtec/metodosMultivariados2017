## ----include = TRUE------------------------------------------------------
knitr::opts_chunk$set(fig.dpi = 300, fig.height = 7, fig.width = 7)
library(psych)

## ----polychoric, include = TRUE, fig.width=7,fig.height=7----------------
draw.tetra(.9,2,0.5)

## ----include = TRUE------------------------------------------------------
draw.tetra(.1,0,0)

## ----include = TRUE, message=FALSE---------------------------------------
library(ggplot2)

## ----include = TRUE------------------------------------------------------
dfOrd  <- data.frame(diamonds)
head(dfOrd)

## ----funciones, include=FALSE--------------------------------------------
library(scales)
cuberoot_trans = function() trans_new('cuberoot',
                                      transform = function(x) x^(1/3),
                                      inverse = function(x) x^3)

## ----include = TRUE, echo=FALSE, message=F, warning=F--------------------
ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter',aes(color=clarity)) +
  scale_color_brewer(type = 'div',
    guide = guide_legend(title = 'Clarity', reverse = T,
    override.aes = list(alpha = 1, size = 2))) +                         
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
    breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
    breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat and Clarity')

ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter',aes(color=cut)) +
  scale_color_brewer(type = 'div',
    guide = guide_legend(title = 'Cut', reverse = T,
    override.aes = list(alpha = 1, size = 2))) +                         
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
    breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
    breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat and Cut')

ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter',aes(color=color)) +
  scale_color_brewer(type = 'div',
    guide = guide_legend(title = 'Color', reverse = F,
    override.aes = list(alpha = 1, size = 2))) +                         
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
    breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
    breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat and Color')

## ----include = TRUE, warning=FALSE---------------------------------------
ordNum <- data.matrix(dfOrd)
head(ordNum)

## ----include = TRUE, message=FALSE,warning=FALSE-------------------------
cor(ordNum[,2],ordNum[,3])
prop.table(table(ordNum[,2],ordNum[,3]))
polychoric(ordNum[,c(2,3)])

## ----include = TRUE, message=FALSE, warning=FALSE------------------------
pc <- mixed.cor(x=ordNum,smooth=TRUE, correct=TRUE)

## ----include = TRUE------------------------------------------------------
pc

## ----include = TRUE------------------------------------------------------
faPC <- principal(r=pc$rho, nfactors=5, rotate="none",scores=TRUE)

## ----include = TRUE------------------------------------------------------
faPC

## ----include = TRUE------------------------------------------------------
predict(faPC,ordNum[1,],ordNum)
fa.plot(faPC)
fa.diagram(faPC)

## ----include = TRUE------------------------------------------------------
faPC$scores <- psych::factor.scores(ordNum,faPC)   
biplot.psych(faPC,choose=c(1,2),main = "Componente 1 vs Componente 2")
biplot.psych(faPC,choose=c(1,3),main = "Componente 1 vs Componente 3")
biplot.psych(faPC,choose=c(2,3),main = "Componente 2 vs Componente 3")
biplot.psych(faPC,choose=c(4,5),main = "Componente 4 vs Componente 5")

