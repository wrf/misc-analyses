# global olive oil production 1990 to 2017
# data from:
# http://www.internationaloliveoil.org/estaticos/view/131-world-olive-oil-figures

rawfilename = "~/git/misc-analyses/olive_v_butter/global_production_2018_INTERNATIONAL_OLIVE_OIL_COUNCIL.tab"

olivedata = read.table(rawfilename, header=TRUE, sep="\t", row.names=1)
olivedata
library(maps)

#olivedata[olivedata==0] = NA
#apply(olivedata, 1, function(x) mean(x,na.rm=TRUE))



avgproduction = apply(olivedata, 1, function(x) mean(x[x>0]) )
avg_noNA = avgproduction[!is.na(avgproduction)]

log_avg = floor( log(avg_noNA)+4 )
countries = names(log_avg)

latrange = c(17,52)
lonrange = c(-13,42)
medimap = map('world', ylim=latrange, xlim=lonrange)
colorset = c( colorRampPalette(c("#dddbd0","#9cc817"))(7), colorRampPalette(c("#9cc817","#3cb500"))(3) )
plot(1:10,1:10,pch=16,cex=5,col=colorset)

euronums = match(countries, medimap$names)
euronums
#euronums[32] = 57
euronum_noNA = euronums[!is.na(euronums)]
countries_noNA = countries[!is.na(euronums)]

countries_noNA

avg_noNA = log_avg[!is.na(euronums)]
avg_noNA
vecbycountry = rep("#dddddd", length(medimap$names) )
vecbycountry[euronum_noNA] = colorset[avg_noNA]
vecbycountry[euronum_noNA]
for (ctry in countries_noNA){
	vecbycountry[grep(ctry,medimap$names)] = colorset[avg_noNA[ grep(ctry,countries_noNA)]]
}


wc = world.cities

wcaps = wc[wc$capital==1,]
# Montenegro not included, because data are from 2006
# get data manually
mnc = c("Podgorica","Montenegro",1, 42.441286, 19.262892,1)

wcaps
citiesonly = wc[1:(dim(wc)[1]),1]
citiesonly

# extract capitals for relevant countries
capsonly = wcaps[match(c(countries_noNA), wcaps[1:(dim(wcaps)[1]),2],nomatch=FALSE),]
capsonly

# round up for average production
avgrounded = ceiling(avgproduction)
# filter for thosee on the map
avgrounded_noNA = avgrounded[countries_noNA][-match("Montenegro",names(avg_noNA))]

capslat = capsonly[["lat"]]
capslon = capsonly[["long"]]
# plot numbers on top of each capital
text(capslon, capslat, avgrounded_noNA, cex=1+log10(avgrounded_noNA) )


# basically does not work for displaying things other than names
# must extract lat long from wc list
# and then print numbers by country
#
#for (i in 1:length(countries_noNA) ){  map.cities(country=countries_noNA[i],capitals=1)  }
#

avg_cex = 0.25+log10(avgrounded_noNA)
avg_cex[avg_cex<0.75] = 0.75

pdf(file="~/git/misc-analyses/olive_v_butter/med_only_avg_production_1990-2018.pdf", width=9, height=7)

medimap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
text(capslon, capslat, avgrounded_noNA, cex=avg_cex )

dev.off()









#