

library(shiny)
library(maps)

mmetsp_file = "~/git/misc-analyses/marine_meta/sample-attr_noap_fixed.tab"
mmetsp_data = read.table(mmetsp_file, header=TRUE, sep="\t")
phyrefs = c( "Unknown", "Bacillariophyta", "Dinophyta", "Pyrrophycophyta" , "Foraminifera", "Glaucophyta", "Chlorophyta",
             "Rhodophyta", "Cryptophyta" , "Ciliophora", "Sarcomastigophora", "Chlorarachniophyta", "Euglenozoa", "Cercozoa",
             "Ochrophyta", "Alveolata", "Haptophyta", "Labyrinthista", "Apicomplexa", "Perkinsozoa", "Bicosoecida", "Ascomycota", "None")
phycols = c( "#888888", "#41ab5d"        , "#ec7014"  , "#a6bddb"         , "#a6bddb"     , "#ccebc5"    , "#41ab5d",
             "#ce1256"   , "#993404"     , "#9ebcda"   , "#e0ecf4"          , "#ffeda0"           , "#41ab5d"   , "#2166ac",
             "#9cb511"   , "#a6bddb"  , "#41ab5d"   , "#a6bddb"      , "#8c510a"    , "#c7eae5"    , "#a6bddb"    , "#b2182b" , "#888888")

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Marine Microbial Eukaryote Transcriptome Sequencing"),
  
  # Sidebar layout with input and output definitions ----
  verticalLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "lat",
                  label = "Latitude",
                  min = -90,
                  max = 90,
                  value = c(-90,90)
                  ),
      sliderInput(inputId = "long",
                  label = "Longitude",
                  min = -180,
                  max = 180,
                  value = c(-180,180)),
      actionButton("resetView", "Reset View")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(width=12,
      h3("Each point is a sample. Click and drag over points to display stats"),
      plotOutput(outputId = "worldMap",
                 click = "plot_click",
                 brush = brushOpts(id = "plot_brush")
                 #brush = brushOpts(id = "plot_brush", resetOnNew = TRUE)
                 ),
      tableOutput("sampleInfo")
    #  verbatimTextOutput("sampleInfo")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  #longrange = reactiveValues(data=input$long)
  #latrange = reactiveValues(data=input$lat)
  #observeEvent(input$resetView, {
  #  longrange = c(-180,180)
  #  latrange = c(-90,90) 
  #})
  
  #observeEvent(input$resetView, {
  #  longrange$data <- NULL
  #  latrange$data <- NULL
  #}) 
  
  output$worldMap <- renderPlot({
    #if is.null(longrange)
    
    longrange = input$long
    latrange = input$lat
    

    
   # longrange = c(input$plot_brush$xmin, input$plot_brush$xmax)
   # latrange = c(input$plot_brush$ymin, input$plot_brush$ymax)
    
    worldmap = map('world', xlim=longrange, ylim=latrange, fill=TRUE, col="#dedede", mar=c(0.1,0.1,0.1,0.1),)
    lines( input$long, c(0,0), lwd=0.5,col="#00000022")
    lines( c(0,0), input$lat, lwd=0.5,col="#00000022")
    points( mmetsp_data[["longitude"]], mmetsp_data[["latitude"]], bg=phycols[match(mmetsp_data[["phylum"]],phyrefs)], pch=21, cex=1.5)
    
  })
  output$sampleInfo <- renderTable({
    #nearPoints(mmetsp_data[,2:44], input$plot_click, xvar = "longitude", yvar = "latitude", maxpoints=10)
    brushedPoints(mmetsp_data, input$plot_brush, xvar = "longitude", yvar = "latitude")
  },
  hover = TRUE,
  spacing = 'xs',
  width = "100%"
  )
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)

