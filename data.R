library(RMySQL)
library(tidyverse)
library(lubridate)

database<- dbConnect(MySQL(), user="root", host="127.0.0.1", password="", dbname="estacion")

query<- dbGetQuery(database,statement ="SELECT * FROM dataestacion")

query1 <- query %>% mutate(Fecha = parse_date_time(Fecha, "ymd HMS"))

write.csv(query1, file="C:/Users/USUARIO/Desktop/MAESTRIA/Tesis-Maestria/NuevaPrueba/data1.csv")

dbDisconnect(database)