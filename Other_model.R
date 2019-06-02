

######################
# LASSO and Ridge regression
######################

# include package
library(dplyr)
library(leaps)
library(glmnet)
library(MLmetrics)

# Divide data based on year

n1 <- Final_data[which(Final_data$Fiscal.Year=="2017"),]
n2 <- Final_data[which(Final_data$Fiscal.Year=="2016"),]
n3 <- Final_data[which(Final_data$Fiscal.Year=="2018"),]

# Find the common job titles in each dataset
common <- intersect(n1$Job.Title, n2$Job.Title) 
common1 <- intersect(common, n3$Job.Title) 
common1<-common1[1:500] #only selected 1st 500 becuase it is taking time to run
common<-common[1:500]
n21<-n2[n2$Job.Title %in% common1,]
n11<-n1[n1$Job.Title %in% common1,]
n31<-n3[n3$Job.Title %in% common1,]
n21<-n21[1:73270,]


#train and test data base
x.tr <- model.matrix(n11$Base.Pay ~ n11$Fiscal.Year+n11$Fiscal.Quarter+n11$Job.Title, data = n11)[,-1]
y.tr <- n11$Base.Pay
x.val <- model.matrix(n21$Base.Pay ~ n21$Fiscal.Year+n21$Fiscal.Quarter+n21$Job.Title, data = n21)[,-1]
y.val<-n21$Base.Pay

#ridge regresion 
set.seed(10)
rr.cv <- cv.glmnet(x.tr, y.tr, alpha = 0)
rr.bestlam <- rr.cv$lambda.min
rr.goodlam <- rr.cv$lambda.1se

# predict validation set using best lambda and calculate RMSE
rr.fit <- glmnet(x.tr, y.tr, alpha = 0)
plot(rr.fit, xvar = "lambda", label = TRUE)
rr.pred <- predict(rr.fit, s = rr.bestlam, newx = x.val)

# Perfomance
sqrt(mean((rr.pred - y.val)^2))
MAPE(rr.pred,n21$Base.Pay)

#lasso
set.seed(10)
las.cv <- cv.glmnet(x.tr, y.tr, alpha = 1)
plot(las.cv)
las.bestlam <- las.cv$lambda.min
las.goodlam <- las.cv$lambda.1se

# predict validation set using best lambda and calculate RMSE
las.fit <- glmnet(x.tr, y.tr, alpha = 1)
plot(las.fit, xvar = "lambda", label = TRUE)
rr.pred <- predict(las.fit, s = las.bestlam, newx = x.val)

#Performance
sqrt(mean((rr.pred - y.val)^2))
MAPE(rr.pred,n21$Base.Pay)

