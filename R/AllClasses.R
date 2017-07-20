#'@title S4 Class \code{aptaqpcr} to contain the data
#'@slot initialData contains the initial data in the form of an object.
#'of Class \code{data.frame}. These are the raw fluorescent data.
#'@slot meanData contains the result of the function \code{mean.apt} in the form of an object
#'of Class \code{data.frame}. These are the data obtained after combining replicates.
#'@slot diffData contains the result of the function \code{diff.apt} in the form of an
#'object of Class \code{data.frame}. These are the first derivative data of the combined
#'replicates.
#'@slot fitData contains the result of the functions \code{apt.fit.value} and \code{apt.fit.all}
#'in the form of an object of Class \code{data.frame}. These are the fitting results obtained
#'from the two Gaussian fit.
#'@slot confMeanData contains the result (the mean values) of the function \code{mean.conf}
#'in the form of an object of Class \code{data.frame}. These are Gaussian mean values of the
#'temperature.
#'@slot confData contains the result (the confidence intervals) of the function \code{mean.conf}
#'in the form of an object of Class \code{data.frame}. These data are the confidence intervals
#'of the Gaussian mean values.
#'@exportClass
setClass("aptaqpcr", contains = "data.frame", representation(initialData = "data.frame",
                                                             meanData = "data.frame",
                                                             diffData = "data.frame",
                                                             fitData = "data.frame",
                                                             confMeanData = "data.frame",
                                                             confData = "data.frame"))
