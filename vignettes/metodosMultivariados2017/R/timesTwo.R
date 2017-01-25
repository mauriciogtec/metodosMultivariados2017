#' @title Multiplicar por dos
#' @description Esta es una funcion de ejemplo para multiplicar un valor o vector \code{x} por dos.
#' @param x un elemento o vector numerico
#' @details Esta funcion es parte del tutorial para hacer paquetes del curso de Metodos Multivariados 2017
#' en el ITAM. La funcion recibe un elemento \code{x} que puede ser un numero o un vector numerico y lo devuelve
#' multiplicado por dos. La documentacion de ayuda es generada usando roxygen2.
#' @examples
#' timesTwo(3)
#' timesTwo(0:10)
#' @export
timesTwo <- function(x) {
  2*x
}
