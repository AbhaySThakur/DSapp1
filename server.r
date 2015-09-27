library(shiny)
fit_old <<- NULL
fit     <<- NULL
mat     <<- NULL
shinyServer(function(input, output) { 
	val <- reactiveValues(x=NULL,y=NULL)
	observe({
		#Handles initial empty condition on load
		if(is.null(input$plot_click)){
			return()
		}
		isolate({
			val$x <- c(val$x,input$plot_click$x)
			val$y <- c(val$y,input$plot_click$y)
			})
	})
	observe({
		if(input$clear > 0){
			val$x <- NULL
			val$y <- NULL
			fit_old<- NULL
			fit   <- NULL
		}
	})
	output$x_val <- renderText({
		length(val$x)
	})
	output$LMPlot <- renderPlot({
		plot(val$x, val$y, xlim=c(0, 4), ylim=c(0, 4), xlab="", ylab="",pch=16,col=rgb(0,1,0.5,0.3),cex=2)
		text(2, 4, "Grey - old reg line, blue - reg line due to new point",cex = 1)
		if(length(val$x) > 1){
			text(2, 4, "Grey - old reg line, blue - reg line due to new point",cex = 1)
			fit <- lm(val$y~val$x)
			abline(fit,col="blue",lwd=2)
			if(!is.null(fit_old)){ abline(fit_old, col="grey",lwd=2)}
		}else if(length(val$x) == 1){
			text(2, 2, "Need atleast 2 points for calculations",cex = 2)
		}else{text(2, 2, "Please click within the chart to create data points",cex = 2)}
		fit_old <<- fit		
	})
	output$x_coef <- renderPrint({
		if(length(val$x) > 2){
		summary(lm(val$y~val$x))$coefficients
		} else { print("Need more data point to display reg coefficients")}
	})
}
)