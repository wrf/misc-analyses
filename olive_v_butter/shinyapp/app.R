# olive_v_butter/shinyapp/app.R
# make interactive choropleth plot of food production data from the UN
#
# original dataset at:
# http://www.fao.org/faostat/en/#data/FBS
#
# definitions from:
# https://www.fao.org/faostat/en/#definitions
#
# created by WRF 2021-05-16
# v1.2 2022-04-01 updated to 2022 dataset (including 2019, and back-added 2010-2013)
# v1.3 2022-05-03 autoname pdf file
# v1.31 2022-05-23 use csv of descriptions

library(shiny)
library(ggplot2)
library(dplyr)
library(maps)

DEBUG=TRUE
app_version="v1.32"

# current host of this file at:
setwd("~/git/misc-analyses/olive_v_butter/butterline")
fooddatafile = "./data/FoodBalanceSheets_E_All_Data_2022-04-01.csv.gz"
# read as latin1 to later deal with cote d'ivoire
fooddata = read.csv(fooddatafile, header=TRUE, stringsAsFactors = FALSE, encoding="latin1")
#head(fooddata)
#unique(fooddata$Unit)
#unique(fooddata$Area)

#commdatafile = "./data/CommodityBalances_(non-food)_E_All_Data_NOFLAG_1962-2013.csv"
#commdata = read.csv(commdatafile, header=TRUE, stringsAsFactors = FALSE, encoding="latin1")
#head(commdata)
#table(commdata$Item)

# read tabular food definitions file, listing sub-items of some foods
food_definitions_file = "./data/fbs_item_descriptions_2022.csv"
#food_definitions = read.table(food_definitions_file, header=TRUE, sep="\t")
food_definitions = read.csv(food_definitions_file, header=TRUE)
# check for duplicated items in definitions, which are in the whole table as well
food_definitions_item_counts = table(food_definitions$Item)
if (max(food_definitions_item_counts) > 1){
  if (DEBUG){
    print("Excluding duplicated entries in definitions file:")
    print(food_definitions_item_counts[food_definitions_item_counts > 1])
  }
}
# appears to include, unsure why
# Eggs
# Milk - Excluding Butter
# Miscellaneous
# these must be filtered out to get correct estimates and table display
dup_item_codes = c(2948, 2949, 2928)

################################################################################
# these are summary items only
is_not_item = c("Population", "Grand Total", "Animal Products", "Vegetal Products")

# this is the order that the items appear in the dropdown menu
is_meat = c("Meat", "Bovine Meat", "Mutton & Goat Meat", 
            "Pigmeat", "Poultry Meat",   "Meat, Other",  "Offals", "Offals, Edible",
            "Animal fats",  "Butter, Ghee",  "Cream",  "Fats, Animals, Raw",
            "Eggs", "Milk - Excluding Butter"  )

is_fish = c("Fish, Seafood",  "Freshwater Fish", "Meat, Aquatic Mammals", 
            "Fish, Body Oil", "Fish, Liver Oil", "Demersal Fish",  "Pelagic Fish", 
            "Marine Fish, Other",  "Crustaceans",  "Cephalopods",  "Molluscs, Other", 
            "Aquatic Products, Other",  "Aquatic Animals, Others" , "Aquatic Plants"  )

is_plant = c("Cereals - Excluding Beer", "Wheat and products", 
             "Rice and products" , "Barley and products",  "Maize and products",  
             "Rye and products",  "Oats", "Millet and products",  "Sorghum and products",  
             "Cereals, Other", "Starchy Roots",  "Cassava and products", "Potatoes and products", 
             "Sweet potatoes", "Yams", "Roots, Other",  "Sugar Crops",  "Sugar cane",  
             "Sugar beet", "Pulses",  "Beans", "Peas", "Pulses, Other and products", 
             "Treenuts", "Nuts and products", "Oilcrops",  "Soyabeans",  "Groundnuts", 
             "Sunflower seed", "Rape and Mustardseed",  "Cottonseed",  "Coconuts - Incl Copra",
             "Sesame seed", "Palm kernels", 
             "Vegetables",  "Olives (including preserved)", 
             "Tomatoes and products", "Onions", "Vegetables, other", 
             "Fruits - Excluding Wine", "Oranges, Mandarines",   "Lemons, Limes and products", 
             "Grapefruit and products", "Citrus, Other", "Bananas",  "Plantains",  
             "Apples and products",  "Pineapples and products" , "Dates", 
             "Grapes and products (excl wine)",  "Fruits, other", 
             "Vegetable Oils", "Soyabean Oil",   "Groundnut Oil", "Sunflowerseed Oil" , 
             "Rape and Mustard Oil" , "Cottonseed Oil", "Palmkernel Oil", "Palm Oil", 
             "Coconut Oil",   "Sesameseed Oil", "Olive Oil", "Ricebran Oil", "Maize Germ Oil",
             "Oilcrops Oil, Other", "Oilcrops, Other",
             "Miscellaneous",  "Infant food" )

is_alcohol = c( "Alcoholic Beverages", "Wine", "Beer", "Beverages, Fermented", 
                "Beverages, Alcoholic", "Alcohol, Non-Food")

is_spice = c("Honey", "Stimulants",  "Coffee and products", "Cocoa Beans and products", 
             "Tea (including mate)",  "Spices",  "Pepper", "Pimento", "Cloves","Spices, Other",
             "Sweeteners, Other", "Sugar & Sweeteners", "Sugar non-centrifugal", "Sugar (Raw Equivalent)")

# commodity balance sheet items
is_fiber = c("Abaca", "Cotton lint", "Hard Fibres, Other", "Jute", "Jute-Like Fibres",
             "Silk","Sisal", "Soft-Fibres, Other", "Wool (Clean Eq.)", "Rubber")
is_oil_crop = c("Copra Cake", "Cottonseed", "Cottonseed Cake", "Groundnut Cake", "Oilcrops", 
                "Oilseed Cakes, Other", "Palm kernels", "Palmkernel Cake",
                "Rape and Mustard Cake", "Rape and Mustardseed", "Sesameseed Cake",
                "Soyabean Cake", "Sunflowerseed Cake")
is_commodity = c("Alcohol, Non-Food", "Alcoholic Beverages", "Brans", "Tobacco")

# make list of regions to exclude from barplot, otherwise they always end up as top 20
is_not_country = c("World", "Asia", "Europe", "Africa", "Oceania",
                   "Eastern Asia", "Central Asia", "Southern Asia", "Western Asia", "South-Eastern Asia", "South-eastern Asia",
                   "Western Africa", "Middle Africa", "Southern Africa", "Northern Africa", "Eastern Africa",
                   "Americas", "Northern America", "Central America", "South America",
                   "Northern Europe", "Western Europe", "Southern Europe", "Eastern Europe",
                   "Australia and New Zealand", "China, mainland",
                   "European Union (with UK)",
                   "Small Island Developing States",
                   "Land Locked Developing Countries", 
                   "Least Developed Countries",
                   "Low Income Food Deficit Countries", 
                   "Net Food Importing Developing Countries")

valid_element_types = c("Import Quantity", "Export Quantity", "Production", 
                        "Feed", "Food", "Seed", "Domestic supply quantity",
                        "Tourist consumption", 
                        "Stock Variation", "Losses", "Processing", "Residuals", "Other uses (non-food)")
valid_element_types.short = c("Import Quantity", "Export Quantity", "Production")

# this is the order of items in the dropdown menu
all_items_food_only = c( is_plant, is_meat, is_fish, is_alcohol, is_spice)

all_items_combined = c(is_not_item, is_meat, is_fish, is_plant, is_alcohol, is_spice )
# check that everything is included
if (length(all_items_combined) != length(unique(fooddata$Item)) ){
  print( paste("ERROR: item missing, set contains", length(unique(fooddata$Item)), 
               "and file contains", length(all_items_combined)) )}

# confirm that all items are in a division
# will print items not in vector all_items_food_only
# may include spelling/capitalization changes like
# 2022: "Fruits, Other" to "Fruits, other" ; "Vegetables, Other" to "Vegetables, other"
not_found_items = match( names( table(fooddata$Item) ), all_items_combined )
if (sum(is.na(not_found_items)) > 0){names( table(fooddata$Item) )[is.na(not_found_items)]}

# table for display, and for recoding step
fooddata_recode = fooddata %>%
                  filter( ! fooddata$Item.Code %in% dup_item_codes ) %>%
                  filter(! Item %in% is_not_item &
                         Element %in% valid_element_types ) %>%
                  select(Area, Item, Element, Y2011, Y2012, Y2013, Y2014, Y2015, Y2016, Y2017, Y2018, Y2019) %>%
                  rename(region=Area )

# adjust names for certain remaining countries
fooddata_recode$region = recode(fooddata_recode$region,
                         "Côte d'Ivoire" = "Ivory Coast",
                         "C\xf4te d'Ivoire" = "Ivory Coast",
                         "Cote d'Ivoire" = "Ivory Coast",
                         "United Republic of Tanzania" = "Tanzania",
                         "Iran (Islamic Republic of)" = "Iran",
                         "Lao People's Democratic Republic" = "Laos",
                         "Viet Nam" = "Vietnam",
                         "China, Macao SAR" = "Macao",
                         "China, Hong Kong SAR" = "Hong Kong",
                         "China, Taiwan Province of" = "Taiwan",
                         "Democratic People's Republic of Korea" = "North Korea",
                         "Republic of Korea" = "South Korea",
                         "United Kingdom" = "UK",
                         "United Kingdom of Great Britain and Northern Ireland" = "UK",
                         "United States of America" = "USA",
                         "Venezuela (Bolivarian Republic of)" = "Venezuela",
                         "Bolivia (Plurinational State of)" = "Bolivia",
                         "Republic of Moldova" = "Moldova",
                         "Czechia" = "Czech Republic",
                         "Russian Federation" = "Russia",
                         "European Union (28)" = "European Union (with UK)",
                         "European Union (27)" = "European Union (excluding UK)")

###TODO allow divide by population
country_population = fooddata %>%
                    filter( Item=="Population", Element=="Total Population - Both sexes" ) %>%
                    select(Area, Item, Element, Y2011, Y2012, Y2013, Y2014, Y2015, Y2016, Y2017, Y2018, Y2019)
#country_population

countries_w_data = sort(unique(fooddata_recode$region))

worldpolygons = map_data("world")
#head(worldpolygons)
#unique(worldpolygons$region)

################################################################################

ui <- fluidPage(
  titlePanel(h1(paste("UN FAO Food Balance Sheets", app_version), style="color:#21632e; text-align:center; font-weight:bold;"), windowTitle="UN FAO Food Balance Sheets"),
  verticalLayout(
    fluidRow(
      column(4,
             # sliderInput(inputId = "lat",
             #             label = "Latitude",
             #             min = -90,
             #             max = 90,
             #             value = c(-50,70)
             #            ),
             # sliderInput(inputId = "long",
             #             label = "Longitude",
             #             min = -180,
             #             max = 180,
             #             value = c(-180,180)
             #            ),
             selectInput("year", "Year (on map and plot)", 
                         choices = list("2019" = "Y2019",
                                        "2018" = "Y2018",
                                        "2017" = "Y2017",
                                        "2016" = "Y2016",
                                        "2015" = "Y2015",
                                        "2014" = "Y2014",
                                        "2013" = "Y2013",
                                        "2012" = "Y2012",
                                        "2011" = "Y2011"
                                        ), 
                         selected="Y2019"
                         ),
             sliderInput(inputId = "tableYearRange",
                         label = "Years (for table display)",
                         min = 2011,
                         max = 2019,
                         value = c(2016,2019),
                         step=1, sep=""
                        ),
             ), # end column
      column(4,

             selectInput("itemType", "Food item type (on map, plot and table)", 
                         choices = all_items_food_only
                         ),
             selectInput("elementType", "Measurement (on map, plot and table)", 
                         choices = valid_element_types
                        ),
             selectInput("chosenCountry", "Country or region (to show on table)", 
                         choices = countries_w_data,
                         selected = "European Union (excluding UK)"
             )
             #helpText("Note: Net food = imports + prod - exports - feed")
             ), # end column
      column(4,
             radioButtons("tableformat", "Show table of:",
                          choices = list("Item + Measure (for all countries)" = "itemelement",
                                         "Item + Country (for all measures)" = "itemcountry",
                                         "Measure + Country (for all items)" = "countrymeasure"
                                         )
                          ),
             radioButtons("tablesorting", "Sort table by:",
                          choices = list("Alphabetical by country/region" = "alphabetical",
                                         "Sorted by value descending" = "sortdescend",
                                         "Sorted by value ascending" = "sortascend"
                                         )
                          ),
             h5(strong("Save current map view as PDF")),
             downloadButton("printpdf", label = "Print")
             )
    ), # end fluidRow

    mainPanel(width="100%",
              verbatimTextOutput(outputId = "showingWhat"),
              h3("Scroll down for raw data table.", style="color:#21632e"),
              htmlOutput(outputId = "foodDesc"),
              plotOutput(outputId = "worldMap",
                 height="650px"
                 ),
              plotOutput(outputId = "rankedBarplot",
                         height="200px"
                 ),
              h3("Country or region data:", style="color:#21632e"),
              p("Note: all units are in 1000 tonnes, i.e. M kg"),
              tableOutput("countryInfo"),
              br(),
              h1("About this app:", style="color:#21632e"),
              p("The goal of the original project was to visualise import and export trends of seafood alone. 
                This was converted into an interactive app to display a map and barplot of major importers or exporters of various seafood products, 
                which may be relevant to researchers or consumers.
                For example, a country like Italy has long coastlines, 
                but the low productivity of the Mediterranean sea means that much of the seafood consumed in Italy is actually imported. 
                Most tourists do not know this."),
              p("For the first version, the dataset from the UN was filtered to display only seafood, 
                but the second version of the app was modified to include all food items."),
              p("Source code for this app can be found here:"),
              a("https://github.com/wrf/misc-analyses/tree/master/olive_v_butter", href="https://github.com/wrf/misc-analyses/tree/master/olive_v_butter"),
              br(), br(),
              p("For all measures, units are in 1000 tonnes, or M kg, or properly in gigagrams - Gg. 
                One tonne of water, 1000kg, would be a 1m cube. 
                A shipping container (40 x 8 x 8.5 ft) would be about 68 cubic meters of internal space. 
                So 1 Gg would be about 15 shipping containers."),
              p("To download the raw data from the UN FAO Statistics Division, go to:"),
              a("www.fao.org/faostat/en/#data/FBS", href="https://www.fao.org/faostat/en/#data/FBS"),
              br(), br(),
              p("App created by WRF, last modified by WRF 2022-05-23"),
              br()
    ) # end mainPanel
  ) # end verticalLayout
)

#
server <- function(input, output) {
  #output$showingWhat <- renderPrint({ sub("_2017_Gg","",input$displaytype) })
  #output$showingWhat <- renderPrint({ gsub( " ","_", as.character(paste( input$itemType, input$elementType, input$year, ".pdf", sep="_" ))) })
  
  output$foodDesc <- renderUI({
    #item_def_desc = food_definitions[match(input$itemType, food_definitions$item),3]
    #item_def_desc = food_definitions[match(input$itemType, food_definitions$Item),5]
    # set everything to lowercase to correct for 
    # "Fruits, Other" to "Fruits, other"
    # "Vegetables, Other" to "Vegetables, other"
    item_def_desc = food_definitions[match( tolower(input$itemType), tolower(food_definitions$Item)),5]
    
    if ( is.na(item_def_desc) | item_def_desc=="" ){
      reformat_desc = as.character(input$itemType) # do nothing
    } else if (item_def_desc != ""){
      reformat_desc = gsub("Default composition: ", "", item_def_desc)
    }
    HTML(paste( input$itemType, "includes:<br/>", reformat_desc) )
  })

  #TODO  
  # output$rankDesc <- renderText({
  #   # rank top 3 for each item and element
  #   rankdf = data.frame(matrix(nrow = 0, ncol = ncol(fooddata_recode) ))
  #   colnames(rankdf) = names(fooddata_recode)
  #   for (rankitem in all_items_food_only){
  #     for (rankelement in valid_element_types.short){
  #       xf = filter(fooddata_recode, ! region %in% is_not_country, Item==rankitem, Element==rankelement)
  #       rankdf = rbind(rankdf, slice_max(xf, order_by = get(input$year), n = 3))
  #       filter(rankdf, region==input$chosenCountry )
  #     }}
  # })
  
  # create barplot ggplot object
  ggbars = reactive({
    # only display actual countries
    fd_filt <- filter(fooddata_recode, ! region %in% is_not_country,
                      Item==input$itemType, Element==input$elementType  ) %>%
      slice_max(order_by=get(input$year), n=20)
    
    if (input$itemType %in% is_meat) {
      color_set = colorRampPalette(c("#e9e9a3","#632121"))(7)
    } else if (input$itemType %in% is_fish) {
      color_set = colorRampPalette(c("#e9e9a3","#06246f"))(7)
    } else if (input$itemType %in% is_plant) {
      color_set = colorRampPalette(c("#e9e9a3","#21632e"))(7)
    } else if (input$itemType %in% is_alcohol) {
      color_set = colorRampPalette(c("#e9e9a3","#632159"))(7)
    } else { # implying is_spice
      color_set = colorRampPalette(c("#e9e9a3","#a37d17"))(7)
    }
    color_bins = c(0, 1, 10, 100, 1000, 10000, 100000)

    ggplot(fd_filt, aes(x=region, y=input$year ) ) +
      coord_flip() +
      scale_y_continuous(expand = c(0,0) ) +
      labs(x=NULL, y=paste(input$year, input$elementType,"of",input$itemType) ) +
      scale_fill_gradientn(colours = color_set,
                           breaks = color_bins,
                           na.value="gray70", trans = "log10") +
      geom_bar( stat="identity", show.legend = FALSE,
                aes(reorder(region, .data[[input$year]]), .data[[input$year]], fill=.data[[input$year]]) )
  })
  
  # draw updated plot
  output$rankedBarplot <- renderPlot({
    ggbars()
  })
  
  # create map ggplot object
  mapgg = reactive({
    # subset food data
    fooddata_subset = left_join(worldpolygons, filter(fooddata_recode, Item==input$itemType & Element==input$elementType), by="region" )
    # choose the measurement to display
    filldata = select(fooddata_subset, input$year)[,1]

    # adjust parameters for the one measurement that is a ratio
    if (input$itemType %in% is_meat) {
      color_set = colorRampPalette(c("#e9e9a3","#632121"))(7)
    } else if (input$itemType %in% is_fish) {
      color_set = colorRampPalette(c("#e9e9a3","#06246f"))(7)
    } else if (input$itemType %in% is_plant) {
      color_set = colorRampPalette(c("#e9e9a3","#21632e"))(7)
    } else if (input$itemType %in% is_alcohol) {
      color_set = colorRampPalette(c("#e9e9a3","#632159"))(7)
    } else { # implying is_spice
      color_set = colorRampPalette(c("#e9e9a3","#a37d17"))(7)
    }
    color_bins = c(0, 1, 10, 100, 1000, 10000, 100000)
    
    # generate title text
    full_title = paste( gsub("Y","",input$year), "Global",  input$elementType, "of", input$itemType )
    
    DEFAULT_LON = c(-180,180)
    DEFAULT_LAT = c(-50,70)
    # generate the map
    ggplot(fooddata_subset, aes(long,lat, group=group)) +
      #coord_cartesian( xlim = input$long, ylim = input$lat ) +
      coord_cartesian( xlim = DEFAULT_LON, ylim = DEFAULT_LAT ) +
      theme(plot.title = element_text(size=20),
            axis.text = element_blank(),
            axis.ticks = element_blank(),
            legend.position=c(0,0.5),
            legend.key.size = unit(1, 'cm'),
            legend.justification = "left") +
      scale_fill_gradientn(colours = color_set, 
                           breaks = color_bins,
                           na.value="gray70", trans = "log10",
                           oob = scales::squish_infinite) +
      # possibly add oob = scales::squish_infinite
      labs(x=NULL, y=NULL, fill="Quantity\n(M kg)",
           title=full_title,
           #subtitle= paste("showing:", input$itemType ),
           caption="Data from UN Food and Agriculture Organization (FAO) 2022\nwww.fao.org/faostat/en/#data/FBS") +
      geom_polygon( aes(x=long, y = lat, group = group, fill=filldata), colour="#ffffff")
  })

  # draw map
  output$worldMap <- renderPlot({
    mapgg()
  })
  
  # print map ggplot object
  output$printpdf <- downloadHandler(
    filename = function() { paste0( gsub( " ","_", paste( input$itemType, input$elementType, input$year, sep="_" )),".pdf") },
    content = function(filename){
      printmap = mapgg()
      ggsave(filename, printmap, device="pdf", width=11, height=6)
    }
  )
  
  # make table
  output$countryInfo <- renderTable({
    # filter table
    if (input$tableformat == "itemelement"){
      ft = filter(fooddata_recode, Item==input$itemType & Element==input$elementType)
    } else if (input$tableformat == "itemcountry"){
      ft = filter(fooddata_recode, Item==input$itemType & region==input$chosenCountry)
    } else {
      ft = filter(fooddata_recode, Element==input$elementType & region==input$chosenCountry)
    }
    # sort if required, default is alphabetical
    if (input$tablesorting == "sortdescend"){
      arrange(ft, desc( get(input$year) ) )
    } else if (input$tablesorting == "sortascend"){
      arrange(ft, get(input$year) )
    } else {
      ft
    }
  # a few last options
  },
  hover = TRUE,
  spacing = 'xs',
  width = "100%"
  )
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
