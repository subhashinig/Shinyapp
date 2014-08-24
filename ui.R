library(shiny)

shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Classification Algorithm Demo"),
        
    sidebarPanel(
      
      radioButtons("algo", "Select Algorithm:",
                   c("Support Vector Machine" = "svm",
                     "Linear Discriminant Analysis" = "lda",
                     "Random Forests" = "rf")),
      
      submitButton("Submit")
    ),
    
    
    mainPanel(
        h3('Dataset display'),
        verbatimTextOutput("dis"),
      
        h3('Dataset exploratory'),
        plotOutput("data"),
        
        h3('Your algorithm'),
        verbatimTextOutput("algo"),
        
        h3('Results'),
        verbatimTextOutput("res")
    )
  )
)

