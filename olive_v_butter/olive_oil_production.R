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
vecbycountry = rep("#dddddd", length(euromap$names) )
vecbycountry[euronum_noNA] = colorset[avg_noNA]
vecbycountry[euronum_noNA]
for (ctry in countries_noNA){
	vecbycountry[grep(ctry,euromap$names)] = colorset[avg_noNA[ grep(ctry,countries_noNA)]]
} 

pdf(file="~/git/misc-analyses/olive_v_butter/med_only_avg_production_1990-2018.pdf", width=9, height=7)

medimap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))

dev.off()















#