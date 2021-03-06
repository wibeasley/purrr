% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/zip.R
\name{zip_n}
\alias{zip2}
\alias{zip3}
\alias{zip_n}
\title{Zip lists.}
\usage{
zip_n(.x, .fields = NULL, .simplify = FALSE)

zip2(.x, .y, .fields = NULL, .simplify = FALSE)

zip3(.x, .y, .z, .fields = NULL, .simplify = FALSE)
}
\arguments{
\item{.x,.y,.z}{Lists or vectors}

\item{.fields}{Fields to use when unzipping - defaults to the names
of the first sub-list.}

\item{.simplify}{If \code{TRUE}, lists containing atomic scalars of
the same type will be converted to a vector.}
}
\description{
Zip turns a list-of-lists "inside-out".  For example, if you had a
list of length n where each component had values \code{a} and
\code{b}, \code{zip_n()} would make a list with elements \code{a} and
\code{b} that contained lists of length n.
}
\details{
Note that \code{zip_n()} is its own inverse, much like the
transpose operation on a matrix. You can get back the original
input by zipping it twice. \code{zip2(x, y)} is a shortcut for
\code{zip_n(list(x, y))}.
}
\examples{
x <- rerun(5, x = runif(1), y = runif(5))
x \%>\% str()
x \%>\% zip_n() \%>\% str()
x \%>\% zip_n() \%>\% zip_n() \%>\% str()

x <- list(a = 1:5, b = 5:1)
x \%>\% zip_n()
x \%>\% zip_n(.simplify = TRUE)

# Zipping is its own inverse operation
x \%>\% str()
x \%>\% zip_n(.simplify = TRUE) \%>\% zip_n(.simplify = TRUE) \%>\% str()

# zip2(x, y) is a shortcut for zip_n(list(x, y)). It can be handy
# but doesn't handle names and is not its own inverse.
x \%>\% zip_n() \%>\% str()
zip2(1:5, 5:1) \%>\% str()
}

