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
#dati<- mutate(dati, mese=paste(year(datainizio),'-',month(datainizio),sep=''))
#dati$mese<-as.Date((paste(dati$mese,"-01",sep="")))
dati<-mutate(dati,anno=year(datareg))
dati$anno<-as.Date((paste(dati$anno,"-01","-01",sep="")))

# dati<-dati %>% 
#   mutate(Res=ifelse(ris=="R", 1, 0))




####grafico trend annuale %resistenze materiale,specie,antibiotico###

totx<-dati %>% 
  group_by(anno, specie,materiale, ceppo, antibiotico) %>% 
  summarise("n"=n()) 
res<-dati %>% 
  group_by(anno, specie,materiale,ceppo, antibiotico) %>% 
  filter(ris=='R') %>% 
  summarise("r"=n())  
z<-totx %>% full_join(res)%>% 
  replace_na(list(r=0)) %>% 
  mutate("%resistenti"=(r/n)*100) 

z<-z%>% 
  filter(specie=="BOVINO",ceppo=='Escherichia coli', 
         materiale=="LATTE",antibiotico=="Cefalexina") 
z<-xts(z$`%resistenti`, order.by = as.Date(z$anno))
 
dygraph(z,ylab = "%resistenza")
###########GRAFICO E TABELLA DELLA STRUTTURA COMPLESSA###############
grafico<-reactive({graf})
tabella<-reactive({set})

output$dygraph <- renderDygraph({
  
  dygraph(z,ylab = "%resis")%>%
    dySeries("..1", label="Totale Attività", color='red')%>%
    dySeries("..2", label = "Settore Alimenti", color='green')%>%
    dySeries("..3", label="Sanità Animale", color='blue')%>%
    dySeries("..4", label="Controllo Qualità", color='black')%>%
    dySeries("..5", label="Alimenti Zootecnici", color='brown')%>%
    dyHighlight(highlightSeriesOpts = list(strokeWidth = 1.5))%>%
    dyRoller(rollPeriod = input$mesi)%>%
    dyRangeSelector()
  
})
  
  
  
  
  
  
  
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
  group_by(materiale, ceppo, antibiotico) %>% 
  summarise("n"=n()) 
res<-dati %>% 
  group_by(materiale,ceppo, antibiotico) %>% 
  filter(ris=='R') %>% 
  summarise("r"=n())  
z<-totx %>% full_join(res)%>% 
  replace_na(list(r=0)) %>% 
  mutate("%resistenti"=(r/n)*100) 

#output$plotRes<-renderPlot(
  
  
  z%>% 
    filter(ceppo=='Escherichia coli', materiale=="LATTE") %>% 
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
  
