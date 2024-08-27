# paradise paper replots
# created 2024-08-23
# data from
# https://offshoreleaks.icij.org/pages/database
# https://github.com/ICIJ/offshoreleaks-data-packages?tab=readme-ov-file
#
# interactive graphic at
# https://www.arcgis.com/apps/MapJournal/index.html?appid=1f611be658e74ad48f899d1d6152bdb4

library(ggplot2)
library(dplyr)

country_code_ISO = read.table("~/git/misc-analyses/happiness_index/data/country_codes_ISO3166.txt", header = TRUE, sep="\t", quote="")

#####

node_addresses_file = "~/git/misc-analyses/quality_of_life/data/nodes-addresses_GENERATED_ON_20240715.csv.gz"
node_addresses = read.csv(node_addresses_file)

names(node_addresses)
head(node_addresses)

leak_sources = as.data.frame(table(node_addresses$sourceID))
leak_sources$Var1 = recode(gsub("corporate ","",leak_sources$Var1), 
                           "Pandora Papers - Overseas Management Company (OMC)" = "Pandora Papers - OMC",
         "Pandora Papers - Alemán, Cordero, Galindo & Lee (Alcogal)" = "Pandora Papers - Alcogal",
         "Pandora Papers - Il Shin Corporate Consulting Limited" = "Pandora Papers - Il Shin",
         "Pandora Papers - Fidelity Corporate Services" = "Pandora Papers - Fidelity",
         "Pandora Papers - SFM Corporate Services" = "Pandora Papers - SFM" )
leak_sources

leak_colors = rep(c("#ac2f07aa", "#a48122aa", "#ee1144aa", "#ab5d13aa", "#0c6f51aa"), c(7,10,1,1,1) )

gg = ggplot(leak_sources, aes(x=Var1, y=Freq) ) + 
  coord_flip() +
  theme(axis.text.y=element_text(size=11, colour="#9999cc"),
        axis.text.x=element_text(size=10, colour="#9999cc"),
        axis.title.x=element_text(size=16, colour="#9999cc"),
        plot.title = element_text(size=18, colour="#9999cc"),
        plot.subtitle = element_text( colour="#9999cc"),
        plot.background = element_rect(fill = "#001030"),
        panel.background = element_rect(fill = "#001030"),
        panel.grid.major = element_line(color = '#222242', linewidth = 0.5),
        panel.grid.minor = element_line(color = '#222242', linewidth = 0.2) ) +
  geom_col( fill=rev(leak_colors), show.legend = FALSE) +
  labs(x=NULL, y="Number of corporate addresses",
       title="Sources of offshore financial documents",
       subtitle="Data from The International Consortium of Investigative Journalists 2024") +
  annotate(geom="text", y=leak_sources$Freq+6000, x=leak_sources$Var1, label=leak_sources$Freq, colour="#666686" )
gg
ggsave("~/git/misc-analyses/quality_of_life/images/paper_sources_and_counts.pdf", gg, width=8, height=6, title="Sources of offshore financial documents")


#####


table(node_addresses$sourceID)
f = filter(node_addresses, sourceID !="Paradise Papers - Malta corporate registry" )
f
names(node_addresses)

panama_addresses = filter(node_addresses, sourceID =="Panama Papers" )

address_counts = table(panama_addresses$country_codes)
sort(address_counts)

address_counts.d = arrange(as.data.frame(address_counts, stringsAsFactors = FALSE),desc(Freq))[20:1,] %>% mutate(row = row_number())
codes_to_names = country_code_ISO$ISO3166.name[match(names(panama_addresses.s),country_code_ISO$A.3)]

# barplot of top 20
ggb = ggplot(address_counts.d, aes(x=reorder(Var1, Freq, order=TRUE), y=Freq) ) +
  theme(plot.title = element_text(size=18, colour="#9999cc"),
        plot.subtitle = element_text(colour="#9999cc"),
        plot.caption = element_text(colour="#9999cc"),
        axis.text = element_text( size=12, colour="#9999cc" ),
        axis.title = element_text( size=12, colour="#9999cc" ),
        axis.ticks = element_line( colour="#9999cc" ),
        plot.background = element_rect(fill = "#001030"),
        panel.background = element_rect(fill = "#001030"),
        panel.grid.major = element_line(color = '#222242', linewidth = 0.5),
        panel.grid.minor = element_line(color = '#222242', linewidth = 0.2) ) +
  scale_y_continuous(expand=c(0.01,0.1,0.05,1) ) +
  scale_x_discrete( labels=codes_to_names[20:1] ) +
  labs(y="Number of registered addresses", x=NULL,
       title="Registered addresses from Panama Papers",
       subtitle="Including both sending or receiving addresses",
       caption="Data from The International Consortium of Investigative Journalists 2024" ) +
  geom_col( fill="#ee1144aa") + 
  coord_flip()
ggb
ggsave(file="~/git/misc-analyses/quality_of_life/images/paper_sources_top_20_countries.pdf", ggb, device="pdf", width=7, height=6, title="Number of registered addresses")


########################
# world map of addresses
worldpolygons = map_data("world")

country_middles = aggregate(cbind(long, lat) ~ region, data=worldpolygons, 
                    FUN=function(x)mean(range(x)) )
# add places not in higher level map
country_middles.m = rbind(country_middles, 
                          data.frame(region=c("Hong Kong", "United States Virgin Islands"),
                                     lat=c(22.3, 18.340333),
                                     long=c(114.2, -64.931102) ) 
                          )
# manually fix centroids, especially of long countries or those with islands
manual_middle_corrections = data.frame(region=c("New Zealand", "USA", "UK", "Australia", "Canada", 
                                             "Chile" , "Ecuador", 
                                             "Russia" , "Norway", 
                                             "Finland", "Sweden" , "Denmark" , 
                                             "South Africa",
                                             "Croatia", 
                                             "Malaysia", "Vietnam", "Indonesia"),
                                    long=c( 174.777222 , -77.016389, -0.1275 , 149.126944 , -75.695 , 
                                            -70.65 , -78.54224 ,
                                            37.617222 , 10.738889 ,
                                            23.76 , 17.644722 , 12.568333 , 
                                            28.045556, 
                                            15.9775 , 
                                            101.412484 , 105.85 , 107.6097 ),
                                    lat=c(-41.288889 , 38.904722 , 51.507222 , -35.293056 , 45.424722, 
                                          -33.4375 , 0.00 , 
                                          55.755833 , 59.913333 ,
                                          61.498056, 59.858056 , 55.676111 , 
                                          -26.204444,
                                          45.813056, 
                                          4.464488, 21.00, -6.912 ) )
match(manual_middle_corrections$region, country_middles.m$region)
country_middles.m[match(manual_middle_corrections$region, country_middles.m$region),] = manual_middle_corrections
# manually fix names to match ISO AT3
country_middles.m$region = recode(country_middles.m$region, 
                                "USA"="United States",
                                "UK"="United Kingdom",
                                "Ivory Coast"="Côte d'Ivoire",
                                "Trinidad"="Trinidad and Tobago",
                                "Republic of Congo"="Republic of the Congo",
                                "Swaziland"="Eswatini",
                                "Antigua"="Antigua and Barbuda",
                                "Curacao"="Curaçao",
                                "Cocos Islands"="Cocos (Keeling) Islands",
                                "Virgin Islands"="British Virgin Islands",
                                "Saint Kitts"="Saint Kitts and Nevis",
                                "Saint Vincent"="Saint Vincent and the Grenadines",
                                "South Georgia"="South Georgia and the South Sandwich Islands",
                                "Vatican"="Holy See")
country_code_ISO.r = rename(country_code_ISO, region=ISO3166.name )
country_middles.r = left_join(country_middles.m, country_code_ISO.r )
address_counts.d = data.frame("A.3"=names(address_counts),
                              counts = c(address_counts) )
country_middles.rc = left_join(country_middles.r, address_counts.d )

ggm = ggplot(worldpolygons, aes(x = long, y = lat) ) +
  coord_map(xlim=c(-170,170), ylim=c(-50, 65) ) +
  theme(plot.title = element_text(size=22, colour="#9999cc"),
        plot.subtitle = element_text(colour="#9999cc"),
        plot.caption = element_text(colour="#9999cc"),
        plot.background = element_rect(fill = "#001030"),
        panel.background = element_rect(fill = "#001030"),
        panel.grid.major = element_line(color = 'black'),
        legend.position=c(-170,0),
        axis.text = element_blank(),
        axis.ticks = element_blank() ) +
  labs(x=NULL, y=NULL, size=NULL,
       title="Registered addresses from Panama Papers",
       subtitle="Including both sending or receiving addresses",
       caption="Data from The International Consortium of Investigative Journalists 2024" ) +
  geom_polygon( aes(group = group), colour="#666686", fill="#222222") +
  scale_size_continuous(range = c(0.5, 12)) + 
  geom_point( data=country_middles.rc, aes(size=counts), colour="#ee114488" )
ggm
ggsave("~/git/misc-analyses/quality_of_life/images/paper_sources_map.panama_papers.pdf", ggm, device="pdf", width=17, height=9, title="Registered addresses from Panama Papers")

#####

node_entities_file = "~/git/misc-analyses/quality_of_life/data/nodes-entities_GENERATED_ON_20240715.csv.gz"
node_entities = read.csv(node_entities_file)

names(node_entities)
head(node_entities)


#####

node_intermediaries_file = "~/git/misc-analyses/quality_of_life/data/nodes-intermediaries_GENERATED_ON_20240715.csv.gz"
node_intermediaries = read.csv(node_intermediaries_file)
names(node_intermediaries)


sort(table(node_intermediaries$country_codes))

#####

node_officers_file = "~/git/misc-analyses/quality_of_life/data/nodes-officers_GENERATED_ON_20240715.csv.gz"
node_officers = read.csv(node_officers_file)
dim(node_officers)
names(node_officers)
head(node_officers)
rev(sort(table(node_officers$name)))[1:100]
table(node_officers$country_codes)
rev(sort(table(node_officers$country_codes)))[1:40]

node_others_file = "~/git/misc-analyses/quality_of_life/data/nodes-others_GENERATED_ON_20240715.csv.gz"
node_others = read.csv(node_others_file)

###

relation_data_file = "~/git/misc-analyses/quality_of_life/data/relationships_GENERATED_ON_20240715.csv.gz"
relation_data = read.csv(relation_data_file)
head(relation_data)

table(relation_data$rel_type)
#       connected_to          intermediary_of               officer_of probably_same_officer_as 
#              12145                   598546                  1720357                      132 
# registered_address          same_address_as                  same_as          same_company_as 
#             832721                        5                     4272                    15523 
#         same_id_as     same_intermediary_as             same_name_as                  similar 
#               3120                        4                   104170                    46761 
# similar_company_as               underlying 
#                203                     1308 

sort(table(relation_data$link), decreasing=TRUE)[1:21]
dim(relation_data)
f = filter(relation_data, link=="director of")
dim(f)
s = sort(table(f$node_id_start), decreasing=TRUE)


#             shareholder of          registered address             intermediary of 
#                     589938                      566910                      512797 
#                director of           registered office                secretary of 
#                     457922                      164290                      115652 
# judicial representative of                same name as     legal representative of 
#                     109526                      104170                       99181 
#        registered agent of similar name and address as      records & registers of 
#                      78737                       46761                       36318 
#                 auditor of   Ultimate Beneficial Owner         residential address 
#                      27242                       25876                       25317 
#       managing director of              beneficiary of                    owner of 
#                      23830                       23637                       20405 
#                   director           vice-president of               liquidator of 
#                      20339                       19678                       17365



#