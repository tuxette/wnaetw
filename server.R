source("scripts/scripts.R")
library(ineq)
library(e1071)
library(graphics)
library(stats)
## Change this
shinyServer(function(input, output) {
	# This function loads the dataset using the different options specified by the user in ui.R
	datasetInput <- reactive(function() {
		separator <- switch(input$sep,","=",",	";"=";","space"=" ","tab"="\t")
		if (input$quote) {quotesymb <- "\""} else {quotesymb <- ""}
		if (input$rownames) {
			res <- read.table(input$fileurl, header=input$header, dec=input$dec, sep=separator, stringsAsFactor=FALSE, quote=quotesymb, row.names=1)
		} else {
			res <- read.table(input$fileurl, header=input$header, dec=input$dec, sep=separator, stringsAsFactor=FALSE, quote=quotesymb)
		}
	res
})

	output$view <- reactiveTable(function() {
		all.data <- datasetInput()
		if (nrow(all.data)>50) {
			all.data <- all.data[1:50,]
		}
		if (ncol(all.data)>10) {
			all.data <- all.data[,1:10]
		}
		all.data
})

	# This function calculate the output (print) of sent to the main panel in ui.R
	output$summary <- reactiveTable(function() {
		dataset <- datasetInput()
		t(apply.wmtw(dataset)$res)
	})

	output$downloadSummary <- downloadHandler(
		filename = "summary.csv",
		content = function(file) {
			write.csv(apply.wmtw(datasetInput())$res, file)
		})
		
	output$boxplots <- reactivePlot(function() {
		make.boxplot(datasetInput(),main=input$main,xlab=input$xlab,ylab=input$ylab,scale=input$scale)
	})
})
