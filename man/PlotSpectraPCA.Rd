% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Spectra_visulization.R
\name{PlotSpectraPCA}
\alias{PlotSpectraPCA}
\title{PlotSpectraPCA}
\usage{
PlotSpectraPCA(mSet = NULL, imgName, format = "png", dpi = 72, width = NA)
}
\arguments{
\item{mSet}{mSet object, usually generated after the peakannotaion finished here.}

\item{imgName}{Character, to give the name of BPI figures ploted.}

\item{format}{Character, to give the format of BPI figures ploted. Can be "jpeg", "png", "pdf", "svg",
"tiff" or "ps". Default is "png".}

\item{dpi}{Numeric, to define the dpi of the figures. Default is 72.}

\item{width}{Numeric, to define the width of the figure. Height = width * 0.618.}
}
\value{
will return a figure of PCA after log tranformation (log2)
}
\description{
This function is used to plot the PCA of all spectra
}
\examples{
data(mSet);
newPath <- dir(system.file("mzData", package = "mtbls2"),
               full.names = TRUE, recursive = TRUE)[c(10, 11, 12)]
mSet <- updateRawSpectraPath(mSet, newPath);
PlotSpectraPCA(mSet);
}
