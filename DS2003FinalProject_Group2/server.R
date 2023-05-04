library(ggplot2)
library(viridis)
library(shiny)
library(shinyWidgets)
library('rsconnect')
dataset <- read.csv("Spotify 2010 - 2019 Top 100.csv")
dataset <- subset(dataset, dataset$top.year != 'NA')
spot <- dataset[,-c(1, 2, 3, 5, 18)]
invars <- spot[, c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)]
names(invars) <- c('BeatsperMinute', 'Energy', 'Danceability', 'Decibel', 'Live', 'Positivity', 'Duration', 'Acoustics', 'Speech', 'Popularity', 'TopYear')
spotvars <- colnames(invars)
attach(spot)

function(input, output){
  output$scatterplot <- renderPlot({
    ggplot(invars, mapping = aes_string(x= input$xval, y= input$yval)) + 
      geom_point(aes(color = factor(invars$TopYear))) + 
      xlim(input$minimum,input$maximum) +
      scale_color_viridis(discrete = TRUE, option = "D") +
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            panel.background = element_rect(fill = '#FFFFFF'),
            text=element_text(size=16,family="serif")) +
      ggtitle(paste('Relationship Between Variables:', input$xval, ' & ', input$yval)) + 
      guides(color = guide_legend(title = "Year Charted"))
  })
  d <- reactive({
    years <- subset(invars, TopYear == input$year)
    
  })
  output$distplot <- renderPlot({
    ggplot(d(), aes(get(input$vars2), factor(TopYear)))+
      geom_boxplot(aes(color = factor(TopYear))) + scale_color_viridis(discrete = TRUE, option = "D") +
      coord_flip()+ geom_jitter(width = input$jitter, aes(color = factor(TopYear)))+ylab("Year")+xlab(input$vars2)+ ggtitle(paste('Boxplot of ', input$vars2, " by Year")) +theme(panel.grid.major = element_blank(), 
                                                                                                                                                                                  panel.grid.minor = element_blank(),
                                                                                                                                                                                  panel.background = element_rect(fill = '#FFFFFF'),
                                                                                                                                                                                  text=element_text(size=16,family="serif"))+ 
      guides(color = guide_legend(title = "Year Charted"))
  })
}
  