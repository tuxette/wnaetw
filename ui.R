# Open a page
shinyUI(pageWithSidebar(
	# Application title
	headerPanel("Welcome lazy student ! You're currently using the package 'What Nicolas's teacher wants' "),

	# Create a sidebar on the left
	sidebarPanel(
		h2("Input data"),
		textInput("fileurl",strong("Paste your file's url:"), ""),
		# Create a checkbox to let the user specify if headers are included in the csv file
		checkboxInput(inputId = "header", label = " Are the variable names included in the dataset?", value = TRUE),
		checkboxInput(inputId = "rownames", label=" Are the observations names included in the dataset?", value=FALSE),
		checkboxInput(inputId = "quote", label = " Are quote marks in the dataset?", value = TRUE),
		# Create lists to describe the csv file format
		selectInput("sep","Column separator",choices=c(",",";","space","tab")),
		selectInput("dec","Decimal mark",choices=c(".",","))
	),

	# Main panel definition
	mainPanel(
		conditionalPanel(
			condition = "input.fileurl == '' ",
			h3("Basic user guide"),
			p(HTML("To run the application, paste the URL of your data file (you can use, for instance, a public <a href='https://www.dropbox.com/'>Dropbox</a> URL or ask me to host your data by <a href='mailto:nathalie@nathalievilla.org'>sending me an email</a>) in the dedicated area on the left. CSV files are the easiest to use; such an example is given <a href='http://owncloud.nathalievilla.org/apps/files_sharing/get.php?token=a4ccfca90d9c7928ceb6153929d4212bd90badc5'>here</a>. You can test this file by pasting its URL:")),
			p(HTML("<code>http://owncloud.nathalievilla.org/apps/files_sharing/get.php?token=a4ccfca90d9c7928ceb6153929d4212bd90badc5</code>")),
			p("Once your file's URL is pasted, the data are imported and if the importation is done properly, the data are displayed on the main panel and analyzed on the two other panels.")
		),
		conditionalPanel(
			condition = "input.fileurl != '' ",
			tabsetPanel(
				tabPanel("Data",
					h3("The dataset you want to use is displayed below:"),
					p("(only the first 50 first rows if the dataset contains more than 50 rows, and the first 10 columns if the dataset contains more than 10 columns)"),
					tableOutput("view")
				),
				tabPanel("Summary",downloadButton('downloadSummary', 'Download Summary'),br(),br(),tableOutput("summary")),
				tabPanel("Boxplots",
					textInput("main",strong("Graphic title:"), "Boxplots"),
					textInput("xlab",strong("X axis label:"), "Variables"),
					textInput("ylab",strong("Y axis label:"), ""),
					checkboxInput(inputId = "scale", label = " Scale variables?", value = TRUE),
					plotOutput("boxplots"))
			)
		)
	)
))