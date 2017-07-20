#'@name ReadAptaqPCR
#'@aliases ReadAptaqPCR
#'@title To read the .csv as well as .txt file of experimental data
#'@description Function \code{ReadAptaqPCR} reads in .csv as well as .txt files of raw fluorescent
#'melting temprature data of RTqPCR and uses the data to populate an object of Class \code{"aptaqpcr"}.
#'@param file the name of the file to read in.
#'@param type the type of the file out of ".csv" or ".txt" to read in. The default parameter
#'is ".csv".
#'@return object of Class \code{"aptaqpcr"}.
#'@details Allows the user to read in raw fluorescence data.
#'More details are provided in the \code{AptaqPCR} package vignette.
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@keywords aptaqpcr, ReadAptaqPCR
#'@examples
#'##To read the .csv file
#'file1 <- system.file("exData", "multiapt31.csv", package = "AptaqPCR")
#'read.datacsv <- ReadAptaqPCR(file1)
#'
#'## To express all the data
#'read.datacsv
#'
#'## To express the initial data (all the data read in, except concentration)
#'slot(read.datacsv,"initialData")
#'
#'## To read the .txt file
#'file1 <- system.file("exData", "multiapt31.txt", package = "AptaqPCR")
#'read.datatxt <- ReadAptaqPCR(file1, type = ".txt")
#'
#'## To express the initial data (except concentration)
#'slot(read.datatxt, "initialData")
#'@export
ReadAptaqPCR <- function(file, type = ".csv"){
  if (type == ".csv"){
    res1 <- read.csv(file, header = TRUE)
  }

  else if(type == ".txt"){
    res1 <- read.table(file, header = TRUE, fill = TRUE,skip = 0, sep = "\t", quote = "\"",comment.char = "")
  }
  else{
    warning('Select the type of file out of ".txt" and ".csv" !' )
  }

  res <- as.data.frame(res1)
  res.data <- new("aptaqpcr", initialData = res)
  res.data
}
