## ---- eval=FALSE---------------------------------------------------------
#  senado_votaciones <- readRDS("C:/Github/votacionEspacialMexico/source_rds/L63_A2_N1_PO1_RESULTS.RDS")

## ---- eval =FALSE--------------------------------------------------------
#  devtools::use_data()
#  devtools::use_data(senado_votaciones)

## ---- eval=FALSE---------------------------------------------------------
#  #' @title datos de votaciones del senado
#  #' @description datos de votaciones del senado
#  #' @format primeras tres columnas informacion de votaciones
#  #' las siguientes votaciones de cada senador
#  #' 1 es que voto que si
#  "senado_votaciones"
#  

## ---- eval=FALSE---------------------------------------------------------
#  devtools::document()
#  devtools::install(build_vignettes = TRUE)

