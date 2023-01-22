# generic shinyapp created by WRF 2023-01-22
# last modified 2023-01-22

library(shiny)
library(ggplot2)
library(dplyr)

# begin app interface
ui <- fluidPage(
  titlePanel("Generic plot viewer shinyapp", windowTitle = "Generic plot viewer shinyapp"),
  fluidRow(
    column(4,
           fileInput("fileName", label = "Select file", 
                     multiple = FALSE,
                     accept = c(".tab", ".tsv", ".txt", "text/csv",
                                "text/comma-separated-values,text/plain",
                                ".csv")),
           checkboxInput("header", "Header", TRUE),
           radioButtons("sep", "Separator",
                        choices = c(Tab = "\t",
                                    Comma = ",",
                                    Semicolon = ";"),
                        selected = "\t"),
           selectInput("x_select", label="X-axis control of plot",
                       choices = c()
                       ),
           selectInput("y_select", label="Y-axis control of plot",
                       choices = c()
                       ),
           checkboxInput("xlog", "Log X-axis", FALSE),
           checkboxInput("ylog", "Log Y-axis", FALSE),
           downloadButton("printpdf", label = "Print graph to PDF")
    ), # end column
    column(8,
           plotOutput(outputId = "genericPlot",
                      width="100%", height="600px",
                      click = "plot_click",
                      brush = brushOpts(id = "plot_brush")
           )
    ) # end column
  ),
  fluidRow(
    column(4,
           verbatimTextOutput("debugText"),
    ),
    tableOutput("selectedPoints")
  ) # end row
) # end fluidPage

server <- function(input, output) {
  output$debugText <- renderPrint({ dim(getUserDataset()) })
  
  getUserDataset <- reactive({
    if (is.null(input$fileName))
      return(NULL)
    d <- read.table( input$fileName$datapath, header = input$header, sep = input$sep )
    return(d)
  })
  
  makeUserGGplot <- reactive({
    req(input$fileName)
    d = getUserDataset()
    if (!is.null(d)){
      ggplot(data = d, aes(x = .data[[input$x_select]], y = .data[[input$y_select]] ) ) +
        theme(legend.position="none",
              axis.text=element_text(size=16),
              axis.title=element_text(size=18),
              plot.title = element_text(size=20) ) +
        scale_x_continuous(trans = ifelse(input$xlog==TRUE,"log10","identity") ) +
        scale_y_continuous(trans = ifelse(input$ylog==TRUE,"log10","identity") ) +
        labs(x=input$x_select, y=input$y_select) +
        geom_point( colour="#016c59", size=5, alpha=0.75 )
    }
  })
  
  output$genericPlot <- renderPlot({
    makeUserGGplot()
  })
  
  output$printpdf <- downloadHandler(
    filename = function() {"plot.pdf"},
    content = function(filename){
      gg = makeUserGGplot()
      ggsave(filename, gg, device="pdf", width=8, height=6)
    }
  )

  # choices for X and Y axis are normally empty
  # this will update the list of columns once the file is loaded
  observe({
    updateSelectInput(session = getDefaultReactiveDomain(), 
                      "x_select", label="X-axis control of plot",
                      choices = names(getUserDataset()),
                      selected = names(getUserDataset())[1]
    )
    updateSelectInput(session = getDefaultReactiveDomain(), 
                      "y_select", label="Y-axis control of plot",
                      choices = names(getUserDataset()),
                      selected = names(getUserDataset())[2]
    )
  }) # end observe

  # make table of brushed points for whatever X and Y are selected
  output$selectedPoints <- renderTable({
    d = getUserDataset()
    brushedPoints( d, input$plot_brush, xvar = input$x_select, yvar = input$y_select )
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)

#