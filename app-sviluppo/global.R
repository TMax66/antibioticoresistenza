######LIBRERIE######
library(shiny)
library(shinydashboard)
library (DT)
library(plotly)
library(reshape2)
library(data.table)
library(dplyr)
library(ggplot2)
library(tibble)
library(lubridate)
library(scales)
library(gridExtra)
library(forecast)
library(TTR)
library(xts)
library(dygraphs)
library(datasets)
library(tidyverse)
library(rpivotTable)
library(shinyalert)
library(knitr)
library(formattable)
library(kableExtra)
####################################################################
dati<-read.csv("dati.csv", header=T, sep=";")
dati<-as_tibble(dati)
dati$datareg<-dmy(dati$datareg)
dati<-mutate(dati,anno=year(datareg))
dati$anno<-as.Date((paste(dati$anno,"-01","-01",sep="")))

options(knitr.kable.NA = '')



z<-dati %>% 
    filter(codall=="044BG044") %>%
    select(anno,specie, ceppo, materiale, antibiotico, ris) %>% 
    mutate(ris = 
             ifelse(ris=="R",     
                    cell_spec(ris, "html", color="red",bold=T),
                    cell_spec(ris, "html", color="green", bold=T))) %>% 
    
    arrange(anno) %>% 
    #mutate(dtprel=format(dtprel, "%d-%m-%Y")) %>% 
    pivot_wider(names_from=antibiotico,values_from=ris ) 

kable(z,escape=F) %>% 
  kable_styling("striped",font_size = 10)




  