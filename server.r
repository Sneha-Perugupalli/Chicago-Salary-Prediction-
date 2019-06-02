##################################
# web-page outputs
##################################

library(shiny)
library(ggplot2)

# input take value from user and predict

shinyServer(function(input, output) {

  output$summary <- renderPrint({
    predict.data1<-data.frame(Fiscal.Year=input$year,Fiscal.Quarter=input$quarter,Job.Title=input$second)
    if(input$quarter=="1"|input$quarter=="4")
    {
      x<-predict(lm.fit1,predict.data1)
      
    }
    else
    {
    x<-predict(lm.fit,predict.data1)
    }
    
    cat(unname(x))
  })
  
  # output median value
  output$abc <- renderPrint({
  fd21<-Final_data[which((Final_data$Fiscal.Year=="2016"|Final_data$Fiscal.Year=="2017")&Final_data$Job.Title==input$tittle ), ]
  y<-median(fd21$Base.Pay)
  cat("MEDIAN:",floor(y),"$")
   })
  # output plot
  output$q13 <- renderPrint({
    fd21<-Final_data[which((Final_data$Fiscal.Year=="2016"|Final_data$Fiscal.Year=="2017")&Final_data$Job.Title==input$tittle ), ]
    y1<-quantile(fd21$Base.Pay,0.10)
      y1<-quantile(fd21$Base.Pay,0.25)
    y2<-quantile(fd21$Base.Pay,0.75)
    cat("|",floor(y1),"|",floor(y2),"|")
  })
  #output plot
  output$plot <- renderPlot({
    df <- data.frame(
      group = c("Stroger Hospital","Health","Provident Hos","Justice adv","Ambulatory com",
                "Transpotation","Admin","BOH","OAK Forest","HR"),
      value = c(41, 19, 3,1,7,3,22,1,1,2)
    )
  
   bp<- ggplot(df, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")
  pie <- bp + coord_polar("y", start=0)
    pie
    
  })
  
  #output line plot
  
  output$lplot <- renderPlot({

    fd11<-Final_data[which(Final_data$Fiscal.Year=="2016"&Final_data$Job.Title==input$tittle ), ]
    fd12<-Final_data[which(Final_data$Fiscal.Year=="2017"&Final_data$Job.Title==input$tittle ), ]
    fd13<-data.frame(Fiscal.Year=2018,Fiscal.Quarter=2,Job.Title=input$tittle)
    fd14<-data.frame(Fiscal.Year=2019,Fiscal.Quarter=2,Job.Title=input$tittle)
    fd15<-data.frame(Fiscal.Year=2020,Fiscal.Quarter=2,Job.Title=input$tittle)
    f1 <- data.frame(
      year = c("2016","2017"),
      value = c(median(fd11$Base.Pay),median(fd12$Base.Pay))
    )
    
    a<-predict(lm.fit,fd13)
    b<-predict(lm.fit,fd14)
    c<-predict(lm.fit,fd15)
    fdm<-data.frame(
      year=c("2018","2019","2020"),
      value=c(a,b,c)
    )
    f2<-rbind(f1,fdm)
    lp<-ggplot(data=f2, aes(x=year, y=value,group=1))+ geom_line(color="red")+geom_point()
    lp
    
      })
  
})