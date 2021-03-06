% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ageComparisons.R
\name{ageBias}
\alias{ageBias}
\alias{plot.ageBias}
\alias{summary.ageBias}
\title{Compute and view possible biases between paired sets of ages.}
\usage{
ageBias(formula, data, ref.lab = tmp$Enames, nref.lab = tmp$Rname,
  method = stats::p.adjust.methods, sig.level = 0.05, min.n.CI = 3)

\method{summary}{ageBias}(object, what = c("table", "symmetry", "Bowker",
  "EvansHoenig", "McNemar", "bias", "diff.bias", "n"), flip.table = FALSE,
  zero.print = "-", digits = 3, cont.corr = c("none", "Yates", "Edwards"),
  ...)

\method{plot}{ageBias}(x, what = c("bias", "sunflower", "numbers"),
  difference = FALSE, xlab = x$ref.lab, ylab = x$nref.lab,
  show.n = TRUE, nYpos = 1.03, cex.n = 0.75, lwd = 1,
  show.pts = FALSE, pch.pts = 19, col.pts = grDevices::rgb(0, 0, 0,
  transparency), transparency = 1/10, pch.mean = 95, cex.mean = lwd,
  col.CI = "black", col.CIsig = "red", lwd.CI = lwd, sfrac = 0,
  show.range = FALSE, col.range = "gray", lwd.range = lwd,
  col.agree = "black", lwd.agree = lwd, lty.agree = 2,
  cex.numbers = 0.9, xlim = NULL, ylim = NULL,
  yaxt = graphics::par("yaxt"), xaxt = graphics::par("xaxt"), ...)
}
\arguments{
\item{formula}{A formula of the form \code{nrefvar~refvar}, where \code{nrefvar} and \code{refvar} generically represent the variables that contain the paired \dQuote{nonreference} and \dQuote{reference} age assignments, respectively.  See details.}

\item{data}{A data.frame that minimally contains the paired age assignments given in \code{formula}.}

\item{ref.lab}{A string that contains a label for the reference age assignments.}

\item{nref.lab}{A string that contains a label for the nonreference age assignments.}

\item{method}{A string that indicates which method to use for adjusting p-values for multiple comparisons.  See \code{?p.adjust.methods}.}

\item{sig.level}{A numeric value used to determine whether a p-value indicates a significant result.  The confidence level used in \code{plot} is 100*(1-\code{sig.level}).}

\item{min.n.CI}{A numeric value (default is 3) that indicates the smallest sample size for which a confidence interval should be computed.}

\item{what}{A string that indicates what type of summary to print or plot to construct.  See details.}

\item{flip.table}{A logical that indicates whether the age-agreement table should be \sQuote{flipped} (i.e., rows are reversed so that younger ages are at the bottom of the table).  This makes the table more directly comparable to the age-bias plot.}

\item{zero.print}{A string that indicates what should be printed in place of the zeroes on an age-agreement table.  The default is to print a single dash.}

\item{digits}{A numeric value that indicates the minimum number of digits to print when showing \code{what="bias"} or \code{what="diff.bias"} in \code{summary}.}

\item{cont.corr}{A string that indicates the continuity correction method to be used with (only) McNemar test.  If \code{"none"} (default) then no continuity correction is used, if \code{"Yates"} then 0.5 is used, and if \code{"Edwards"} then 1 is used.}

\item{x,object}{An object of class \code{ageBias}, usually a result from \code{ageBias}.}

\item{difference}{A logical that indicates whether or not the difference between the two age assignments should be used.  See details.}

\item{xlab,ylab}{A string that contains a label for the x-axis (reference) or y-axis (non-reference) age assignments, respectively.}

\item{show.n}{A logical that indicates whether the sample sizes for each level of the x-axis variable is shown (\code{=TRUE}, default) or not (\code{=FALSE}).}

\item{nYpos}{A numeric value that indicates the relative Y position of the sample size values when \code{show.n=TRUE}.  For example, if \code{nYpos=1.03} then the sample size values will be centered at 3 percent above the top end of the y-axis.}

\item{cex.n}{A character expansion value for the size of the sample size values.}

\item{lwd}{A single numeric value that can be used to control the separate \sQuote{lwd} argument (e.g., \code{lwd.CI}, \code{lwd.range}).}

\item{show.pts}{A logical that indicates whether to show the raw data points.}

\item{pch.pts}{A numeric value that indicates the plotting character to be used when plotting the raw data points.}

\item{col.pts}{A string or numeric value that indicates the color to be used for plotting the raw data points.  The default is to use black with the transparency found in \code{transparency}.}

\item{transparency}{A numeric value (between 0 and 1) that indicates the level of transparency to use for plotting the raw data points.  If expressed as 1/x, then x points plotted on top of each other will represent the color in \code{col.pts}.}

\item{pch.mean}{A numeric value that indicates the plotting character to be used for the mean values (i.e., center of confidence interval bars).}

\item{cex.mean}{A character expansion value for the size of the mean symbol in \code{pch.mean}.}

\item{col.CI}{A string or numeric value that indicates the color to be used for confidence interval bars that are considered non-significant.}

\item{col.CIsig}{A string or numeric value that indicates the color to be used for confidence interval bars that are considered significant.}

\item{lwd.CI}{A numeric value that indicates the line width for the confidence interval bars.}

\item{sfrac}{A numeric value that controls the size of the ends of the confidence interval bars.  See \code{sfrac} in \code{\link[plotrix]{plotCI}} of \pkg{plotrix}.}

\item{show.range}{A logical that indicates whether to show vertical bars that represent the range of the data points.}

\item{col.range}{A string or numeric value that indicates the color to be used for the interval representing the range of the data.}

\item{lwd.range}{A numeric value that indicates the line width for the interval representing the range of the data.}

\item{col.agree}{A string or numeric value that indicates the color for the 1:1 or zero (if difference) reference line.}

\item{lwd.agree}{A numeric value that indicates the line width for the 1:1 or zero (if difference) reference line.}

\item{lty.agree}{A numeric value that indicates the line type for the 1:1 or zero (if difference) reference line.}

\item{cex.numbers}{A character expansion value for the size of the numbers plotted when \code{what="numbers"} is used.}

\item{xlim,ylim}{A numeric vector of length 2 that contains the limits of the x-axis (reference ages) or y-axis (non-reference ages), respectively.}

\item{xaxt,yaxt}{A string which specifies the x- and y-axis types. Specifying \dQuote{n} suppresses plotting of the axis.  See \code{?par}.}

\item{\dots}{Additional arguments for methods.}
}
\value{
\code{ageBias} returns a list with the following items:
\itemize{
  \item data A data.frame with the original paired age assignments and the difference between those assignements.
  \item agree The age-agreement table.
  \item bias A data.frame that contains the bias statistics.
  \item bias.diff A data.frame that contains the bias statistics for the differences.
  \item ref.lab A string that contains an optional label for the age assignments in the columns (reference) of the age-agreement table.
  \item nref.lab A string that contains an optional label for the age assignments in the rows (non-reference) of the age-agreement table.
}

The \code{summary} returns the result if \code{what=} contains one item, otherwise it returns nothing.  Nothing is returned by \code{plot}, but see details for a description of the plot that is produced.
}
\description{
Constructs age-agreement tables, statistical tests to detect bias, and plots to visualize potential bias in paired age assignments.  Ages may be from, for example, two readers of the same structure, one reader at two times, two stuctures (e.g., scales, spines, otoliths), or a structure and known ages, or one structure and known ages.
}
\details{
Generally, one of the two age assessments will be identified as the \dQuote{reference} set.  In some cases this may be the true ages, the ages from the more experience reader, the ages from the first reading, or the ages from the structure gnerally thought to provide the most accurate results.  In other cases, such as comparing two novice readers, the choice may be arbitrary.  The reference ages will form the columns of the age-agreement table and will be the \dQuote{constant} age used in the t-tests and age-bias plots (i.e., the x-axis).  See further details below.

The age-agreement table is constructed with  \code{what="table"} in \code{summary}.  The agreement table can be \dQuote{flipped}, i.e., the rows in descending rather than ascending order, with \code{flip.table=TRUE}.  By default, the tables are shown with zeroes replaced by dashes.  This behavior can be changed with \code{zero.print}.

Three statistical tests of symmetry for the age-agreement table can be computed with \code{what=} in \code{summary}.  The \dQuote{unpooled} or Bowker test as described in Hoenig et al. (1995) is constructed with \code{what="Bowker"}, the \dQuote{semi-pooled} or Evans-Hoenig test as described in Evans and Hoenig (1998) is constructed with \code{what="EvansHoenig"}, and the \dQuote{pooled} or McNemar test as described in Evans and Hoenig (1998) is constructed with \code{what="McNemar"}.  All three tests are run simultaneously with \code{what="symmetry"}.

An age-bias plot, as defined by Campana et al. (1995), is constructed with \code{what="bias"} (the default) in \code{plot}.  The reference variable from the \code{ageBias} call is plotted on the x-axis.  Plotted confidence intervals are computed for the mean of the non-reference ages at each age of the reference ages.  The level of confidence is controlled by \code{sig.level=} given in the original \code{ageBias} call (i.e., confidence level is 100*(1-\code{sig.level}).  Confidence intervals are only shown if the sample size is greater than the value in \code{min.n.CI=}.  Confidence intervals plotted in red do not contain the reference age (see discussion of t-tests below).  Vertical lines that connect the minimum to the maximum observed value of the y-axis variable at each age of the x-axis variable are plotted in grey if \code{show.range=TRUE}.  Individual points are plotted if \code{show.pts=TRUE}  The 1:1 (45 degree) agreement line is shown for comparative purposes.  The sample sizes at each age of the x-axis variable are shown if \code{show.n=TRUE} (the default).  The position of the sample sizes is controlled with \code{nYpos=}.

An age-bias plot, as defined by Muir et al. (2008), is constructed as defined above but by also including \code{difference=TRUE} in \R{plot} so that the y-axis is the difference in the paired reference and non-reference ages from the \code{ageBias} call (specifically, non-reference-reference).

The frequency of observations at each unique (x,y) coordinate are shown by using \code{what="numbers"} in \code{plot}.

A \dQuote{sunflower plot}, which contains a symbol for each unique (x,y) coordinate with as many \dQuote{petals} as observations at that point, is constructed with \code{what="sunflower"} in \code{plot}.  A sunflower plot with differences between the two structures can be constructed by also including \code{difference=TRUE}.

Individual t-tests to determine if the mean age of the non-reference set at a particular age of the reference set is equal to the reference age (e.g., is the mean age of the non-reference at age-3 of the reference set statistically equal to 3?) are shown with \code{what="bias"} in \code{summary}.  The results provide a column that indicates whether the difference is significant or not as determined by adjusted p-values from the t-tests and using the signficance level provided in \code{sig.level} (defaults to 0.05).  Similar results for the difference in ages (e.g., is the mean row variable age minus column variable age at column variable age-3 equal to 0?) are constructed with \code{what="diff.bias"} in \code{summary}.

The sample size present in the age-agreement table is found with \code{what="n"}.
}
\section{Testing}{
 Tested all symmetry test results against results in Evans and Hoenig (2008), the McNemar and Evans-Hoenig results against results from \code{\link[fishmethods]{compare2}} in \pkg{fishmethods}, and all results using the \code{\link[FSAdata]{AlewifeLH}} data set from \pkg{FSAdata} against results from \url{http://www.nefsc.noaa.gov/fbp/age-prec/}.
}

\section{IFAR Chapter}{
 4-Age Comparisons.
}
\examples{
data(WhitefishLC)
ab1 <- ageBias(scaleC~otolithC,data=WhitefishLC,ref.lab="Otolith Age",nref.lab="Scale Age")
summary(ab1)
summary(ab1,what="symmetry")
summary(ab1,what="Bowker")
summary(ab1,what="EvansHoenig")
summary(ab1,what="McNemar")
summary(ab1,what="McNemar",cont.corr="Yates")
summary(ab1,what="bias")
summary(ab1,what="diff.bias")
summary(ab1,what="n")
summary(ab1,what=c("n","symmetry","table"))
# show the zeroes (rather than dashes)
summary(ab1,what="table",zero.print="0")
# flip the table -- ease of comparison to age-bias plot
summary(ab1,what="table",flip.table=TRUE)

## default plot
plot(ab1)
## demonstrates squaring up the axes
plot(ab1,ylim=c(-1,23),xlim=c(-1,23))
## plot with the data points shown
plot(ab1,show.pts=TRUE,transparency=1/8)
## plot with the range shown
plot(ab1,show.range=TRUE)
## plot with no difference in significance bar colors
plot(ab1,col.CIsig="black")
## plot of differences (note could use same modifications as shown above)
plot(ab1,difference=TRUE)
## sunflower plot
plot(ab1,what="sunflower")
plot(ab1,what="sunflower",difference=TRUE)
## "Numbers" plot
plot(ab1,what="number",col.agree="gray50")
}
\author{
Derek H. Ogle, \email{derek@derekogle.com}
}
\references{
Ogle, D.H.  2015.  \href{http://derekogle.com/IFAR}{Introductory Fisheries Analyses with R}.  Chapman & Hall/CRC, Boca Raton, FL.

Campana, S.E., M.C. Annand, and J.I. McMillan. 1995.  \href{http://www.bio.gc.ca/otoliths/documents/Campana\%20et\%20al\%201995\%20TAFS.pdf}{Graphical and statistical methods for determining the consistency of age determinations.} Transactions of the American Fisheries Society 124:131-138.

Evans, G.T. and J.M. Hoenig.  1998.  Testing and viewing symmetry in contingency tables, with application to readers of fish ages.  Biometrics 54:620-629.

Hoenig, J.M., M.J. Morgan, and C.A. Brown. 1995.  Analysing differences between two age determination methods by tests of symmetry.  Canadian Journal of Fisheries And Aquatic Systems 52:364-368.

McBride, R.S.  2015. Diagnosis of paired age agreement: A simulation approach of accuracy and precision effects. ICES Journal of Marine Science, XX:XXX-XXX.

Muir, A.M., M.P. Ebener, J.X. He, and J.E. Johnson.  2008.  \href{http://www.tandfonline.com/doi/abs/10.1577/M06-160.1}{A comparison of the scale and otolith methods of age estimation for lake whitefish in Lake Huron.}  North American Journal of Fisheries Management 28:625-635.
}
\seealso{
See \code{\link{agePrecision}} for measures of precision between pairs of age assignments.  See \code{\link[fishmethods]{compare2}} in \pkg{fishmethods} for similar functionality.
}
\keyword{htest}
\keyword{manip}

