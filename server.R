source("scripts/scripts.R")

shinyServer(function(input, output) {
  dInput <- reactive({
    in.file <- input$file1
    
    if (is.null(in.file))
      return(NULL)
    
    if (input$rownames) {
      read.table(in.file$datapath, header=input$header, sep=input$sep,
               quote=input$quote, row.names=1, dec=input$dec)
    } else {
      read.table(in.file$datapath, header=input$header, sep=input$sep,
                 quote=input$quote, dec=input$dec)
    }
  })
  
  output$view <- renderTable({
    d.input <- dInput()
    if (is.null(d.input)) return(NULL)
    if (ncol(d.input>10)) d.input <- d.input[,1:10]
    head(dInput(), n=50)  
  })
  
  # This function calculates the output sent to the main panel in ui.R
  output$summary <- renderTable({
    d.input <- dInput()
    t(apply.wmtw(d.input))
  })
  
  output$downloadSummary <- downloadHandler(
    filename = "summary.csv",
    content = function(file) {
      write.csv(apply.wmtw(dInput()), file)
  })

  # This function makes a boxplot for the numeric variables in the data set
  output$boxplots <- renderPlot({
    make.boxplot(dInput(),main=input$main,xlab=input$xlab,ylab=input$ylab,
                 scale=input$scale, col=input$color)
  })
})



