##' Convert an OpenMx MxModel object into an IFA group
##'
##' @param mxModel MxModel object
##' @param data observed data (otherwise the data will be taken from the mxModel)
##' @param container an MxModel in which to search for the latent distribution matrices
##' @return a groups with item parameters and latent distribution
as.IFAgroup <- function(mxModel, data=NULL, container=NULL) {
	expectation <- mxModel$expectation
  if (!is(expectation, "MxExpectationBA81")) {
    stop(paste("Don't know how to create an IFA group from",
               class(expectation)))
  }
	if (missing(container)) {
		container <- mxModel
	}

  mat <- expectation$item
  if (length(grep("\\.", mat))) {
    stop(paste("Don't know how to obtain the item matrix", mat))
  }
  itemMat <- mxModel[[mat]]
  if (is.null(itemMat)) {
    stop(paste("Item matrix", mat, "not found"))
  }
  
  ret <- list(spec = expectation$ItemSpec,
              param = itemMat$values,
              free = itemMat$free,
              qpoints = expectation$qpoints,
              qwidth = expectation$qwidth)
  
  mat <- expectation$mean
  if (length(grep("\\.", mat))) {
    meanMat <- eval(substitute(mxEval(theExpression, container),
			       list(theExpression = parse(text = mat)[[1]])))
    if (is.null(meanMat)) {
      stop(paste("Don't know how to obtain the mean matrix", mat))
    }
    ret$mean <- meanMat
  } else {
	  mxMat <- mxModel[[mat]]
	  if (!is.null(mxMat)) {
		  ret$mean <- mxMat$values
	  }
  }

  mat <- expectation$cov
  if (length(grep("\\.", mat))) {
    covMat <- eval(substitute(mxEval(theExpression, container),
				   list(theExpression = parse(text = mat)[[1]])))
    if (is.null(covMat)) {
      stop(paste("Don't know how to obtain the cov matrix", mat))
    }
    ret$cov <- covMat
  } else {
	  mxMat <- mxModel[[mat]]
	  if (!is.null(mxMat)) {
		  ret$cov <- mxMat$values
	  }
  }
  
  if (!missing(data)) {
    ret$data <- data
  } else if (!is.null(mxModel$data)) {
    mxData <- mxModel$data
    if (mxData$type != "raw") {
      stop(paste("Not sure how to handle data of type", mxData$type))
    }
    if (mxData$.isSorted) {
      unsort <- match(0:(length(mxData$indexVector)-1), mxData$indexVector)
      ret$data <- mxData$observed[unsort,]
    } else {
      ret$data <- mxData$observed
    }
  }

  if (!is.na(expectation$minItemsPerScore)) {
    ret$minItemsPerScore <- expectation$minItemsPerScore
  }

	# take minItemsPerScore into account TODO
  if (!is.na(expectation$weightColumn)) {
    ret$weightColumn <- expectation$weightColumn
    ret$observedStats <- nrow(ret$data) - 1
  } else {
	  if (ncol(ret$param) == ncol(ret$data)) {
		  freq <- tabulateRows(ret$data[orderCompletely(ret$data),])
		  ret$observedStats <- length(freq) - 1L
	  }
  }

  ret
}