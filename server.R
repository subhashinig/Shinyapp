library(shiny)
library(caret)

data(iris)

inTrain <- createDataPartition(iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
number_ticks <- function(n) {function(limits) pretty(limits, n)}

algo <- function(){
  if(input$algo == "svm"){
    re <- "Support Vector Machine"
  }
  else if(input$algo == "lda"){
    re <- "Linear Discriminant Analysis"
  }
  else{
    re <- "Random Forests"
  }
  return(re)
}

svm <- function(training, testing){
  start <- Sys.time()
  fit <- train(Species ~ ., method = "svmLinear", data = training)
  pred <- predict(fit, testing)
  end <- Sys.time()
  
  time <- end - start
  res <- confusionMatrix(pred, testing$Species)
  
  re <- list(summary = res, time = time)
  
  return(re)
}

lda <- function(training, testing){
  start <- Sys.time()
  fit <- train(Species ~ ., method = "lda", data = training)
  pred <- predict(fit, testing)
  end <- Sys.time()
  
  time <- end - start
  res <- confusionMatrix(pred, testing$Species)
  
  re <- list(summary = res, time = time)
  
  return(re)
}

rf <- function(training, testing){
  start <- Sys.time()
  fit <- train(Species ~ ., method = "rf", data = training)
  pred <- predict(fit, testing)
  end <- Sys.time()
  
  time <- end - start
  res <- confusionMatrix(pred, testing$Species)
  
  re <- list(summary = res, time = time)
  
  return(re)
}

shinyServer(
  function(input, output) {
    
    output$dis <- renderPrint({str(iris)})
    
    output$data <- renderPlot(function() {
      p <- scatterplotMatrix(~.|Species,data = iris, legend = FALSE)
      print(p)
    })
    
    output$algo <- reactivePrint(function(){
      if(input$algo == "svm"){
        re <- "Support Vector Machine"
      }
      else if(input$algo == "lda"){
        re <- "Linear Discriminant Analysis"
      }
      else{
        re <- "Random Forests"
      }
      return(re)
    })
    
    output$res <- reactivePrint(function(){
      if(input$algo == "svm"){
        svm(training, testing)
      }
      else if(input$algo == "lda"){
        lda(training, testing)
      }
      else{
        rf(training, testing)
      }
    })
  }
)
