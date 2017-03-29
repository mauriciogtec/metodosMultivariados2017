version
install.packages("roxygen2")
library(devtools)
library(roxygen2)
install_github("mauriciogtec/metodosMultivariados2017", build_vignettes= TRUE)
library(metodosMultivariados2017)
browseVignettes("metodosMultivariados2017")
help(package = "metodosMultivariados2017")

devtools::document()
devtools::install(build_vignettes = TRUE)
devtools::build_vignettes()
