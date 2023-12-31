#' OptiLCMS: A package for computating the notorious bar statistic.
#'
#' The OptiLCMS package provides a pipeline for metabolomics processing.
#' 
#' @section OptiLCMS functions:
#' The OptiLCMS functions ...
#'
#' @docType package
#' @name OptiLCMS
#' @useDynLib OptiLCMS, .registration=TRUE, .fixes = "C_"
NULL
#> NULL



######## =-------- Call C by .C -------= ########

#' continuousPtsAboveThreshold
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
continuousPtsAboveThreshold <-
  function(y, threshold, num, istart = 1) {
    if (!is.double(y))
      y <- as.double(y)

      if (.C(
        C_continuousPtsAboveThreshold,
        y,
        as.integer(istart - 1),
        length(y),
        threshold = as.double(threshold),
        num = as.integer(num),
        n = integer(1)
      )$n > 0)
        TRUE
      else
        FALSE

  }

#' continuousPtsAboveThresholdIdx
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
continuousPtsAboveThresholdIdx <-
  function(y, threshold, num, istart = 1) {
    if (!is.double(y))
      y <- as.double(y)

      as.logical(
        .C(
          C_continuousPtsAboveThresholdIdx,
          y,
          as.integer(istart - 1),
          length(y),
          threshold = as.double(threshold),
          num = as.integer(num),
          n = integer(length(y))
        )$n
      )
      
  }

#' descendMin
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
descendMin <- function(y, istart = which.max(y)) {
  if (!is.double(y))
    y <- as.double(y)

    unlist(.C(
      C_DescendMin,
      y,
      length(y),
      as.integer(istart - 1),
      ilower = integer(1),
      iupper = integer(1)
    )[4:5]) + 1

}

#' which.colMax
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
which.colMax <- function (x, na.rm = FALSE, dims = 1) {
  if (is.data.frame(x))
    x <- as.matrix(x)
  if (!is.array(x) || length(dn <- dim(x)) < 2)
    stop("`x' must be an array of at least two dimensions")
  if (dims < 1 || dims > length(dn) - 1)
    stop("invalid `dims'")
  n <- prod(dn[seq_len(dims)])
  dn <- dn[-(seq_len(dims))]
  if (!is.double(x))
    x <- as.double(x)

    z <- .C(C_WhichColMax,
            x,
            as.integer(n),
            as.integer(prod(dn)),
            integer(prod(dn)),
            PACKAGE = "OptiLCMS")[[4]]

  if (length(dn) > 1) {
    dim(z) <- dn
    dimnames(z) <- dimnames(x)[-(seq_len(dims))]
  }
  else
    names(z) <- dimnames(x)[[dims + 1]]
  z
}

#' descendZero
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
descendZero <- function(y, istart = which.max(y)) {
  if (!is.double(y))
    y <- as.double(y)

    unlist(
      .C(
        C_DescendZero,
        y,
        length(y),
        as.integer(istart - 1),
        ilower = integer(1),
        iupper = integer(1),
        PACKAGE = "OptiLCMS"
      )[4:5]
    ) + 1

}

#' colMax
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
colMax <- function (x, na.rm = FALSE, dims = 1) {
  if (is.data.frame(x))
    x <- as.matrix(x)
  if (!is.array(x) || length(dn <- dim(x)) < 2)
    stop("`x' must be an array of at least two dimensions")
  if (dims < 1 || dims > length(dn) - 1)
    stop("invalid `dims'")
  n <- prod(dn[seq_len(dims)])
  dn <- dn[-(seq_len(dims))]
  if (!is.double(x))
    x <- as.double(x)

    z <- .C(C_ColMax,
            x,
            as.integer(n),
            as.integer(prod(dn)),
            double(prod(dn)),
            PACKAGE = "OptiLCMS")[[4]]

  if (length(dn) > 1) {
    dim(z) <- dn
    dimnames(z) <- dimnames(x)[-(seq_len(dims))]
  }
  else
    names(z) <- dimnames(x)[[dims + 1]]
  z
}

#' rectUnique
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
rectUnique <-
  function(m,
           order = seq(length = nrow(m)),
           xdiff = 0,
           ydiff = 0) {
    nr <- nrow(m)
    nc <- ncol(m)
    if (!is.double(m))
      m <- as.double(m)

      .C(
        C_RectUnique,
        m,
        as.integer(order - 1),
        nr,
        nc,
        as.double(xdiff),
        as.double(ydiff),
        logical(nrow(m))
      )[[7]]

}

#' findEqualGreaterM
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
findEqualGreaterM <- function(x, values) {
  if (!is.double(x))
    x <- as.double(x)
  if (!is.double(values))
    values <- as.double(values)

    .C(C_FindEqualGreaterM,
       x,
       length(x),
       values,
       length(values),
       index = integer(length(values)))$index + 1

}


######## = ------- Call C by .Call -----= #########
#' R_set_obiwarp
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
R_set_obiwarp <-
  function(valscantime1,
           scantime1,
           mzvals,
           mzs,
           cntrPr,
           valscantime2,
           scantime2,
           curP,
           parms) {

      rtadj <-
        .Call(
          C_R_set_obiwarp,
          valscantime1,
          scantime1,
          mzvals,
          mzs,
          cntrPr$profMat,
          valscantime2,
          scantime2,
          mzvals,
          mzs,
          curP$profMat,
          parms$response,
          parms$distFun,
          parms$gapInit,
          parms$gapExtend,
          parms$factorDiag,
          parms$factorGap,
          as.numeric(parms$localAlignment),
          parms$initPenalty,
          PACKAGE = 'OptiLCMS'
        )
 
    return (rtadj)
  }

#' getEIC4Peaks
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
getEIC4Peaks <-
  function(mset, peaks, maxscans) {
    mset$env$mz <-
      lapply(MSnbase::spectra(mset$onDiskData, BPPARAM = SerialParam()),
             mz)
    mset$env$intensity <-
      MSnbase::intensity(mset$onDiskData, BPPARAM = SerialParam())
    
    mset$scantime <- MSnbase::rtime(mset$onDiskData)
    
    valCount <- cumsum(lengths(mset$env$mz, FALSE))
    ## Get index vector for C calls
    mset$scanindex <-
      as.integer(c(0, valCount[-length(valCount)])) 
    
    npeaks <- dim(peaks)[1]
    
    scans  <- length(mset$scantime)
    eics <- matrix(NA, npeaks, maxscans)
    
    mset$env$mz <- as.double(unlist(mset$env$mz))
    mset$env$intensity <- as.double(unlist(mset$env$intensity))
    scan_time_leng <- as.integer(length(mset$scantime))
    
    MessageOutput(paste0(npeaks, " peaks found!"), "\n", NULL)
    
    for (p in seq_len(npeaks)) {
      timerange <- c(peaks[p, "rtmin"], peaks[p, "rtmax"])
      tidx <-
        which((mset$scantime >= timerange[1]) &
                (mset$scantime <= timerange[2]))
      
      if (length(tidx) > 0) {
        scanrange <- range(tidx)
      } else{
        scanrange <- seq_len(scans)
      }
      massrange <- c(peaks[p, "mzmin"], peaks[p, "mzmax"])

        eic <- .Call(
          C_getEIC,
          mset$env$mz,
          mset$env$intensity,
          as.integer(mset$scanindex),
          as.double(massrange),
          as.integer(scanrange),
          scan_time_leng,
          PACKAGE = 'OptiLCMS'
        )$intensity
        
      eic[eic == 0] <- NA;
      eics[p, scanrange[1]:scanrange[2]] <- eic;
    }
    
    eics
  }

#' breaks_on_nBins
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
breaks_on_nBins <-
  function(fromX, toX, nBins, shiftByHalfBinSize = FALSE) {
    if (missing(fromX) | missing(toX) | missing(nBins))
      stop("'fromX', 'toX' and 'nBins' are required!")
    if (!is.double(fromX))
      fromX <- as.double(fromX)
    if (!is.double(toX))
      toX <- as.double(toX)
    if (!is.integer(nBins))
      nBins <- as.integer(nBins)
    shiftIt <- 0L
    
    if (shiftByHalfBinSize) {
      shiftIt <- 1L
    }
    
      res <- .Call(C_breaks_on_nBins, fromX, toX, nBins, shiftIt,
                   PACKAGE = "OptiLCMS")
    
    return(res)
  }

#' imputeLinInterpol
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
imputeLinInterpol <-
  function(x,
           baseValue,
           method = "lin",
           distance = 1L,
           noInterpolAtEnds = FALSE) {
    method <-
      match.arg(method, c("none", "lin", "linbase")) ## interDist? distance = 2
    if (method == "none") {
      return(x)
    }
    if (!is.double(x))
      x <- as.double(x)
    
    if (method == "lin") {
      noInter <- 0L
      if (noInterpolAtEnds)
        noInter <- 1L
        res <- .Call(C_impute_with_linear_interpolation,
                     x,
                     noInter,
                     PACKAGE = "OptiLCMS")
      
      return(res)
    }
    
    if (method == "linbase") {
      if (missing(baseValue))
        baseValue <- min(x, na.rm = TRUE) / 2
      if (!is.double(baseValue))
        baseValue <- as.double(baseValue)
      if (!is.integer(distance))
        distance <- as.integer(distance)

        res <- .Call(C_impute_with_linear_interpolation_base,
                     x,
                     baseValue,
                     distance,
                     PACKAGE = "OptiLCMS")
      
      return(res)
    }
  }

#' binYonX
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
binYonX <- function(x,
                    y,
                    breaks,
                    nBins,
                    binSize,
                    binFromX,
                    binToX,
                    fromIdx = 1L,
                    toIdx = length(x),
                    method = "max",
                    baseValue,
                    sortedX = !is.unsorted(x),
                    shiftByHalfBinSize = FALSE,
                    returnIndex = FALSE,
                    returnX = TRUE) {
  if (!missing(x) & missing(y))
    y <- x
  if (missing(x) | missing(y))
    stop("Arguments 'x' and 'y' are mandatory!")
  if (missing(nBins) & missing(binSize) & missing(breaks))
    stop("One of 'breaks', 'nBins' or 'binSize' has to be defined!")
  if (!sortedX) {
    message("'x' is not sorted, will sort 'x' and 'y'.")
    ## Sort method; see issue #180 for MSnbase
    ## Note: order method = "radix" is considerably faster - but there is no
    ## method argument for older R versions.
    o <- order(x)
    x <- x[o]
    y <- y[o]
  }
  ## Check fromIdx and toIdx
  if (any(fromIdx < 1) | any(toIdx > length(x)))
    stop("'fromIdx' and 'toIdx' have to be within 1 and lenght(x)!")
  if (length(toIdx) != length(fromIdx))
    stop("'fromIdx' and 'toIdx' have to have the same length!")
  if (missing(binFromX))
    binFromX <- as.double(NA)
  if (missing(binToX))
    binToX <- as.double(NA)
  ## For now we don't allow NAs in x
  if (anyNA(x))
    stop("No 'NA' values are allowed in 'x'!")
  ## Check that input values have the correct data types.
  if (!is.double(x))
    x <- as.double(x)
  if (!is.double(y))
    y <- as.double(y)
  if (!is.double(binFromX))
    binFromX <- as.double(binFromX)
  if (!is.double(binToX))
    binToX <- as.double(binToX)
  if (!is.integer(fromIdx))
    fromIdx <- as.integer(fromIdx)
  if (!is.integer(toIdx))
    toIdx <- as.integer(toIdx)
  ## breaks has precedence over nBins over binSize.
  shiftIt <- 0L
  if (!missing(breaks)) {
    if (shiftByHalfBinSize)
      warning("Argument 'shiftByHalfBinSize' is ignored if 'breaks'",
              " are provided.")
    if (!is.double(breaks))
      breaks <- as.double(nBins)
    nBins <- NA_integer_
    binSize <- as.double(NA)
  } else {
    if (!missing(nBins)) {
      breaks <- as.double(NA)
      if (!is.integer(nBins))
        nBins <- as.integer(nBins)
      binSize <- as.double(NA)
    } else{
      breaks <- as.double(NA)
      nBins <- NA_integer_
      if (!is.double(binSize))
        binSize <- as.double(binSize)
    }
  }
  if (shiftByHalfBinSize)
    shiftIt <- 1L
  ## Define default value for baseValue
  if (missing(baseValue)) {
    baseValue = as.double(NA)
  } else {
    if (!is.double(baseValue))
      baseValue <- as.double(baseValue)
  }
  
  getIndex <- 0L
  if (returnIndex)
    getIndex <- 1L
  getX <- 0L
  if (returnX)
    getX <- 1L
  if (length(toIdx) > 1) {
      .Call(
        C_binYonX_multi,
        x,
        y,
        breaks,
        nBins,
        binSize,
        binFromX,
        binToX,
        force(fromIdx - 1L),
        force(toIdx - 1L),
        shiftIt,
        as.integer(.aggregateMethod2int(method)),
        baseValue,
        getIndex,
        getX,
        PACKAGE = "OptiLCMS"
      )

  } else {

      .Call(
        C_binYonX,
        x,
        y,
        breaks,
        nBins,
        binSize,
        binFromX,
        binToX,
        force(fromIdx - 1L),
        force(toIdx - 1L),
        shiftIt,
        as.integer(.aggregateMethod2int(method)),
        baseValue,
        getIndex,
        getX,
        PACKAGE = "OptiLCMS"
      )
  }
}


#' massifquantROIs
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
massifquantROIs <- function(mz,
                            int,
                            scanindex,
                            scantime,
                            mzrange,
                            scanrange,
                            minIntensity,
                            minCentroids,
                            consecMissedLim,
                            ppm,
                            criticalVal,
                            segs,
                            scanBack) {

  ROIs <-
      .Call(
        C_massifquant,
        mz,
        int,
        scanindex,
        scantime,
        as.double(mzrange),
        as.integer(scanrange),
        as.integer(length(scantime)),
        as.double(minIntensity),
        as.integer(minCentroids),
        as.double(consecMissedLim),
        as.double(ppm),
        as.double(criticalVal),
        as.integer(segs),
        as.integer(scanBack),
        PACKAGE = 'OptiLCMS'
      )

  return(ROIs)
  
}

#' getEIC
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
getEIC <-
  function(mz,
           int,
           scanindex,
           mzrange,
           scanrange) {

      noised <- .Call(
        C_getEIC,
        mz,
        int,
        scanindex,
        as.double(mzrange),
        as.integer(scanrange),
        as.integer(length(scanindex)),
        PACKAGE = "OptiLCMS"
      )

    return(noised)
  }

#' getMZ
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
getMZ <- function(mz,
                  int,
                  scanindex,
                  mzrange,
                  scrange,
                  scantime) {

    omz <- .Call(
      C_getMZ,
      mz,
      int,
      scanindex,
      as.double(mzrange),
      as.integer(scrange),
      as.integer(length(scantime))
    )

  return(omz)
}


#' findmzROI
#' @noRd
#' @references Smith, C.A. et al. 2006. {Analytical Chemistry}, 78, 779-787
findmzROI <- function(mz,
                      int,
                      scanindex,
                      scanrange,
                      scantime,
                      param,
                      minCentroids) {

    roiList <- .Call(
      C_findmzROI,
      mz,
      int,
      scanindex,
      as.double(c(0.0, 0.0)),
      as.integer(scanrange),
      as.integer(length(scantime)),
      as.double(param$ppm * 1e-6),
      as.integer(minCentroids),
      as.integer(param$prefilter),
      as.integer(param$noise),
      PACKAGE = "OptiLCMS"
    )
    
  return(roiList)
  
}
