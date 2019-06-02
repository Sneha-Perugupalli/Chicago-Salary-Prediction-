################################
# Pre Processing
###############################

#remove all previous Environment Variable

rm(list=ls())
library(Amelia)
library(ISLR)

#read data and replce blank with NA(for Middle name)
MyData <- read.csv(file="E:/wallpaper/Employee_Payroll.csv", header=TRUE, sep=",",na.strings=c("","NA"))

#missing value plot
missmap(MyData)

#remove rows with pay=0 
CleanData1<-MyData[which(MyData$Base.Pay!="0"),]

#remove rows with unsepcified office name
CleanData2 <- CleanData1[complete.cases(CleanData1$Office), ]

# Convert all value of job_tittle to lowercase otherwise count in different job_tittle 
Final_data<-within(CleanData2, Job.Title <- tolower(Job.Title))

#plot missing value map
missmap(Final_data)
