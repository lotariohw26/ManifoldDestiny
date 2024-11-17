#if (grepl("wasm", sessionInfo()[[2]])) {
#  # If the session info contains "wasm", install the package from the specified repository
#  webr::install("WASMP", repos = "https://joernih.github.io/WASMA/")
#  library("WASMP")
#} else {
#  # If the session info does not contain "wasm", load the package from the local library
#  library("WASMP")
#}
library(ManifoldDestiny)
library(plotly)
library(shiny)
library(dplyr)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
# Shiny
ui <- fluidPage(
  titlePanel("Election simulator for the rigging of a natural election"),
  sidebarLayout(
    sidebarPanel(
      h4("Simulation settings:"),
      textInput("npr",  "Numer of precinct", value='30, 50, 3'),
      textInput("par",  "Prob of assigning to R:", value='0.51, 0.01'),
      textInput("prv", "Prob of R voting:", value='0.7, 0.01'),
      textInput("prm", "Prob of voting by mail if voting by R:", value='0.4, 0.01'),
      textInput("pdv", "Prob of D voting:", value='0.5, 0.01'),
      textInput("pdm", "Prob of voting by mail if voting by D:", value='0.6, 0.01'),
      selectInput("form", "Rigged:",
                  choices = c("Normal Form" = "N",
                              "Hybrid Form" = "H",
                              "Opposition Form" = "O"), selected = "2"),
      selectizeInput("prevar","Predermined variables",choices=c("alpha","x","y","zeta","omega"),multiple =TRUE,options=list(maxItems=3),
      selected = c("alpha", "x", "y")),
      selectizeInput("endvar","Endogenous variables",choices=c("alpha","x","y","zeta","lamda"),multiple =TRUE,options=list(maxItems=2), selected=c("zeta","lamda")),
      textInput("pn", "Polynomial", value='0.23'),
      selectInput("linear", "Polynomial:",
                  choices = c("Linear" = "1",
                              "Quadratic" = "2",
                              "Cubic" = "3",
                              "Quartic" = "4"), selected = "1"),
      textInput("wn", "White noise", value='0.0, 0.0'),
      textInput("kvec", "parameters", value='0,0.5,0.5'),
      selectInput("loss", "Loss function:",
      choices = c("(alpha-alpha_s)^2" = "1","Def" = "2"), selected = "1"),
    #sidebarPanel(
    #  selectInput("cidr", "Complex rotator", choices = c("No", "Yes")),
    #  conditionalPanel(
    #    condition = "input.cidr == 'Yes'",
    #    selectInput("auto2", "Manual", choices = c("Yes", "No")),
    #    h4("Settings (Euler)"),
    #    selectizeInput("rotation", "Euler-rotation order (optional)", choices = c(1, 2, 3, 4, 5, 6), multiple = TRUE,options = list(maxItems = 3)),
    #    sliderInput("theta", "Theta:", min = 0, max = 360, value = 0),
    #    sliderInput("phi", "Phi:", min = 0, max = 360, value = 0),
    #    sliderInput("rho", "Rho:", min = 0, max = 360, value = 0),
    #  ),
    #),
    sidebarPanel(
      selectInput("auto", "Manual", choices = c("Yes", "No")),
      conditionalPanel(
        condition = "input.auto == 'No'",
        textInput("ABC","T", value='0.0, 0.0'),
        selectizeInput("lossalog","Loss algorithm",choices=c("alpha","x","y","zeta","lamda"),multiple =FALSE,options=list(maxItems=1))
      )
    ),
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Sorted",
		 plotOutput("plotq_n"),
		 plotOutput("plotq_r")
		 ),
        tabPanel("3d",
                 plotlyOutput(outputId="plot3d_n"),
                 plotlyOutput(outputId="plot3d_r")
		 ),
        tabPanel("Plot",
		 plotOutput("plotxy_n"),
		 plotOutput("plotxy_r")
		 ),
        tabPanel("Desc",
		verbatimTextOutput("table_dsc_n"),
		verbatimTextOutput("table_dsc_r")
		 )
      )
    )
  )
)
server <- function(input, output, session) {
  observeEvent(input$form, {
      # Update the default value of the "Polynomial Equation(s)" text input
      if (input$form == "1") {
          updateTextInput(session, "wn", value ="0,0")
      } else if (input$form == "2") {
          updateTextInput(session, "wn", value ="0,0001")
      } else if (input$form == "3") {
          updateTextInput(session, "wnf", value ="0,0002")
      }
  })    # Create a reactive expression for the result
  reativ <- reactive({
    # Input values
    #inpr <- c(30,50,3)
    # <- c(m=0.51,s=0.10)
    # <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
    # <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
    ## Normal election parameter values
    inpr <- as.numeric(strsplit(input$npr, ',')[[1]]) 
    ipar <- as.numeric(strsplit(input$par, ',')[[1]])
    iprv <-  c(as.numeric(trimws(strsplit(input$prv, ",")[[1]])),as.numeric(trimws(strsplit(input$prm, ",")[[1]])))[c(1,3,2,4)]
    ipdv <-  c(as.numeric(trimws(strsplit(input$pdv, ",")[[1]])),as.numeric(trimws(strsplit(input$pdm, ",")[[1]])))[c(1,3,2,4)]
    perv <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,inpr[2],inpr[3])))})(inpr[1])
    ztec <- c(0,1)	
    gsh  <- ballcastsim(perv,ipar,iprv,ipdv,ztec)
    #### Fair election counting
    fec <- Countinggraphs(gsh)
    fec$sortpre()
    fec$plotxy()
    fec$plot2d()
    #### Rigged election parameter values
    ifrm <- input$form
    ipre <- unlist(strsplit(trimws(input$prevar), '\\s+'))
    iend <- unlist(strsplit(trimws(input$endvar), '\\s+'))
    ipln <- as.numeric(input$linear)
    inpn <- as.numeric(input$pn)
    ikvc <- as.numeric(strsplit(input$kvec, ',')[[1]])
    iwtn <- as.numeric(strsplit(input$wn, ',')[[1]])
    loss <- input$loss
    rig <- Countinggraphs(fec$rdfc)
    rss <- list(frm=1,
           pre=c('alpha','x','y'),
           end=c('zeta','Omega','lamda'),
           eq='alpha=k0+k1*x+k2*y',
           va='y',
	   rot=list(fr=c(1,0),sr=c(4,0),tr=c(2,0)))
    rig$mansys(sygen=rss)
    rig$setres(inpn,1) #rig$setres(inpn,1)
    rig$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=iwtn,man=T)
    rec <- Countinggraphs(rig$rdfc)
    rec$sortpre()
    rec$plotxy()
    rec$plot2d()
    list(fec,rig,rec)
  })  
  # Plot 
  output$plotq_n <- renderPlot({
    #dft <- reativ()
    #gmn <- dft[[1]]$pl_2dsort[[1]]
    #cowplot::plot_grid(gmn, labels = "Fair election")
  })
  output$plotq_r <- renderPlot({
    #dft <- reativ()
    #gmr <- dft[[3]]$pl_2dsort[[1]]
    #cowplot::plot_grid(gmr, labels = "Rigged election")
  })
  output$table_dsc_n <- renderPrint({
    #sugs <- c("alpha=k0+k1*x+k2*y","alpha=k0+k1*x+k2*y+k3*zeta")
    #nel <- Estimation(reativ()[[1]]$rdfc,1)
    #nel$regression(sugs[1])
    #n1 <- summary(nel$regsum[[1]])
    #nel$regression(sugs[2])
    #n2 <- summary(nel$regsum[[1]])
    #list(n1,n2)
  })
  output$table_dsc_r <- renderPrint({
    #sugs <- c("alpha=k0+k1*x+k2*y","alpha=k0+k1*x+k2*y+k3*zeta")
    #ner <- Estimation(reativ()[[2]]$rdfc,1)
    #ner$regression(sugs[1])
    #r1 <- summary(ner$regsum[[1]])
    #ner$regression(sugs[2])
    #r2 <- summary(ner$regsum[[1]])
    #list(r1,r2)
  })
  output$plot3d_n <- renderPlotly({
    #gdf <- reativ()[[1]]$rdfc %>% dplyr::select(c('alpha','x','y'))
    #mrdfc <- as.matrix(gdf)
    #z <- mrdfc[,1]
    #x <- mrdfc[,2]
    #y <- mrdfc[,3]
    #p1 <- plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers", marker=list(size=3))
    #plotly::layout(p1,title = "Fair election")
  })
  output$plot3d_r <- renderPlotly({
    #gdf <- reativ()[[3]]$rdfc %>% dplyr::select(c('alpha','x','y'))
    #mrdfc <- as.matrix(gdf)
    #z <- mrdfc[,1]
    #x <- mrdfc[,2]
    #y <- mrdfc[,3]
    #p2 <- plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers",marker = list(size = 3))
    #plotly::layout(p2,title = "Rigged election")
  })
  output$plotxy_n <- renderPlot({
    #dft <- reativ()
    #gm1 <- dft[[1]]$pl_corrxy[[1]]
    #gm3 <- dft[[1]]$pl_corrxy[[2]]
    #cowplot::plot_grid(gm1, gm3, ncol = 2, labels = c("Column 1", "Column 2"))
  })
  output$plotxy_r <- renderPlot({
    #dft <- reativ()
    #gm2 <- dft[[3]]$pl_corrxy[[1]]
    #gm4 <- dft[[3]]$pl_corrxy[[2]]
    #cowplot::plot_grid(gm2, gm4, ncol = 2, labels = c("Column 1", "Column 2"))
  })
  #output$downloadData <- downloadHandler(
  #  filename = function() {
  #    paste("data-", Sys.Date(), ".csv", sep="")
  #  },
  #  content = function(file) {
  #    write.csv(data, file)
  #})
}
shinyApp(ui = ui, server = server)


