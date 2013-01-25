\docType{methods}
\name{rpf.1dim.moment}
\alias{rpf.1dim.moment}
\title{Calculate cell moments}
\usage{
  rpf.1dim.moment(spec, params, scores, m)
}
\arguments{
  \item{spec}{list of item models}

  \item{params}{data frame of item parameters, 1 per row}

  \item{scores}{model derived person scores}

  \item{m}{which moment}
}
\value{
  moment matrix
}
\description{
  Popular moments include 2 (variance) and 4 (kurtosis).
}
