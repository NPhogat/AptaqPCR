#'@name AptaqPCR.gui
#'@aliases AptaqPCR.gui
#'@title Run the graphical user interface for melting curve analysis for diagnostics
#'@description Run the graphical user interface
#'@author Navneet Phogat, Matthias Kohl, \email{Matthias.Kohl@@stamats.de}
#'@examples
#'AptaqPCR.gui()
#'@export
AptaqPCR.gui <- function() {
  runApp(system.file("AptaqPCR.gui", package = "AptaqPCR"))
}
