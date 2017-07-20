library(shiny)
library(AptaqPCR)
shinyServer(function(input,output){
  ftype <- reactive({input$filetype})

  concnamer <- reactive({
    as.character(unlist(strsplit(input$concname,",")))
  })

  xldr <- reactive({input$xld})

  ncr <- reactive({
    as.numeric(unlist(strsplit(input$nc,",")))
  })

  br <- reactive({
    as.numeric(unlist(strsplit(input$b,",")))
  })

  cr <- reactive({
    as.numeric(unlist(strsplit(input$c,",")))
  })

  dr <- reactive({
    as.numeric(unlist(strsplit(input$d,",")))
  })

  er <- reactive({
    as.numeric(unlist(strsplit(input$e,",")))
  })

  fr <- reactive({
    as.numeric(unlist(strsplit(input$f,",")))
  })

  gr <- reactive({
    as.numeric(unlist(strsplit(input$g,",")))
  })

  hr <- reactive({
    as.numeric(unlist(strsplit(input$h,",")))
  })

  cvaluer <- reactive({input$cvalue})

  methr <- reactive({input$meth})

  concr <- reactive({
    as.numeric(unlist(strsplit(input$conc,",")))
  })

  xlr <- reactive({input$xl})

  file <- reactive({
    if(is.null(input$file)){
      infile <- NULL
    } else
      infile <- ReadAptaqPCR(input$file$datapath, type = ftype())
    x.initdata <- as.data.frame(slot(infile,"initialData"))
    x.initdata
  })

  meandata <- eventReactive(input$compute,{
    runif(input$file)
    isolate({
      if(!(is.null(file))){
        x.init <- file()
        x.data <- new("aptaqpcr",initialData = x.init)
        x.mean <- mean.apt(x.data)
        x.rep <- as.data.frame(slot(x.mean,"meanData"))
        x.rep
      }
      else{
        return(NULL)
      }
    })
  })

  m.plot <- reactive({
    if (is.null(meandata())){
      return(NULL)
    }
    else{
    x <- meandata()
    nc.plot <- ggplot(x, aes(temp,nc))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[1])
    b.plot <- ggplot(x, aes(temp,b))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[2])
    c.plot <- ggplot(x, aes(temp,c))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[3])
    d.plot <- ggplot(x, aes(temp,d))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[4])
    e.plot <- ggplot(x, aes(temp,e))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[5])
    f.plot <- ggplot(x, aes(temp,f))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[6])
    g.plot <- ggplot(x, aes(temp,g))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[7])
    h.plot <- ggplot(x, aes(temp,h))+
      geom_point(colour="blue")+ ylab("Fluorescence")+ xlab(xldr())+ ggtitle(concnamer()[8])
    grid.arrange(nc.plot,b.plot,c.plot,d.plot,e.plot,f.plot,g.plot,h.plot,ncol = 2, nrow = 4)
    }
  })

  diffdata <- reactive({
    if(is.null(meandata())){
      return(NULL)
    }
    else{
      x.mean <- meandata()
      data <- new("aptaqpcr", meanData = x.mean)
      x.diff <- diff.apt(data)
      kd.diff.new <- as.data.frame(slot(x.diff,"diffData"))
      kd.diff.new
    }
  })

  d.plot <- reactive({
    if ((is.null(meandata())) || (is.null(diffdata()))){
      return(NULL)
    }
    else{
    x <- diffdata()
    temp <- x[,"temp"]
    nc.plot <- ggplot(x, aes(temp,nc))+
      geom_point(colour="steel blue")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[1])
    b.plot <- ggplot(x, aes(temp,b))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[2])
    c.plot <- ggplot(x, aes(temp,c))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[3])
    d.plot <- ggplot(x, aes(temp,d))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[4])
    e.plot <- ggplot(x, aes(temp,e))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[5])
    f.plot <- ggplot(x, aes(temp,f))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[6])
    g.plot <- ggplot(x, aes(temp,g))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[7])
    h.plot <- ggplot(x, aes(temp,h))+
      geom_point(colour="steel blue")+ ylab("dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[8])
    grid.arrange(nc.plot,b.plot,c.plot,d.plot,e.plot,f.plot,g.plot,h.plot,ncol = 2, nrow = 4)
    }
  })

  nd.plot <- reactive({
    if ((is.null(meandata())) || (is.null(diffdata()))){
      return(NULL)
    }
    else{
    x1 <- diffdata()
    temp <- x1[,"temp"]
    x2 <- x1[-1]
    x3 <- -(x2)
    x <- cbind(temp,x3)
    nc.plot <- ggplot(x, aes(temp,nc))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[1])
    b.plot <- ggplot(x, aes(temp,b))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[2])
    c.plot <- ggplot(x, aes(temp,c))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[3])
    d.plot <- ggplot(x, aes(temp,d))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[4])
    e.plot <- ggplot(x, aes(temp,e))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[5])
    f.plot <- ggplot(x, aes(temp,f))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[6])
    g.plot <- ggplot(x, aes(temp,g))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[7])
    h.plot <- ggplot(x, aes(temp,h))+
      geom_point(colour="green")+ ylab("-dF/dT")+ xlab(xldr())+ ggtitle(concnamer()[8])
    grid.arrange(nc.plot,b.plot,c.plot,d.plot,e.plot,f.plot,g.plot,h.plot,ncol = 2, nrow = 4)
    }
  })

  output$tabset <- renderUI({
    if(is.null(input$file)) {
      tabPanel("No input detected")
    }
    else {
      tabsetPanel(
        tabPanel("Combined reps", plotOutput("mean.plot", height = 1400, width = 850)),
        tabPanel("First derivative", plotOutput("diff.plot", height = 1400, width = 850)),
        tabPanel("Negative first derivative", plotOutput("negdiff.plot", height = 1400, width = 850)),
        tabPanel("Gaussian fit plots", plotOutput("fitplot", height = 1400, width = 850)),
        tabPanel("Gaussian fit table", tableOutput("fittable")),
        tabPanel("Gaussian means", tableOutput("confmean")),
        tabPanel("95% C.I. of Gaussian means", tableOutput("confdata")),
        tabPanel("Gaussian mean vs conc", plotOutput("concplot"))
      )
    }
  })

  output$mean.plot <- renderPlot({m.plot()})

  output$diff.plot <- renderPlot({d.plot()})

  output$negdiff.plot <- renderPlot({nd.plot()})

  f.plot <- eventReactive(input$computefit,{
    #runif(input$h)
    isolate({
      if((!(is.null(hr()))) && (!(is.null(diffdata())))){
    data <- diffdata()
    temp <- data[,"temp"]
    nc.plot <- apt.fit(data[,"nc"],ncr()[1],ncr()[2],ncr()[3],ncr()[4],ncr()[5],ncr()[6],methr(),
                       cvaluer(),temp,concnamer()[1])
    b.plot <- apt.fit(data[,"b"],br()[1],br()[2],br()[3],br()[4],br()[5],br()[6],methr(),
                      cvaluer(),temp,concnamer()[2])
    c.plot <- apt.fit(data[,"c"],cr()[1],cr()[2],cr()[3],cr()[4],cr()[5],cr()[6],methr(),
                      cvaluer(),temp,concnamer()[3])
    d.plot <- apt.fit(data[,"d"],dr()[1],dr()[2],dr()[3],dr()[4],dr()[5],dr()[6],methr(),
                      cvaluer(),temp,concnamer()[4])
    e.plot <- apt.fit(data[,"e"],er()[1],er()[2],er()[3],er()[4],er()[5],er()[6],methr(),
                      cvaluer(),temp,concnamer()[5])
    f.plot <- apt.fit(data[,"f"],fr()[1],fr()[2],fr()[3],fr()[4],fr()[5],fr()[6],methr(),
                      cvaluer(),temp,concnamer()[6])
    g.plot <- apt.fit(data[,"g"],gr()[1],gr()[2],gr()[3],gr()[4],gr()[5],ncr()[6],methr(),
                      cvaluer(),temp,concnamer()[7])
    h.plot <- apt.fit(data[,"h"],hr()[1],hr()[2],hr()[3],hr()[4],hr()[5],hr()[6],methr(),
                      cvaluer(),temp,concnamer()[8])
    grid.arrange(nc.plot, b.plot, c.plot, d.plot, e.plot, f.plot, g.plot, h.plot,
                 ncol = 2, nrow = 4)
      }
      else{
        return(NULL)
      }
  })
})
  fit.data <- reactive({
    if ((is.null(f.plot())) || is.null(hr())){
      return(NULL)
    }
    else{
    data <- diffdata()
    temp <- data[,"temp"]
    nc <- apt.fit(data[,"nc"],ncr()[1],ncr()[2],ncr()[3],ncr()[4],ncr()[5],ncr()[6],methr(),cvaluer(),temp)
    b <- apt.fit(data[,"b"],br()[1],br()[2],br()[3],br()[4],br()[5],br()[6],methr(),cvaluer(),temp)
    c <- apt.fit(data[,"c"],cr()[1],cr()[2],cr()[3],cr()[4],cr()[5],cr()[6],methr(),cvaluer(),temp)
    d <- apt.fit(data[,"d"],dr()[1],dr()[2],dr()[3],dr()[4],dr()[5],dr()[6],methr(),cvaluer(),temp)
    e <- apt.fit(data[,"e"],er()[1],er()[2],er()[3],er()[4],er()[5],er()[6],methr(),cvaluer(),temp)
    f <- apt.fit(data[,"f"],fr()[1],fr()[2],fr()[3],fr()[4],fr()[5],fr()[6],methr(),cvaluer(),temp)
    g <- apt.fit(data[,"g"],gr()[1],gr()[2],gr()[3],gr()[4],gr()[5],gr()[6],methr(),cvaluer(),temp)
    h <- apt.fit(data[,"h"],hr()[1],hr()[2],hr()[3],hr()[4],hr()[5],hr()[6],methr(),cvaluer(),temp)
    aptfitalls <- apt.fit.value(nc,b,c,d,e,f,g,h,
                                conc = c(concnamer()[1], concnamer()[2], concnamer()[3],
                                         concnamer()[4],concnamer()[5],concnamer()[6],
                                         concnamer()[7], concnamer()[8]))
    x.fit <- as.data.frame(slot(aptfitalls,"fitData"))
    rownames(x.fit) <- c("Mean1","SD1","A1","Mean2","SD2","A2")
    x.fit
    }
  })

  output$fitplot <- renderPlot({f.plot()})

  output$fittable <- renderTable({
    x.fitdata <- fit.data()
    x.fitdata
  })

  conf.mean <- eventReactive(input$computeconf,{
    #runif(input$xl)
    isolate({
      if((!(is.null(xlr()))) || (!(is.null(f.plot())))){
        x <- fit.data()
        x.new <- new("aptaqpcr",fitData = x)
        confmean <- mean.conf(x.new)
        x.mean <- as.data.frame(slot(confmean,"confMeanData"))
        rownames(x.mean) <- c("Mean1","Mean2")
        x.mean
      }
      else{
        return(NULL)
      }
    })
  })

  conf.data <- reactive({
    if (is.null(conf.mean())){
      return(NULL)
    }
    else{
    x <- fit.data()
    x.new <- new("aptaqpcr",fitData = x)
    conf <- mean.conf(x.new)
    x.conf <- slot(conf,"confData")
    rownames(x.conf) <- c("conf.mean1","conf.mean2")
    x.conf
    }
  })

  c.plot <- reactive({
    if (is.null(conf.mean())){
      return(NULL)
    }
    else{
    x <- fit.data()
    x.new <- new("aptaqpcr",fitData = x)
    gmc.plot <- tempconc.plot(x.new, conc =  c(concr()), xlabel = xlr())
    gmc.plot
    }
  })

  output$confmean <- renderTable({
    x <- as.data.frame(conf.mean())
    rownames(x) <- c("Mean1","Mean2")
    x
  })

  output$confdata <- renderTable({
    x <- as.data.frame(conf.data())
    rownames(x) <- c("conf.mean1","conf.mean2")
    x
  })

  output$concplot <- renderPlot({c.plot()})

  output$download <- downloadHandler(
    filename  = "result_report.html",
    content <- function(file) {
      knitr:::knit(input = "result_report.Rmd",
                   output = "result_report.md", quiet = TRUE)
      markdown:::markdownToHTML("result_report.md", "result_report.html")
    }
  )

})
