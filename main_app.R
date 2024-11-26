# load required libraries
# install these packages via install.packages etc
# (i had to install the binaries (type) since the usual source didnt work for some reason)
library(shiny)
library(leaflet)
library(ggplot2)

# define the user interface
ui <- fluidPage(
  # add some rly basic styling
  tags$head(
    tags$style(HTML("
      body { 
        background-color: #f4f4f4; 
        font-family: 'Arial', sans-serif;
      }
      .main-container {
        background-color: white;
        border-radius: 15px;
        padding: 20px;
        margin-top: 20px;
        box-shadow: 0 6px 12px rgba(0,0,0,0.1);
      }
      .title-panel {
        text-align: center;
        margin-bottom: 20px;
      }
      .title-panel h2 {
        color: #333;
        font-weight: bold;
      }
    "))
  ),
  
  # title
  div(class = "title-panel",
      titlePanel("Geospatial Data Visualization for our beautiful study project")
  ),
  
  # Main layout
  fluidRow(
    column(4, 
           wellPanel(
             # placeholder for potential future controls
             p("add controls here as needed for future references")
           )
    ),
    column(8, 
           div(class = "main-container",
               tabsetPanel(
                 tabPanel("Map", 
                          leafletOutput("mapPlot", height = "500px")
                 ),
                 tabPanel("Plot", 
                          plotOutput("emptyPlot", height = "500px")
                 )
               )
           )
    )
  )
)

# define the server logic
server <- function(input, output) {
  # empty Leaflet map centered on a specific location
  output$mapPlot <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2)
  })
  
  # empty ggplot
  output$emptyPlot <- renderPlot({
    ggplot() +
      theme_minimal() +
      labs(
        title = "just a placeholder plot",
        x = "X-axis",
        y = "Y-axis"
      ) +
      theme(
        plot.title = element_text(hjust = 0.5, size = 15, face = "bold"),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white")
      )
  })
}

# run the application
shinyApp(ui = ui, server = server)
