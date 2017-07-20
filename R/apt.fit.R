#'@name apt.fit
#'@aliases apt.fit
#'@title To fit the negative of the first derivative data on the basis of the Gaussian fit
#'(two Gaussian Fit)
#'@description Function \code{apt.fit} acts on the object of Class \code{data.frame} and implements
#'the function \code{\link[stats]{optim}} for fitting the data on the basis of two Gaussian fit. The
#'function \code{apt.fit} saves the fitting results in an object of Class \code{data.frame}. The
#'function \code{apt.fit} also produces the fitting plots, which are generated on the basis of the
#'function \code{\link[ggplot2]{ggplot}}.
#'@param x the data to be fitted. These data are the first derivative data. See the examples
#'to extract the first derivative data to be passed for the two Gaussian fitting.
#'@param m1 Initial value of mu1 (first mu). This is the initial value of the first Gaussian mean
#'value of temperature. The default value is 44.
#'@param sd1 Initial value of first standard deviation. The deault value is 1.
#'@param A1 Initial value of first amplitude. The default value is 3.
#'@param m2 Initial value of mu2 (second mu). This is the initial value of the second Gaussian mean
#'value of temperature. The default value is 53.
#'@param sd2 Initial value of second standard deviation. The default value is 1.
#'@param A2 Initial value of  second amplitude. The default value is A2.
#'@param method The method to be implemented. The default method is "BFGS". For more details
#'see also \code{\link[stats]{optim}}.
#'@param cvalue This is the tolerance value (reltol value).The default value is 2e-9.
#'For more details see also \code{\link[stats]{optim}}.
#'@param temp These are the temperature values. See the examples to extract the temperature values
#'to be passed for the two Gaussian fitting of the data.
#'@param plottitle The tittle of the plot to be defined by the user, only in the case if the
#'user wants to generate the plot. If missing the plotttile in the arguments, then, the results
#'will be generated in the form of the Class \code{data.frame}.
#'@param xlabel The xlabel should be defined only if the user defined the plottitle. The default
#'is "Temperature (°C)".
#'@param ylabel ylabel should be defined only if the user defined the plottitle. The default is
#'-dF/dT.
#'@return Return an object of Class \code{data.frame}. Also, return the results in the form of a
#'plot.
#'@details Function \code{apt.fit} acts on the object of Class \code{data.frame} and implements
#'the function \code{\link[stats]{optim}} for fitting the data on the basis of two Gaussian fit.
#'The function \code{apt.fit} saves the fitting results in an object of Class \code{data.frame}.
#'The function \code{apt.fit} also produces the fitting plots, which are generated on the basis of
#'the function \code{\link[ggplot2]{ggplot}}. To have an idea about the initial value of the
#'Gaussian parameters m1,A1,m2 and A2 regarding fitting, we recommend to have a look on the results of the
#'plot of negative of first derivative, generated through the function \code{\link[AptaqPCR]{apt.plot}}.
#'For more details see the vignettes of the package \code{AptaqPCR}. See also \code{\link[AptaqPCR]{ReadAptaqPCR}},
#'\code{\link[AptaqPCR]{mean.apt}}, \code{\link[AptaqPCR]{diff.apt}}, \code{\link[AptaqPCR]{apt.plot}} and
#'\code{\link[AptaqPCR]{apt.fit.value}}.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, ReadAptaqPCR, mean.apt, diff.apt, apt.fit
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
#'nc <- apt.fit(data[,"nc"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'b <- apt.fit(data[,"b"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'c <- apt.fit(data[,"c"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'d <- apt.fit(data[,"d"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'e <- apt.fit(data[,"e"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'f <- apt.fit(data[,"f"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'g <- apt.fit(data[,"g"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'h <- apt.fit(data[,"h"],44,1,3,53,1,3,"BFGS",2e-9,temp)
#'
#'
#'## To fit the negative of the first derivative data to generate the fitting results in the
#'## form of plots, where the names of plos are defined on the basis of the concentration
#'
#'nc.plot <- apt.fit(data[,"nc"],44,1,3,53,1,3,"BFGS",2e-9,temp,"0 pM")
#'b.plot <- apt.fit(data[,"b"],44,1,3,53,1,3,"BFGS",2e-9,temp,"30.50 pM")
#'c.plot <- apt.fit(data[,"c"],44,1,3,53,1,3,"BFGS",2e-9,temp,"15.25 pM")
#'d.plot <- apt.fit(data[,"d"],44,1,3,53,1,3,"BFGS",2e-9,temp,"7.62 pM")
#'e.plot <- apt.fit(data[,"e"],44,1,3,53,1,3,"BFGS",2e-9,temp,"3.81 pM")
#'f.plot <- apt.fit(data[,"f"],44,1,3,53,1,3,"BFGS",2e-9,temp,"1.90 pM")
#'g.plot <- apt.fit(data[,"g"],44,1,3,53,1,3,"BFGS",2e-9,temp,"0.95 pM")
#'h.plot <- apt.fit(data[,"h"],44,1,3,53,1,3,"BFGS",2e-9,temp,"0.47 pM")
#'
#'## To arrange all the plots in a single plot
#'grid.arrange(nc.plot, b.plot, c.plot, d.plot, e.plot, f.plot, g.plot, h.plot, ncol = 2, nrow = 4)
#'@export
apt.fit <- function(x,m1=44,sd1=1,A1=3,m2=53,sd2=1,A2=3, method = "BFGS",
                    cvalue=2e-9, temp, plottitle, ylabel, xlabel)
{
  f.optim <- function(par)
  {
    m1 <- par[1]
    sd1 <- par[2]
    A1 <- par[3]
    m2 <- par[4]
    sd2 <- par[5]
    A2 <- par[6]
    dfdtfit <- ((A1*exp(-0.5 * ((temp - m1)/sd1)^2))+ (A2*exp(-0.5 * ((temp - m2)/sd2)^2)))
    sum((-x - dfdtfit)^2)
  }
  fit <- optim(c(m1,sd1,A1,m2,sd2,A2),f.optim, method=method, control=list(reltol=cvalue))
  p <- fit$par
  parameters <- as.data.frame(rbind(p[1],p[2],p[3],p[4],p[5],p[6]))
  rownames(parameters) <- c("Mean1","SD1","A1","Mean2","SD2","A2")
  colnames(parameters) <- ("Value")
  if (missing(plottitle)){
    parameters
  }
  else
  {
    param.table <- tableGrob(parameters)
    fit.data <- ((p[3]*exp(-0.5*((temp-p[1])/p[2])^2)) + (p[6]*exp(-0.5*((temp-p[4])/p[5])^2)))
    plot.data <- as.data.frame(cbind(temp,-x,fit.data))
    colnames(plot.data) <- c("temp","x","x.fit")
    if (missing(ylabel)){
      ylabel = "-dF/dT"
    }
    else{
      ylabel = ylabel
    }
    if (missing(xlabel)){
      xlabel = "Temperature (°C)"
    }
    else{
      xlabel = xlabel
    }
    plot1 <- ggplot(plot.data, aes(temp,x))+
      geom_point(colour="steelblue")+ ylab(ylabel)+ xlab(xlabel)+
      geom_line(aes(temp,x.fit), color = "red",size = 2)+
      ggtitle(plottitle)

    plot1
  }
}
