library(shiny)

taxinput <- read.csv("TaxRates.csv")
taxdata <- subset(taxinput, select = c("State", "State.Tax.Rate"))
taxdata$state <- as.character(taxdata$State)

#Calculate sales tax rate for the selected state
rate <- function(state){
  row <- which(taxdata$State == state)
  taxdata$State.Tax.Rate[row]
}

#Calculate amount of sales tax
salesTaxCalc <- function(cost,state){
  cost * rate(state)
}

#Calculate total cost with tax
total <- function(cost,state){
  cost + (cost * rate(state))
}

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$cost})
    output$statetax <- renderPrint({salesTaxCalc(input$cost,input$state)})
    output$totalcost <- renderPrint({total(input$cost,input$state)})
  }
)