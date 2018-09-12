library(shiny)

clockOutput <- function(outputId, locale = "en-US") {
  tags$div(id = outputId, class = "clock-output", `data-locale` = locale)
}

renderTime <- function() {
  time <- reactivePoll(1000, NULL, checkFunc = Sys.time, valueFunc = Sys.time)
  reactive(list(unixTimeMs = as.numeric(time()) * 1000))
}

ui <- fluidPage(
  tags$script(crossorigin = TRUE, src = "https://unpkg.com/react@16/umd/react.development.js"),
  tags$script(crossorigin = TRUE, src = "https://unpkg.com/react-dom@16/umd/react-dom.development.js"),
  tags$script(crossorigin = TRUE, src = "https://unpkg.com/@babel/standalone/babel.js"),
  tags$script(src = "clock-output.jsx", type = "text/jsx"),
  
  titlePanel("React Examples"),
  tags$h3("Clock Output"),
  clockOutput("clock")
)

server <- function(input, output) {
  output$clock <- renderTime()
}

shinyApp(ui = ui, server = server)