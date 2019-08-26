# tourism vs population v1 created 2019-08-26
# data from:
# https://www.e-unwto.org/doi/pdf/10.18111/9789284419876
#
library(maps)


tourdatafile = "~/git/misc-analyses/tourism/2017_2016_arrivals_by_country.tab"

tourdata = read.table(tourdatafile, header=TRUE, sep="\t", row.names=1)
tourdata

# fix values where 2017 data was not present, but 2016 was, so use 2016
tours2017 = tourdata[["X2017"]]
nulltours2017 = which(tours2017==0)
tours2017[nulltours2017] = tourdata[["X2016"]][nulltours2017]
tours2017

tours2017_raw = tours2017 * 1000000

popdatafile = "~/git/misc-analyses/tourism/2016_population_by_country.tab"
popdata = read.table(popdatafile, header=TRUE, sep="\t", row.names=1)
popdata

tours_to_pops = match( row.names(tourdata), row.names(popdata) )
tours_to_pops

tvp2017 = tours2017_raw / popdata[tours_to_pops,1]
#tvp2017
cbind(tvp2017, row.names(tourdata))


# few outliers make highly variable
range(tvp2017)
# log range appears better
range(log10(tvp2017))
# reassign high and low values
tvp2017[tvp2017>10]=10
tvp2017[tvp2017<0.01]=0.01

tvp2017_log = log10(tvp2017)
tvp2017_log
#hist(tvp2017_log,breaks=14)
tvp2017_adj = round((tvp2017_log*3)+7)
tvp2017_adj

countries = row.names(tourdata)

latrange = c(-90,90)
lonrange = c(-180,180)
worldmap = map('world', ylim=latrange, xlim=lonrange)
colorset = colorRampPalette(c("#7fbc41", "#e6f5d0", "#d6604d", "#762a83"))(10)

plot(1:11,1:11,pch=16,cex=5,col=colorset)

countrynums = match(countries, worldmap$names)

vecbycountry = rep("#dddddd", length(worldmap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,worldmap$names)] = colorset[tvp2017_adj[ grep(ctry,countries)]]
}
vecbycountry


# finally generate pdf map

pdf(file="~/git/misc-analyses/tourism/2017_2016_annual_tourism_by_countries.pdf", width=14, height=7)

worldmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
# legend box
rect(-10,-77,130,-40,col="#ffffff")
# draw boxes for each bin
rect(seq(10, length(colorset)*10 ,10),rep(-65,length(colorset)), seq(20,10+length(colorset)*10,10) ,rep(-75,length(colorset)),col=colorset)
# add labels
text(15,-60,"1/100", cex=1.6)
text(45,-60,"1/10", cex=1.6)
text(75,-60,"1/1", cex=1.6)
text(105,-60, "10/1" , cex=1.6)
text(60,-48,"2017 Annual Tourists:Locals", cex=2, font=2)
mtext("Tourism data from UNWTO 2018 Tourism Highlights\nPopulation data from World Population Clock 2017",side=1)

dev.off()


#