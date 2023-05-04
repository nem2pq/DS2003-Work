library(shiny)
library(ggplot2)


covid<-read.csv('WHO-COVID-19-global-table-data.csv')
covid$country <- row.names(covid)
covid$mortalityRate <- covid$Deaths...cumulative.total / covid$Cases...cumulative.total
se <- sd(na.omit(covid$mortalityRate))/sqrt(length(na.omit(covid$mortalityRate)))
covidSubset <- covid[covid$country %in% c("France", "Germany", "Italy", "Republic of Korea", "Jqpan", "Australia", "Argentina", "Mexico", "Iran (Islamic Republic of)", "Canada", "India", "Indonesia", "Thailand", "South Africa", "Iraq", "Jordan", "Ethiopa", "Kenya", "Zambia"),]


function(input, output){
  output$mortplot <- renderPlot({
    covidSubset1 <- covidSubset[covidSubset$Name == input$Region,]
    ggplot(covidSubset1, aes(x=country, y=mortalityRate)) + geom_bar(stat="identity") + ylab('Mortality Rate') +
      xlab('Country') + labs(title="Mortality Rate in Various WHO Regions") + geom_errorbar(aes(ymin = mortalityRate-se, ymax = mortalityRate+se, width = 0.4)) +theme_bw()
  })}