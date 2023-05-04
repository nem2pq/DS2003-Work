library(shiny)
library(ggplot2)


function(input, output){
  dataset <- reactive({
    read.csv('diabetes.csv')
  })
  output$diaplot <- renderPlot({
    ggplot(dataset(), aes(x=Glucose, y=BloodPressure)) + geom_point(alpha=0.3) + geom_smooth(method="loess", formula=y ~ poly(x, as.numeric(input$degree)), se=FALSE, span=input$span) + theme_bw()
  })}