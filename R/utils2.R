#' @import lubridate
#' @import xts

#' @title load.packages
#' @description The load.packages function loads a 
#' list of packages.
#' @param pkgs Character array containing names of 
#' packages.
#' @param repos character indicating the URL of a CRAN 
#' mirror. http://cran.itam.mx is the default value.
#' @details The function will try to load each package.
#' 
#' If it fails, the function will proceed to install 
#' along with its dependecies.
#'
#' Newly installed packages will be loaded as well.
#'
#' Two lists are printed: the list of packages that 
#' could be loaded and the list of packages that failed 
#' to be installed.
#'
#' sessionInfo() is called at the end of the function.
#' @export
load.packages <- function(
  pkgs,
  repos = "http://cran.itam.mx"
) {
  
  attached <- paste()
  failed <- paste()
  
  for(package in pkgs) {
    
    if(!library(package,
                character.only = TRUE,
                logical.return = TRUE)) {
      
      install.packages(package,
                       dependencies = TRUE,
                       repos = repos)
      
      if(!library(package,
                  character.only = TRUE,
                  logical.return = TRUE)) {
        
        failed <- paste(failed, "\n\t", package)
        
      } else attached <- paste(attached, "\n\t", package)
      
    }else attached <- paste(attached, "\n\t", package)
  }
  
  if(length(attached)==0) attached <- "\n\t None"
  if(length(failed)==0) failed <- "\n\t None"
  
  attached <- paste("\nSuccessfully attached packages:",
                    attached)
  failed <- paste("\nPackages that failed to be installed:",
                  failed)
  
  cat("\n############################################################")
  cat(attached)
  cat(failed)
  cat("\n############################################################\n\n")
  
  sessionInfo()
}

#' @title strspl
#' @description Split the elements of a character 
#' vector \code{x} into substrings according to the 
#' matches to substring \code{split} within them. A 
#' character vector is returned. Blank spaces, tabs
#' and line breaks are removed.
#' @param x character vector, each element of which 
#' is to be split. Other inputs, including a factor, 
#' will give an error.
#' @param split character vector containing regular 
#' expressions to use for splitting. If empty matches 
#' occur, in particular if \code{split} has length 0, 
#' \code{x} is split into single characters. If 
#' \code{split} has length greater that 1, it is 
#' re-cycled along. Default value is ','.
#' @details See strsplit \{base\}.
#' @export
strspl <- function (
  x,
  split = ','
) {
  gsub("[ ]+|\n|\t", "", unlist(strsplit(x, split)))
}

#' @title weighted.geometric.mean
#' @description Compute a weighted geometric mean.
#' @param x a vector or dataframe containing the values
#' whose weighted geometric mean is to be computed.
#' @param w a vector of weights.
#' @param na.rm remove NA for values before processing,
#' the default value is FALSE.
#' @details See weighted.mean \{stats\} or geometric.mean 
#' \{psych\}.
#' @export
weighted.geometric.mean <- function (
  x,
  w,
  na.rm = FALSE
) {
  if (is.null(nrow(x))) {
    exp(weighted.mean(log(x), w, na.rm = na.rm))
  }
  else {
    exp(apply(log(x), 2, weighted.mean, w, na.rm = na.rm))
  }
}

#' @title startpoints
#' @description Extract index values of a given 
#' \code{xts} object corresponding to the first 
#' observation given a period specified by \code{on}.
#' @param x an xts object.
#' @param on the periods starpoints to find as a 
#' character string.
#' @param k along every k-th element.
#' @details Extends xts.
#' @export
startpoints <- function (
  x,
  on = "months",
  k = 1
) {
  head(xts::endpoints(x, on, k) + 1, -1)
}