% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mean.conf.R
\docType{methods}
\name{mean.conf}
\alias{mean.conf}
\title{To compute the confidence interval of the Gaussian means of temperature}
\usage{
\S4method{mean.conf}{aptaqpcr}(aptaqpcr, mean.all = "No")
}
\arguments{
\item{aptaqpcr}{An object of the Class \code{aptaqpcr}, which is produced as an output of the
function \code{mean.conf}.}

\item{mean.all}{The default is "No", where the last Gaussian mean will be ommited. If mean.all is
defined as "Yes", the last Gaussian mean will also be included. We recommend to select as "No".}

\item{aptaqpcr}{An object of the Class \code{aptaqpcr}, which is produced as an output of the
function \code{mean.conf}. More details are provided in the \code{AptaqPCR} package vignette. See
also \code{\link[AptaqPCR]{apt.fit}} and \code{\link[AptaqPCR]{apt.fit.value}}.}
}
\value{
object of Class \code{aptaqpcr}.
}
\description{
Function \code{mean.conf} acts on an object of the Class \code{aptaqpcr}, which is
produced as an output of the function apt.fit.value and populates an object of Class \code{aptaqpcr}.
}
\details{
Function \code{mean.conf} acts on an object of the Class \code{aptaqpcr}, which is
produced as an output of the function apt.fit.value and populates an object of Class \code{aptaqpcr}.
}
\examples{
##To read the .csv file
file1 <- system.file("exData", "multiapt31.csv", package = "AptaqPCR")
read.datacsv <- ReadAptaqPCR(file1)

## To combine the replicates on the basis of the mean
meandata <- mean.apt(read.datacsv)

## To compute the first derivative of the combined replicates
diffdata <- diff.apt(meandata)

## To express the first derivative data
data <- slot(diffdata,"diffData")
temp <- data[,"temp"]  ##Temperature data

## To fit the negative of first derivative data to generate the fitting results in the
##form of values (an object of Class data.frame)

nc <- apt.fit(data[,"nc"],44,1,3,53,1,3,"BFGS",2e-9,temp)
b <- apt.fit(data[,"b"],44,1,3,53,1,3,"BFGS",2e-9,temp)
c <- apt.fit(data[,"c"],44,1,3,53,1,3,"BFGS",2e-9,temp)
d <- apt.fit(data[,"d"],44,1,3,53,1,3,"BFGS",2e-9,temp)
e <- apt.fit(data[,"e"],44,1,3,53,1,3,"BFGS",2e-9,temp)
f <- apt.fit(data[,"f"],44,1,3,53,1,3,"BFGS",2e-9,temp)
g <- apt.fit(data[,"g"],44,1,3,53,1,3,"BFGS",2e-9,temp)
h <- apt.fit(data[,"h"],44,1,3,53,1,3,"BFGS",2e-9,temp)

## implement the function apt.fit.value to combine all the results
aptfitalls <- apt.fit.value(nc,b,c,d,e,f,g,h,
conc = c("0 pM", "30.50 pM", "15.25 pM", "7.62 pM", "3.81 pM", "1.90 pM",
"0.95 pM","0.47 pM"))

## To compute the confidence intervals of the Gaussian means of temperature
## 1) By omitting the last value
conf.int <- mean.conf(aptfitalls)

## To express the mean values
slot(conf.int,"confMeanData")

## To express the confidence intervals
slot(conf.int,"confData")

## 2) By including the last value
conf.int.last <- mean.conf(aptfitalls, mean.all = "Yes")

## To express the mean values
slot(conf.int.last,"confMeanData")

## To express the confidence intervals
slot(conf.int.last,"confData")
}
\author{
Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@stamats.de}
}
\keyword{apt.fit,}
\keyword{apt.fit.value,}
\keyword{aptaqpcr,}
\keyword{mean.conf}
