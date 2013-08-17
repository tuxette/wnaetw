source("scripts/scripts.R")
library(ineq)
library(e1071)
library(graphics)
library(stats)
## Change this
shinyServer(function(input, output) {
	# This function loads the dataset using the different options specified by the user in ui.R
	datasetInput <- reactive(function() {
	  in.file <- input$dfile
	  
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
		all.data <- datasetInput()
		if (nrow(all.data)>50) {
			all.data <- all.data[1:50,]
		}
		if (ncol(all.data)>10) {
			all.data <- all.data[,1:10]
		}
		all.data
  })

	# This function calculates the output sent to the main panel in ui.R
	output$summary <- renderTable({
		dataset <- datasetInput()
		t(apply.wmtw(dataset)$res)
	})

	output$downloadSummary <- downloadHandler(
		filename = "summary.csv",
		content = function(file) {
			write.csv(apply.wmtw(datasetInput())$res, file)
	})
	
  # This function makes a boxplot for the numeric variables in the data set
	output$boxplots <- reactivePlot(function() {
		make.boxplot(datasetInput(),main=input$main,xlab=input$xlab,ylab=input$ylab,
                 scale=input$scale, col=input$color)
	})
})
