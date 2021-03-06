#'@name apt.plot
#'@aliases apt.plot
#'@title To plot the Fluorescence vs Temperature, dF/dT vs Temperature and -dF/dT vs Temperature
#'@description The function \code{apt.plot} plots the results of the function \code{mean.apt} to
#'generate the plots of Fluorescence vs Temperature, results of the function \code{diff.apt} to
#'generate the plots of dF/dT vs Temperature and -dF/dT vs Temperature. The function generates the
#'plots on the basis of the function \code{\link[ggplot2]{ggplot}}.
#'@param aptaqpcr the object of the Class \code{"aptaqpcr"}, produced as an output of the function
#'\code{mean.apt} or \code{diff.apt}.
#'@param ylabel the name of the y axis to be defined. If missing y label, then, the default will be
#'"Fluorescence" in case of data of combined replicates, "dF/dT" in case of first derivative data
#'of combined replicates and "-dF/dT" in case of negative of first derivative data of the combined
#'replicates.
#'@param xlabel the name of the x-axis to be defined. The default is "Temperature".
#'@param color to define the color of the plot. The default is "blue" for the combined replicates,
#'"steal blue" for the first derivative data and "green" for the negative of the first derivative
#'data.
#'@param conc a character vector to define the names of all the plots.if missing conc, then the
#'default names of the plots will be nc, b, c, d, e, f, g and h.
#'@param plot to define which plots are to be ploted. "Mean" for the combined replicates, "Diff"
#'for the first derivative data and "negDiff" for the negative of the first derivative data. Default
#'is mean.
#'@return return the plots.
#'@details The function \code{apt.plot} acts on an object of the Class \code{"aptaqpcr"} and
#'plots the results of the function \code{mean.apt} to generate the plots of
#'Fluorescence vs Temperature, results of the function \code{diff.apt} to generate the plots of
#'dF/dT vs Temperature and -dF/dT vs Temperature. More details are provided in the \code{AptaqPCR}
#'package vignette.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, ReadAptaqPCR, mean.apt, diff.apt, apt.plot
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
#'## (1) To plot the results of combined replicates (Fluorescence vs Temperature)
#'apt.plot(meandata) ##default plot
#'
#'## to define the names of the plots on the basis of the concentration
#'apt.plot(meandata, conc = c("0 pM","30.50 pM","15.25 pM","7.62 pM","3.81 pM",
#'"1.90 pM","0.95 pM","0.47 pM"))
#'
#'## (2) To plot the results of the first derivative
#'apt.plot(diffdata, plot = "Diff") ##default plot
#'
#'## To define the names of the plots on the basis of the concentration
#'apt.plot(diffdata, plot = "Diff", conc = c("0 pM","30.50 pM","15.25 pM","7.62 pM",
#'"3.81 pM","1.90 pM","0.95 pM","0.47 pM"))
#'
#'## (3) To plot the results of the negative of first derivative
#'apt.plot(diffdata, plot = "negDiff") ##default plot
#'
#'## plots on the name of the concentration
#'apt.plot(diffdata, plot = "negDiff", conc = c("0 pM","30.50 pM","15.25 pM","7.62 pM",
#'"3.81 pM","1.90 pM","0.95 pM","0.47nM"))
#'
#'## One can also define the other parameters like ylabel, xlabel and color, if user want to have
#'##different instead of the default ones.
#'@export
setMethod("apt.plot", signature = "aptaqpcr", definition =
            function (aptaqpcr, ylabel, xlabel, color,
                      conc = c("0nM","1nM","2nM","3nM","4nM","5nM","6nM","7nM"),
                      plot = "Mean"){
              if (plot == "Mean"){
                x <- slot(aptaqpcr,"meanData")
                if (missing(ylabel)){
                  ylabel = "Fluorescence"
                }
                else{
                  ylabel = ylabel
                }
                if (missing(color)){
                  color = "blue"
                }
                else{
                  color = color
                }
              }

              else if (plot == "Diff"){
                x <- slot(aptaqpcr,"diffData")
                if (missing(ylabel)){
                  ylabel = "dF/dT"
                }
                else{
                  ylabel = ylabel
                }
                if (missing(color)){
                  color = "steel blue"
                }
                else{
                  color = color
                }
              }

              else if (plot == "negDiff"){
                x1 <- slot(aptaqpcr,"diffData")
                temp <- x1[,"temp"]
                x2 <- x1[-1]
                x3 <- -(x1)
                x <- cbind(temp,x3)
                if (missing(ylabel)){
                  ylabel = "-dF/dT"
                }
                else{
                  ylabel = ylabel
                }
                if (missing(color)){
                  color = "green"
                }
                else{
                  color = color
                }
              }

              else{
                warning("Please provide the option out of Mean, Diff or negDiff for argument plot!")
              }

              if (missing(conc)){
                nc = "nc"
                b = "b"
                c = "c"
                d = "d"
                e = "e"
                f = "f"
                g = "g"
                h = "h"
              }
              else{
                nc = conc[1]
                b = conc[2]
                c = conc[3]
                d = conc[4]
                e = conc[5]
                f = conc[6]
                g = conc[7]
                h = conc[8]
              }

              if (missing(xlabel)){
                xlabel = "Temperature (°C)"
              }
              else{
                xlabel = xlabel
              }
              nc.plot <- ggplot(x, aes(temp,nc))+
                geom_point(colour=color)+ ylab(ylabel)+ xlab(xlabel)+
                ggtitle(nc)

              b.plot <- ggplot(x, aes(temp,b))+
                geom_point(colour=color)+ ylab(ylabel)+ xlab(xlabel)+
                ggtitle(b)

              c.plot <- ggplot(x, aes(temp,c))+
                geom_point(colour=color)+ ylab(ylabel)+ xlab(xlabel)+
                ggtitle(c)

              d.plot <- ggplot(x, aes(temp,d))+
                geom_point(colour=color)+ ylab(ylabel)+ xlab(xlabel)+
                ggtitle(d)

              e.plot <- ggplot(x, aes(temp,e))+
                geom_point(colour=color)+ ylab(ylabel)+ xlab(xlabel)+
                ggtitle(e)

              f.plot <- ggplot(x, aes(temp,f))+
                geom_point(colour=color)+ ylab(ylabel)+xlab(xlabel)+
                ggtitle(f)

              g.plot <- ggplot(x, aes(temp,g))+
                geom_point(colour=color)+ ylab(ylabel)+xlab(xlabel)+
                ggtitle(g)

              h.plot <- ggplot(x, aes(temp,h))+
                geom_point(colour=color)+ ylab(ylabel) + xlab(xlabel)+
                ggtitle(h)

              grid.arrange(nc.plot,b.plot,c.plot,d.plot,e.plot,f.plot,g.plot,h.plot,ncol=2, nrow=4)
            })
