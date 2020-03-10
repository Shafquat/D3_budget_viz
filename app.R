library(shiny)
library(plotly)

# load data
budget_data <- read.csv('budget_2010_2019_cleaned.csv')

# Assign colours to categories for consistency year over year
color_map <- c('Contribution From Reserves/Reserve Funds'="#a2b9bc", 
               'Contribution To Reserves/Reserve Funds'="#b2ad7f", 
               'Federal Subsidies'= "#878f99",
               "Inter-Divisional Recoveries"= "#6b5b95",
               "Other Expenditures"="#d6cbd3", 
               "Provincial Subsidies"="#eca1a6", 
               "Service And Rent"="#bdcebe", 
               "Transfers from Capital Fund"="#ada397", 
               "Licences & Permits Revenue"= "#d5e1df",
               "Special Levy for Scarborough Subway"= "#e3eaa7",
               "Contributions to Capital"="#b5e7a0", 
               "Equipment"="#86af49", 
               "Inter-Divisional Charges"="#b9936c",
               "Materials & Supplies"= "#dac292",
               "Other Subsidies"='#e6e2d3', 
               "Salaries And Benefits"="#c4b7a6", 
               "Sundry and Other Revenues"="#e4d1d1", 
               "User Fees & Donations"="#b9b0b0", 
               "Legal Fee Rec - 3rd Party"="#d9ecd0", 
               "Property Tax"="#77a8a8")


ui <- fluidPage(
  # title page
  titlePanel("City of Toronto Approved Budget*"),
  fluidRow(
    column(width=12,
           p("*The 2013 budget was recommended and not approved."),
           p("Data Source:",
             a(href="https://open.toronto.ca/dataset/budget-operating-budget-program-summary-by-expenditure-category/", "Toronto Open Data Portal")),
           p("Created by:",
             a(href="https://shafquatarefeen.com", "Shafquat Arefeen"))
    )
  ),
  fluidRow(
    align = "center",
    column(width=12,sliderInput("budget_year", "Budget Year", 2010, 2019, 0, step=1,sep="", ticks = TRUE,
                   animate=animationOptions(interval=600, loop=FALSE), width = '350px'),
       selectInput("program", "Select a Program", choices = c("All",sort(unique(as.character(budget_data$Program)))))
       
       
       
    )),
    fluidRow(
      align = "center",
      column(width=6,
             # Output:  Pies
             h4(textOutput("r_title")),
             plotlyOutput("revenue_pie")
      ),
      column(width=6,
             # Output:  Pies
             h4(textOutput("e_title")),
             plotlyOutput("expense_pie")
      )
    )
  )

server <- function(input, output, session) {
  filtered <- reactive({
    rows <- (budget_data$Year==input$budget_year) &
      (input$program=="All" | budget_data$Program==input$program)
    budget_data[rows,,drop = FALSE] 
    
  })
  
  output$r_title <- renderText({ 
    paste(input$program, "Total Revenue in ", input$budget_year, ' $', format(round(
      sum(as.numeric(filtered()$Revenue), na.rm = TRUE)
      / 1e6, 2), trim = TRUE), "M")
  })
  
  output$e_title <- renderText({ 
    paste(input$program,"Total Expenses in ", input$budget_year, ' $', format(round(
      sum(as.numeric(filtered()$Expense), na.rm = TRUE)
      / 1e6, 2), trim = TRUE), "M")
  })
  
  
  output$revenue_pie <- renderPlotly({
    plot_ly(filtered(), labels = filtered()$Category, values = filtered()$Revenue, type = 'pie', 
            textposition = 'inside',
            width = 412, height = 600,
            textinfo = 'percent',
            insidetextfont = list(color = '#000000'),
            # hoverinfo = 'text',
            # text = ~paste(filtered()$Category),
            marker = list(colors = color_map[filtered()$Category],
                          line = list(color = '#FFFFFF', width = 2)),
            #The 'pull' attribute can also be used to create space between the sectors
            showlegend = TRUE) %>% layout(autosize = F, legend = list(orientation ='h', x = 0.5))
    })
  
  
  output$expense_pie <- renderPlotly({
    plot_ly(filtered(), labels = filtered()$Category, values = filtered()$Expense, type = 'pie', 
            textposition = 'inside',
            width = 412, height = 600,
            textinfo = 'percent',
            insidetextfont = list(color = '#000000'),
            # hoverinfo = 'text',
            # text = ~paste(filtered()$Category),
            marker = list(colors = color_map[filtered()$Category],
                          line = list(color = '#FFFFFF', width = 2)),
            #The 'pull' attribute can also be used to create space between the sectors
            showlegend = TRUE) %>% layout(autosize = F,legend = list(orientation ='h', x = 0.5))
    
  })
                                        
  
}

shinyApp(ui = ui, server = server)