library(shiny)
library(shinyWidgets)
library(r2d3)
library(DT)

# load data
budget_data <- read.csv('budget_2010_2019.csv')


ui <- fluidPage(
  # title page
  tags$h1("City of Toronto Approved Budget*"),
  fluidRow(
    column(width=6,
           p("*The 2013 budget was recommended and not approved."),
           p("Data Source:",
             a(href="https://open.toronto.ca/dataset/budget-operating-budget-program-summary-by-expenditure-category/", "Toronto Open Data Portal")),
           p("Created by:",
             a(href="https://shafquatarefeen.com", "Shafquat Arefeen"))
    )
  ),
  fluidRow(
    column(width=9,sliderInput("budget_year", "Budget Year", 2010, 2019, 0, step=1,sep="",
                   animate=animationOptions(interval=600, loop=FALSE)),
       pickerInput("program", "Select a Program", choices = 0)
       
    ),
    column(width=9,
           # Output: Sankey Chart
           d3Output("mychart")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui = ui, server = server)