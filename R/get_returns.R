#' @title get_returns
#' @description Creates xts of returns
#' @param x xts containing prices or returns
#' @param is_prices boolean indicating whether x 
#' contains prices or returns
#' @param roll rolling window
#' @param halflife half life as percentage of roll
#' @param is_cumulative boolean indicating whether 
#' cumulative return should be computed
#' @details xx
#' @export
get_returns <- function(
  x,
  is_prices = TRUE,
  roll = 1,
  halflife = 1,
  is_cumulative = FALSE
) {
  # get price changes
  if(is_prices) {
    returns <- x / xts::lag.xts(x)
  } else {
    returns <- x + 1
  }
  
  # get decay
  decay <- get_decay(roll, halflife)
  
  # get returns
  returns <- rollapply(returns,
                       roll,
                       weighted.geometric.mean,
                       decay,
                       fill = NA,
                       align = "right")
  returns <- returns - 1
  
  # get rolling cumulative returns
  if(is_cumulative) {
    returns <- na.fill(returns, list(0, NA, NA))
    returns <- apply(returns + 1, 2, cumprod)
  }
  
  returns
}

#' @title plot_returns
#' @description Plots returns
#' @param returns xts containg daily or cumulative 
#' returns
#' @details xx
#' @export
plot_returns <- function(
  returns
){
  returns <- returns %>%
    as.data.frame() %>%
    tibble::rownames_to_column("date") %>%
    mutate(date = as.Date(date)) %>%
    gather(asset_id, ret, -date)
  
  p <- returns %>%
    plot_ly(x = ~date,
            y = ~ret,
            color = ~asset_id,
            mode = "lines")
  p
}