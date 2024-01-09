######################################################################################
#webr::install("ManifoldDestinyWASMP", repos = "https://lotariohw26.github.io/MD_WASMC")
#ManifoldDestinyWASMP::wasmconload()
ManifoldDestiny::wasmconload()
######################################################################################
ui <- fluidPage(
  titlePanel("Election simulator for the rigging of a natural election"),
  sidebarLayout(
    sidebarPanel(
      h4("Simulation settings:"),
      textInput("probw",  "Prob of assigning to R:", value='0.51, 0.10'),
      textInput("prob_rv", "Prob of R voting:", value='0.7, 0.10'),
      textInput("prob_rm", "Prob of voting by mail if voting by R:", value='0.4, 0.10'),
      textInput("prob_dv", "Prob of D voting:", value='0.5, 0.10'),
      textInput("prob_dm", "Prob of voting by mail if voting by D:", value='0.6, 0.10'),
      selectInput("form", "Rigged:",
                  choices = c("Normal Form" = "1",
                              "Hybrid Form" = "2",
                              "Opposition Form" = "3"), selected = "1"),
      selectizeInput("prevar","Predermined variables",choices=c("alpha","x","y","zeta","omega"),multiple =TRUE,options=list(maxItems=3),
      selected = c("alpha", "x", "y")),
      selectizeInput("endvar","Predermined variables",choices=c("alpha","x","y","zeta","lamda"),multiple =TRUE,options=list(maxItems=2), selected=c("zeta","lamda")),
      textInput("pn", "Polynomial", value='0.23'),
      selectInput("linear", "Polynomial:",
                  choices = c("Linear" = "1",
                              "Quadratic" = "2",
                              "Cubic" = "3",
                              "Quartic" = "4"), selected = "1"),
      textInput("wn", "White noise", value='0.0, 0.0'),
      textInput("kvec", "parameters", value='0,0.5,0.5')
      #selectInput("loss", "Loss function:",
      #            choices = c("Abc" = "1",
      #                        "Def" = "2"), selected = "1"),
      #selectizeInput("rotation", "Euler-rotation order (optional)", choices = c(1, 2, 3, 4, 5, 6), multiple = TRUE,options = list(maxItems = 3))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Normal election",
		 plotOutput("plotq_n"),
		 plotOutput("plotxy_n"),
		 plotlyOutput("plot3d_n")
		 ),
        tabPanel("Rigged election",
		 plotOutput("plotq_r"),
		 plotOutput("plotxy_r"),
		 plotlyOutput("plot3d_r")
		 )
        #tabPanel(#verbatimTextOutput(outputId = "table_dsc1")
        #tabPanel(#verbatimTextOutput(outputId = "table_dsc2")
      )
    )
  )
)
server <- function(input, output) {
  # Create a reactive expression for the result
  result <- reactive({
    #

    #
    pwn  <- input$probw 
    parv <- input$prob_rv 
    padv <- input$prob_rm 
    parv <- input$prob_dv 
    padv <- input$prob_dm 
    #
    form <- input$form
    form <- input$endvar
    form <- input$prevar
    form <- input$pn
    form <- input$linear
    form <- input$wn
    kvec <- input$kvec
    #kvec <- input$loss
    #kvec <- input$rotation
    #### Interactive
    isys <- list(frm=frm,pre=pres,end=ends,me=c(plnr=linp,rots=0))
    #### Interactive
    #### Simulation of ballot voting
    dfm <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,1000,30)))})(10)
    app_bal <- ballcastsim(dfm,pwn,parv,padv,ztech)
    ### Fair election
    app_n_cou <- Countinggraphs(app_bal)
    app_n_cou$sortpre()
    app_n_cou$plotxy()
    app_n_cou$plot2d()
    ### Rigging an election
    app_exr_cou <- Countinggraphs(app_bal)
    app_exr_cou$sortpre()
    #app_exr_cou$mansys(sygen=isys)
    app_exr_cou$mansys(sygen=list(frm=1,pre=c("alpha","x","y"),end=c("zeta","lamda"),me=c(plnr=1,rot=0)))
    #app_exr_cou$setres(pnc)
    app_exr_cou$setres(0.23,0)
    #app_exr_cou$manimp(init_par=kvec,man=TRUE,wn=c(wn[1],wn[2]))
    app_exr_cou$manimp(init_par=c(k0=0.0,k1=0.5,k2=0.5),TRUE,wn=c(0,0))
    app_exm_cou <- Countinggraphs(app_exr_cou$rdfc)
    app_exm_cou$sortpre()
    app_exm_cou$plotxy()
    app_exm_cou$plot2d()
    list(app_n_cou,app_exm_cou)
  })  
  output$table_dsc1 <- renderText({
    #browser()
    #sugsol <- c(alpha='k0+k1*x+k2*y',alpha='k0+k1*x+k2*y+k3*zeta')
    #result()[[1]]$rdfc
    #nel <- Estimation(result()[[1]]$rdfc,1)
    #nel$regression(sugsol[1])
    #nel$regsum[[1]]
    #n1 <- summary(nel$regsum[[1]])
    #nel$regression(sugsol[2])
    #n2 <- summary(nel$regsum[[1]])
    ##list(n1,n2)
  })
  output$table_dsc2 <- renderPrint({
    #sugsol <- c(alpha='k0+k1*x+k2*y',alpha='k0+k1*x+k2*y+k3*zeta')
    #ner <- Estimation(result()[[2]]$rdfc,1)
    #ner$regression(sugsol[1])
    #r1 <- summary(ner$regsum[[1]])
    #ner$regression(sugsol[2])
    #r2 <- summary(ner$regsum[[1]])
    #list(r1,r2)
  })
  # Plot 
  output$plotq_n <- renderPlot({
    browser()
    dft <- result()
    gm1 <- dft[[1]]$pl_2dsort[[1]]
    cowplot::plot_grid(gm1, labels = "Fair election")
    #gm2 <- dft[[2]]$pl_2dsort[[1]]
    #cowplot::plot_grid(cowplot::plot_grid(gm1, labels = "Fair election"), cowplot::plot_grid(gm2, labels = "Rigged election"), ncol = 2, align = 'hv')
  })
  output$plotq_r <- renderPlot({
    dft <- result()
    #gm1 <- dft[[1]]$pl_2dsort[[1]]
    gm2 <- dft[[2]]$pl_2dsort[[1]]
    cowplot::plot_grid(gm2, labels = "Fair election")
    #cowplot::plot_grid(cowplot::plot_grid(gm1, labels = "Fair election"), cowplot::plot_grid(gm2, labels = "Rigged election"), ncol = 2, align = 'hv')
  })
  output$plotxy_n <- renderPlot({
     #browser()
     dft <- result()
     gm1 <- dft[[1]]$pl_corrxy[[1]]
     gm3 <- dft[[1]]$pl_corrxy[[1]]
     cowplot::plot_grid(gm1, gm3, ncol = 2, labels = c("Column 1", "Column 2"))
  })
  output$plotxy_r <- renderPlot({
     dft <- result()
     gm2 <- dft[[2]]$pl_corrxy[[1]]
     gm4 <- dft[[2]]$pl_corrxy[[1]]
     cowplot::plot_grid(gm2, gm4, ncol = 2, labels = c("Column 1", "Column 2"))
  })
  output$plot3d_n <- renderPlotly({
     gdf <- result()[[1]]$rdfc %>% dplyr::select(c('alpha','x','y'))
     mrdfc <- as.matrix(gdf)
     z <- mrdfc[,1]
     x <- mrdfc[,2]
     y <- mrdfc[,3]
     p1 <- plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers", marker=list(size=3))
     plotly::layout(p1,title = "Fair election")
  })
  output$plot3d_r <- renderPlotly({
     gdf <- result()[[2]]$rdfc %>% dplyr::select(c('alpha','x','y'))
     mrdfc <- as.matrix(gdf)
     z <- mrdfc[,1]
     x <- mrdfc[,2]
     y <- mrdfc[,3]
     p2 <- plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers",marker = list(size = 3))
     plotly::layout(p2,title = "Rigged election")
  })
}
shinyApp(ui = ui, server = server)
#options(scipen=999)
#set.seed(1)



