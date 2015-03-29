library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  # Title
  headerPanel("Welcome to the Freedom Calculator App"),
  
  # User input: Monthly incom , Monthly expenses, yield-Annual return, Annual withdrawal rate 
  sidebarPanel(
    numericInput('Upv', 'Initial saving amount', 0, min = 0),
    numericInput("IncomRange", "Insert your monthly net income", 10000),
    helpText("Same as above, convenient to perform sensitivity analyzes"),
    uiOutput("slider"),
    uiOutput("sliderExpenses"),
    helpText("Monthly Expenses -  is also the monthly amount pension after retirement"),
    sliderInput("URyield"    ,label = "Average annual yield",min=.025,max=0.10,value=.05  ,step=.005),
    helpText("Passive investment up to 7.5%  more details in the Help tab"),
    radioButtons("URwithdrawal", "annual withdrawal",inline = TRUE, choices =
                      c( "0.03"   = "0.030",
                         "0.035"  = "0.035",
                         "0.04"   = "0.04"),
                         selected = "0.04")
                      
   ),
  
mainPanel(  tabsetPanel(
                         tabPanel("MyApp", plotOutput("distPlot"),h2(textOutput("text1")),textOutput("text2")),
                         tabPanel("Help", 
                                  p("This App target, is to encourage and promote economic independence and early retirement, ERE. Through investment in the capital market and persistence over time on the plan of action, anyone can succeed!"),
                                  p("Of course, the amount of savings is individual for each person, the purpose of the App is to present guidelines for action until desired retirement, so the App encourages playing with the slider variables and performing, sensitivity analysis, Enjoy!"),
                                  h4("Several assumptions:"),
                                  p("Monthly expenses - a parameter that represents the level of monthly expenses, in present and future. The model assumes a fixed number throughout the period but you can use the slider to examine the level of expenses."),
                                  p("The model encourages a passive investment and assumes a 7.5% return on the stock market and 2.5% in bonds (real return), it must be understood that these numbers are an anchor for the calculation and not guaranteed in any way to the user. Moving the parameter annual yield above 7.5% is not properly represented in the summary. Those who want to go on the safe side can reduce the annual withdrawal parameter to 3-3.5%"),
                                  p("* Important! The use of this App is at your own risk and does not assume any specific action in the investment portfolio"),                                  
                                  helpText( a("Click here for more details", href="http://rpubs.com/mosheR/67591",target="_blank"))
                                  ) #help panel  
                   ), #tabset_Panels
         htmlOutput("text")       
        ) #main panel
))