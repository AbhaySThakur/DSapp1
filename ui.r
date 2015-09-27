shinyUI(navbarPage("Click on tabs -->>",
	tabPanel("Main Page",
		titlePanel("Display effect of regression Line with Addition of each new point"),
		plotOutput(outputId = "LMPlot","100%","400px",click="plot_click"),
		hr(),
		fluidRow(
			column(width=2,align="center",h4("Reset the Chart"),
					actionButton(inputId = "clear",label = "Reset graph")
			),
			column(width=3,align="center",
				   h4("Current Data points")
					,textOutput("x_val")
			),
			column(width=7,
				   h4("Regression line coefficients")
				   ,verbatimTextOutput("x_coef")
			)
			
		)
	),
	tabPanel("Instructions",
	p("Click on the plot to generate a point"),
        p("You would need atleast two point for the regression line to show up"),
	p("There is a button at the bottom left that clear and resets the graph"),
	p("Number of data points and the current regression coefficients are show in the table at bottom"),
	p("Regression coefficients are for the current data"),
	p("Line in the grey color is the regression line before adding the new point"),
        p("Line in blue is the latest regression line due to the added point")
	)
))
