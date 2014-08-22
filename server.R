
# load libraries

library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(maps)
library(ggplot2)

# source r code
source("helpers.R")

# load credentials
load("twitteR_credentials")
registerTwitterOAuth(cred)

# Define server logic
shinyServer(function(input, output) {
  
  output$wordcloudmap <- renderPlot({
    
    args <- list(input$tweet)
    
    args$obs <- input$obs 
    args$since <- as.character(input$daterange[1])
    args$until <- as.character(input$daterange[2])
   
    do.call(t.wordcloud, args)
  
  })
  
  output$t.title <- renderText({
    paste0("Wordcloud for Search Term '", input$tweet, "' Using ", input$obs, " Tweets")
  })
  
})