% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/FSAUtils.R
\name{oddeven}
\alias{is.even}
\alias{is.odd}
\alias{oddeven}
\title{Determine if a number is odd or even.}
\usage{
is.odd(x)

is.even(x)
}
\arguments{
\item{x}{A numeric vector.}
}
\value{
A logical vector of the same length as x.
}
\description{
Determine if a number is odd or even.
}
\examples{
## Individual values
is.odd(1)
is.odd(2)
is.even(3)
is.even(4)

## Vector of values
d <- 1:8
data.frame(d,odd=is.odd(d),even=is.even(d))
}
\author{
Derek H. Ogle, \email{derek@derekogle.com}
}
\keyword{manip}

