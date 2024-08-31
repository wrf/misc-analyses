# birth rate plotter created by WRF 2024-08-21

library(shiny)
library(ggplot2)
library(dplyr)

APP_VERSION = "v1.0"

birthrate_file = "~/git/misc-analyses/birth_rate_by_month/data/UNdata_Export_20230630_084956534.txt.gz"
birthdata = read.table(birthrate_file, header=TRUE, sep=";", stringsAsFactors = FALSE )

summary(birthdata)
unique(birthdata$Reliability)
country_list = unique(birthdata[["Country.or.Area"]])


# months in order, to keep numerical order
months = c("January", "February", "March", "April", "May", "June",
           "July", "August", "September", "October", "November", "December")
# adjusted number of days per month
d_per_month = (365/12) / c(31,28,31,30,31,30,31,31,30,31,30,31)

element_colors = rep(c("#12934d","#a72c01", "#bca626", "#8a78c1", "#2689bc"), each=2 )

# 1960 metal rat      rat   ox  tiger rabbit dragon snake
zh_zodiac_symbols = c("鼠", "牛", "虎", "兔", "龍", "蛇", 
                      "馬", "羊", "猴", "雞", "狗", "豬" )
#                    horse  goat monkey chicken dog pig

gr_zodiac_symbols = c("♑︎︎", "♒︎︎", "♓︎︎", "♈︎︎", "♉︎︎", "♊︎︎", "♋︎︎", "♌︎︎", "♍︎︎",#
                      "♎︎︎", "♏︎︎", "♐︎︎" )#

# begin app interface
ui <- fluidPage(
  titlePanel(paste("Global birth rate viewer",APP_VERSION), 
             windowTitle = paste("Global birth rate viewer",APP_VERSION)),
  fluidRow(
    column(4,
           selectInput("chosenCountry", "Country to display", 
                       choices = country_list,
                       selected = "Malaysia" ),
           checkboxInput("grZodiac", "Include Western Zodiac", FALSE),
           checkboxInput("zhZodiac", "Include Chinese Zodiac", FALSE),
           sliderInput(inputId = "ptHue", label = "Line color",
                       min = 0, max = 1,
                       value = 0.25, step=0.01, sep="" ),
           downloadButton("printUpPDF", label = "Print upper graph to PDF"),
           downloadButton("printLowPDF", label = "Print lower graph to PDF")
       ), # end column
    column(8,
           plotOutput(outputId = "fullTimeline",
                      width="100%", height="400px",
                      click = "plot_click",
                      brush = brushOpts(id = "mainTime_brush", direction="x")
           ),
           plotOutput(outputId = "monthlyAverages",
                      width="100%", height="400px",
                      click = "plot_click",
                      brush = brushOpts(id = "monthlyTime_brush", direction="x")
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
  #output$debugText <- renderPrint({ dim(getUserDataset()) })
  
  output$fullTimeline <- renderPlot({
    country_final_only = filter(birthdata, Reliability == "Final figure, complete",
                                Month %in% months,
                                Country.or.Area==input$chosenCountry) %>%
      select( Country.or.Area, Month, Year, Value ) %>%
      mutate( mi = match(Month,months) ) %>%
      arrange(Country.or.Area, Year, mi)
    
    months_by_year_by_country = c(table(country_final_only[["Year"]],country_final_only[["Country.or.Area"]]))
    months_by_year_by_country = months_by_year_by_country[months_by_year_by_country>0]
    
    yearly_averages = country_final_only %>% group_by(Country.or.Area, Year) %>% summarise( yearly_mean = mean(Value) )
    yearmonth_index = country_final_only$Year + (0.0833 * (match(country_final_only$Month, months )-1))

    number_of_years = length(yearly_averages$Year)
    yearly_mean_range = round(range(yearly_averages$yearly_mean))
    year_range = range(country_final_only$Year)
    
    subtitle_text = paste("Data from UN Demographic Statistics Database, including",number_of_years,"years from",year_range[1],"to",year_range[2])
    caption_text = paste("Monthly range from", min(country_final_only$Value) ,"to", max(country_final_only$Value))
    line_color.dark = hsv(h = input$ptHue, s=0.81, v=0.25 )
    line_color.light = hsv(h = input$ptHue, s=0.85, v=0.95 )
    
    cgg = ggplot(country_final_only, aes(x=yearmonth_index,y=Value, colour=yearmonth_index)) + 
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
            axis.text.y=element_text(size=13),
            axis.title.y=element_text(size=16),
            legend.position="none",
            #legend.justification = "right",
            #legend.title = element_text(size=16),
            #legend.key.size = unit(1, 'cm'),
            plot.title = element_text(size=25)) +
      coord_cartesian(xlim=year_range) +
      scale_x_continuous(breaks=unique(country_final_only$Year), labels=unique(country_final_only$Year), 
                         minor_breaks = NULL, expand = c(0.01,0)) +
      scale_color_gradient(low=line_color.dark, high=line_color.light) +
      labs(x=NULL, y = "Births per month", 
           title=input$chosenCountry, subtitle=subtitle_text,
           caption=caption_text) +
      geom_line(alpha=0.9, size=1, lineend = "round")
    # possibly add Zodiac
    if (input$zhZodiac==TRUE){
      zodiac_year = zh_zodiac_symbols[(((seq(year_range[1],year_range[2],1)-1960)%%12)+1)]
      zodiac_color = element_colors[(((seq(year_range[1],year_range[2],1)-1964)%%10)+1)]
      cgg = cgg+annotate( geom="text", x=seq(year_range[1],year_range[2],1)+0.5, y=max(country_final_only$Value), 
                          label=zodiac_year, color=zodiac_color )
    }
    cgg
  })

  ##############################################################################

  output$monthlyAverages <- renderPlot({
    country_final_only = filter(birthdata, Reliability == "Final figure, complete",
                                Month %in% months,
                                Country.or.Area==input$chosenCountry) %>%
      select( Country.or.Area, Month, Year, Value ) %>%
      arrange(Country.or.Area, Year, match(Month,months))
    months_by_year_by_country = c(table(country_final_only[["Year"]],country_final_only[["Country.or.Area"]]))
    months_by_year_by_country = months_by_year_by_country[months_by_year_by_country>0]

    yearly_averages = country_final_only %>% group_by(Country.or.Area, Year) %>% summarise( yearly_mean = mean(Value) )
    yearly_averages_c = rep(yearly_averages$yearly_mean, months_by_year_by_country )
    d_per_month_c = d_per_month[match(country_final_only[["Month"]],months)]
    
    number_of_years = length(yearly_averages$Year)
    yearly_mean_range = round(range(yearly_averages$yearly_mean))
    year_range = range(country_final_only$Year)
    
    subtitle_text = paste("Data from UN Demographic Statistics Database, including",number_of_years,"years from",year_range[1],"to",year_range[2])
    caption_text = paste("Averages range from", yearly_mean_range[1] ,"to",yearly_mean_range[2])
    
    line_color.dark = hsv(h = input$ptHue, s=0.81, v=0.25 )
    line_color.light = hsv(h = input$ptHue, s=0.85, v=0.95 )
    
    cgg = ggplot(country_final_only, aes(x=match(Month,months), 
                                         y=Value/yearly_averages_c*d_per_month_c, 
                                         group=interaction(Country.or.Area,Year) ) ) + 
      theme(axis.text.y=element_text(size=13),
            axis.title.y=element_text(size=16),
            legend.position=c(1,0.8),
            legend.justification = "right",
            legend.title = element_text(size=16),
            legend.key.size = unit(1, 'cm'),
            plot.title = element_text(size=25)) +
      coord_cartesian(xlim=c(1,12),ylim=c(0.75,1.25)) +
      scale_x_continuous(breaks=c(1:12), labels=months, minor_breaks = NULL) +
      scale_color_gradient(low=line_color.dark, high=line_color.light) +
      labs(x=NULL, y = "Births relative to monthly average of that year",
           title=input$chosenCountry, subtitle=subtitle_text,
           caption=caption_text) +
      geom_line(aes(colour=Year), alpha=0.3, size=3, lineend = "round")

    cgg
  })
  
  output$printUpPDF <- downloadHandler(
    filename = function() {"plot.pdf"},
    content = function(filename){
      gg = makeUserGGplot()
      ggsave(filename, gg, device="pdf", width=8, height=6)
    }
  )
  # cairo_pdf(filename = outputfilename, width=12, height=6, family="Arial Unicode MS"

  # make table of brushed points for whatever X and Y are selected
  # output$selectedPoints <- renderTable({
  #   d = getUserDataset()
  #   brushedPoints( d, input$plot_brush, xvar = input$x_select, yvar = input$y_select )
  # })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)

#