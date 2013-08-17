# Open a page
# change this
shinyUI(pageWithSidebar(
	# Application title
	headerPanel("Welcome lazy student! You're currently using the package 'What Nicolas's teacher wants' "),

	# Create a sidebar on the left
	sidebarPanel(
		h2("Input data"),
    
		fileInput('dfile', 'Choose CSV/TXT File',
		          accept=c('text/csv', 'text/comma-separated-values,text/plain')),
		tags$hr(),
		checkboxInput('header', ' Header?', TRUE),
		checkboxInput('rownames', ' Row names?', FALSE),
		radioButtons('sep', 'Separator:',
                 c(Comma=',',Semicolon=';',Tab='\t', Space=' '), 'Comma'),
		radioButtons('quote', 'Quote:',
		             c(None='','Double Quote'='"','Single Quote'="'"),
		             'Double Quote'),
    radioButtons('dec', 'Decimal mark', c(Dot='.', Comma=','), 'Dot')
		
		br(),
		p(HTML("This application is kindly provided by
           <a href='http://tuxette.nathalievilla.org'><font color='#DF01A5'>
           <b>Natty</b></font></a> with the generous help of 
           <font color='#3E2D8E'><b>Nicholas</b></font>, 
           <font color='#159332'><b>Arthur P.</b></font> and 
           <font color='#159332'><b>John</b></font> ;-)")),
		p(HTML("Get the sources on <b>github</b>:<br>
           <span style='font-size:12px;font-family:courrier;
           background-color:#FADDF2;border:1px solid black;'>
           <font color='#870500'><b>git clone 
           https://github.com/tuxette/wnaetw.git</b></font></code></span>"))
	),

	# Main panel definition
	mainPanel(
		conditionalPanel(
			condition = "input.fileurl == '' ",
			h3("Basic user guide"),
			p(HTML("To run the application, paste the URL of your data file (you can use, for instance, a public <a href='https://www.dropbox.com/'>Dropbox</a> URL or ask me to host your data by <a href='mailto:nathalie@nathalievilla.org'>sending me an email</a>) in the dedicated area on the left. CSV files are the easiest to use; such an example is given <a href='http://owncloud.nathalievilla.org/apps/files_sharing/get.php?token=a4ccfca90d9c7928ceb6153929d4212bd90badc5'>here</a>. You can test this file by pasting its URL:")),
			p(HTML("<code>http://owncloud.nathalievilla.org/apps/files_sharing/get.php?token=a4ccfca90d9c7928ceb6153929d4212bd90badc5</code>")),
			p("Once your file's URL is pasted, the data are imported and if the importation is done properly, the data are displayed on the main panel and analyzed on the two other panels."),
			p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Warning! wnaetw is a free software provided without guarantee: please note that it does not replace your brain. In particular, the dev team is not responsible if a lazy student is not able to interpret the function's outputs properly!!! (and if he thinks that an average zip code is somehow informative...)</div></b>"))
		),

    tabsetPanel("Data",
                h3("Basic user guide"),
                p(HTML("To run the application, import your data set using the 
                       import button on the left hand side panel. You data must
                       be supplied on the form of a text/csv file. An example
                       of a properly formatted file is provided at <a href=
'http://owncloud.nathalievilla.org/apps/files_sharing/get.php?token=a4ccfca90d9c7928ceb6153929d4212bd90badc5'
                       >here</a> (it contains simple data on my former 
                       first-year students): this file is formatted using the 
                       default options of the left panel.")),
                p("Once your file's URL is pasted, the data are imported and if
                  the importation is done properly, the data are displayed on
                  the main panel and analyzed on the two other panels."),
                p(HTML("<b><div style='background-color:#FADDF2;border:1px solid
                       black;'>Warning! 'wnaetw' is a free program provided
                       without any guarantee: please note that it does not
                       replace your brain. In particular, the dev team is not
                       responsible if a lazy student is not able to interpret
                       the function's outputs properly!!! (and if he thinks
                       that an average zip code is somehow informative...)</div>
                       </b>")),br(),
                h3("The dataset you want to use is displayed below:"),
                p("(only the first 50 first rows if the dataset contains more
                  than 50 rows, and the first 10 columns if the dataset contains
                  more than 10 columns)"),
                tableOutput("view")
    ),
		tabPanel("Summary",downloadButton('downloadSummary', 'Download Summary'),
             br(),br(),tableOutput("summary")),
    
		tabPanel("Boxplots",
		         textInput("main",strong("Graphic title:"), "Boxplots"),
		         textInput("xlab",strong("X axis label:"), "Variables"),
		         textInput("ylab",strong("Y axis label:"), ""),
             textInput("color","Color:","pink",)
		         checkboxInput(inputId = "scale", label = " Scale variables?",
                           value = TRUE),
		         plotOutput("boxplots")
    )
	)
))
