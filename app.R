#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

clockOutput <- function(outputId) {
  tags$div(id = outputId, class = "clockOutput")
}

renderTime <- function() {
  t <- reactiveVal(as.numeric(Sys.time()))
  update <- function() {
    t(as.numeric(Sys.time()))
    later::later(update, 1000)
  }
  reactive(list(timestamp = t()))
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$script(crossorigin = TRUE, src = "https://unpkg.com/react@16/umd/react.development.js"),
  tags$script(crossorigin = TRUE, src = "https://unpkg.com/react-dom@16/umd/react-dom.development.js"),
  tags$script(crossorigin = TRUE, src = "https://unpkg.com/@babel/standalone/babel.js"),
  tags$script(src = "react-widget.jsx", type = "text/jsx"),
  
  clockOutput("clock"),
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$clock <- renderTime()
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

