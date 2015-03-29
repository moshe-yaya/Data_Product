---
title       : Freedom Calculator App
subtitle    : Developing Data Products / Johns Hopkins University - Data Science Specialization (Coursera)
author      : Moshe Rechtman
job         : 21/03/2015           

framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : standalone # {standalone, draft}
knit        : slidify::knit2slides


---

## App Introducing


Freedom Calculator aim is to encourage the user to achieve economic independence and early retirement   in a short time compared to the legal retirement age. By completing five variables, the App presents a graph showing the amount of accumulated savings and the time needed for the desired retire. An interesting point is that no matter the size of the income but the percentage of monthly savings affects the time it takes to retire. Therefore adaptation modest lifestyle away from the consumer culture will promote this goal much faster than the average person's image.
If this field raises interest and excitement, you can find it on ERE on the WEB.

some embedded R code ...

```r
1+1
```

```
## [1] 2
```



--- 

## Using the App

# The Application has 5 Variables:

* Initial saving amount: Initial capital, getting started amount of money

* Monthly net income   : Net monthly income after taxes

* Monthly Expenses     : Fixed monthly expenses (in present and future) 

* Annual yield         : Expected rate in the investment portfolio , risk level Measurement 

* Annual withdrawal    : Percentage annual withdrawal from retirement savings. Those who want to go on the safe side can change to 3 -3.5 %

---

## Basic assumptions

To build such a model some assumptions must to be taken. It is important to note that even if the assumptions are not precise, they are good enough to provide reference points for the amount of time needed for the desired retirement.

1. Monthly Expenses- Fixed monthly amount spent during and after retirement, 

2. Annual yield-  This Application is directed for passive investment strategy and it assumes an average annual return of 7.5% and 2.5% of shares and bonds, for long-term investment.

3. Flexibility to changes- Life is not a mathematical model, so model variables are expected to constantly change, therefore the App encourages the user to perform sensitivity analyzes and there is always the possibility of discounting the savings and reposition the data.



---

## Model Description

Monthly saving amount + Initial capital = amount required for retirement

Monthly saving amount :
$(Monthly Savings Amount)*((1+ Annual Yield)^n - 1))/ Annual Yield$

Initial capital :
$(Initial Saving Amount) * (1+ Annual Yield)^n$  

Amount required for retirement:
$(Monthly Savings Amount *12) / Withdrawal$

  a  <- $( expenses *12 / withdrawal + savings *12 / Yield)$  
 $*( Yield /(Retirement Amount * Yield + savings *12))$
  
  $b  <-  (1+yield)$
  
Years for Retirment = $LEN(a/b)$


To try the app click [here](http://datapresent.shinyapps.io/dataProduct)
