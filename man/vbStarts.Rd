% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/vbStarts.R
\name{vbStarts}
\alias{vbStarts}
\title{Find reasonable starting values for a von Bertalanffy growth function.}
\usage{
vbStarts(formula, data = NULL, type = c("Typical", "typical",
  "BevertonHolt", "Original", "original", "vonBertalanffy", "GQ",
  "GallucciQuinn", "Mooij", "Weisberg", "Schnute", "Francis", "Somers",
  "Somers2"), ages2use = NULL, methEV = c("means", "poly"),
  meth0 = c("yngAge", "poly"), plot = FALSE, col.mdl = "gray70",
  lwd.mdl = 3, lty.mdl = 1, cex.main = 0.75, dynamicPlot = FALSE, ...)
}
\arguments{
\item{formula}{A formula of the form \code{len~age}.}

\item{data}{A data frame that contains the variables in \code{formula}.}

\item{type}{A string that indicates the parameterization of the von Bertalanffy model.}

\item{ages2use}{A numerical vector of the two ages to be used in the Schnute or Francis paramaterizations.  See details.}

\item{methEV}{A string that indicates how the lengths of the two ages in the Schnute paramaterization or the three ages in the Francis paramaterization should be derived.  See details.}

\item{meth0}{A string that indicates how the t0 and L0 paramaters should be derived.  See details.}

\item{plot}{A logical that indicates whether a plot of the data with the superimposed model fit at the starting values should be created.}

\item{col.mdl}{A color for the model when \code{plot=TRUE}.}

\item{lwd.mdl}{A line width for the model when \code{plot=TRUE}.}

\item{lty.mdl}{A line type for the model when \code{plot=TRUE}.}

\item{cex.main}{A character expansion value for the main title when \code{plot=TRUE}.}

\item{dynamicPlot}{A logical that indicates whether a plot with dynamically linked slider bars should be constructed for finding starting values.}

\item{\dots}{Further arguments passed to the methods.}
}
\value{
A list that contains reasonable starting values.  Note that the parameters will be listed in the same order and with the same names as listed in \code{\link{vbFuns}}.
}
\description{
Finds reasonable starting values for the parameters in a specific parameterization of the von Bertalanffy growth function.
}
\details{
This function attempts to find reasonable starting values for a variety of parameterizations of the von Bertalanffy growth function.  There is no guarantee that these starting values are the \sQuote{best} starting values.  One should use them with caution and should perform sensitivity analyses to determine the impact of different starting values on the final model results.

The Linf and K paramaters are estimated via the concept of the Ford-Walford plot.  The product of the starting values for Linf and K is used as a starting value for omega in the GallucciQuinn and Mooij parameterizations.  The result of log(2) divided by the starting value for K is used as the starting value for t50 in the Weisberg parameterization.

If \code{meth0="yngAge"}, then a starting value for t0 or L0 is found by algebraically solving the typical or original paramaterization, respectively, for t0 or L0 using the mean length of the first age with more than one data point as a \dQuote{known} quantity.  If \code{meth0="poly"} then a second-degree polynomial model is fit to the mean length-at-age data.  The t0 starting value is set equal to the root of the polynomial that is closest to zero.  The L0 starting value is set equal to the mean length at age-0 predicted from the polynomial function.

Starting values for the L1 and L3 parameters in the Schnute paramaterization and the L1, L2, and L3 parameters in the Francis parameterization may be found in two ways.  If \code{methEV="poly"}, then the starting values are the predicted length-at-age from a second-degree polynomial fit to the mean lengths-at-age data.  If \code{methEV="means"} then the observed sample means at the corresponding ages are used.  In the case where one of the supplied ages is fractional, then the value returned will be linearly interpolated between the mean lengths of the two closest ages.  The ages to be used for L1 and L3 in the Schnute and Francis parameterizations are supplied as a numeric vector of length 2 in \code{ages2use=}.  If \code{ages2use=NULL} then the minimum and maximum observed ages will be used.  In the Francis method, L2 will correspond to the age half-way between the two ages in \code{ages2use=}.  A warning will be given if L2<L1 for the Schnute method or if L2<L1 or L3<L2 for the Francis method.

Starting values can also be obtained by plotting the data with the model superimposed but tied to slider bars that allow the parameters to be interactively changed.  One can change the parameters until a reasonable fit is observed and then use those valeus as starting values.  Such a plot is constructed by including \code{dynamicPlot=TRUE}.  The initial parameters for the slider bars are the starting values constructed as described above.  It should be noted that the dynamic plot may show an error of \dQuote{[tcl] can't get device image}, but the plot will correctly update if the slider bar is adjusted.
}
\note{
The \sQuote{original} and \sQuote{vonBertalanffy} and the \sQuote{typical} and \sQuote{BevertonHolt} parameterizations are synonymous.
}
\section{IFAR Chapter}{
 12-Individual Growth.
}
\examples{
## Examples
data(SpotVA1)
vbStarts(tl~age,data=SpotVA1)
vbStarts(tl~age,data=SpotVA1,type="Original")
vbStarts(tl~age,data=SpotVA1,type="GQ")
vbStarts(tl~age,data=SpotVA1,type="Mooij")
vbStarts(tl~age,data=SpotVA1,type="Weisberg")
vbStarts(tl~age,data=SpotVA1,type="Francis",ages2use=c(0,5))
vbStarts(tl~age,data=SpotVA1,type="Schnute",ages2use=c(0,5))
vbStarts(tl~age,data=SpotVA1,type="Somers")
vbStarts(tl~age,data=SpotVA1,type="Somers2")

## Using a different method to find t0 and L0
vbStarts(tl~age,data=SpotVA1,meth0="yngAge")
vbStarts(tl~age,data=SpotVA1,type="original",meth0="yngAge")

## Using a different method to find the L1, L2, and L3
vbStarts(tl~age,data=SpotVA1,type="Francis",ages2use=c(0,5),methEV="means")
vbStarts(tl~age,data=SpotVA1,type="Schnute",ages2use=c(0,5),methEV="means")

## Example with a Plot
vbStarts(tl~age,data=SpotVA1,plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="original",plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="GQ",plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="Mooij",plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="Weisberg",plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="Francis",ages2use=c(0,5),plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="Schnute",ages2use=c(0,5),plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="Somers",plot=TRUE)
vbStarts(tl~age,data=SpotVA1,type="Somers2",plot=TRUE)

## Dynamic Plots Method -- ONLY RUN IN INTERACTIVE MODE
if (interactive()) {
  vbStarts(tl~age,data=SpotVA1,dynamicPlot=TRUE)
  vbStarts(tl~age,data=SpotVA1,type="original",dynamicPlot=TRUE)
  vbStarts(tl~age,data=SpotVA1,type="GQ",dynamicPlot=TRUE)
  vbStarts(tl~age,data=SpotVA1,type="Mooij",dynamicPlot=TRUE)
  vbStarts(tl~age,data=SpotVA1,type="Weisberg",dynamicPlot=TRUE)
  vbStarts(tl~age,data=SpotVA1,type="Francis",ages2use=c(0,5),dynamicPlot=TRUE)
  vbStarts(tl~age,data=SpotVA1,type="Schnute",ages2use=c(0,5),dynamicPlot=TRUE)
}

## See examples in vbFuns() for use of vbStarts() when fitting Von B models
}
\author{
Derek H. Ogle, \email{derek@derekogle.com}
}
\references{
Ogle, D.H.  2015.  \href{http://derekogle.com/IFAR}{Introductory Fisheries Analyses with R}.  Chapman & Hall/CRC, Boca Raton, FL.

See references in \code{\link{vbFuns}}.
}
\seealso{
See \code{\link{vbModels}} for a list of models and parameterizations used in \pkg{FSA} and \code{\link{vbFuns}} for functions that represent the von Bertalanffy parameterizations.
}
\keyword{manip}

