library(shiny)
library(ggplot2)


fluidPage(
  selectInput("Region", label = "Who Region:", choices = c("Africa", "Americas", "Eastern Mediterranean", "Europe", "South-East Asia", "Western Pacific"), selected = "Africa"),
  plotOutput("mortplot"))