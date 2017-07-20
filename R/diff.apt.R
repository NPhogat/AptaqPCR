#'@name diff.apt
#'@aliases diff.apt
#'@title To compute the first derivative of the combined replicates
#'@description Function \code{diff.apt} computes the first derivative of the combined
#'replicates and uses the data to populate an object of Class \code{"aptaqpcr"}.
#'@param aptaqpcr the object of Class \code{"aptaqpcr"}, produced as an output of the function
#'\code{mean.apt}.
#'@return object of Class \code{"aptaqpcr"}.
#'@details Function \code{diff.apt} acts on an object of Class \code{"aptaqpcr"}, which are produced
#'as an output of the function \code{mean.apt} and uses the data to populate an object of
#'Class \code{"aptaqpcr"}. See also \code{\link[AptaqPCR]{ReadAptaqPCR}} and \code{\link[AptaqPCR]{mean.apt}}.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, ReadAptaqPCR, mean.apt, diff.apt
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
#'## To express all the data
#'diffdata
#'
#'## To express the first derivative data
#'slot(diffdata,"diffData")
#'@export
setMethod("diff.apt", signature = "aptaqpcr", definition =
            function (aptaqpcr){
              x <- slot(aptaqpcr,"meanData")
              ###temperature data and diff of temperature data
              temp.data <- x[,"temp"]
              temp.diff <- diff(temp.data)
              x.data <- x[-1]
              cr.rep <- as.data.frame(x.data)
              col.cr <-unique(colnames(cr.rep))
              r.cr <- nrow(cr.rep)
              d = data.frame(min.value=rep(0,r.cr), max.value=rep(0,r.cr))
              for (i in 1:length(col.cr)){
                x <- cr.rep[,i]
                diff.data <- diff(x)/temp.diff
                diff.new <- rbind(0,as.matrix(diff.data))
                d[,i] <- diff.new
              }
              d.new <- as.data.frame(cbind(temp.data,d))
              colnames(d.new) <- c("temp","nc","b","c","d","e","f","g","h")
              init.data <- as.data.frame(slot(aptaqpcr,"initialData"))
              mean.data <- as.data.frame(slot(aptaqpcr,"meanData"))
              apt.diffdata <- new("aptaqpcr",initialData = init.data, meanData = mean.data,
                                  diffData = d.new)
              apt.diffdata
            })
