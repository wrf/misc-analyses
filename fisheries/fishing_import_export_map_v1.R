# ratio of imports to exports of fisheries in europe
#
# data from
# www.fao.org/fishery/statistics/global-consumption/en
# http://www.fao.org/faostat/en/#data/FBS


#
library(maps)
library(maptools)
library(mapproj)
library(ggplot2)
library(leaflet)
#library(rgeos)
library(sp)


wmap = map("world", fill=TRUE, plot=FALSE)
summary(wmap)

wmapids <- sapply(strsplit(wmap$names, ":"), function(x) x[1])
wmap_poly <- map2SpatialPolygons(wmap, IDs=wmapids, proj4string=CRS("+proj=longlat +datum=WGS84"))
summary(wmap_poly)

m <- leaflet( options=leafletOptions( minZoom=2, maxZoom=8 ) ) %>%
    setView(lng=0, lat=35, zoom=4) %>% 
    addTiles() #%>%
    #addPolygons(data=worldpolygons, lon=long, lat=lat )
    #addPolygons(lng=long, lat=lat, fillColor = topo.colors(10, alpha = NULL), stroke = FALSE, group=group)
    #addPolygons( data=worldpolygons, lng=long, lat=lat, fillColor = topo.colors(10, alpha = NULL), stroke = FALSE, group=group)
m

fishdatafile = "~/git/misc-analyses/fisheries/data/FoodBalanceSheets_E_summary_only_renamed.tab"
# units in 1000 tonnes
# 1000 tonnes = 1 Gg = 1000000 kg
fishdata = read.table(fishdatafile, header=TRUE, sep="\t")
summary(fishdata)

worldpolygons = map_data("world")
head(worldpolygons)
class(worldpolygons)
unique(worldpolygons$region)

worldpolygons_w_fish = left_join(worldpolygons, fishdata, by="region")

importgg = ggplot(worldpolygons_w_fish, aes(long,lat, group=group)) +
    coord_map(xlim=c(-180,180), ylim=c(-54, 66) ) +
    theme(plot.title = element_text(size=20),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position=c(0,0.5),
          legend.justification = "left") +
    scale_fill_gradientn(colours = colorRampPalette(c("#b0e6cd","#063e6f"))(7), 
                         breaks = c(0, 1, 10, 100, 1000, 10000),
                         na.value="gray70", trans = "log10") +
    labs(x=NULL, y=NULL, fill="Fish Imports\nall categories\n(M kg)",
         title="2017 global imports of all seafood",
         subtitle="includes: pelagic fish, demersal fish, freshwater fish, crustaceans, cephalopods, and other molluscs",
         caption="Data from UN Food and Agriculture Organization (FAO) 2017\nwww.fao.org/fishery/statistics/global-consumption/en") +
    geom_polygon( aes(x=long, y = lat, group = group, fill=imports_2017), colour="#ffffff")
importgg
ggsave("~/git/misc-analyses/fisheries/images/global_fish_imports_only_2017.pdf", importgg, device="pdf", width=11, height=6)

country_name = fishdata[["country"]]
prod_expt = fishdata[["production_2017"]] + fishdata[["exports_2017"]]
imports = fishdata[["imports_2017"]]

import_vs_prod_ratio = imports / prod_expt
import_vs_prod_ratio[import_vs_prod_ratio==Inf] = 50
import_vs_prod_ratio[import_vs_prod_ratio==0] = 0.002

import_vs_prod_ratio

log_import_vs_prod_ratio = log10(import_vs_prod_ratio)
log_import_vs_prod_ratio
log_import_vs_prod_ratio_adj = (log_import_vs_prod_ratio + 3) * 5
log_import_vs_prod_ratio_adj
hist( log_import_vs_prod_ratio_adj, breaks=19)


fishdatafile = "~/git/misc-analyses/fisheries/data/FoodBalanceSheets_E_reformat_all_fish.tab"
fishdata = read.table(fishdatafile, header=TRUE, sep="\t")

fishdata_recode = recode(fishdata$region,
                         "Cote d'Ivoire" = "Ivory Coast",
                         "United Kingdom" = "UK" )

net_fish_as_food = fishdata$production_2017_Gg + fishdata$imports_2017_Gg -
                   fishdata$exports_2017_Gg - fishdata$feed_2017_Gg

worldpolygons_w_fish = left_join(worldpolygons, fishdata, by="region")

ggplot(worldpolygons_w_fish, aes(long,lat, group=group)) +
    coord_map(xlim=c(-180,180), ylim=c(-54, 66) ) +
    theme(plot.title = element_text(size=20),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position=c(0,0.5),
          legend.justification = "left") +
    scale_fill_gradientn(colours = colorRampPalette(c("#b0e6cd","#063e6f"))(7), 
                         breaks = c(0, 1, 10, 100, 1000, 10000),
                         na.value="gray70", trans = "log10") +
    labs(x=NULL, y=NULL, fill="Fish Imports\nall categories\n(M kg)",
         title="2017 global imports of all seafood",
         subtitle="includes: pelagic fish, demersal fish, freshwater fish, crustaceans, cephalopods, and other molluscs",
         caption="Data from UN Food and Agriculture Organization (FAO) 2017\nwww.fao.org/fishery/statistics/global-consumption/en") +
    geom_polygon( aes(x=long, y = lat, group = group, fill=imports_2017), colour="#ffffff")
importgg







latrange = c(-90,90)
lonrange = c(-180,180)
worldmap = map('world', ylim=latrange, xlim=lonrange)
colorset = colorRampPalette(c("#253494", "#6baed6", "#ffeda0", "#fc4e2a"))(25)
ncolor = length(colorset)

plot(1:ncolor,1:ncolor,pch=16,cex=5,col=colorset)

countrynums = match(country_name, worldmap$names)
countrynums

vecbycountry = rep("#555555", length(worldmap$names) )
for (ctry in country_name){
	vecbycountry[grep(ctry,worldmap$names)] = colorset[log_import_vs_prod_ratio_adj[ grep(ctry,country_name)]]
}
vecbycountry


longaxis = c(-180,-135,-90,-45,0,45,90,135,180)

# finally generate pdf map

pdf(file="~/git/misc-analyses/fisheries/images/2017_fish_imports_vs_production.pdf", width=14, height=7)

worldmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
lines(c(-180,180),c(0,0),lwd=0.2,col="#00000022")
lines(c(0,0),c(-83,90),lwd=0.2,col="#00000022")
# legend box
rect(-9,-77,133,-40,col="#ffffff")
# draw boxes for each bin
rect(seq(0, (ncolor-1)*5 ,5),rep(-65,ncolor), seq(5,5+(ncolor-1)*5,5) ,rep(-75,ncolor),col=colorset, border=FALSE)
# add labels
text(22,-60,"100+", cex=1.6)
text(47,-60,"10/1", cex=1.6)
text(72,-60,"1/1", cex=1.6)
text(97,-60, "1/10" , cex=1.6)
text(62,-48,"2017 Seafood Production vs Imports", cex=1.6, font=2)
mtext("Seafood from UN FAO 2017 Food Balance",side=1)
axis(3, at=longaxis, pos=87)

dev.off()





consumption = fishdata[["production_2017"]] + fishdata[["imports_2017"]]
log_consumption_adj = ceiling( log10(consumption) + 0.5 )

range( log10(consumption) )


colorset = colorRampPalette(c("#eff3ff", "#08519c"))(6)
vecbycountry = rep("#555555", length(worldmap$names) )
for (ctry in country_name){
	vecbycountry[grep(ctry,worldmap$names)] = colorset[log_consumption_adj[ grep(ctry,country_name)]]
}

worldmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
lines(c(-180,180),c(0,0),lwd=0.2,col="#00000022")
lines(c(0,0),c(-83,90),lwd=0.2,col="#00000022")


