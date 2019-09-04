# tourism vs population v1 created 2019-08-26
# data from:
# https://www.e-unwto.org/doi/pdf/10.18111/9789284419876
# data for 2018 from:
# https://www.e-unwto.org/doi/book/10.18111/9789284421152
#
library(maps)


#tourdatafile = "~/git/misc-analyses/tourism/2017_2016_arrivals_by_country.tab"
tourdatafile = "~/git/misc-analyses/tourism/2018_arrivals_by_country.tab"

tourdata = read.table(tourdatafile, header=TRUE, sep="\t", row.names=1)
tourdata

# fix values where 2018 data was not present, try 2017, then 2016
tours2018 = tourdata[["X2018"]]
nulltours2018 = which(tours2018==0)
tours2018[nulltours2018] = tourdata[["X2017"]][nulltours2018]
nulltours2017 = which(tours2018==0)
tours2018[nulltours2017] = tourdata[["X2016"]][nulltours2017]
tours2018_raw = tours2018 * 1000000

#tours2017 = tourdata[["X2017"]]
#nulltours2017 = which(tours2017==0)
#tours2017[nulltours2017] = tourdata[["X2016"]][nulltours2017]
#tours2017

#tours2017_raw = tours2017 * 1000000

# https://www.worldometers.info/world-population/population-by-country/
popdatafile = "~/git/misc-analyses/tourism/2018_population_by_country.tab"
popdata = read.table(popdatafile, header=TRUE, sep="\t", row.names=1)
popdata

tours_to_pops = match( row.names(tourdata), row.names(popdata) )
tours_to_pops

cbind( paste( round(tours2018_raw/1000000,digits=1),  round(popdata[tours_to_pops,1]/1000000,digits=1), sep="/"), row.names(tourdata) )

tvp2018 = tours2018_raw / popdata[tours_to_pops,1]
#tvp2017
cbind(tvp2018, row.names(tourdata))


# few outliers make highly variable
range(tvp2018)
# log range appears better
range(log10(tvp2018))
# reassign high and low values
tvp2018[tvp2018>10]=10
tvp2018[tvp2018<0.01]=0.01

tvp2018_log = log10(tvp2018)
tvp2018_log
#hist(tvp2018_log,breaks=14)
tvp2018_adj = round((tvp2018_log*6)+13)
tvp2018_adj

countries = row.names(tourdata)

latrange = c(-90,90)
lonrange = c(-180,180)
worldmap = map('world', ylim=latrange, xlim=lonrange)
colorset = colorRampPalette(c("#7fbc41", "#e6f5d0", "#d6604d", "#762a83"))(19)
ncolor = length(colorset)

plot(1:ncolor,1:ncolor,pch=16,cex=5,col=colorset)

countrynums = match(countries, worldmap$names)

vecbycountry = rep("#dddddd", length(worldmap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,worldmap$names)] = colorset[tvp2018_adj[ grep(ctry,countries)]]
}
vecbycountry

longaxis = c(-180,-135,-90,-45,0,45,90,135,180)

# finally generate pdf map

pdf(file="~/git/misc-analyses/tourism/2018_annual_tourism_by_countries.pdf", width=14, height=7)

worldmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
lines(c(-180,180),c(0,0),lwd=0.2,col="#00000022")
lines(c(0,0),c(-83,90),lwd=0.2,col="#00000022")
# legend box
rect(-10,-77,130,-40,col="#ffffff")
# draw boxes for each bin
rect(seq(10, (ncolor+1)*5 ,5),rep(-65,ncolor), seq(15,5+(ncolor+1)*5,5) ,rep(-75,ncolor),col=colorset, border=FALSE)
# add labels
text(15,-60,"1/100", cex=1.6)
text(45,-60,"1/10", cex=1.6)
text(75,-60,"1/1", cex=1.6)
text(105,-60, "10/1" , cex=1.6)
text(60,-48,"2018 Annual Tourists:Locals", cex=2, font=2)
mtext("Tourism data from UNWTO 2019 Tourism Highlights\nPopulation data from World Population Clock 2019",side=1)
axis(3, at=longaxis, pos=87)

dev.off()

#
#
#
# currently only for 2017 data
# make zoom in map of europe

latrange = c(22,62)
lonrange = c(-9,56)
euromap = map('world', ylim=latrange, xlim=lonrange)
colorset = colorRampPalette(c("#7fbc41", "#e6f5d0", "#d6604d", "#762a83"))(19)
ncolor = length(colorset)

plot(1:ncolor,1:ncolor,pch=16,cex=5,col=colorset)

countrynums = match(countries, euromap$names)

vecbycountry = rep("#dddddd", length(euromap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,euromap$names)] = colorset[tvp2017_adj[ grep(ctry,countries)]]
}
pdf(file="~/git/misc-analyses/tourism/2017_2016_annual_tourism_europe_only.pdf",  width=9, height=7)
euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,0.6,1,0.6))
rect(0,22,44,28.5,col="#ffffff")
rect(seq(2, (ncolor)*2 ,2)+1,rep(23,ncolor), seq(2, (ncolor)*2, 2)+3 ,rep(25,ncolor),col=colorset, border=FALSE)
text(4, 25.5,"1/100", cex=1)
text(16, 25.5,"1/10", cex=1)
text(28, 25.5,"1/1", cex=1)
text(40, 25.5, "10/1" , cex=1)
text(22, 27,"2017 Annual Tourists:Locals", cex=2, font=2)
mtext("Tourism data from UNWTO 2018 Tourism Highlights   Population data from World Population Clock 2017",side=1)


dev.off()




latrange = c(10,46)
lonrange = c(21,69)
mideastmap = map('world', ylim=latrange, xlim=lonrange)
colorset = colorRampPalette(c("#7fbc41", "#e6f5d0", "#d6604d", "#762a83"))(19)
ncolor = length(colorset)
vecbycountry = rep("#dddddd", length(mideastmap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,mideastmap$names)] = colorset[tvp2017_adj[ grep(ctry,countries)]]
}
pdf(file="~/git/misc-analyses/tourism/2017_2016_annual_tourism_mideast_only.pdf",  width=9, height=7)
mideastmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,0.6,1,0.6))
map.cities(capitals=1,pch=13, lwd=1.5, col="#888888")
rect(37,10,69,15,col="#ffffff")
blksz = 1.5
blk_latst = 37.25
blk_lonst = 11
blk_lonen = 13
rect(seq(blksz, (ncolor)*blksz ,blksz )+blk_latst, rep(blk_lonst,ncolor), seq(blksz, (ncolor)*blksz, blksz)+blk_latst+blksz,rep(blk_lonen,ncolor), col=colorset, border=FALSE)
text(blksz*1.5 + blk_latst, blk_lonen+1,"1/100", cex=1)
text(blksz*7.5 + blk_latst, blk_lonen+1,"1/10", cex=1)
text(blksz*13.5 + blk_latst, blk_lonen+1,"1/1", cex=1)
text(blksz*19.5 + blk_latst, blk_lonen+1, "10/1" , cex=1)
#text(22, -22,"2017 Annual Tourists:Locals", cex=2, font=2)
mtext("Tourism data from UNWTO 2018 Tourism Highlights   Population data from World Population Clock 2017",side=1)
dev.off()



latrange = c(22,62)
lonrange = c(-9,56)
asiamap = map('world', ylim=latrange, xlim=lonrange)
colorset = colorRampPalette(c("#7fbc41", "#e6f5d0", "#d6604d", "#762a83"))(19)
ncolor = length(colorset)
vecbycountry = rep("#dddddd", length(asiamap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,asiamap$names)] = colorset[tvp2017_adj[ grep(ctry,countries)]]
}
pdf(file="~/git/misc-analyses/tourism/2017_2016_annual_tourism_SEasia_only.pdf",  width=9, height=7)
asiamap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,0.6,1,0.6))
rect(37,10,69,15,col="#ffffff")
blksz = 1.5
blk_latst = 37.25
blk_lonst = 11
blk_lonen = 13
rect(seq(blksz, (ncolor)*blksz ,blksz )+blk_latst, rep(blk_lonst,ncolor), seq(blksz, (ncolor)*blksz, blksz)+blk_latst+blksz,rep(blk_lonen,ncolor), col=colorset, border=FALSE)
text(blksz*1.5 + blk_latst, blk_lonen+1,"1/100", cex=1)
text(blksz*7.5 + blk_latst, blk_lonen+1,"1/10", cex=1)
text(blksz*13.5 + blk_latst, blk_lonen+1,"1/1", cex=1)
text(blksz*19.5 + blk_latst, blk_lonen+1, "10/1" , cex=1)
text(22, -22,"2017 Annual Tourists:Locals", cex=2, font=2)
mtext("Tourism data from UNWTO 2018 Tourism Highlights   Population data from World Population Clock 2017",side=1)
dev.off()



colorset = colorRampPalette(c("#7f41bc", "#e6d0f5", "#d6604d", "#363610"))(19)
ncolor = length(colorset)
vecbycountry = rep("#dddddd", length(euromap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,euromap$names)] = colorset[tvp2017_adj[ grep(ctry,countries)]]
}
pdf(file="~/git/misc-analyses/tourism/2017_2016_annual_tourism_europe_only_blue.pdf",  width=9, height=7)
euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,0.6,1,0.6))
rect(0,22,44,28.5,col="#ffffff")
rect(seq(2, (ncolor)*2 ,2)+1,rep(23,ncolor), seq(2, (ncolor)*2, 2)+3 ,rep(25,ncolor),col=colorset, border=FALSE)
text(4, 25.5,"1/100", cex=1)
text(16, 25.5,"1/10", cex=1)
text(28, 25.5,"1/1", cex=1)
text(40, 25.5, "10/1" , cex=1)
text(22, 27,"2017 Annual Tourists:Locals", cex=2, font=2)
mtext("Tourism data from UNWTO 2018 Tourism Highlights   Population data from World Population Clock 2017",side=1)
dev.off()


#