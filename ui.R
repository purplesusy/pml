library(shiny)

# Define UI for application that plot a wordcloud
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mining Tweets"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("Create maps using tweets"),
      
      br(),
  
      textInput('tweet', 'Enter word(s) to plot:', value = 'machine learning'),
      
      br(),
      
      dateRangeInput('daterange', 
                     'Select a date range:',
                     start = Sys.Date() - 1,
                     end = Sys.Date(),
                     min = Sys.Date() - 7,
                     max = Sys.Date(),
                     format = 'mm/dd/yy',
                     separator = '-'),
      
      br(),
      
      sliderInput('obs', 
                  'Number of Tweets',
                  min = 100, max = 500, value = 100, step = 100),
      
      br(),
      br(),
      
      submitButton("Update")
      
    ),
    
    # Show results
    mainPanel(
      
      #plotOutput("wordcloudmap")
      
      tabsetPanel(type = "tabs",
                  tabPanel("WordCloud", 
                           helpText("Create wordcloud maps using tweets"),
                           br(),
                           textOutput("t.title"),
                           br(),
                           plotOutput("wordcloudmap"))
                  )
      
    )
  )
))
