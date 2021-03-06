% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/map.R
\name{map_call}
\alias{map_call}
\title{Map a list to a function call}
\usage{
map_call(.x, .f, ...)
}
\arguments{
\item{.x}{A list or a vector. Vectors are coerced to a list.}

\item{.f}{A function or the name of a function to call with the
elements of \code{.x} as arguments.}

\item{...}{Additional arguments passed on to \code{.f}.}
}
\description{
While \code{\link{lift_dl}()} wraps a function in
\code{\link{do.call}()}, \code{map_call()} is directly equivalent
to \code{do.call()} except that it takes a list as first argument
instead of a function. This makes `map_call()` pipable.
}
\examples{
# We map a list of strings to paste(), with sep = "-" and the
# string "2001" as additional arguments
list("01", "01") \%>\%
  map(~ sub("^01", "10", .)) \%>\%
  map_call("paste", "2001", sep = "-")
}
\seealso{
\code{\link{lift_dl}()} and \code{\link{do.call}()}
}

