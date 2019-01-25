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
dati<-as.tibble(dati)
dati$datareg<-dmy(dati$datareg)
#dati<- mutate(dati, mese=paste(year(datainizio),'-',month(datainizio),sep=''))
#dati$mese<-as.Date((paste(dati$mese,"-01",sep="")))
dati<-mutate(dati,anno=year(datareg))
dati$anno<-as.Date((paste(dati$anno,"-01","-01",sep="")))

dati<-dati %>% 
  mutate(Res=ifelse(ris=="R", 1, 0))



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
    filter(ceppo=='Escherichia coli') %>% 
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
  
#####heatmap####
  
    totx<-dati %>%   
      # dplyr::select(IDceppo,SPECIE,c(12:22)) %>% 
      # gather(antibiotico, esito, 4:13) %>% 
      group_by(specie,ceppo, antibiotico) %>% 
      summarise("n"=n())
    resx<-dati %>% 
      # dplyr::select(IDceppo,SPECIE, c(12:22)) %>% 
      # gather(antibiotico, esito, 4:13) %>% 
      group_by(specie,ceppo, antibiotico) %>% 
      filter(ris=='R') %>% 
      summarise("r"=n())
    
    x<-totx %>% full_join(resx)%>% 
      #factor(identificazione,antibiotico) %>% 
      replace_na(list(r=0)) %>% 
      mutate("%resistenti"=(r/n)*100) %>% 
      #filter(identificazione=="Acinetobacter") %>% 
      as.data.frame() 

  
  

  x %>% 
      filter(specie=="BOVINO") %>% 
      arrange(`%resistenti`) %>% 
      mutate(antibiotico = factor(antibiotico, unique(antibiotico))) %>% 
      ggplot(aes(ceppo,antibiotico)) + 
      geom_tile(aes(fill = `%resistenti`), colour = "white") + 
      scale_fill_gradient(low = "snow2", high = "steelblue")+ theme_grey(base_size = 9) + 
      labs(x = "", y = "", title="profilo di resistenza dei ceppi", caption=Sys.Date()) + 
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) 
  

