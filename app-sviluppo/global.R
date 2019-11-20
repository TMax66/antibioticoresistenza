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
dati<-dati %>% 
  filter(codall!="000IX000" & specie %in% c("BOVINO", "BOVINO - VITELLO"))

dati$specie<-
  plyr::revalue(dati$specie, c("BOVINO - VITELLO"="BOVINO"))

options(knitr.kable.NA = '')


# dati$antibiotico<-
#   plyr::revalue(dati$antibiotico, 
#           c("Lincomicina"="Clindamicina", "Pirlimicina"="Clindamicina", 
#           "Enrofloxacin"="Danofloxacin", "Marbofloxacin"="Danofloxacin",
#           "Flumequina"="Acido Nalidixico", "Amoxicillina"="Ampicillina", 
#           "Apramicina"="Gentamicina","Cefalexina"="Cefalotina", "Cefoperazone"="Ceftiofur",
#           "Cefquinome"="Ceftiofur", "Cloxacillina"="Oxacillina",  "Penetamato Iodidrato" = "Penicillina G",
#           "Penicillina"="Penicillina G", "Spiramicina"="Tilmicosina", "Streptomicina"="Kanamicina", 
#           "Sulfadimetossina"="Sulfisoxazolo", "Tilosina"="Tilmicosina", "Tiamfenicolo"="Cloramfenicolo",
#           "Nafcillina"="Oxacillina", "Rifaximina"="Rifampicina", "Clortetraciclina"="Tetraciclina",
#           "Ossitetraciclina"="Tetraciclina", "Florfenicolo"="Cloramfenicolo", "Tulatromicina"="Eritromicina",
#           "Sulfadiazina"="Sulfisoxazolo", "Cefpodoxime"="Ceftiofur"))



