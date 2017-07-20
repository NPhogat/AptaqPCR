library(shiny)
shinyUI(fluidPage(
  titlePanel("Melting curve analysis for diagnostics"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Choose .csv or .txt tab separated file to upload"),
      tags$hr(),
      checkboxInput("header","Header", TRUE),
      selectInput("filetype", "Select the type of file", choices = c(".csv",".txt")),
      br(),
      actionButton("compute","Compute upto -dF/dT"),
      p("Upload files, fill up next two arguments and click on compute button!"),
      br(),
      textInput("concname","Name of plots on the basis of the Concentration",
                "0 pM, 30.50 pM, 15.25 pM,7.62 pM,3.81 pM, 1.90 pM,0.95 pM,0.47 pM"),
      br(),
      textInput("xld","xlabel for plots","Temperature °C"),
      br(),

      actionButton("computefit","Compute Gaussian Fit"),
      p("Fill up fitting arguments and click on compute button of fitting results!"),
      br(),
      textInput("nc","initial values of m1,sd1,A1,m2,sd2 and A2 for 1st 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("b","initial values of m1,sd1,A1,m2,sd2 and A2 for 2nd 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("c","initial values of m1,sd1,A1,m2,sd2 and A2 for 3rd 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("d","initial values of m1,sd1,A1,m2,sd2 and A2 for 4th 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("e","initial values of m1,sd1,A1,m2,sd2 and A2 for 5th 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("f","initial values of m1,sd1,A1,m2,sd2 and A2 for 6th 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("g","initial values of m1,sd1,A1,m2,sd2 and A2 for 7th 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      textInput("h","initial values of m1,sd1,A1,m2,sd2 and A2 for 8th 2Gaussian plot",
                "44,1,3,53,1,3"),
      br(),
      numericInput("cvalue","Provide the reltol value","2e-9"),
      br(),
      textInput("meth","Provide the method for Gaussian fitting","BFGS"),
      br(),

      actionButton("computeconf","Compute Final Results"),
      p("Provide values of concentration, xlabel and click on compute button for final results!"),
      br(),
      textInput("conc","Values of concentration","0, 30.50, 15.25, 7.62, 3.81, 1.90,0.95"),
      br(),
      textInput("xl","Define the xlabel for the final plot","Concentration (pM)"),
      br(),

      downloadButton("download", "Download Results"),
      p("Download the results by clicking on the download button!")
    ),
    mainPanel(
      uiOutput("tabset")
    )
  )
))
