#' @title Dummys from contingency
#' @description Returns two matrices, one representing dummy observations
#' of rows and one representing dummy observations of colummns
#' @param tbl a contingency table
#' @return /code{X} the matrix of dummy row categories observations and /code{Y}
#' the dummy of dummy column categories observations
#' @export
contingency_dummies <- function(tbl){
  N <- sum(as.numeric(tbl))
  row_dim <- dimnames(tbl)[[1]]
  col_dim <- dimnames(tbl)[[2]]
  X <- matrix(FALSE, ncol = length(row_dim), nrow = N, dimnames = list(NULL, row_dim))
  Y <- matrix(FALSE, ncol = length(col_dim), nrow = N, dimnames = list(NULL, col_dim))
  count <- 0
  for (i in seq_along(row_dim)) {
    for (j in seq_along(col_dim)) {
      N_ij <- tbl[i, j]
      X[(count + 1):(count + N_ij), i] <- TRUE
      Y[(count + 1):(count + N_ij), j] <- TRUE
      count <- count + N_ij
    }
  }
  list(X = X, Y = Y)
}
