library(shiny)

taxinput <- read.csv("TaxRates.csv")
taxdata <- subset(taxinput, select = c("State", "State.Tax.Rate"))
taxdata$state <- as.character(taxdata$State)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
  
  # Application title
  titlePanel("Sales Tax Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput('cost','Taxable Cost', 0.00, min = 0.00, step = 1.00),
      selectInput('state', 'State', choices = as.character(taxdata$State)),
      submitButton('Submit')
    ),
    
    # Show the sub total, total tax, and total after tax
    mainPanel(
      h4('Sub Total'),
      verbatimTextOutput("inputValue"),
      h4('Total Tax'),
      verbatimTextOutput("statetax"),
      h4('Total'),
      verbatimTextOutput("totalcost")
    )
   )
  )
)