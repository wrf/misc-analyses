# plot of birth rate by month
#
# data from UNData
# https://data.un.org/Default.aspx
# found at
# UNData Live births by month of birth
# https://data.un.org/Data.aspx?d=POP&f=tableCode:55
#
#

library(ggplot2)
library(dplyr)
library(gridExtra)

# read data here
birthrate_file = "~/git/misc-analyses/birth_rate_by_month/data/UNdata_Export_20210419_155726210.txt"
birthdata = read.table(birthrate_file, header=TRUE, sep=";", stringsAsFactors = FALSE)

summary(birthdata)

# months in order, to keep numerical order
months = c("January", "February", "March", "April", "May", "June",
           "July", "August", "September", "October", "November", "December")
# adjusted number of days per month
d_per_month = (365/12) / c(31,28,31,30,31,30,31,31,30,31,30,31)


#
# big loop to make plots for all countries
country_list = unique(birthdata[["Country.or.Area"]])
#
i = 0
plot_list = list()
mo_yr_country_list = list()
for (country in country_list){
    i = i+1
    country_final_only = filter(birthdata, Reliability == "Final figure, complete",
                             Month %in% months,
                             Country.or.Area==country) %>%
        select( Country.or.Area, Month, Year, Value ) %>%
        arrange(Country.or.Area, Year, match(Month,months))
    months_by_year_by_country = c(table(country_final_only[["Year"]],country_final_only[["Country.or.Area"]]))
    months_by_year_by_country = months_by_year_by_country[months_by_year_by_country>0]
    #mo_yr_country_list[[i]] = months_by_year_by_country
    yearly_averages = country_final_only %>% group_by(Country.or.Area, Year) %>% summarise( yearly_mean = mean(Value) )
    yearly_averages_c = rep(yearly_averages$yearly_mean, months_by_year_by_country )
    d_per_month_c = d_per_month[match(country_final_only[["Month"]],months)]
    
    number_of_years = length(yearly_averages$Year)
    yearly_mean_range = round(range(yearly_averages$yearly_mean))
    year_range = range(country_final_only$Year)
    subtitle_text = paste("Data from UN Demographic Statistics Database, including",number_of_years,"years from",year_range[1],"to",year_range[2])
    #subtitle_text = paste(number_of_years, "years from",year_range[1],"to",year_range[2])
    caption_text = paste("Averages range from", yearly_mean_range[1] ,"to",yearly_mean_range[2])
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
        scale_color_gradient(low="#00220b", high="#66e284") +
        labs(x=NULL, y = "Births relative to monthly average of that year",
             title=country, subtitle=subtitle_text,
             caption=caption_text) +
        geom_line(aes(colour=Year), alpha=0.3, size=3, lineend = "round")
    country_w_underscores = gsub(" ","_",country)
    if (yearly_mean_range[2] > 100) {
        plot_list[[i]] = cgg
        outputfilename = paste0("~/git/misc-analyses/birth_rate_by_month/countries/", country_w_underscores, ".UNdata_20210419.pdf")
        ggsave(outputfilename, cgg, device="pdf", width=8, height=6)
    }
} # end for loop

#pdf("~/git/misc-analyses/birth_rate_by_month/all_countries_tiled.UNdata_20210419.pdf", paper="a4", width=8, height=10)
#for (i in seq(1, length(plot_list), 6)) {
#    grid.arrange(grobs=plot_list[i:(i+5)], ncol=2)
#}
#dev.off()



# vector of countries by region, arbitrarily
is_M_europe = c("Germany", "Austria")

# begin analysis
#
# for Austria and Germany
ATDE_final_only = filter(birthdata, Reliability == "Final figure, complete",
                                 Month %in% months,
                                 Country.or.Area %in% is_M_europe) %>%
                      select( Country.or.Area, Month, Year, Value ) %>%
                      arrange(Country.or.Area, Year, match(Month,months))
#ATDE_final_only
#table(ATDE_final_only[["Year"]],ATDE_final_only[["Country.or.Area"]])

months_by_year_by_country = c(table(ATDE_final_only[["Year"]],ATDE_final_only[["Country.or.Area"]]))
months_by_year_by_country = months_by_year_by_country[months_by_year_by_country>0]

#table(table(ATDE_final_only[["Country.or.Area"]],ATDE_final_only[["Year"]]))
#sum(table(ATDE_final_only[["Country.or.Area"]],ATDE_final_only[["Year"]]))
#
#table(ATDE_final_only[["Year"]])
#sum(table(ATDE_final_only[["Year"]]))
#head(ATDE_final_only)

yearly_averages = ATDE_final_only %>% group_by(Country.or.Area, Year) %>% summarise( yearly_mean = mean(Value) )
yearly_averages_c = rep(yearly_averages$yearly_mean, months_by_year_by_country )
d_per_month_c = d_per_month[match(ATDE_final_only[["Month"]],months)]

atdegg = ggplot(ATDE_final_only, aes(x=match(Month,months), 
                                y=Value/yearly_averages_c*d_per_month_c, 
                                group=interaction(Country.or.Area,Year) ) ) + 
    theme(axis.text.y=element_text(size=13),
          axis.title.y=element_text(size=16),
          legend.position=c(0.25,0.15),
          legend.title = element_text(size=14),
          legend.key.size = unit(1, 'cm')) +
    coord_cartesian(xlim=c(1,12),ylim=c(0.8,1.2)) +
    scale_x_continuous(breaks=c(1:12), labels=months, minor_breaks = NULL) +
    labs(caption="Data from UN Demographic Statistics Database, using data on AT and DE from 1973 to 2018",
         x=NULL, y = "Births relative to monthly average of that year",
         color = "Country") +
    scale_color_manual(values=c("#b10026", "#fec44f")) +
    geom_line(aes(colour=Country.or.Area), alpha=0.3, size=3, lineend = "round") +
    guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    annotate( geom="text", x=10, y=1.18, label="Oktoberfest", fontface="bold" ) +
    annotate( geom="text", x=7, y=1.19, label="9 months\nafter Oktoberfest", fontface="bold" ) +
    annotate( geom="segment", x=10,y=1.15, xend=10, yend = 1.12, arrow = arrow(length = unit(3, "mm")) ) +
    annotate( geom="segment", x=7,y=1.17, xend=7, yend = 1.14, arrow = arrow(length = unit(3, "mm")) )
atdegg

ggsave("~/git/misc-analyses/birth_rate_by_month/images/UNdata_Export_20210419_AT_plus_DE.pdf", atdegg, device="pdf", width=8, height=6)

#
# for Sweden, Norway, and Finland
is_N_europe = c("Sweden", "Norway", "Finland")

SENOFI_final_only = filter(birthdata, Reliability == "Final figure, complete",
                             Month %in% months,
                             Country.or.Area %in% is_N_europe) %>%
    select( Country.or.Area, Month, Year, Value ) %>%
    arrange(Country.or.Area, Year, match(Month,months))

months_by_year_by_country = c(table(SENOFI_final_only[["Year"]],SENOFI_final_only[["Country.or.Area"]]))
months_by_year_by_country = months_by_year_by_country[months_by_year_by_country>0]

yearly_averages = SENOFI_final_only %>% group_by(Country.or.Area, Year) %>% summarise( yearly_mean = mean(Value) )
yearly_averages_c = rep(yearly_averages$yearly_mean, months_by_year_by_country )
d_per_month_c = rep(d_per_month, length(months_by_year_by_country) )

senofigg = ggplot(SENOFI_final_only, aes(x=match(Month,months), 
                                     y=Value/yearly_averages_c*d_per_month_c, 
                                     group=interaction(Country.or.Area,Year) ) ) + 
    theme(axis.text.y=element_text(size=13),
          axis.title.y=element_text(size=16),
          legend.position=c(0.25,0.17),
          legend.title = element_text(size=14),
          legend.key.size = unit(1, 'cm')) +
    coord_cartesian(xlim=c(1,12),ylim=c(0.75,1.25)) +
    scale_x_continuous(breaks=c(1:12), labels=months, minor_breaks = NULL) +
    labs(x=NULL, y = "Births relative to monthly average of that year",
         caption="Data from UN Demographic Statistics Database, using data for Norway, Sweden, and Finland from 1971 to 2018",
         color = "Country") +
    scale_color_manual(values=c("#3690c0", "#99000d", "#fec44f" )) +
    geom_line(aes(colour=Country.or.Area), alpha=0.3, size=3, lineend = "round") +
    guides(colour = guide_legend(override.aes = list(alpha = 1)))
senofigg
ggsave("~/git/misc-analyses/birth_rate_by_month/images/UNdata_Export_20210419_SE_NO_FI.pdf", senofigg, device="pdf", width=8, height=6)


#summary(SENOFI_final_only)
# plot by year, rather than country
scandyeargg = ggplot(SENOFI_final_only, aes(x=match(Month,months), 
                                y=Value/yearly_averages_c*d_per_month_c, 
                                group=interaction(Country.or.Area,Year) ) ) + 
    theme(axis.text.y=element_text(size=13),
          axis.title.y=element_text(size=16),
          legend.position=c(1,0.8),
          legend.justification = "right",
          legend.title = element_text(size=16),
          legend.key.size = unit(1, 'cm')) +
    coord_cartesian(xlim=c(1,12),ylim=c(0.8,1.25)) +
    scale_x_continuous(breaks=c(1:12), labels=months, minor_breaks = NULL) +
    scale_color_gradient(low="#00220b", high="#66e284") +
    labs(x=NULL, y = "Births relative to monthly average of that year",
         title="Norway, Sweden, and Finland",
         caption="Data from UN Demographic Statistics Database, using data for Norway, Sweden, and Finland from 1971 to 2018") +
    geom_line(aes(colour=Year), alpha=0.3, size=3, lineend = "round")
scandyeargg
ggsave("~/git/misc-analyses/birth_rate_by_month/images/UNdata_Export_20210419_scand_by_year.pdf", scandyeargg, device="pdf", width=8, height=6)


#
# for Mediterranean europe
#is_S_europe = c("Spain", "Italy", "Greece", "Croatia")
is_S_europe = c("Spain", "Italy" )

GRITSP_final_only = filter(birthdata, Reliability == "Final figure, complete",
                           Month %in% months,
                           Country.or.Area %in% is_S_europe) %>%
    select( Country.or.Area, Month, Year, Value ) %>%
    arrange(Country.or.Area, Year, match(Month,months))

months_by_year_by_country = c(table(GRITSP_final_only[["Year"]],GRITSP_final_only[["Country.or.Area"]]))
months_by_year_by_country = months_by_year_by_country[months_by_year_by_country>0]
yearly_averages = GRITSP_final_only %>% group_by(Country.or.Area, Year) %>% summarise( yearly_mean = mean(Value) )
yearly_averages_c = rep(yearly_averages$yearly_mean, months_by_year_by_country )
d_per_month_c = d_per_month[match(GRITSP_final_only[["Month"]],months)]

gritspgg = ggplot(GRITSP_final_only, aes(x=match(Month,months), 
                                         y=Value/yearly_averages_c*d_per_month_c, 
                                         group=interaction(Country.or.Area,Year) ) ) + 
    theme(axis.text.y=element_text(size=13),
          axis.title.y=element_text(size=16),
          legend.position=c(0.65,0.17),
          legend.title = element_text(size=14),
          legend.key.size = unit(1, 'cm')) +
    coord_cartesian(xlim=c(1,12),ylim=c(0.75,1.25)) +
    scale_x_continuous(breaks=c(1:12), labels=months, minor_breaks = NULL) +
    labs(x=NULL, y = "Births relative to monthly average of that year",
         caption="Data from UN Demographic Statistics Database, using data for Spain, Italy, Croatia and Greece from 1970 to 2018",
         color = "Country") +
#    scale_color_manual(values=c("#cb181d", "#08519c", "#006d2c", "#ffcf3d" )) +
    scale_color_manual(values=c("#006d2c", "#ffcf3d" )) +
    geom_line(aes(colour=Country.or.Area), alpha=0.3, size=3, lineend = "round") +
    guides(colour = guide_legend(override.aes = list(alpha = 1)))
gritspgg
ggsave("~/git/misc-analyses/birth_rate_by_month/images/UNdata_Export_20210419_medeurope.pdf", gritspgg, device="pdf", width=8, height=6)

#


#