options(digits=2)

ManifoldDestiny::wasmconload()
abc <- data(package = "ManifoldDestiny")[[3]][,3]
abr <- abc[grepl("app", abc)][3]
# [1] "app0"        "app0nr"      "app1"        "app2"        "app3"        "app4"        "concl_appps"
apps <- get(abr)
###############################################################################################################################################################
ui <- fluidPage(
  titlePanel("Election results analyzer"),
  sidebarLayout(
    sidebarPanel(
      #selectInput(inputId = "app_select", label = "Select election data from the set of applications",
      #        choices = apps,
      #        selected = "app0"),
      #textInput("purge", "Purge criteria:",value="0;0;0"),
      #selectInput("form", "Type of rigg:",
      #            choices = c("Normal Form" = "1",
      #                        "Hybrid Form" = "2",
      #                        "Opposition Form" = "3"), selected = "2"),
      #textInput("meqf", "Manifold equation:",
      #          value = "alpha=k0+k1*g+k2*h"),
      #textInput("solvf", "Solve for:",
      #          value = "g"),
      #br(),
      ##h4("Rotation Settings (Euler)"),
      ##selectizeInput("rotation", "Euler-rotation order (optional)", choices = c(1, 2, 3, 4, 5, 6), multiple = TRUE,options = list(maxItems = 3)),
      ##sliderInput("theta", "Theta:", min = 0, max = 360, value = 0),
      ##sliderInput("phi", "Phi:", min = 0, max = 360, value = 0),
      ##sliderInput("rho", "Rho:", min = 0, max = 360, value = 0),
      h4("Suggested solution:"),
      textOutput("sidebarText")  # Output element for dynamic text
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Descriptive", verbatimTextOutput(outputId = "table_dsc")),
        tabPanel("2D Plots", plotOutput(outputId = "plot_xy")),
        tabPanel("Quantile Plot", plotOutput(outputId = "plot_q")),
        tabPanel("3D plots", htmlOutput(outputId = "plot_3ds")),
        tabPanel("Regressions", verbatimTextOutput(outputId = "print_sum")),
        tabPanel("Residuals", plotOutput(outputId = "plot_res")),
        tabPanel("Comparison", verbatimTextOutput(outputId = "print_com")),
        #tabPanel("3D rotation", plotlyOutput(outputId = "plot_3d_rot")),
        tabPanel("Metadata", verbatimTextOutput(outputId = "meta_dsc"))
      )
    )
  )
)
server <- function(input, output, session) {
  observeEvent(input$form, {
     #Update the default value of the "Polynomial Equation(s)" text input
    if (input$form == "1") {
      updateTextInput(session, "meqf", value = "alpha=k0+k1*x+k2*y")
      updateTextInput(session, "solvf", value = "y")
    } else if (input$form == "2") {
      updateTextInput(session, "meqf", value = "alpha=k0+k1*g+k2*h")
      updateTextInput(session, "solvf", value = "g")
    } else if (input$form == "3") {
      updateTextInput(session, "meqf", value = "alpha=k0+k1*m+k2*n")
      updateTextInput(session, "solvf", value = "m")
    }
  })  
  cformo <- reactive({
    # Manual
    #isla <- input$app_select
    seld <- apps
    seld[[1]]
    seld[[2]]
    #mds <- md[[sna]]
    ##### Purge
    #mds$mtd$prg$cnd <- c(0)
    #mds$mtd$prg$stuv <- c(0,0,0,0)
    #mds$mtd$prg$blup[1] <- 0
    #mds$mtd$prg$blup[2] <- 1
    ##### Solution
    #mds$sgs$fr <- as.numeric(input$form)
    #mds$sgs$eq <- as.numeric(input$meqf)
    #mds$sgs$va <- as.numeric(input$solvf)
    ##### Rotation
    #mds$mtd$sgs$ro[1] <- input$theta*pi/180
    #mds$mtd$sgs$ro[2] <- input$phi*pi/180
    #mds$mtd$sgs$ro[3] <- input$rho*pi/180
    #### Selreport
    selr <- selreport(seld)
    #selr[[2]]$comdesc
    #selr[[1]]$pl_3d_mani[[1]]
    #selr[[1]]$all_pl_3d_mani[[1]]
    return(selreport(seld))
  })
  observe(print(cformo()[[1]]$desms))
  output$table_dsc <- renderPrint({
    print(cformo()[[1]]$desms)
  })
  output$plot_q <- renderPlot({
    cformo()[[1]]$pl_2dsort[[1]]
  })
  output$plot_xy <- renderPlot({
    cowplot::plot_grid(plotlist=cformo()[[1]]$pl_corrxy[c(1,2)],ncol=2)
  })
  output$plot_3ds <- renderUI({
    cformo()[[1]]$all_pl_3d_mani[[1]]
  })
  output$print_sum <- renderPrint({
    list(summary(cformo()[[3]]$regsum[[1]]),
	 summary(cformo()[[2]]$regsum[[1]]))
  })
  output$plot_res <- renderPlot({
    pla <- cformo()[[2]]$resplots[[1]][[c(1)]]
    #plb <- cformo()[[2]]$resplots[[2]][[c(1)]]
    #plc <- cformo()[[2]]$resplots[[3]][[c(1)]]
    cowplot::plot_grid(plotlist=list(pla,pla,pla),ncol=1)
  })
  output$print_com <- renderPrint({
    cformo()[[2]]$comdesc
  })
  output$sidebarText <- renderPrint({
    #paste0(cformo()[[6]]$mtd$sgs$eq)
  })
  output$plot_3d_rot <- renderPlotly({
    cformo()[[1]]$rotplotly[[1]]
  })
  output$meta_dsc <- renderPrint({
    cformo()[[4]]
  })
}
shinyApp(ui = ui, server = server)






