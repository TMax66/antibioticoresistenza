#############INTERFACCIA GRAFICA###################################################
ui<-navbarPage("Antibiotico-resistenze -Bergamo",
       tabPanel("Profili di resistenza",
                fluidPage(
                  useShinyalert(),
                  sidebarPanel(
                    selectInput("sp2", "specie",
                                c(unique(as.character(dati$specie)))),
                    selectInput("mt2", "materiale",
                                c(unique(as.character(dati$materiale)))),
                    selectInput("cp2", "ceppo",
                                c(unique(as.character(dati$ceppo)))),
                    textInput("codaz", "Codice allevamento")
                 
                  ),
                  mainPanel(
                    
                    plotOutput('plotprof')
                  )

                )
                ),
       tabPanel("Molecole",
                fluidPage(
                  sidebarPanel(
                    selectInput("mo3", "Molecola",
                                c(unique(as.character(dati$antibiotico)))),
                    selectInput("sp3", "Specie",
                                c(unique(as.character(dati$specie)))),
                    selectInput("mt3", "materiale",
                                c(unique(as.character(dati$materiale)))),
                    textInput("codaz", "Codice allevamento")
                    
                  ),
                  mainPanel(
                    plotOutput('plotceppi')
                  )
                  
                )

                ),
       
  tabPanel("Trend",
           fluidPage(
             sidebarPanel(
               selectInput("sp", "specie",
                           c(unique(as.character(dati$specie)))),
               selectInput("mt", "materiale",
                           c(unique(as.character(dati$materiale)))),
               selectInput("cp", "ceppo",
                           c(unique(as.character(dati$ceppo)))),
               selectInput("mo", "molecola",
                           c(unique(as.character(dati$antibiotico))))
             ),
             br(),
             br(),
             mainPanel(
               dygraphOutput('dygraph')
             )
           ))
       
       
       
)






