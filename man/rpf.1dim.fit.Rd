% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diagnose.R
\name{rpf.1dim.fit}
\alias{rpf.1dim.fit}
\title{Calculate item and person Rasch fit statistics}
\usage{
rpf.1dim.fit(
  spec,
  params,
  responses,
  scores,
  margin,
  group = NULL,
  wh.exact = TRUE
)
}
\arguments{
\item{spec}{list of item response models \lifecycle{deprecated}}

\item{params}{matrix of item parameters, 1 per column \lifecycle{deprecated}}

\item{responses}{persons in rows and items in columns \lifecycle{deprecated}}

\item{scores}{model derived person scores \lifecycle{deprecated}}

\item{margin}{for people 1, for items 2}

\item{group}{spec, params, data, and scores can be provided in a list instead of as arguments}

\item{wh.exact}{whether to use the exact Wilson-Hilferty transformation}
}
\description{
Note: These statistics are only appropriate if all discrimination
parameters are fixed equal and items are conditionally independent
(see \code{\link{ChenThissen1997}}).  A best effort is made to
cope with missing data.
}
\details{
Exact distributional properties of these statistics are unknown
(Masters & Wright, 1997, p. 112).  For details on the calculation,
refer to Wright & Masters (1982, p. 100).

The Wilson-Hilferty transformation is biased for less than 25 items.
Consider wh.exact=FALSE for less than 25 items.
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
data(kct)
responses <- kct.people[,paste("V",2:19, sep="")]
rownames(responses) <- kct.people$NAME
colnames(responses) <- kct.items$NAME
scores <- kct.people$MEASURE
params <- cbind(1, kct.items$MEASURE, logit(0), logit(1))
rownames(params) <- kct.items$NAME
items<-list()
items[1:18] <- rpf.drm()
params[,2] <- -params[,2]
rpf.1dim.fit(items, t(params), responses, scores, 2, wh.exact=TRUE)
}
\references{
Masters, G. N. & Wright, B. D. (1997). The Partial
Credit Model. In W. van der Linden & R. K. Kambleton (Eds.),
\emph{Handbook of modern item response theory}
(pp. 101-121). Springer.

Wilson, E. B., & Hilferty, M. M. (1931). The distribution of
chi-square. \emph{Proceedings of the National Academy of Sciences of the
United States of America,} 17, 684-688.

Wright, B. D. & Masters, G. N. (1982). \emph{Rating Scale
Analysis.} Chicago: Mesa Press.
}
\seealso{
Other diagnostic: 
\code{\link{ChenThissen1997}()},
\code{\link{SitemFit}()},
\code{\link{SitemFit1}()},
\code{\link{multinomialFit}()},
\code{\link{sumScoreEAPTest}()}
}
\concept{diagnostic}
