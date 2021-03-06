#' @title Lengths and weights for Chinook Salmon from three locations in Argentina.
#'
#' @description Lengths and weights for Chinook Salmon from three locations in Argentina.
#'
#' @name ChinookArg
#' 
#' @docType data
#' 
#' @format A data frame with 112 observations on the following 3 variables:
#'  \describe{
#'    \item{tl}{Total length (cm)}
#'    \item{w}{Weight (kg)}
#'    \item{loc}{Capture location (Argentina, Petrohue, Puyehue)} 
#'  }
#' 
#' @section Topic(s):
#'  \itemize{
#'    \item Weight-Length 
#'  }
#' 
#' @concept 'Weight-Length'
#' 
#' @keywords datasets
#' 
#' @examples
#' data(ChinookArg)
#' str(ChinookArg)
#' head(ChinookArg)
#' op <- par(mfrow=c(2,2),pch=19)
#' plot(w~tl,data=ChinookArg,subset=loc=="Argentina")
#' plot(w~tl,data=ChinookArg,subset=loc=="Petrohue")
#' plot(w~tl,data=ChinookArg,subset=loc=="Puyehue")
#' par(op)
#'
NULL