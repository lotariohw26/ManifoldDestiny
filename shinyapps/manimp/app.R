options(scipen=999)
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
      textInput("prec",  "Numer of precinct", value='30, 50, 3'),
      textInput("probw",  "Prob of assigning to R:", value='0.51, 0.01'),
      textInput("prob_rv", "Prob of R voting:", value='0.7, 0.01'),
      textInput("prob_rm", "Prob of voting by mail if voting by R:", value='0.4, 0.01'),
      textInput("prob_dv", "Prob of D voting:", value='0.5, 0.01'),
      textInput("prob_dm", "Prob of voting by mail if voting by D:", value='0.6, 0.01'),
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
      textInput("kvec", "parameters", value='0,0.5,0.5'),
      selectInput("loss", "Loss function:",
                  choices = c("Abc" = "1",
                              "Def" = "2"), selected = "1"),
      selectizeInput("rotation", "Euler-rotation order (optional)", choices = c(1, 2, 3, 4, 5, 6), multiple = TRUE,options = list(maxItems = 3))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Quantile",
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
server <- function(input, output) {
  # Create a reactive expression for the result
  result <- reactive({
    # Input values
    prn <- as.numeric(strsplit(input$prec, ',')[[1]])
    pwn <- as.numeric(strsplit(input$probw, ',')[[1]])
    prcr <-  c(as.numeric(trimws(strsplit(input$prob_rv, ",")[[1]])),as.numeric(trimws(strsplit(input$prob_rm, ",")[[1]])))[c(1,3,2,4)]
    prcd <-  c(as.numeric(trimws(strsplit(input$prob_rv, ",")[[1]])),as.numeric(trimws(strsplit(input$prob_dm, ",")[[1]])))[c(1,3,2,4)]
    #prcr <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10) #c(input$prob_rv,input$prob_rm)
    #prcd <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10) #c(input$prob_dv,input$prob_dm)
    frm <- as.numeric(input$form)
    whn <- as.numeric(strsplit(input$wn, ',')[[1]])
    kvc <- as.numeric(strsplit(input$kvec, ',')[[1]])
    endv <- unlist(strsplit(trimws(input$endvar), '\\s+'))
    parv <- unlist(strsplit(trimws(input$prevar), '\\s+'))
    #### Simulation of ballot voting
    dfm <- (function(x){data.frame(P = seq(1, x), RV = as.integer(pmax(rnorm(x, prn[2], prn[3]), 0)))})(prn[1])
    app_bal <- ballcastsim(dfm,pwn,prcr,prcd,ztech=c(0,0))
    #### Fair election
    app_n_cou <- Countinggraphs(app_bal)
    app_n_cou$sortpre()
    app_n_cou$plotxy()
    app_n_cou$plot2d()
    ### Rigging an election
    app_exr_cou <- Countinggraphs(app_bal)
    #app_exr_cou$sortpre()
    #app_exr_cou$mansys(sygen=list(frm=1,pre=c("alpha","x","y"),end=c("zeta","lamda"),me=c(plnr=1,rot=0)))
    app_exr_cou$mansys(sygen=list(frm=1,
    			      pre=c("alpha","x","y"),
    			      end=c("zeta","lamda"),
    			      me=c(plnr=1,rot=0),
    			      lf="(alpha-alpha_s)^2"))
    app_exr_cou$setres(0.14,1)
    app_exr_cou$manimp(init_par=c(k0=0.0,k1=0.50,k2=0.50),man=true,wn=c(0,0.0),1)
    app_exm_cou <- Countinggraphs(app_exr_cou$rdfc)
    app_exm_cou$sortpre()
    app_exm_cou$plotxy()
    app_exm_cou$plot2d()
    #browser()
    #list(app_n_cou,app_n_cou)
    list(app_n_cou,app_exm_cou)
  })  
  output$table_dsc_n <- renderPrint({
#	  browser()
    #sugsol <- c("k0+k1*x+k2*y","k0+k1*x+k2*y+k3*zeta")
    #nel <- Estimation(result()[[1]]$rdfc,1)
    #nel$regression(sugsol[1])
    #n1 <- summary(nel$regsum[[1]])
    #nel$regression(sugsol[2])
    #n2 <- summary(nel$regsum[[1]])
    #list(n1,n1)
    #list(n1,n2)
    list('abc','def')
  })
  output$table_dsc_r <- renderPrint({
    #sugsol <- c("alpha=k0+k1*x+k2*y","alpha=k0+k1*x+k2*y+k3*zeta")
    #ner <- Estimation(result()[[2]]$rdfc,1)
    #ner$regression(sugsol[1])
    #r1 <- summary(ner$regsum[[1]])
    #ner$regression(sugsol[2])
    #r2 <- summary(ner$regsum[[1]])
    #list(r1,r2)
    list('ghi','jkl')
  })
  # Plot 
  output$plotq_n <- renderPlot({
    dft <- result()
    gm1 <- dft[[1]]$pl_2dsort[[1]]
    cowplot::plot_grid(gm1, labels = "Fair election")
  })
  output$plotq_r <- renderPlot({
    dft <- result()
    gm1 <- dft[[1]]$pl_2dsort[[1]]
    gm2 <- dft[[2]]$pl_2dsort[[1]]
    cowplot::plot_grid(gm2, labels = "Rigged election")
  })
  output$plotxy_n <- renderPlot({
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




