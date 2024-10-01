ui <- fluidPage(
  titlePanel("Rigged Election Results Analyzer"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "app_select", 
                  label = "Select an election from the library",
                  choices = abr,
                  selected = "biden_trump_nevada_2020"),
      selectInput("form", "Rigged:",
                  choices = c("Normal Form" = "1",
                              "Hybrid Form" = "2",
                              "Opposition Form" = "3"), 
                  selected = "2"),
      textInput("purge", "Purge criteria:", value = "0;0;0"),
      textInput("meqf", "Manifold object(s):",
                value = "alpha=k0+k1*g+k2*h"),
      textInput("solvf", "Solve for:",
                value = "g"),
      br(),
      h4("Rotation Settings (Euler)"),
      selectizeInput("rotation", "Euler-rotation order (optional)", 
                     choices = c(1, 2, 3, 4, 5, 6), 
                     multiple = TRUE,
                     options = list(maxItems = 3)),
      sliderInput("theta", "Theta:", min = 0, max = 360, value = 0),
      sliderInput("phi", "Phi:", min = 0, max = 360, value = 0),
      sliderInput("rho", "Rho:", min = 0, max = 360, value = 0),
      h4("Suggested solution:"),
      textOutput("sidebarText"),  # Output element for dynamic text
      selectInput("auto", "Manual", choices = c("Yes", "No")),
      conditionalPanel(
        condition = "input.auto == 'No'",
        textInput("ABC", "T", value = '0.0, 0.0'),
        selectizeInput("lossalog", "Loss algorithm", 
                       choices = c("alpha", "x", "y", "zeta", "lambda"), 
                       multiple = FALSE, 
                       options = list(maxItems = 1))
      )
    ),  # Added comma here
    mainPanel(
      tabsetPanel(
        tabPanel("Descriptive", verbatimTextOutput(outputId = "table_dsc")),
        tabPanel("2D Scatter Plots", plotOutput(outputId = "plot_xy")),
        tabPanel("Quantile Plot", plotOutput(outputId = "plot_q")),
        tabPanel("Bow Plot", plotOutput(outputId = "plot_bow")),
        tabPanel("3D Rotation", plotlyOutput(outputId = "plot_3d")),
        tabPanel("3D Scatter Plots", htmlOutput(outputId = "plot_3ds")),
        tabPanel("Regressions", verbatimTextOutput(outputId = "print_sum")),
        tabPanel("Residuals", plotOutput(outputId = "plot_res")),
        tabPanel("Comparison", verbatimTextOutput(outputId = "print_com")),
        tabPanel("Metadata", verbatimTextOutput(outputId = "meta_dsc"))
      )
    )
  )
)

