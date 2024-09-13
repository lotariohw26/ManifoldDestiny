ManifoldDestiny::wasmconload()
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
abc <- data(package = "ManifoldDestiny")[[3]][,3]
abr <- abc[grepl("app", abc)]
apps <- get(abr[1])
options(digits=2)
###############################################################################################################################################################
ui <- fluidPage(
  titlePanel("Election results analyzer"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "app_select", label = "Select election data from the set of applications",
                  choices = abr,
                  selected = "app0"),
      textInput("purge", "Purge criteria (Z, STUV, P):", value = "0;0 0 0 0;0"),
      selectInput("form", "Type of rig:",
                  choices = c("Normal Form" = "1",
                              "Hybrid Form" = "2",
                              "Opposition Form" = "3"), selected = "2"),
      textInput("meqf", "Manifold equation:",
                value = "alpha=k0+k1*g+k2*h"),
      textInput("solvf", "Solve for:",
                value = "g"),
      br(),
      selectInput("auto", "Euler-rotation", choices = c("No", "Yes")),
      
      # Conditional panel for Euler-rotation settings
      conditionalPanel(
        condition = "input.auto === 'Yes'",
        h4("Rotation Settings (Euler)"),
        selectizeInput("rotation", "Euler-rotation order (optional)", 
                       choices = c(1, 2, 3, 4, 5, 6), 
                       multiple = TRUE, 
                       options = list(maxItems = 3)),
        sliderInput("theta", "Theta:", min = 0, max = 360, value = 0),
        sliderInput("phi", "Phi:", min = 0, max = 360, value = 0),
        sliderInput("rho", "Rho:", min = 0, max = 360, value = 0)
      ),
      
      textOutput("sidebarText"),  # Output element for dynamic text
      h4("Suggested solution:")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Descriptive", verbatimTextOutput(outputId = "table_dsc")),
        tabPanel("Purged", verbatimTextOutput(outputId = "table_pur")),
        tabPanel("2D Plots", plotOutput(outputId = "plot_xy")),
        tabPanel("Quantile Plot", plotOutput(outputId = "plot_q")),
        tabPanel("3D plots", htmlOutput(outputId = "plot_3ds")),
        tabPanel("Regressions", verbatimTextOutput(outputId = "print_sum")),
        tabPanel("Residuals", plotOutput(outputId = "plot_res")),
        tabPanel("Comparison", verbatimTextOutput(outputId = "print_com")),
        tabPanel("3D rotation", plotlyOutput(outputId = "plot_3d_rot")),
        tabPanel("Bowshock", plotOutput(outputId = "plot_bp")),
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
    #seld <- get(apps)
    seld <- get(input$app_select)
    seld[[1]]
    seld[[2]]
    #mds <- md[[sna]]
    ##### Purge
    vecl <- lapply(strsplit(input$purge, ";")[[1]], function(part) as.numeric(strsplit(part, " ")[[1]]))
    seld[[2]]$prg$z <- vecl[[1]]
    seld[[2]]$prg$stuv <- vecl[[2]]
    seld[[2]]$prg$prma <- vecl[[3]]
    ##### Solution
    #browser()
    seld[[2]]$sol$fr <- input$form
    seld[[2]]$sol$eq[[1]] <- input$meqf
    seld[[2]]$sol$va <- input$solvf
    #browser()
    #seld[[2]]$sol$ro[[1]]
    #seld[[2]]$sol$ro[[2]][1] <- input$theta*pi/180
    #seld[[2]]$sol$ro[[2]][2] <- input$phi*pi/180
    #seld[[2]]$sol$ro[[2]][3] <- input$rho*pi/180
    #seld[[2]]$sol$ro[[2]]
    ##### Selreport
    return(selreport(seld))
  })
  observe(print(cformo()[[1]]$desms))
  output$sidebarText <- renderPrint({
    paste0(cformo()[['md']]$sol$eq," \n ",cformo()[['md']]$sol$eq)
  })
  output$table_dsc <- renderPrint({
    print(cformo()[[1]]$desms)
  })
  output$table_pur <- renderPrint({
    print(cformo()[[1]]$purdf)
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
    list(summary(cformo()[[2]]$regsum[[1]]),
	 summary(cformo()[[3]]$regsum[[1]]))
  })
  output$plot_res <- renderPlot({
    l1 <- cformo()[[2]]$resplots[[1]][[1]]
    l2 <- cformo()[[2]]$resplots[[1]][[2]]
    l3 <- cformo()[[2]]$resplots[[1]][[3]]
    l4 <- cformo()[[2]]$resplots[[1]][[4]]
    cowplot::plot_grid(plotlist=list(l1,l2,l3,l4))
  })
  output$print_com <- renderPrint({
    cformo()[[2]]$comdesc
  })
  output$plot_3d_rot <- renderPlotly({
    cformo()[[1]]$rotplotly[[1]]
  })
  output$plot_bp <- renderPlot({
    cformo()[[4]]$pl_2dsort
  })
  output$meta_dsc <- renderPrint({
    cformo()[['md']]
  })
}
shinyApp(ui = ui, server = server)

