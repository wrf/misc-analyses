# natural resources and poverty
# data from
# Wackernagel et al (2021) Importance of Resource Security for Poverty Eradication
# https://www.nature.com/articles/s41893-021-00708-4
#
# created 2024-08-28

library(dplyr)

resource_data_file = "~/git/misc-analyses/land_usage/data/wackernagel2021_resource_poverty_main_table.txt"
resource_data = read.table(resource_data_file, header=TRUE, sep='\t', quote="", stringsAsFactors = FALSE )

resource_data.f = filter(resource_data, !is.na(Country_number) )

unique(resource_data$area)

region_colors = c("#99000088", "#f00b3788",
                  "#261f9288", "#4b9eed88", "#045aad88", "#19bac488", 
                  "#81048d88", "#d658e388",
                  "#8d890488", "#04ad1d88")
region_areas = c("North America", "Latin America and Caribbean",
                 "South Asia", "South-East Asia", "East Asia", "Oceania", 
                 "Western Europe", "Eastern Europe and Central Asia",
                 "Middle East and North Africa", "Sub-Saharan Africa")
region_colors.matched = region_colors[match(unique(resource_data.f$area),region_areas)]
region_matches = match( resource_data.f$area, unique(resource_data.f$area) )
region_matches

resource_data.f$Total.Biocapacity__gha.person

global_mean_gdp = 10380

pdf(file="~/git/misc-analyses/land_usage/image/wackernagel2021_resource_poverty_main_fig2log.pdf", 
    width=11, height=8, title="Importance of Resource Security for Poverty Eradication")
par(mar=c(4.5,4.5,2,2))
plot( resource_data.f$GDP__current.USD.per.capita , resource_data.f$Biocapacity.Reserve__gha.person ,
      type='n' , xlim=c(300, 120000), ylim=c(-12,9), log='x',
      cex.axis=1.3, cex.lab=1.4, axes=FALSE,
      xlab="GDP per capita (log current USD~2010)", ylab="Biocapacity reserve or deficit (gha per person)" )
axis(2, cex.axis=1.3)
axis(1, at=c(500,1000,5000,10000,50000,100000), labels=c("500$", "1k$", "5k$", "10k$", "50k$", "100k$"))
rect(100,-13, global_mean_gdp, 0, col="#f0000011", border = NA)
rect(global_mean_gdp,-13, 150000, 0, col="#80004011", border = NA)
rect(100, 0, global_mean_gdp, 10, col="#40800011", border = NA)
rect(global_mean_gdp, 0, 150000, 10, col="#00f00011", border = NA)
abline(h=0, lwd=3, col="#00000033")
abline(v=global_mean_gdp , lwd=3, col="#00000033")
points( resource_data.f$GDP__current.USD.per.capita , resource_data.f$Biocapacity.Reserve__gha.person ,
      pch=16, cex=log(resource_data.f$Population__thousands), col=region_colors.matched[region_matches] )
text( resource_data.f$GDP__current.USD.per.capita , resource_data.f$Biocapacity.Reserve__gha.person ,
      resource_data.f$country_code , cex=0.5 )
text(c(250,250,10500,10500), c(9,-12,9,-12), 
     c("Reserves, low GDP", "Deficit, low GDP", "Reserves, high GDP", "Deficit, high GDP"), pos=4 )
dev.off()



#####

footprint_data_file = "~/git/misc-analyses/land_usage/data/wackernagel2021_resource_poverty_income_footprint.txt"
footprint_data = read.table(footprint_data_file, header=TRUE, sep="\t")

bdf = data.frame(year= footprint_data$Year,
                 q1=footprint_data$Quadrant.1.HR.Population__thousands,
                 q2=footprint_data$Quadrant.2.LR.Population__thousands,
                 q4=footprint_data$Quadrant.4.HD.Population__thousands,
                 q3=footprint_data$Quadrant.3.LD.Population__thousands )

pdf(file="~/git/misc-analyses/land_usage/image/wackernagel2021_resource_poverty_main_fig3.pdf", 
    width=7, height=5, title="Importance of Resource Security for Poverty Eradication")
par(mar=c(4,5,2,0.8))
barplot(t(as.matrix(bdf)), col=c("#be3d3dff","#3dbe3dff","#a0c8a0ff","#b86990ff"),
        axes=FALSE , ylim=c(0,8.5e6), ylab="Population (billions)",
        names.arg = bdf$year, las=2 , space = 0 , cex.lab=1.4, cex.names=0.8 )
axis(2, at=c(0:8)*1e6, labels=c(0:8) )
rect(2,6e6, 5, 7e6, col="#be3d3dff", border = NA)
rect(5,6e6, 8, 7e6, col="#b86990ff", border = NA)
rect(2,7e6, 5, 8e6, col="#a0c8a0ff", border = NA)
rect(5,7e6, 8, 8e6, col="#3dbe3dff", border = NA)
text(c(3.5,6.5,3.5,6.5), c(6.5e6,6.5e6,7.5e6,7.5e6), 
     c("DL", "DH", "RL", "RH"), col="white")
arrows( rep(5,4), rep(7e6,4), c(5,1.5,5,8.5),
         c(5.8e6,7e6,8.2e6,7e6) , length = 0.05, lwd=2 )
text(1.5,7e6,"$", pos=2)
text(8.5,7e6,"$$$", pos=4)
dev.off()


#