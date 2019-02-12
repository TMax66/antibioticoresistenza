library(tidyverse)
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
library(rpivotTable)
####################################################################
dati<-read.csv("dati.csv", header=T, sep=";")
dati<-as_tibble(dati)
dati$datareg<-dmy(dati$datareg)
dati<-mutate(dati,anno=year(datareg))
dati$anno<-as.Date((paste(dati$anno,"-01","-01",sep="")))

####grafico trend annuale %resistenze materiale,specie,antibiotico###


  
  #  mutate(antibiotico = factor(antibiotico, unique(antibiotico))) %>% 
  # ggplot(aes(x=antibiotico,y=`%resistenti`,label=`%resistenti`))+
  # geom_point(stat='identity',col="snow2", size=8)+
  # geom_text(color="black", size=3)+
  # geom_segment(aes(x=antibiotico, 
  #                  xend=antibiotico, 
  #                  # y=min(`%resistenti`),
  #                  y=0,
  #                  yend=`%resistenti`-2 
  #                  # linetype="dashed", 
  #                  #
  # ))+
  # labs(title="% di ceppi resistenti",caption=Sys.Date()) +  
  # coord_flip()





#####grafico materiale ceppo antibiotico####
totx<-dati %>% 
  group_by(specie,materiale, ceppo, antibiotico) %>% 
  summarise("n"=n()) 
res<-dati %>% 
  group_by(specie,materiale,ceppo, antibiotico) %>% 
  filter(ris=='R') %>% 
  summarise("r"=n())  
z<-totx %>% full_join(res)%>% 
  replace_na(list(r=0)) %>% 
  mutate("%resistenti"=(r/n)*100) 


  
  
 x<- z%>% 
    filter(ceppo=='Escherichia coli', materiale=="LATTE", specie=="CONIGLIO") 
  
   if(x)
    arrange(`%resistenti`) %>% 
    mutate(`%resistenti`= round(`%resistenti`,1)) %>% 
    mutate(antibiotico = factor(antibiotico, unique(antibiotico))) %>% 
    ggplot(aes(x=antibiotico,y=`%resistenti`,label=`%resistenti`))+
    geom_point(stat='identity',col="snow2", size=8)+
    geom_text(color="black", size=3)+
    geom_segment(aes(x=antibiotico, 
                     xend=antibiotico, 
                     # y=min(`%resistenti`),
                     y=0,
                     yend=`%resistenti`-2 
                     # linetype="dashed", 
                     #
    ))+
    labs(title="% di ceppi resistenti",caption=Sys.Date()) +  
    coord_flip()
  
############################################################
  totx<-dati %>% 
    group_by(specie,materiale, ceppo, antibiotico) %>% 
    summarise("n"=n()) 
  res<-dati %>% 
    group_by(specie,materiale,ceppo, antibiotico) %>% 
    filter(ris=='R') %>% 
    summarise("r"=n())  
  z<-totx %>% full_join(res)%>% 
    replace_na(list(r=0)) %>% 
    mutate("%resistenti"=(r/n)*100) %>% 
    filter(materiale=="LATTE", specie=="BOVINO", antibiotico=="Ampicillina")
  
  
z%>% 
    arrange(`%resistenti`) %>% 
    mutate(`%resistenti`= round(`%resistenti`,1)) %>% 
    ungroup() %>% 
    mutate(ceppo= factor(ceppo, unique(ceppo))) %>% 
    ggplot(aes(x=ceppo,y=`%resistenti`,label=`%resistenti`))+
    geom_point(stat='identity',col="snow2", size=8)+
    geom_text(color="black", size=3)+
    geom_segment(aes(x=ceppo, 
                     xend=ceppo, 
                     # y=min(`%resistenti`),
                     y=0,
                     yend=`%resistenti`-2 
                     # linetype="dashed", 
                     #
    ))+
    labs(title="% di ceppi resistenti",caption=Sys.Date()) +  
    coord_flip()
  