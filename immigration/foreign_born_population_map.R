# fraction of each country that is foreign born, according to 2015 UN Immigration report
#

library(maps)

inputfile = "~/git/misc-analyses/immigration/foreign_born_population_by_country_UN2015_country_names_fixed.tab"
immigrant_data = read.table(inputfile, header=TRUE, sep="\t")

countries = immigrant_data[["country"]]
percent_foreign = immigrant_data[["percent_country"]]
rounded_percent = floor(percent_foreign)
rounded_percent[rounded_percent > 50] = 50
rounded_percent = rounded_percent + 1

latrange = c(-90,90)
lonrange = c(-180,180)
worldmap = map('world', ylim=latrange, xlim=lonrange)

colorset = colorRampPalette(c("#ffffbf", "#78c679", "#313695"))(51)
ncolor = length(colorset)

plot(1:ncolor,1:ncolor,pch=16,cex=5,col=colorset)

countrynums = match(countries, worldmap$names)

vecbycountry = rep("#dddddd", length(worldmap$names) )
for (ctry in countries){
	vecbycountry[grep(ctry,worldmap$names)] = colorset[ rounded_percent[ grep(ctry,countries)]]
}
vecbycountry[match("China:Hong Kong", worldmap$names)] = colorset[ rounded_percent[ grep("Hong Kong",countries) ]]


pdf(file="~/git/misc-analyses/immigration/2015_foreign_born_percentage.pdf", width=14, height=7)

worldmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
lines(c(-180,180),c(0,0),lwd=0.2,col="#00000022")
lines(c(0,0),c(-83,90),lwd=0.2,col="#00000022")

rect(-10,-77,130,-40,col="#ffffff")
# draw boxes for each bin
rect(seq(10,2*ncolor+8,2),rep(-65,ncolor), seq(12,2*ncolor+10,2) ,rep(-75,ncolor),col=colorset, border=FALSE)
# add labels
text(15,-60,"0%", cex=1.6)
text(65,-60,"25%", cex=1.6)
text(115,-60, ">50%" , cex=1.6)
text(60,-48,"2015 Percent Foreign Born", cex=2, font=2)
dev.off()














