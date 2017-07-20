#'@name mean.apt
#'@aliases mean.apt
#'@title To combine the replicates of experimental data on the basis of mean
#'@description Function \code{mean.apt} combines the replicates and uses the data to populate
#'an object of Class \code{"aptaqpcr"}.
#'@param aptaqpcr an object of Class \code{"aptaqpcr"}, produced as an output of the function
#'\code{ReadAptaqPCR}.
#'@return object of Class \code{"aptaqpcr"}.
#'@details Function \code{mean.apt} acts on an object of Class \code{"aptaqpcr"}, produced
#'as an output of the function \code{ReadAptaqPCR}. It combines the replicates and uses
#'the data to populate an object of Class \code{"aptaqpcr"}.See also \code{\link[AptaqPCR]{ReadAptaqPCR}}.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, ReadAptaqPCR, mean.apt
#'@examples
#'##To read the .csv file
#'file1 <- system.file("exData", "multiapt31.csv", package = "AptaqPCR")
#'read.datacsv <- ReadAptaqPCR(file1)
#'
#'##To combine the replicates on the basis of mean
#'meandata <- mean.apt(read.datacsv)
#'
#'## To express all the data
#'meandata
#'
#'## To express the combined replicates
#'slot(meandata,"meanData")
#'@export
setMethod("mean.apt", signature = "aptaqpcr", definition =
            function (aptaqpcr){
              x <- slot(aptaqpcr,"initialData")
              ###temperature data and diff of temperature data
              temp.data <- x[,"Text"]

              ###extract fluodata, row mean, diff of fluo data, diff(fluodata)/diff(temp)
              nc.rep <- grep("..NC", colnames(x))
              nc.mean <- rowMeans(x[,nc.rep])
              b.rep <- grep("..BT", colnames(x))
              b.mean <- rowMeans(x[,b.rep])
              c.rep <- grep("..CT",colnames(x))
              c.mean <- rowMeans(x[,c.rep])
              d.rep <- grep("..DT",colnames(x))
              d.mean <- rowMeans(x[,d.rep])
              e.rep <- grep("..ET",colnames(x))
              e.mean <- rowMeans(x[,e.rep])
              f.rep <- grep("..FT",colnames(x))
              f.mean <- rowMeans(x[,f.rep])
              g.rep <- grep("..GT",colnames(x))
              g.mean <- rowMeans(x[,g.rep])
              h.rep <- grep("..HT",colnames(x))
              h.mean <- rowMeans(x[,h.rep])
              apt.mean <- as.data.frame(cbind(temp.data,nc.mean,b.mean,c.mean,d.mean,e.mean,f.mean,
                                              g.mean,h.mean))
              colnames(apt.mean) <- c("temp","nc","b","c","d","e","f","g","h")
              init.data <- as.data.frame(slot(aptaqpcr,"initialData"))
              apt.meandata <- new("aptaqpcr",initialData = init.data, meanData = apt.mean)
              apt.meandata
            })
