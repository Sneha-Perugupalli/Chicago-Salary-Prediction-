####################################
#Multiple-linear Regression
####################################

#include package 
library(MASS)
library(ggpubr)
library(ISLR)
library(ggplot2)
library(MLmetrics)

#Select data only for 2 years, 3rd year data is for testing

newdata <- Final_data[which((Final_data$Fiscal.Year=="2017"|Final_data$Fiscal.Year=="2016")& (Final_data$Fiscal.Quarter=="3"|Final_data$Fiscal.Quarter=="2" )),]

#fit model
lm.fit<-lm(Base.Pay~Fiscal.Year+Fiscal.Quarter+Job.Title,data=newdata)
lm.pred<- predict(lm.fit, newdata = n21)

#performance and summary 
sqrt(mean((lm.pred - n21$Base.Pay)^2))
summary(lm.fit1)

# Select data for 2 years but for different quarter because it will take time to run
newdata1 <- Final_data[which((Final_data$Fiscal.Year=="2017"|Final_data$Fiscal.Year=="2016")& (Final_data$Fiscal.Quarter=="1"|Final_data$Fiscal.Quarter=="4" )),]

# fit model
lm.fit1<-lm(Base.Pay~Fiscal.Year+Fiscal.Quarter+Job.Title,data=newdata1)
lm.pred1 <- predict(lm.fit1, newdata = n21)

#performance
sqrt(mean((lm.pred1- n21$Base.Pay)^2))
MAPE(lm.fit$fitted.values,n21$Base.Pay)

#Prediction values for given inputs
predict.data<-data.frame(Fiscal.Year=2019,Fiscal.Quarter=2,Job.Title="correctional officer")
predict.data1<-data.frame(Fiscal.Year=2019,Fiscal.Quarter=4,Job.Title="deputy sheriff d2b")
predict(lm.fit,predict.data,interval = "prediction")
predict(lm.fit1,predict.data1)



