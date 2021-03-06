% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample.R
\name{rpf.sample}
\alias{rpf.sample}
\title{Randomly sample response patterns given a list of items}
\usage{
rpf.sample(
  theta,
  items,
  params,
  ...,
  prefix = "i",
  mean = NULL,
  cov = NULL,
  mcar = 0,
  grp = NULL
)
}
\arguments{
\item{theta}{either a vector (for 1 dimension) or a matrix (for >1
dimension) of person abilities or the number of response patterns
to generate randomly}

\item{items}{a list of item models}

\item{params}{a list or matrix of item parameters. If omitted, random item
parameters are generated for each item model.}

\item{...}{Not used.  Forces remaining arguments to be specified by name.}

\item{prefix}{Column names are taken from param or items.
If no column names are available, some will be generated using
the given prefix.}

\item{mean}{mean vector of latent distribution (optional)}

\item{cov}{covariance matrix of latent distribution (optional)}

\item{mcar}{proportion of generated data to set to NA (missing completely at random)}

\item{grp}{a list containing the model and data. See the details section.}
}
\value{
Returns a data frame of response patterns
}
\description{
Returns a random sample of response patterns given a list of item
models and parameters. If \code{grp} is given then theta, items, params,
mean, and cov can be omitted.
}
\section{Format of a group}{


A model, or group within a model, is represented as a named list.
\describe{
\item{spec}{list of response model objects}
\item{param}{numeric matrix of item parameters}
\item{free}{logical matrix of indicating which parameters are free (TRUE) or fixed (FALSE)}
\item{mean}{numeric vector giving the mean of the latent distribution}
\item{cov}{numeric matrix giving the covariance of the latent distribution}
\item{data}{data.frame containing observed item responses, and optionally,
weights and frequencies}
\item{score}{factors scores with response patterns in rows}
\item{weightColumn}{name of the data column containing the numeric row weights (optional)}
\item{freqColumn}{name of the data column containing the integral row frequencies (optional)}
\item{qwidth}{width of the quadrature expressed in Z units}
\item{qpoints}{number of quadrature points}
\item{minItemsPerScore}{minimum number of non-missing items when estimating factor scores}
}

The \code{param} matrix stores items parameters by column. If a
column has more rows than are required to fully specify a model
then the extra rows are ignored.  The order of the items in
\code{spec} and order of columns in \code{param} are assumed to
match. All items should have the same number of latent dimensions.
Loadings on latent dimensions are given in the first few rows and
can be named by setting rownames. Item names are assigned by
\code{param} colnames.

Currently only a multivariate normal distribution is available,
parameterized by the \code{mean} and \code{cov}. If \code{mean} and
\code{cov} are not specified then a standard normal distribution is
assumed. The quadrature consists of equally spaced points. For
example, \code{qwidth=2} and \code{qpoints=5} would produce points
-2, -1, 0, 1, and 2. The quadrature specification is part of the
group and not passed as extra arguments for the sake of
consistency. As currently implemented, OpenMx uses EAP scores to
estimate latent distribution parameters. By default, the exact same
EAP scores should be produced by \link{EAPscores}.
}

\examples{
# 1 dimensional items
i1 <- rpf.drm()
i1.p <- rpf.rparam(i1)
i2 <- rpf.nrm(outcomes=3)
i2.p <- rpf.rparam(i2)
rpf.sample(5, list(i1,i2), list(i1.p, i2.p))
}
\seealso{
\code{\link{sample}}
}
