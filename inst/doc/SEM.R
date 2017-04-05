## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = "center", 
                      message=FALSE, warning=FALSE)

## ---- message=FALSE, warning=FALSE---------------------------------------
# 0. Librerias
library(tidyverse)
library(forcats)
library(foreign)
library(qgraph)
library(sem)
library(lavaan)
library(semPlot)
theme_set(theme_bw())

## ------------------------------------------------------------------------
# 1. Datos
data <- read.spss("http://www.methodsconsultants.com/data/intelligence.sav", 
                  to.data.frame=TRUE)
head(data)

## ---- fig.width=5, fig.height=4------------------------------------------
data.cov <- cov(data)
data.cov %>% 
  as_tibble() %>% 
  mutate(nom = rownames(data.cov)) %>% 
  gather(var.lab, var.val, -nom) %>% 
  mutate(var.val2 = ifelse(var.lab == nom, NA, var.val), 
         nom = factor(nom, levels = c('reading', 'writing', 'math', 
                                      'analytic', 'simpsons', 
                                      'familyguy',  'amerdad')),
         var.lab = factor(var.lab, levels = c('reading', 'writing', 'math', 
                                      'analytic', 'simpsons', 
                                      'familyguy',  'amerdad'))) %>% 
  ggplot(aes(x = nom, y = var.lab, fill = var.val2)) + 
  geom_tile() + 
  ylab(NULL) + xlab(NULL) +  
  theme(axis.text.x = element_text(angle = 90)) + 
  guides(fill = guide_legend("covarianza"))

## ---- fig.width=5, fig.height=4------------------------------------------
qgraph(cov(data), borders = FALSE, layout = "spring")

## ------------------------------------------------------------------------
# 3. libreria SEM
cat(file = "SEM/sem_intellect.txt",
"humor -> simpsons, NA, 1
humor -> familyguy, l2, NA
humor -> amerdad, l3, NA
intell -> reading, l4, NA
intell -> writing, l5, NA
intell -> math, l6, NA
intell -> analytic, l7, NA
intell -> humor, g1, NA
simpsons <-> simpsons, e1, NA
familyguy <-> familyguy, e2, NA
amerdad <-> amerdad, e3, NA
reading <-> reading, d1, NA
writing <-> writing, d2, NA
math <-> math, d3, NA
analytic <-> analytic, d4, NA
intell <-> intell, NA, 1
humor <-> humor, z1, NA")

specify.sem <- sem::specifyModel(file = "SEM/sem_intellect.txt")
fit.sem <- sem::sem(specify.sem, data.cov, N = 100)
summary(fit.sem)

## ---- fig.keep='first'---------------------------------------------------
pathDiagram(fit.sem)

## ------------------------------------------------------------------------
model <- "
# latent variable definitions
humor =~ simpsons + familyguy + amerdad
intell =~ reading + writing + math + analytic
# regressions
intell ~ humor
"

fit.lav <- lavaan::sem(model, data = data)
lavaan::summary(fit.lav, standardized=TRUE)

## ------------------------------------------------------------------------
lavaan::coef(fit.lav) %>% sort()

## ---- fig.width=11, fig.height=6-----------------------------------------
semPaths(fit.lav, "std", curvePivot = T, layout = "circle2")

## ------------------------------------------------------------------------
lavaan::modindices(fit.lav)

