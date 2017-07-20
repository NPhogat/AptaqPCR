#'@name mean.conf
#'@aliases mean.conf
#'@title To compute the confidence interval of the Gaussian means of temperature
#'@description Function \code{mean.conf} acts on an object of the Class \code{aptaqpcr}, which is
#'produced as an output of the function apt.fit.value and populates an object of Class \code{aptaqpcr}.
#'@param aptaqpcr An object of the Class \code{aptaqpcr}, which is produced as an output of the
#'function \code{mean.conf}.
#'@param mean.all The default is "No", where the last Gaussian mean will be ommited. If mean.all is
#'defined as "Yes", the last Gaussian mean will also be included. We recommend to select as "No".
#'@return object of Class \code{aptaqpcr}.
#'@details Function \code{mean.conf} acts on an object of the Class \code{aptaqpcr}, which is
#'produced as an output of the function apt.fit.value and populates an object of Class \code{aptaqpcr}.
#'@param aptaqpcr An object of the Class \code{aptaqpcr}, which is produced as an output of the
#'function \code{mean.conf}. More details are provided in the \code{AptaqPCR} package vignette. See
#'also \code{\link[AptaqPCR]{apt.fit}} and \code{\link[AptaqPCR]{apt.fit.value}}.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, apt.fit, apt.fit.value, mean.conf
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
#'temp <- data[,"temp"]  ##Temperature data
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
#'aptfitalls <- apt.fit.value(nc,b,c,d,e,f,g,h,
#'conc = c("0 pM", "30.50 pM", "15.25 pM", "7.62 pM", "3.81 pM", "1.90 pM",
#'"0.95 pM","0.47 pM"))
#'
#'## To compute the confidence intervals of the Gaussian means of temperature
#'## 1) By omitting the last value
#'conf.int <- mean.conf(aptfitalls)
#'
#'## To express the mean values
#'slot(conf.int,"confMeanData")
#'
#'## To express the confidence intervals
#'slot(conf.int,"confData")
#'
#'## 2) By including the last value
#'conf.int.last <- mean.conf(aptfitalls, mean.all = "Yes")
#'
#'## To express the mean values
#'slot(conf.int.last,"confMeanData")
#'
#'## To express the confidence intervals
#'slot(conf.int.last,"confData")
#'@export
setMethod("mean.conf", signature = "aptaqpcr", definition =
            function(aptaqpcr, mean.all = "No"){
              x <- slot(aptaqpcr,"fitData")
              mean.first <- x["Mean1",]
              mean.second <- x["Mean2",]
              if (mean.all == "No"){
                mean1 <- mean.first[-8]
                mean2 <- mean.second[-8]
              }

              else if (mean.all == "Yes"){
                mean1 <- mean.first
                mean2 <- mean.second
              }

              else{
                warning("Please choose either No or Yes for argument mean.all!")
              }
              cr.rep <- as.data.frame(rbind(mean1, mean2))
              row.cr <-unique(row.names(cr.rep))
              r.cr <- nrow(cr.rep)
              d = data.frame(min.value=rep(0,r.cr), max.value=rep(0,r.cr))
              for (i in 1:length(row.cr)){
                x <- cr.rep[i,]
                x.new <- (x[!is.na(x)])
                sd <- sd(x.new)
                se <- sd/(sqrt(length(x.new)))
                x.new <- as.numeric(x.new)
                x.mean <- mean(x.new)
                CI <- c((x.mean - 2*se), (x.mean + 2*se))
                d[i,] <- CI
              }
              row.names(d) <- c("conf.mean1","conf.mean2")
              confmeandata <- as.data.frame(rbind(mean1, mean2))
              row.names(confmeandata) <- c("Mean1","Mean2")
              conf.data <- new("aptaqpcr", confMeanData = confmeandata, confData = d)
              conf.data
            })
