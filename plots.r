
###############################
# feature Selection plots
###############################

library(ggplot2)
library(ggpubr)
library(dplyr)
library(leaps)
library(magrittr)

# predicting salary for next 3 year and combining data frames  

fd11<-Final_data[which(Final_data$Fiscal.Year=="2016"&Final_data$Job.Title=="correctional officer" ), ]
fd12<-Final_data[which(Final_data$Fiscal.Year=="2017"&Final_data$Job.Title=="correctional officer" ), ]
fd13<-data.frame(Fiscal.Year=2018,Fiscal.Quarter=2,Job.Title="correctional officer")
fd14<-data.frame(Fiscal.Year=2019,Fiscal.Quarter=2,Job.Title="correctional officer")
fd15<-data.frame(Fiscal.Year=2020,Fiscal.Quarter=2,Job.Title="correctional officer")
f1 <- data.frame(
  year = c("2016","2017"),
  value = c(median(fd11$Base.Pay),median(fd12$Base.Pay))
)

a<-predict(lm.fit1,fd13)
b<-predict(lm.fit1,fd14)
c<-predict(lm.fit1,fd15)
fdm<-data.frame(
  year=c("2018","2019","2020"),
  value=c(a,b,c)
)

f2<-rbind(f1,fdm)

# Line plot for year vs salary 
lp<-ggplot(data=f2, aes(x=year, y=value,group=1))+ geom_line(color="red")+geom_point()
lp


#plot for quarter vs salary

fquarter<-distinct(fd11, Fiscal.Quarter, .keep_all = TRUE)
lp1<-ggplot(data=fquarter, aes(x=Fiscal.Quarter, y=Base.Pay,group=1))+ geom_line(color="green")+geom_point()
lp1


#plot for job title vs salary 
d1<-distinct(n1, Job.Title, .keep_all = TRUE)
n1<-n1[1:10,]
bp<-ggbarplot(n1,x="Job.Title",y="Base.Pay",fill = "orange",color = "orange",x.text.angle = 90)
bp + font("x.text", size = 8)
bp

#plot for job title vs salary
d2<-distinct(new_Final, Bureau, .keep_all = TRUE)
d2<-d2[1:10,]
bp1<-ggbarplot(d2,x="Bureau",y="Base.Pay",fill = "orange",color = "orange",x.text.angle = 90   )       
bp1 + font("x.text", size = 8)
bp1



#Forward step selection method

first=lm(Base.Pay~1,data=newdata)
last=lm(Base.Pay~., data=newdata)
step(null1,scope=list(lower=first,upper=last), direction="forward")
  