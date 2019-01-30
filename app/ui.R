#############INTERFACCIA GRAFICA###################################################
ui<-navbarPage("Antibiotico-resistenze Sez. diagnostica di Bergamo",

               tabPanel("trend temporali ",
                        fluidPage(
                          fluidRow(
                            
                            column(6,div(style="height:50px"),dygraphOutput('dygraph')),
                            
                            column(6,div(style="height:50px"),dygraphOutput('vargraf'))),
                          
                          br(),
                          
                          
                          fluidRow( 
                            
                            column(6,div(style="height:50px", align="center",sliderInput("mesi", "smoothing value", 0,48,1))),
                            
                            column(6,div(style="height:50px",align="center",
                                         selectInput("set", "settore",
                                                     c(unique(as.character(dati$settore))))))),
                          
                          br(),
                          br(),
                          hr()
                          
                          
                          
                        )
               ),
              
           
               tabPanel("Prove", "This panel is intentionally left blank")
)






