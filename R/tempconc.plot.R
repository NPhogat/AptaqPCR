#'@name tempconc.plot
#'@aliases tempconc.plot
#'@title To plot the Gaussian Mean (Temperature) vs Concentration
#'@description The function \code{tempconc.plot} acts on an object of the Class \code{aptaqpcr},
#'produced as an output of the function \code{apt.fit.value} to generate the plots, on the basis of the
#'function \code{\link[ggplot2]{ggplot}}.
#'@param aptaqpcr An object of the Class \code{aptaqpcr}, produced as an output of the function
#'\code{apt.fit.value}.
#'@param conc A numeric vector of concentration values. If the Mean.all is defined as "No", then,
#'define the first seven elements in the vector, while, if the Mean.all is defined as "Yes", then, define
#'all the eight elements in the vector.
#'@param xlabel To label the x-axis of the plot. Default is "Concentration (nM)".
#'@param mean.all The default is "No", which means the last value of the means of the temperature
#'will be omitted. To include the last value also for plotting, define the argument mean.all as "Yes".
#'@return Generate the plots.
#'@details The function \code{tempconc.plot} acts on an object of the Class \code{aptaqpcr},
#'produced as an output of the function \code{apt.fit.value} to generate the plots, on the basis of the
#'function \code{\link[ggplot2]{ggplot}}.More details are provided in the \code{AptaqPCR} package
#'vignette. See also \code{\link[AptaqPCR]{apt.fit}}, \code{\link[AptaqPCR]{apt.fit.value}}.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, apt.fit, apt.fit.value, tempconc.plot
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
#'temp <- data[,"temp"]
#'
#'## To fit the negative of first derivative data to generate the fitting results in the
#'##form of values (an object of Class data.frame)
#'
#'nc <- apt.fit(diffdata[,"nc"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'b <- apt.fit(diffdata[,"b"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'c <- apt.fit(diffdata[,"c"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'d <- apt.fit(diffdata[,"d"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'e <- apt.fit(diffdata[,"e"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'f <- apt.fit(diffdata[,"f"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'g <- apt.fit(diffdata[,"g"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'h <- apt.fit(diffdata[,"h"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'
#'## implement the function apt.fit.value to combine all the results
#'aptfitalls <- apt.fit.value(nc,b,c,d,e,f,g,h,
#'conc = c("0 pM", "30.50 pM", "15.25 pM","7.62 pM", "3.81 pM",
#'"1.90 pM","0.95 pM","0.47 pM"))
#'
#'## To plot the Gaussian Mean (Temperature) vs Concentration
#'## 1) By omitting the last value of mean
#'gmc.plot <- tempconc.plot(aptfitalls, conc = c(0, 30.50, 15.25, 7.62, 3.81, 1.90, 0.95),
#'xlabel = "Concentration (pM)")
#'gmc.plot
#'
#'## 2) By including the last value of mean
#'gmc.plot.last <- tempconc.plot(aptfitalls, conc =  c(0, 30.50, 15.25, 7.62, 3.81, 1.90,
#'0.95, 0.47), xlabel = "Concentration (pM)")
#'gmc.plot.last
#'@export
setMethod("tempconc.plot", signature = "aptaqpcr", definition =
            function (aptaqpcr, conc = c(1,2,3,4,5,6,7,8), xlabel = "Concentration (nM)",
                      mean.all = "No" ){
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
              se1 <-as.numeric(format(sd(mean1)/sqrt(length(mean1)),digits =3))
              se2 <-as.numeric(format(sd(mean2)/sqrt(length(mean1)),digits =3))
              plot.data <- as.data.frame(t(rbind(conc,mean1,mean2)))
              row.names(plot.data) <- 1:nrow(plot.data)
              colnames(plot.data) <- c("Concentration","Mean1","Mean2")
              ylim1 <- round(min(mean1)-2)
              ylim2 <- round(max(mean2)+2)
              plot <- ggplot(plot.data, aes(Concentration, Mean1)) + ylim(ylim1,ylim2)+
                geom_point(color = "steel blue", size = 2)+
                geom_errorbar(aes(ymin=Mean1-se1, ymax=Mean1+se1), width=.1, color = "black")+
                ylab("Gaussian Mean (Temperature)")+ xlab(xlabel)+
                geom_point(aes(Concentration, Mean2), color = "red", size = 2)+
                geom_errorbar(aes(ymin=Mean2-se2, ymax=Mean2+se2), width=.1, color = "black", position = "dodge")+
                ggtitle("Gaussian Mean (Temperature) vs Concentration")
              plot
            })
