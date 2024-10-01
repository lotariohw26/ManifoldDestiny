ManifoldDestiny::wasmconload()
compute_residuals <- function(angle, data) {
  # Compute the rotated coordinates
  data$angle <- angle * pi / 180
  data$x_r <- data$x * cos(data$angle) - data$y * sin(data$angle)
  data$y_r <- data$x * sin(data$angle) + data$y * cos(data$angle)
  
  # Compute the residuals
  residuals <- data$x_r - data$y_r
  
  # Return the sum of squared residuals
  return(mean(residuals^2))
}
options(scipen=999)
set.seed(1)
ui <- fluidPage(
  titlePanel("Restoration"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("rotation", "Rotation angle (in degrees):", min = -180, max = 180, value = 0)
    ),
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)
# Server
server <- function(input, output) {
  data <- reactive({
    #angle <- input$rotation * pi / 180  # Convert angle to radians
    #eleres_transformed <- eleres %>%
    #  mutate(x_r = x * cos(angle) - y * sin(angle),
    #         y_r = x * sin(angle) + y * cos(angle),
    #         alpha1 = Omega * x + (1 - Omega) * y,
    #         alpha2 = Omega * x_r + (1 - Omega) * y_r) 
    #result <- list(eleres_transformed, optimal_angle())
    ##
    ## Use the optim function to find the angle that minimizes the sum of squared residuals
    #result <- optim(0, compute_residuals, data = eleres, control = list(fnscale = -1), method = "Brent", lower = -180, upper = 180)
    #return(result)
    #return(result)
  })  
  
  # Plot
  output$plot <- renderPlot({
    #df1 <- data()[[1]]
    #ggplot(data = df1, aes(x = x_r, y = y_r)) +
    #  geom_point(aes(color = "Before Rotation")) +
    #  geom_point(data = eleres, aes(x = y, y = x, color = "After Rotation")) +
    #  labs(x = "X", y = "Y", color = "Rotation") +
    #  scale_x_continuous(limits = c(0, 1)) +  # Limit x-axis between 0 and 1
    #  scale_y_continuous(limits = c(0, 1)) +  # Limit y-axis between 0 and 1
    #  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +  # Add 45-degree line
    #  theme_minimal()
  })
  
  # Table
  output$table <- renderTable({
    #df1 <- data()[[1]]
    #opo <- data()[[2]]$param
    #df2 <- df1 %>% dplyr::summarize(m_alpha1=mean(alpha1),m_alpha2=mean(alpha2),omega=mean(Omega), Precincts=n(), opteulr= opo[[1]])
  })
} 
# Run the app
shinyApp(ui = ui, server = server)

