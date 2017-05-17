## ---- warning = FALSE, message = FALSE-----------------------------------
library(RCurl)
library(lubridate)
library(xts)
library(dplyr)
library(tidyr)
library(plotly)

## ------------------------------------------------------------------------
script <- getURL("https://raw.githubusercontent.com/audiracmichelle/work-in-process/master/michelle/get_prices.R", ssl.verifypeer = FALSE)
eval(parse(text = script))

script <- getURL("https://raw.githubusercontent.com/audiracmichelle/work-in-process/master/michelle/get_decay.R", ssl.verifypeer = FALSE)
eval(parse(text = script))

script <- getURL("https://raw.githubusercontent.com/audiracmichelle/work-in-process/master/michelle/utils.R", ssl.verifypeer = FALSE)
eval(parse(text = script))

script <- getURL("https://raw.githubusercontent.com/audiracmichelle/work-in-process/master/michelle/get_returns.R", ssl.verifypeer = FALSE)
eval(parse(text = script))

remove("script")

## ------------------------------------------------------------------------
yahoo_id <- c(
  "SPY",
  "IYK", #Consumer Goods
  "IYC", #Consumer Services
  "IYE", #Energy
  "IYF", #Financials
  "IYJ", #Industrials
  "IYM", #Materials
  "IDU", #Utilities
  "IYH", #Health Care
  "IYW", #Technology
  "IYZ", #Telecomm
  "IYR" #Real State
)

price <- get_prices_yahoo(yahoo_id, "2010-01-01")


## ---- fig.width = 7------------------------------------------------------
returns <- get_returns_rollapply(price)

plot_returns(returns["2016/", 1:5])

cum_return <- get_returns_rollapply(price["2016/", ], is_cumulative = TRUE)

## ---- fig.width = 7------------------------------------------------------
plot_returns(cum_return[, 1:5])

## ------------------------------------------------------------------------
model = lm(SPY ~ -1 + IYK + IYC, data = returns)
model$coefficients

model = lm(SPY ~ -1 + IYK + IYC + IYE + IYF + IYJ + IYM + IDU + IYH + IYW + IYZ + IYR, data = returns)
model$coefficients

beta <- model$coefficients

## ---- fig.width = 7------------------------------------------------------
X <- returns[, -1]
Y <- returns[, 1]

cov_X <- cov(X, use = "pairwise.complete.obs")
P <- eigen(cov_X)$vectors
colnames(P) <- yahoo_id[-1]
d <- eigen(cov_X)$values

pp <- X %*% P
pp <- as.xts(pp, order.by = index(returns))

plot_returns(pp["2016/", 1:5])

## ------------------------------------------------------------------------
pp_returns <- data.frame(returns$SPY, pp)

model = lm(SPY ~ -1 + IYK + IYC, data = pp_returns)
model$coefficients

model = lm(SPY ~ -1 + IYK + IYC + IYE + IYF + IYJ + IYM + IDU + IYH + IYW + IYZ + IYR, data = pp_returns)
model$coefficients

## ------------------------------------------------------------------------
cov_ppY <- cov(pp_returns, Y, use = "pairwise.complete.obs")

cov_ppY/d


## ------------------------------------------------------------------------
cor(pp[, 1], Y, use = "pairwise.complete.obs")

