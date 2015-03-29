library(shiny)
library(ggplot2)

# Savings is the Monthly amount  of saves And mor important thet is the monthly pension for the rest of life
Savings <- function(income,expenses){
  return(income - expenses)
}

#Returns the amount of future savings, by a series of annual discharge
FutureSavings <- function (rate,nper,pmt){
  return((pmt*((1+rate)^nper-1))/rate)
}

#Future value of a one-time deposit
FV <- function(pv,r,n){ return(pv*(1+r)^n)}

# The retirement amount needed
RetirementAmount <- function(savings,withdrawal){
  return((savings*12)/withdrawal)
}

YearRetirment <- function(savings,expenses,yield,withdrawal,pv) {  # pv = Initial saving amount
 
  a <-as.numeric((expenses*12/withdrawal+savings*12/yield)*(yield/(pv*yield+savings*12))) 
  b <-as.numeric(1+yield)
  return(log(a,base = exp(1))/log(b,base = exp(1)))
}

range <- function(x){
  return(c(1:x,x))
} 

Shares <- function(x){
  return((x-0.025)/.05)
}

#--------------------server in/out--------------------------
shinyServer(function(input,output,session){
   
  #make dynamic slider
  output$slider <- renderUI({
    min <- round(as.numeric(input$IncomRange * 0.75),-3)
    max <- round(as.numeric(input$IncomRange * 1.5) ,-3)
    sliderInput("Uincom", "monthly net income range", min=min, max=max, value=input$IncomRange,step=500)
  })

  output$sliderExpenses <- renderUI({
    min <- round(as.numeric(input$IncomRange * 0.10),-3)
    max <- round(as.numeric(input$IncomRange * 0.95),-3)
    mid <- round(as.numeric(input$IncomRange * 0.50),-3)
    sliderInput("Uexpenses", "Monthly Expenses", min=min, max=max, value=mid,step=500)
    })
  
Shares <- reactive({ Shares( as.numeric(input$URyield)) })
    
savings <- reactive({ Savings( as.numeric(input$Uincom)
                               ,as.numeric(input$Uexpenses))})  
  
YR <- reactive({
          YearRetirment( as.numeric(savings())
                        ,as.numeric(input$Uexpenses)
                        ,as.numeric(input$URyield)
                        ,as.numeric(input$URwithdrawal)
                        ,as.numeric(input$Upv)
                        )
}) # YR

rangeX <- reactive({ range(YR())  })   

rangeY <- reactive({ FutureSavings(as.numeric(input$URyield)
                                 ,rangeX()
                                 ,((as.numeric(savings()))*12)
                                 )
}) # rangeY

RetirmentPlot <- reactive({
   data <- data.frame(cbind(x = rangeX(),y = rangeY()))

 return(plot (ggplot(aes(x=x,y=y),data=data) 
                +geom_point() 
                +geom_line(colour = "green", size = 1)
                +scale_x_continuous(breaks = as.integer(data$x))
                +scale_y_continuous(breaks = data$y)
                +annotate("text", x = YR()/4 + 1 , y = tail(data$y,1),colour = "red", label = paste("Years for Retirment  = ",round(YR(),2)))
                +xlab("year")
                +ylab("Cumulative savings")
                +ggtitle('Live But Different')
                )
        )
  })# RetirmentPlot
 
output$text1   <- renderText({  paste("summary:") })
output$text2   <- renderText({  paste("Monthly pension of", input$Uexpenses , ", Accumulated savings amount of"
                                      , round(tail(rangeY(),1),2) , ",   after",round(tail(rangeX(),1),2)," years of saving.
                                       With AN asset allocation of ", as.numeric((input$URyield-0.025)/.05)*100
                                      , "% stocks and", (1-as.numeric((input$URyield-0.025)/.05))*100 , "% bonds.") })

output$distPlot <- renderPlot({  return(RetirmentPlot())  })

}) # end shinyServer