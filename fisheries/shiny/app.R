# fisheries/shiny/app.R
# make interactive choropleth plot of fisheries data from the UN
#
# data at:
# www.fao.org/fishery/statistics/global-consumption/en
# http://www.fao.org/faostat/en/#data/FBS
#
# created by WRF 2021-05-03

library(shiny)
library(ggplot2)
library(dplyr)


# current host of this file at:
fishdatafile = "~/git/misc-analyses/fisheries/data/FoodBalanceSheets_E_reformat_all_fish.tab"
fishdata = read.table(fishdatafile, header=TRUE, sep="\t", stringsAsFactors = FALSE)
#head(fishdata)

worldpolygons = map_data("world")
#head(worldpolygons)
#unique(worldpolygons$region)

# adjust names for certain remaining countries
# most renaming is handled by the python script simplify_foodbalance_table.py
fishdata$region = recode(fishdata$region,
                         "Cote d'Ivoire" = "Ivory Coast",
                         "Czechia" = "Czech Republic" )
fishdata_recode = mutate(fishdata, net_human_consumed = production_2017_Gg + imports_2017_Gg - exports_2017_Gg - feed_2017_Gg,
         imports_vs_production = pmin(imports_2017_Gg / (production_2017_Gg+0.01),22.22) )
#head(fishdata_recode)
countries_w_data = sort(unique(fishdata_recode$region))

ui <- fluidPage(
  titlePanel("UN FAO Fisheries"),
  verticalLayout(
    fluidRow(
      column(4,
             sliderInput(inputId = "lat",
                         label = "Latitude",
                         min = -90,
                         max = 90,
                         value = c(-55,75)
                        ),
             sliderInput(inputId = "long",
                         label = "Longitude",
                         min = -180,
                         max = 180,
                         value = c(-180,180)
                        )
             ), # end column
      column(4,
             selectInput("fishtype", "Seafood type", 
                         choices = list("All fish and seafood" = "Fish, Seafood", 
                                        "Pelagic fish" = "Pelagic Fish", 
                                        "Demersal fish" = "Demersal Fish",
                                        "Other marine fish" = "Marine Fish, Other",
                                        "Freshwater fish" = "Freshwater Fish", 
                                        "Crustaceans" = "Crustaceans", 
                                        "Cephalopods" = "Cephalopods",
                                        "Molluscs (excl. cephalopods)" = "Molluscs, Other")
                         ),
             selectInput("displaytype", "Measurement", 
                         choices = list("Imports" = "imports_2017_Gg", 
                                        "Production" = "production_2017_Gg", 
                                        "Exports" = "exports_2017_Gg",
                                        "Use as animal feed" = "feed_2017_Gg", 
                                        "Net food for humans" = "net_human_consumed", 
                                        "Ratio of import/production" =  "imports_vs_production"
                                        )
                        ),
             helpText("Note: Net = imports + prod - exports - feed")
             ), # end column
      column(4,
             selectInput("chosenCountry", "Country or region to display tabular data", 
                         choices = countries_w_data,
                         selected = "Africa"
                         ),
             h5(strong("Save current map view as PDF")),
             downloadButton("printpdf", label = "Print")
             )
    ), # end fluidRow

    mainPanel(width="100%",
              verbatimTextOutput(outputId = "showingWhat"),
              h3("Scroll down for raw data."),
              plotOutput(outputId = "worldMap",
                 height="600px"
                 ),
              h3("Country or region data:"),
              tableOutput("countryInfo")
    ) # end mainPanel
  ) # end verticalLayout
)

#
server <- function(input, output) {
  #output$showingWhat <- renderPrint({ sub("_2017_Gg","",input$displaytype) })
  
  output$worldMap <- renderPlot({
    # subset fish data
    fishdata_subset = left_join(worldpolygons, filter(fishdata_recode, item==input$fishtype), by="region" )
    # choose the measurement to display
    filldata = select(fishdata_subset, input$displaytype)[,1]
    
    # adjust parameters for the one measurement that is a ratio
    if (input$displaytype=="imports_vs_production") {
      color_set = colorRampPalette(c("#4393c3", "#addd8e", "#d6604d"))(7)
      color_bins = c(0.01, 0.05, 0.1, 0.5, 1, 5, 10 )
    }
    # otherwise just use light-green to dark-blue palette
    else {
      color_set = colorRampPalette(c("#b0e6cd","#06246f"))(7)
      color_bins = c(0, 1, 10, 100, 1000, 10000, 100000)
    }
    
    # generate title text
    full_title = paste("2017 global seafood", gsub("_"," ",sub("_2017_Gg","",input$displaytype)) )
    
    # generate the map
    fishgg = ggplot(fishdata_subset, aes(long,lat, group=group)) +
      coord_cartesian(xlim=input$long, ylim=input$lat ) +
      theme(plot.title = element_text(size=20),
            axis.text = element_blank(),
            axis.ticks = element_blank(),
            legend.position=c(0,0.5),
            legend.key.size = unit(1, 'cm'),
            legend.justification = "left") +
      scale_fill_gradientn(colours = color_set, 
                           breaks = color_bins,
                           na.value="gray70", trans = "log10") +
      labs(x=NULL, y=NULL, fill="Quantity\n(M kg)",
           title=full_title,
           subtitle= paste("showing:", input$fishtype ),
           caption="Data from UN Food and Agriculture Organization (FAO) 2017\nwww.fao.org/fishery/statistics/global-consumption/en") +
      geom_polygon( aes(x=long, y = lat, group = group, fill=filldata), colour="#ffffff")
    fishgg

  })
  output$printpdf <- downloadHandler(
    filename = function() {"plot.pdf"},
    content = function(filename){
      ggsave(filename, device="pdf", width=11, height=6)
    }
  )
  output$countryInfo <- renderTable({
    filter(fishdata_recode, region==input$chosenCountry)
  },
  hover = TRUE,
  spacing = 'xs',
  width = "100%"
  )
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
