#' @title Votaciones del Senado Mexicano
#' @description Datos de votaciones de la 63 legislatura de Mexico, primer agno, primer periodo ordinario.
#' @usage data(votacion_senado)
#' @format Las primeras tres columnas corresponden a datos de las votaciones y las siguientes a la votacion
#' de cada senador donde:
#' \itemize{
#'     \item \code{FECHA} vector de clase \code{Date} con la fecha de cada votacion
#'     \item \code{ASUNTO} vector de clase \code{character} con la descripcion del asunto votado
#'     \item \code{HREF} vector de clase \code{character} con el link a la pagina web de donde se obtuvieron
#'     las votaciones
#'     \item El resto de las columnas contiene el nombre del senador y el resultado de su voto
#'     con valor \code{1} si el voto fue a favor; \code{-1} en contra; \code{0}  abstencion y \code{NA}
#'     en el caso de ausencia.
#' }
#' @source Los datos se obtuvieron de \link{www.senado.gob.mx} usando
#' \link{github.com/mauriciogtec/votacionEspacialMexico}
"senado_votacion"

#' @title Partidos de los Senadores Mexicanos
#' @description Datos de votaciones de la 63 legislatura de Mexico, primer agno, primer periodo ordinario.
#' @usage data(senado_partidos)
#' @format
#' \itemize{
#'     \item \code{SENADOR} vector de clase \code{character} con el nombre de cada senador
#'     \item \code{PARTIDO} vector de clase \code{character} con el partido durante el periodo
#' }
#' @source Los datos se obtuvieron de \link{www.senado.gob.mx} usando
#' \link{github.com/mauriciogtec/votacionEspacialMexico}
"senado_partidos"
