#' @import magrittr
#' @title Multiplicar por cuatro
#' @description Esta es una funcion de ejemplo para multiplicar un valor o vector \code{x} por cuatro.
#' @param x un elemento o vector numerico
#' @details Esta funcion es parte del tutorial para hacer paquetes del curso de Metodos Multivariados 2017
#' en el ITAM. La funcion recibe un elemento \code{x} que puede ser un numero o un vector numerico y lo devuelve
#' multiplicado por cuatro. La documentacion de ayuda es generada usando roxygen2. La implementacion utiliza \code{\link{timesTwo}}
#' @examples
#' timesFour(3)
#' timesFour(0:10)
#' @export
timesFour <- function(x) {
  x %>% timesTwo() %>% timesTwo()
}
