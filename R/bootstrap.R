#' @name bootstrap
#' 
#' @title Associated S3 methods for bootCase from car.
#'
#' @description Provides S3 methods to construct non-parametric bootstrap confidence intervals, hypothesis tests, and plots of the parameter estimates for \code{\link[car]{bootCase}} objects from the \pkg{car} package.
#'
#' @details \code{confint} finds the two quantiles that have the (1-\code{conf.level})/2 proportion of bootstrapped parameter estimates below and above.  This is an approximate 100\code{conf.level}\% confidence interval.
#' 
#' \code{predict} applies a user-supplied function to each row of \code{object} and then finds the median and the two quantiles that have the proportion (1-\code{conf.level})/2 of the bootstrapped predictions below and above.  The median is returned as the predicted value and the quantiles are returned as an approximate 100\code{conf.level}\% confidence interval for that prediction.
#'
#' In \code{htest} the \dQuote{direction} of the alternative hypothesis is identified by a string in the \code{alt=} argument.  The strings may be \code{"less"} for a \dQuote{less than} alternative, \code{"greater"} for a \dQuote{greater than} alternative, or \code{"two.sided"} for a \dQuote{not equals} alternative (the DEFAULT).  In the one-tailed alternatives the p-value is the proportion of bootstrapped parameter estimates in \code{object$coefboot} that are extreme of the null hypothesized parameter value in \code{bo}.  In the two-tailed alternative the p-value is twice the smallest of the proportion of bootstrapped parameter estimates above or below the null hypothesized parameter value in \code{bo}.
#'
#' @aliases confint.bootCase htest.bootCase hist.bootCase plot.bootCase predict.bootCase
#'
#' @param object,x A \code{bootCase} object.
#' @param parm A number or string that indicates which column of \code{object} contains the parameter estimates to use for the confidence interval or hypothesis test.
#' @param conf.level A level of confidence as a proportion.
#' @param level Same as \code{conf.level}.
#' @param plot A logical that indicates whether a plot should be constructed.  If \code{confint} then a histogram of the \code{parm} parameters from the bootstrap samples with error bars that illustrate the bootstrapped confidence intervals will be constructed.  If code{htest} then a histogram of the \code{parm} parameters with a vertical line illustrating the \code{bo} value will be constructed.
#' @param err.col A single numeric or character that identifies the color for the error bars on the plot.
#' @param err.lwd A single numeric that identifies the line width for the error bars on the plot.
#' @param rows A single numeric that contains the number of rows to use on the graphic.
#' @param cols A single numeric that contains the number of columns to use on the graphic.
#' @param FUN The function to be applied for the prediction.  See the examples.
#' @param MARGIN A single numeric that indicates the margin over which \code{FUN} is applied.  \code{MARGIN=1} will apply to each row and is the default.
#' @param digits A single numeric that indicates the number of digits for the result.
#' @param bo The null hypothesized parameter value.
#' @param alt A string that indicates the \dQuote{direction} of the alternative hypothesis.  See details.
#' @param same.ylim A logical that indicates whether the same limits for the y-axis should be used on each histogram.  Defaults to \code{TRUE}.  Ignored if \code{ylmts} is non-null.
#' @param ymax A single value that sets the maximum y-axis limit for each histogram or a vector of length equal to the number of groups that sets the maximum y-axis limit for each histogram separately.
#' @param col A named color for the histogram bars.
#' @param \dots Additional items to send to functions.
#'
#' @return If \code{object} is a matrix, then \code{confint} returns a matrix with as many rows as columns (i.e., parameter estimates) in \code{object} and two columns of the quantiles that correspond to the approximate confidence interval.  If \code{object} is a vector, then \code{confint} returns a vector with the two quantiles that correspond to the approximate confidence interval.
#'
#' \code{htest} returns a two-column matrix with the first column containing the hypothesized value sent to this function and the second column containing the corresponding p-value.
#'
#' \code{hist} constructs histograms of the bootstrapped parameter estimates.
#'
#' \code{plot} constructs scatterplots of all pairs of bootstrapped parameter estimates.
#'
#' \code{predict} returns a matrix with one row and three columns, with the first column holding the predicted value (i.e., the median prediction) and the last two columns holding the approximate confidence interval.
#'
#' @author Derek H. Ogle, \email{derek@@derekogle.com}
#'
#' @seealso \code{\link[car]{bootCase}} in \pkg{car}.
#'
#' @references S. Weisberg (2005). \emph{Applied Linear Regression}, third edition.  New York: Wiley, Chapters 4 and 11.
#' 
#' @keywords htest
#' 
#' @examples
#' data(Ecoli)
#' fnx <- function(days,B1,B2,B3) {
#'   if (length(B1) > 1) {
#'     B2 <- B1[2]
#'     B3 <- B1[3]
#'     B1 <- B1[1]
#'   }
#'   B1/(1+exp(B2+B3*days))
#' }
#' nl1 <- nls(cells~fnx(days,B1,B2,B3),data=Ecoli,start=list(B1=6,B2=7.2,B3=-1.45))
#' if (require(car)) {    # for bootCase()
#'   nl1.boot <- car::bootCase(nl1,B=99)  # B=99 too small to be useful
#'   confint(nl1.boot,"B1")
#'   confint(nl1.boot,c(2,3))
#'   confint(nl1.boot,conf.level=0.90)
#'   predict(nl1.boot,fnx,days=3)
#'   htest(nl1.boot,1,bo=6,alt="less")
#'   hist(nl1.boot)
#'   plot(nl1.boot)
#'   cor(nl1.boot)
#' }
#'
#' @rdname bootCase
#' @export
confint.bootCase <- function(object,parm=NULL,level=conf.level,conf.level=0.95,plot=FALSE,
                             err.col="black",err.lwd=2,rows=NULL,cols=NULL,...) {
  iCIBoot(object,parm,conf.level,plot,err.col,err.lwd,rows,cols,...)
}

#' @rdname bootCase
#' @export
predict.bootCase <- function(object,FUN,MARGIN=1,conf.level=0.95,digits=NULL,...) {
  iPredictBoot(object,FUN=FUN,MARGIN=MARGIN,conf.level=conf.level,digits=digits,...)
}

#' @rdname bootCase
#' @export
htest.bootCase <- function(object,parm=NULL,bo=0,alt=c("two.sided","less","greater"),plot=FALSE,...) {
  iHTestBoot(object,parm=parm,bo=bo,alt=alt,plot=plot)
}

#' @rdname bootCase
#' @export
hist.bootCase <- function(x,same.ylim=TRUE,ymax=NULL,
                          rows=round(sqrt(ncol(x))),cols=ceiling(sqrt(ncol(x))),...){
  ## Set parameters
  op <- graphics::par("mfrow")
  graphics::par(mfrow=c(rows,cols))
	## If not given ymax, then find highest count on all histograms
  if (is.null(ymax)) {
    for (i in 1:ncol(x)) ymax[i] <- max(hist.formula(~x[,i],plot=FALSE,warn.unused=FALSE,...)$counts)
  }
  if (same.ylim) ymax <- rep(max(ymax),length(ymax))
	## Make the plots
	for(i in 1:ncol(x)) hist.formula(~x[,i],xlab=colnames(x)[i],ylim=c(0,ymax[i]),...)
  graphics::par(mfrow=op)
}

#' @rdname bootCase
#' @export
plot.bootCase <- function(x,...){
	np <- ncol(x)
	lay <- lower.tri(matrix(0,(np-1),(np-1)), TRUE)
	lay[which(lay, TRUE)] <- 1:choose(np,2)
	graphics::layout(lay)
	for(i in 1:(np-1))
		for(j in (i+1):np)
		  graphics::plot(x[,i],x[,j],xlab=colnames(x)[i],ylab=colnames(x)[j],pch=20)
}





#' @title Associated S3 methods for nlsBoot from nlstools.
#'
#' @description Provides S3 methods to construct non-parametric bootstrap confidence intervals and hypothesis tests for parameter values and predicted values of the response variable for a \code{\link[nlstools]{nlsBoot}} object from the \pkg{nlstools} package.
#'
#' @details \code{confint} finds the two quantiles that have the proportion (1-\code{conf.level})/2 of the bootstrapped parameter estimates below and above.  This is an approximate 100\code{conf.level}\% confidence interval.
#' 
#' In \code{htest} the \dQuote{direction} of the alternative hypothesis is identified by a string in the \code{alt=} argument.  The strings may be \code{"less"} for a \dQuote{less than} alternative, \code{"greater"} for a \dQuote{greater than} alternative, or \code{"two.sided"} for a \dQuote{not equals} alternative (the DEFAULT).  In the one-tailed alternatives the p-value is the proportion of bootstrapped parameter estimates in \code{object$coefboot} that are extreme of the null hypothesized parameter value in \code{bo}.  In the two-tailed alternative the p-value is twice the smallest of the proportion of bootstrapped parameter estimates above or below the null hypothesized parameter value in \code{bo}.
#' 
#' In \code{predict}, a user-supplied function is applied to each row of the \code{coefBoot} object in a \code{nlsBoot} object and then finds the median and the two quantiles that have the proportion (1-\code{conf.level})/2 of the bootstrapped predictions below and above.  The median is returned as the predicted value and the quantiles are returned as an approximate 100\code{conf.level}\% confidence interval for that prediction.
#'
#' @param object An object saved from \code{nlsBoot()}.
#' @param parm An integer that indicates which parameter to compute the confidence interval or hypothesis test for.  The confidence interval Will be computed for all parameters if \code{NULL}.
#' @param conf.level A level of confidence as a proportion. 
#' @param level Same as \code{conf.level}.  Used for compatability with the main \code{confint}.
#' @param plot A logical that indicates whether a plot should be constructed.  If \code{confint}, then a histogram of the \code{parm} parameters from the bootstrap samples with error bars that illustrate the bootstrapped confidence intervals will be constructed.  If code{htest}, then a histogram of the \code{parm} parameters with a vertical lines illustrating the \code{bo}value will be constructed.
#' @param err.col A single numeric or character that identifies the color for the error bars on the plot.
#' @param err.lwd A single numeric that identifies the line width for the error bars on the plot.
#' @param rows A numeric that contains the number of rows to use on the graphic.
#' @param cols A numeric that contains the number of columns to use on the graphic.
#' @param FUN The function to be applied for the prediction.  See the examples.
#' @param MARGIN A single numeric that indicates the margin over which \code{FUN} is applied.  \code{MARGIN=1} will apply to each row and is the default.
#' @param digits A single numeric that indicates the number of digits for the result.
#' @param bo The null hypothesized parameter value.
#' @param alt A string that identifies the \dQuote{direction} of the alternative hypothesis.  See details.
#' @param \dots Additional arguments to functions.
#'
#' @return
#' \code{confint} returns a matrix with as many rows as columns (i.e., parameter estimates) in the \code{object$coefboot} data frame and two columns of the quantiles that correspond to the approximate confidence interval.
#' 
#' \code{htest} returns a matrix with two columns.  The first column contains the hypothesized value sent to this function and the second column is the corresponding p-value.
#' 
#' \code{predict} returns a matrix with one row and three columns, with the first column holding the predicted value (i.e., the median prediction) and the last two columns holding the approximate confidence interval.
#'
#' @author Derek H. Ogle, \email{derek@@derekogle.com}
#'
#' @seealso See \code{\link[nlstools]{summary.nlsBoot}} in \pkg{nlstools}
#'
#' @aliases confint.nlsboot
#'
#' @keywords htest
#'
#' @examples
#' data(Ecoli)
#' fnx <- function(days,B1,B2,B3) {
#'   if (length(B1) > 1) {
#'     B2 <- B1[2]
#'     B3 <- B1[3]
#'     B1 <- B1[1]
#'   }
#'   B1/(1+exp(B2+B3*days))
#' }
#' nl1 <- nls(cells~fnx(days,B1,B2,B3),data=Ecoli,start=list(B1=6,B2=7.2,B3=-1.45))
#' if (require(nlstools)) {
#'   nl1.boot <-  nlstools::nlsBoot(nl1,niter=99)  # way too few
#'   confint(nl1.boot,"B1")
#'   confint(nl1.boot,c(2,3))
#'   confint(nl1.boot,conf.level=0.90)
#'   predict(nl1.boot,fnx,days=3)
#'   htest(nl1.boot,1,bo=6,alt="less")
#' }
#' 
#' @rdname nlsBoot
#' @export
confint.nlsBoot <- function(object,parm=NULL,level=conf.level,conf.level=0.95,plot=FALSE,
                            err.col="black",err.lwd=2,rows=NULL,cols=NULL,...) {
  iCIBoot(object$coefboot,parm,conf.level,plot,err.col,err.lwd,rows,cols,...)
}

#' @rdname nlsBoot
#' @export
predict.nlsBoot <- function(object,FUN,MARGIN=1,conf.level=0.95,digits=NULL,...) {
  iPredictBoot(object$coefboot,FUN=FUN,MARGIN=MARGIN,conf.level=conf.level,digits=digits,...)
}

#' @rdname nlsBoot
#' @export
htest <- function(object, ...) {
  UseMethod("htest") 
}

#' @rdname nlsBoot
#' @export
htest.nlsBoot <- function(object,parm=NULL,bo=0,alt=c("two.sided","less","greater"),plot=FALSE,...) {
  iHTestBoot(object$coefboot,parm=parm,bo=bo,alt=alt,plot=plot)
}


##############################################################
## INTERNAL FUNCTIONS
##############################################################
## ===========================================================
## Confindence intervals from bootstrapped results
##   should work for bootCase and nlsboot results
## ===========================================================
iCIBoot <- function(object,parm,conf.level,plot,err.col,err.lwd,rows,cols,...) {
  #### internal function to find CIs
  cl <- function(x) stats::quantile(x,c((1-conf.level)/2,1-(1-conf.level)/2))
  #### end internal function
  #### Main function
  ## Perform some checks on parm
  # if parm=NULL then set to all paramaters
  if (is.null(parm)) parm <- colnames(object)
  else {
    if (is.numeric(parm)) {
      # check numeric parm
      if (max(parm)>ncol(object)) stop("Number in 'parm' exceeds number of columns.",call.=FALSE)
      if (min(parm)<=0) stop("Number in 'parm' must be positive.",call.=FALSE)
    } else {
      # check named parm
      if (!all(parm %in% colnames(object))) stop("Name in 'parm' does not exist in object.",call.=FALSE)
    }
  }
  ## Reduce object to have only the parm columns in it
  object <- object[,parm]
  ## Compute CIs for each column, but handle differently if vector or matrix
  if (is.null(dim(object))) {
    # A vector, then only one parameter
    res <- cl(object)
    names(res) <- iCILabel(conf.level)
  } else {
    res <- t(apply(object,2,cl))
    colnames(res) <- iCILabel(conf.level)
    rownames(res) <- colnames(object)
  }
  ## Make plot if asked for
  if (plot) {
    ## Plotting depends on whether one vector or not
    if (length(parm)==1) {
      ## one histogram
      h <- hist.formula(~object,xlab=parm,main="")
      plotrix::plotCI(mean(object),y=0.95*max(h$counts),li=res[1],ui=res[2],err="x",
             pch=19,col=err.col,lwd=err.lwd,add=TRUE,...)
    } else {
      ## multiple histograms
      np <- ncol(object)
      if (is.null(rows)) rows <- round(sqrt(np))
      if (is.null(cols)) cols <- ceiling(sqrt(np))
      op <- graphics::par("mfrow")
      graphics::par(mfrow=c(rows,cols))
      for (i in 1:np) {
        h <- hist.formula(~object[,i],xlab=colnames(object)[i],...)
        plotrix::plotCI(mean(object[,i]),y=0.95*max(h$counts),li=res[i,1],ui=res[i,2],err="x",
               pch=19,col=err.col,lwd=err.lwd,add=TRUE)
      }
      graphics::par(mfrow=op)
    }
  }
  ## Return CI result
  res
}

## ===========================================================
## Predictions, with intervals, from bootstrapped results
##   should work for bootCase and nlsboot results
## ===========================================================
iPredictBoot <- function(object,FUN,MARGIN,conf.level,digits,...) {
  res <- stats::quantile(apply(object,MARGIN=MARGIN,FUN=FUN,...),c(0.5,0.5-conf.level/2,0.5+conf.level/2))
  if (!is.null(digits)) res <- round(res,digits)
  names(res) <- c("prediction",iCILabel(conf.level))
  res
}

## ===========================================================
## Hypothesis testing from bootstrapped results
##   should work for bootCase and nlsboot results
## ===========================================================
iHTestBoot <- function(object,parm,bo,alt=c("two.sided","less","greater"),plot=FALSE) {
  ## Some checks
  alt <- match.arg(alt)
  ## Multiple parm values in object, make sure a parm was selected
  ## if it was then reduce object to vector of that parm
  if (!is.null(dim(object))) {
    if (is.null(parm)) stop("You must select a parameter number to test.",call.=FALSE)
    else {
      # check parm
      if (length(parm)>1) stop("'parm' must be of length 1.",call.=FALSE)
      else {
        if (is.numeric(parm)) {
          # the column number was too small or too big
          if (parm>ncol(object)) stop("Number in 'parm' exceeds number of columns.",call.=FALSE)
          if (parm<=0) stop("Number in 'parm' must be positive.",call.=FALSE)
        } else {
          # column name does not exist in the matrix
          if (!parm %in% colnames(object)) stop("Name in 'parm' does not exist in object.",call.=FALSE)
        }
        object <- object[,parm]
      }
    }
  }
  ## Calculate one-sided p-values
  p.lt <- length(object[object>bo])/length(object)
  p.gt <- length(object[object<bo])/length(object)
  ## Calculate p-value based on choice in alt
  switch(alt,
         less=p.value <- p.lt,
         greater=p.value <- p.gt,
         two.sided=p.value <- 2*min(p.lt,p.gt)
  )
  ## Put together a result to return
  res <- cbind(bo,p.value)
  colnames(res) <- c("Ho Value","p value")
  rownames(res) <- ""
  ## Make a plot if asked for
  if (plot) {
    hist.formula(~object,xlab=colnames(object),main="")
    graphics::abline(v=bo,col="red",lwd=2,lty=2)
  }
  ## Return the result
  res
}
