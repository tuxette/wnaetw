source("scripts/scripts.R")
library(e1071)
library(ineq)

shinyServer(function(input, output) {
  dInput <- reactive({
    in.file <- input$file1
    quoteMark <- switch(input$quote,
                        "Double Quote"="\"", "Single Quote"="'", "No Quote"="")
    sepMark <- switch(input$sep,
                      "Comma"=",","Semicolon"=";","Tab"="\t", "Space"=" ")
    decMark <- switch(input$dec, "Dot"=".", "Comma"=",")
    
    if (is.null(in.file))
      return(NULL)
    
    if (input$rownames) {
      read.table(in.file$datapath, header=input$header, sep=sepMark,
               quote=quoteMark, row.names=1, dec=decMark)
    } else {
      read.table(in.file$datapath, header=input$header, sep=sepMark,
                 quote=quoteMark, dec=decMark)
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



