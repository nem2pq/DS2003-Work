library(shiny)
library(ggplot2)

dataset <- read.csv('diabetes.csv')
fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("degree", label = h3("Select Degree:"), 
                  choices = list( 0, 1, 2), 
                  selected = 2),
      sliderInput("span", label = h3("Span adjustment:"),
                  min = 0.2, max = 0.9, value = 0.5, step = 0.1)
    ),
    mainPanel(
      plotOutput("diaplot")
    )
  ))