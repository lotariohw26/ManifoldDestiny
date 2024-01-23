library(shiny)

ui <- fluidPage(
  fluidRow(
    column(width = 12,
           textInput("input1", "Input 1"),
           textInput("input2", "Input 2")
    )
  ),
  fluidRow(
    column(width = 12,
           plotOutput("output")
    )
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
#
