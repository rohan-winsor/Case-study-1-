library(shiny)
library(dplyr)
stock<-read.csv("thafinal2.0.csv")
stock$Date = as.Date(stock$Date, format="%m/%d %M:%S")
ui <- fluidPage(
  titlePanel("Case Study"),
  sidebarLayout(
    sidebarPanel(
      selectInput("cat","select the catagory",choice = c("All",unique(as.character(stock$Catagory))),selected	="All",multiple = TRUE),
      dateRangeInput('dateRange',label = 'Choose a date',start = "2017-12-20", end = "2018-12-20",max= "2018-12-21", min  = "2017-12-21"),
      actionButton(inputId = "ok",label = "submit")
     ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("stock", DT::dataTableOutput("table"))
      )))
)
server <- function(input, output) {
   output$table <- DT::renderDataTable(DT::datatable(editable = TRUE,{
    data <- stock
    if (input$cat != "All") {
      data <- data[data$Catagory %in% input$cat,]
    }
    data
  })) 
  observeEvent(input$ok,{output$table <- renderTable({
   stock %>%  
      filter(stock$Date>=input$daterange[1] ,  stock$Date<= input$daterange[2])
   stock  })
  })
}
shinyApp(ui, server)