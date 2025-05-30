% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diagnose.R
\name{multinomialFit}
\alias{multinomialFit}
\title{Multinomial fit test}
\usage{
multinomialFit(
  grp,
  independenceGrp,
  ...,
  method = "lr",
  log = TRUE,
  .twotier = TRUE
)
}
\arguments{
\item{grp}{a list containing the model and data. See the details section.}

\item{independenceGrp}{the independence group}

\item{...}{Not used.  Forces remaining arguments to be specified by name.}

\item{method}{lr (default) or pearson}

\item{log}{whether to report p-value in log units}

\item{.twotier}{whether to use the two-tier optimization (default TRUE)}
}
\description{
For degrees of freedom, we use the number of observed statistics
(incorrect) instead of the number of possible response patterns
(correct) (see Bock, Giibons, & Muraki, 1998, p. 265). This is not
a huge problem because this test is becomes poorly calibrated when
the multinomial table is sparse. For more accurate p-values, you
can conduct a Monte-Carlo simulation study (see examples).
}
\details{
Rows with missing data are ignored.

The full information test is described in Bartholomew & Tzamourani
(1999, Section 3).

For CFI and TLI, you must provide an \code{independenceGrp}.
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
# Create an example IFA group
grp <- list(spec=list())
grp$spec[1:10] <- rpf.grm()
grp$param <- sapply(grp$spec, rpf.rparam)
colnames(grp$param) <- paste("i", 1:10, sep="")
grp$mean <- 0
grp$cov <- diag(1)
grp$uniqueFree <- sum(grp$param != 0)
grp$data <- rpf.sample(1000, grp=grp)

# Monte-Carlo simulation study
mcReps <- 3    # increase this to 10,000 or so
stat <- rep(NA, mcReps)
for (rx in 1:mcReps) {
   t1 <- grp
   t1$data <- rpf.sample(grp=grp)
   stat[rx] <- multinomialFit(t1)$statistic
}
sum(multinomialFit(grp)$statistic > stat)/mcReps   # better p-value
}
\references{
Bartholomew, D. J., & Tzamourani, P. (1999). The
goodness-of-fit of latent trait models in attitude
measurement. \emph{Sociological Methods and Research, 27}(4), 525-546.

Bock, R. D., Gibbons, R., & Muraki, E. (1988). Full-information
item factor analysis. \emph{Applied Psychological Measurement, 12}(3),
261-280.
}
\seealso{
Other diagnostic: 
\code{\link{ChenThissen1997}()},
\code{\link{SitemFit}()},
\code{\link{SitemFit1}()},
\code{\link{rpf.1dim.fit}()},
\code{\link{sumScoreEAPTest}()}
}
\concept{diagnostic}
