#'@name apt.fit.value
#'@aliases apt.fit.value
#'@title To combine the data of the fitting results
#'@description Function \code{apt.fit.value} combines the data of the fitting results, produced
#'as an output of the function \code{apt.fit} and uses the data to populate an object of
#'Class \code{"aptaqpcr"}. The function \code{apt.fit.value} acts as a link between the functions
#'\code{apt.fit} and \code{mean.conf} as well as between \code{apt.fit} and \code{tempconc.plot}.
#'@param nc an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param b an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param c an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param d an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param e an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param f an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param g an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param h an object of data.frame, which is produced as an output of the function \code{apt.fit}.
#'@param conc a character vector to define the names of the columns. If conc is missing, then,
#'in that case default column names will be provided. The default names are nc, b, c, d, e, f,
#'g and h.
#'@return object of Class \code{"aptaqpcr"}.
#'@details Function \code{apt.fit.value} combines the data of the fitting results, produced
#'as an output of the function \code{apt.fit} and uses the data to populate an object of
#'Class \code{"aptaqpcr"}. The function \code{apt.fit.value} acts as a link between the functions
#'\code{apt.fit} and \code{mean.conf} as well as between \code{apt.fit} and \code{tempconc.plot}.
#'More details are provided in the \code{AptaqPCR} package vignette. See also \code{\link[AptaqPCR]{apt.fit}},
#'\code{\link[AptaqPCR]{mean.conf}} and \code{\link[AptaqPCR]{tempconc.plot}}.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, apt.fit, apt.fit.value, mean.conf, tempconc.plot
#'@examples
#'##To read the .csv file
#'file1 <- system.file("exData", "multiapt31.csv", package = "AptaqPCR")
#'read.datacsv <- ReadAptaqPCR(file1)
#'
#'## To combine the replicates on the basis of the mean
#'meandata <- mean.apt(read.datacsv)
#'
#'## To compute the first derivative of the combined replicates
#'diffdata <- diff.apt(meandata)
#'
#'## To express the first derivative data
#'data <- slot(diffdata,"diffData")
#'temp <- data[,"temp"] ##Temperature data
#'
#'## To fit the negative of first derivative data to generate the fitting results in the
#'##form of values (an object of Class data.frame)
#'
#'nc <- apt.fit(data[,"nc"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'b <- apt.fit(data[,"b"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'c <- apt.fit(data[,"c"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'d <- apt.fit(data[,"d"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'e <- apt.fit(data[,"e"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'f <- apt.fit(data[,"f"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'g <- apt.fit(data[,"g"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'h <- apt.fit(data[,"h"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'
#'## implement the function apt.fit.value to combine all the results
#'## default column names
#'aptfitall <- apt.fit.value(nc,b,c,d,e,f,g,h)
#'
#'##To express the combined fitting results
#'slot(aptfitall,"fitData")
#'
#'## By defining column names (specific)
#'aptfitalls <- apt.fit.value(nc,b,c,d,e,f,g,h,
#'conc = c("0 pM", "30.50 pM", "15.25 pM","7.62 pM", "3.81 pM", "1.90 pM",
#'"0.95 pM","0.47 nM"))
#'
#'##To express the combined fitting results
#'slot(aptfitalls,"fitData")
#'@export
apt.fit.value <- function(nc,b,c,d,e,f,g,h,
                          conc = c("0nM", "1nM", "2nM","3nM", "4nM", "5nM","6nM","7nM")){
  fit.data <- as.data.frame(cbind(nc,b,c,d,e,f,g,h))
  if (missing(conc)){
    names(fit.data) <- c("nc","b","c","d","e","f","g","h")
  }
  else{
    names(fit.data) <- c(conc[1],conc[2],conc[3],conc[4],conc[5],conc[6],
                         conc[7],conc[8])
  }
    fit.datanew <- new("aptaqpcr",fitData = fit.data)
    fit.datanew
}
