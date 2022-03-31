#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinythemes)
library(tidyverse)
library(lubridate)
library(plotly)
library(dashboardthemes)
library(RCurl)

server <- function(input, output) {
    
    url <- 'https://raw.githubusercontent.com/AndresG25/NuevaPrueba/main/data1.csv'
    query <- read.csv(url)
    #database<- dbConnect(MySQL(), user="root", host="127.0.0.1", password="", dbname="estacion")
    
    #query<- dbGetQuery(database,statement ="SELECT * FROM dataestacion")
    
    #query1 <- query %>% mutate(Fecha1 = parse_date_time(Fecha, "ymd HMS"))
    
    df <- as.data.frame(query)

    output$RPMane <- renderValueBox({
        pos <- df[nrow(df),]
        
        pos <- pos %>% mutate(RPM = as.numeric(RPM)) %>% select(-Fecha, -Temperatura, -Presion, -Altitud, -Vviento, -Fecha1)
        
        valueBox(value = pos$RPM, subtitle = "RPM Anemometro", color = "green", icon = icon("compass"))
        
    })
    
    output$Vviento<- renderValueBox({
        pos <- df[nrow(df),]
        
        pos <- pos %>% mutate(Vviento = as.numeric(Vviento)) %>% select(-Fecha, -Temperatura, -Presion, -Altitud, -RPM, -Fecha1)
        
        valueBox(value = pos$Vviento, subtitle = "Vel. Viento m/s", icon = icon("wind"), color = "green")
        
    })
    
    output$Temp<- renderValueBox({
        pos <- df[nrow(df),]
        
        pos <- pos %>% mutate(Temperatura = as.numeric(Temperatura)) %>% select(-Fecha, -Vviento, -Presion, -Altitud, -RPM, -Fecha1)
        
        valueBox(value = pos$Temperatura, subtitle = "Temperatura °C", icon = icon("temperature-high"), color = "orange")
        
    })
    
    output$Pres<- renderValueBox({
        pos <- df[nrow(df),]
        
        pos <- pos %>% mutate(Presion = as.numeric(Presion)) %>% select(-Fecha, -Vviento, -Temperatura, -Altitud, -RPM, -Fecha1)
        
        valueBox(value = pos$Presion, subtitle = "Presión Atmosférica Pa", icon = icon("dashboard"), color = "orange")
        
    })
    
    
    
    output$Altitud <- renderValueBox({
        pos <- df[nrow(df),]
        
        pos <- pos %>% mutate(Altitud = as.numeric(Altitud)) %>% select(-Fecha, -Temperatura, -Presion, -RPM, -Vviento, -Fecha1)
        
        valueBox(value = pos$Altitud, subtitle = "Altitud m.s.n.m", color = "orange", icon = icon("cloud"))
        
    })     
        
    output$temperatura <- renderPlotly({
        
        
        df$fecha <- date(df$Fecha1)
        
        df$tiempo <- format(df$Fecha1, format = "%H:%M:%S")
        
        df$hora <- hour(df$Fecha1)
        
        df1 <- df %>% group_by(hora) %>% summarise(Temp = mean(as.integer(Temperatura)))
        
        
        g <- ggplot(df1, aes(x=hora, y=Temp)) + geom_line(color = "red") + geom_point(color = "red")+
            labs(title = "Temperatura promedio diaria") + labs(x = "Periodo", y = "Temperatura")
        
        fig <- ggplotly(g)
        
        
        
    })
    
    output$presion <- renderPlotly({
        
        df$fecha <- date(df$Fecha1)
        
        df$tiempo <- format(df$Fecha1, format = "%H:%M:%S")
        
        df$hora <- hour(df$Fecha1)
        
        df2 <- df %>% group_by(hora) %>% summarize( Pres = mean(as.integer(Presion)))
        
        
        g1 <- ggplot(df2, aes(x=hora, y= Pres)) + geom_line(color = "blue") + geom_point(color = "blue")+
            labs(title = "Presión atmosferica promedio diaria") + labs(x = "Periodo", y = "Presión Atmosferica")
        
        fig1 <- ggplotly(g1)
        
    
        
    })
    
    dbDisconnect(database)
    
}
