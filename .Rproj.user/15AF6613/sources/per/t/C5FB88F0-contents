#######################FUNZIONI DI R#############################################

server<-function(input, output){
  
#####grafico trend#########  
  resistenze<-reactive({     
  
  totx<-dati %>% 
    group_by(anno, specie,materiale, ceppo, antibiotico) %>% 
    summarise("n"=n()) 
  res<-dati %>% 
    group_by(anno, specie,materiale,ceppo, antibiotico) %>% 
    filter(ris=='R') %>% 
    summarise("r"=n())  
  z<-totx %>% full_join(res)%>% 
    replace_na(list(r=0)) %>% 
    mutate("%resistenti"=(r/n)*100) %>% 
    filter(specie==input$sp, ceppo==input$cp, 
           materiale==input$mt,antibiotico==input$mo) 
  })
  
  output$dygraph <- renderDygraph({
    graph<- xts(resistenze()$`%resistenti`, order.by = as.Date(resistenze()$anno))
    dygraph(graph,ylab = "%resistenza") %>% 
      dyAxis("y", label = "% ceppi resistenti",valueRange = c(0, 110)) %>% 
      dySeries("V1", label = "% ceppi resistenti") %>% 
      dyOptions(drawPoints = TRUE, pointSize = 2) 
  })
    
 ####grafico profilo####
    profili<-reactive({

    totx<-dati %>% 
      group_by(specie,materiale, ceppo, antibiotico) %>% 
      summarise("n"=n()) 
    res<-dati %>% 
      group_by(specie,materiale,ceppo, antibiotico) %>% 
      filter(ris=='R') %>% 
      summarise("r"=n())  
    z<-totx %>% full_join(res)%>% 
      replace_na(list(r=0)) %>% 
      mutate("% ceppi resistenti"=(r/n)*100) %>% 
      filter(ceppo==input$cp2, materiale==input$mt2, specie==input$sp2)
    
    
    })
    
    output$plotprof<-renderPlot(
   profili()%>% 
      arrange(`% ceppi resistenti`) %>% 
      mutate(`% ceppi resistenti`= round(`% ceppi resistenti`,1)) %>% 
      mutate(antibiotico = factor(antibiotico, unique(antibiotico))) %>% 
      ggplot(aes(x=antibiotico,y=`% ceppi resistenti`,label=`% ceppi resistenti`))+
      geom_point(stat='identity',col="lightblue", size=8)+
      geom_text(color="black", size=3)+
      geom_segment(aes(x=antibiotico, 
                       xend=antibiotico, 
                       # y=min(`%resistenti`),
                       y=0,
                       yend=`% ceppi resistenti`-2 
                       # linetype="dashed", 
                       #
      ))+
      labs(title=input$cp2,caption=Sys.Date()) +  
      coord_flip()
    
    )


    generi<-reactive({
      
      totx<-dati %>% 
        group_by(specie,materiale, ceppo, antibiotico) %>% 
        summarise("n"=n()) 
      res<-dati %>% 
        group_by(specie,materiale,ceppo, antibiotico) %>% 
        filter(ris=='R') %>% 
        summarise("r"=n())  
      z<-totx %>% full_join(res)%>% 
        replace_na(list(r=0)) %>% 
        mutate("% ceppi resistenti"=(r/n)*100) %>% 
        filter(materiale==input$mt3, specie==input$sp3, antibiotico==input$mo3)
    })
    
    output$plotceppi<-renderPlot(
    generi()%>% 
        arrange(`% ceppi resistenti`) %>% 
        mutate(`% ceppi resistenti`= round(`% ceppi resistenti`,1)) %>% 
        ungroup() %>% 
        mutate(ceppo= factor(ceppo, unique(ceppo))) %>% 
        ggplot(aes(x=ceppo,y=`% ceppi resistenti`,label=`% ceppi resistenti`))+
        geom_point(stat='identity',col="lightblue", size=8)+
        geom_text(color="black", size=3)+
        geom_segment(aes(x=ceppo, 
                         xend=ceppo, 
                         # y=min(`%resistenti`),
                         y=0,
                         yend=`% ceppi resistenti`-2 
                         # linetype="dashed", 
                         #
        ))+
        labs(title=input$mo3,caption=Sys.Date()) +  
        coord_flip()
      
    )
    
  }
