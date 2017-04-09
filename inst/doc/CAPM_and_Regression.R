## ---- warning = FALSE, message = FALSE-----------------------------------
library("metodosMultivariados2017")

load.packages(strspl("RCurl, 
                     lubridate, 
                     xts, 
                     dplyr, 
                     tidyr, 
                     plotly"))

## ---- warning = FALSE, message =  FALSE----------------------------------
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
returns <- get_returns(price)

plot_returns(returns["2016/", ])

## ---- fig.width = 7------------------------------------------------------
cum_return <- get_returns(price["2016/", ], is_cumulative = TRUE)

plot_returns(cum_return[, ])

## ------------------------------------------------------------------------
model = lm(SPY ~ -1 + IYK + IYC, data = returns)
model$coefficients

## ------------------------------------------------------------------------
model = lm(SPY ~ -1 + IYK + IYC + IYE + IYF + IYJ + IYM + IDU + IYH + IYW + IYZ + IYR, data = returns)
model$coefficients

beta <- model$coefficients

## ---- fig.width = 7------------------------------------------------------
X <- returns[, -1]
Y <- returns[, 1]

cov_X <- cov(X, use = "pairwise.complete.obs")
P <- eigen(cov_X)$vectors
colnames(P) <- paste("PC", 1:ncol(P), sep = "")
d <- eigen(cov_X)$values

## ---- fig.width = 7------------------------------------------------------
pp <- X %*% P
pp <- as.xts(pp, order.by = index(returns))

plot_returns(pp["2016/", ])

## ------------------------------------------------------------------------
pp_returns <- data.frame(returns$SPY, pp)

model = lm(SPY ~ -1 + PC1 + PC2, data = pp_returns)
model$coefficients

## ------------------------------------------------------------------------
model = lm(SPY ~ -1 + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10 + PC11, data = pp_returns)
model$coefficients

## ------------------------------------------------------------------------
cov_ppY <- cov(pp, Y, use = "pairwise.complete.obs")
print(cov_ppY)

## ------------------------------------------------------------------------
cov_ppY/d

## ------------------------------------------------------------------------
cor(pp[, 1], Y, use = "pairwise.complete.obs")

