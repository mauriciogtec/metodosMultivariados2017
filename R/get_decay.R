#' @title get_decay
#' @description Creates vector with decay factor. 
#' @param n size.
#' @param halflife halflife as a percentage of n.
#' @param method it can be geometric or 
#' semi-gemetric.
#' @details See reference at 
#' http://stats.stackexchange.com/questions/20542/generating-a-3-month-half-life-weighting-series-in-r
#' it is desirable to find how both methods change with halflife of 0 and 1
#' @export
get_decay <- function(
  n,
  halflife = 1,
  method = "semi-geometric"
) {
  halflife <- ifelse(0 <= halflife || halflife < 1, round(halflife * n), n)
  
  w <- (n - 1):0
  
  if(method == "semi-geometric") {
    w[n:1 > (n - halflife)] <- n - halflife
    decay <- (1 / halflife) * ((halflife - 1) / halflife) ^ w
  }
  
  if(method == "geometric") {
    rho <- 2 ^ (-1/halflife)
    decay <- (1 - rho) / (1 - rho ^ n) * rho ^ w
  }
  
  decay
}
