library(shiny)
stock<-read.csv("thafinal2.0.csv")
ui <- fluidPage(
  titlePanel("Case Study"),
  sidebarLayout(
    sidebarPanel(
      selectInput("cat","select the catagory",choice = c("All",unique(as.character(stock$Catagory))),selected	="All",multiple = TRUE),
      dateRangeInput('daterange',label = 'Choose a date',start = "2017-12-20", end = "2018-12-20",max= "2018-12-21", min  = "2017-12-21"),
      uiOutput('return_dates'),
      actionButton("submitButton","Submit")
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("stock", DT::dataTableOutput("table"))
      ))))
server <- function(input, output) {
  output$table <- DT::renderDataTable(DT::datatable(editable = TRUE,{
    data <- stock
    if (input$cat != "All") {
      data <- data[data$Catagory == input$cat,]
    }
    data
  }))
  # output$table<-DT::renderDataTable({
  #   data <- stock
  # data(date > input$daterange[1]&date < input$daterange[2])
  # })
  # 
}
shinyApp(ui, server)