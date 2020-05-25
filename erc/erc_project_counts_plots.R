# plot ERC grant success as color coded map
# one map for each Starting Grants, Consolidator, and Advanced
# data from:
# https://erc.europa.eu/projects-figures/statistics

library(stats)

stg_eval = read.table("~/git/misc-analyses/erc/erc_2019_StG_evaluated_projects_all_panels.tab",header=TRUE,sep="\t",row.names=1)
stg_grant = read.table("~/git/misc-analyses/erc/erc_2019_StG_granted_projects_all_panels.tab",header=TRUE,sep="\t",row.names=1)

stg_eval
stg_grant
stg_N_countries = dim(stg_grant)[1]
stg_N_yrs = dim(stg_eval)[2]
stg_N_countries
stg_N_yrs


stg_granted_countries = match( row.names(stg_grant), row.names(stg_eval))
stg_granted_countries

stg_eval_sums = rev(colSums(stg_eval[,]))
stg_grant_sums = rev(colSums(stg_grant[,]))
stg_eval_sums

country_cols = rainbow(stg_N_countries)
plot(stg_grant_sums/stg_eval_sums, type='l', ylim=c(0,1), frame.plot=FALSE, axes=FALSE, ylab="Granted projects", xlab="Year", cex.lab=1.4, lwd=3)
axis(2, cex.axis=1.3)
axis(1,at=1:stg_N_yrs, label=rev(names(stg_grant)), cex.axis=1.3)
for (i in 1:stg_N_countries) {
	lines(1:stg_N_yrs, rev(stg_grant[i,])/rev(stg_eval[stg_granted_countries[i],]), col=country_cols[i])
}

###
### OVERVIEW BARPLOT
###

pdf(file="~/git/misc-analyses/erc/erc_2019_StG_all_panels_overview_barplot.pdf", width=7, height=6)
par(mar=c(3,4.5,4,1))
barmain = "ERC Starting Grants 2007-2019"
barplot( rev(colSums(stg_eval)), names=rev(sub("X","",names(stg_eval))), ylim=c(0,9000), col="#ffffbf", cex.names=0.8, cex.axis=1.4, main=barmain  )
par(new=TRUE)
#barplot( rev(colSums(stg_grant)), names=rev(sub("X","",names(stg_grant))), ylim=c(0,9000), col="#006837", cex.names=1.3, cex.axis=1.4  )
barplot( rev(colSums(stg_grant)), names=FALSE, ylim=c(0,9000), col="#006837", cex.names=1.3, cex.axis=1.4, axes=FALSE )
legend(6,9000,legend=c("Submitted", "Granted"), fill=c("#ffffbf", "#006837"), bty='n', cex=1.5)
par(new=FALSE)
dev.off()

###
### BEGIN MAPS SECTION 
###

library(maps)

stg_null_eval_sums = rep(0, dim(stg_eval)[1])
stg_null_eval_sums[stg_granted_countries] = rowSums(stg_grant)
stg_null_eval_sums
rowSums(stg_grant)
rowSums(stg_eval[stg_granted_countries,])
rowSums(stg_eval)
stg_countryaverage = stg_null_eval_sums/rowSums(stg_eval)
stg_countryaverage
range(stg_countryaverage)/min(stg_countryaverage)


ga_colors = colorRampPalette(c("#8e0152","#ffffbf","#006837"))(24)
plot(1:length(ga_colors),1:length(ga_colors),cex=5,pch=16,type="p",col=ga_colors)

ga_colors


floor(stg_countryaverage*100)
colorby_ga = ga_colors[floor(stg_countryaverage*100)+1]
colorby_ga

latrange = c(30,62)
lonrange = c(-11,38)

euromap = map('world', ylim=latrange, xlim=lonrange)
#attributes(euromap)

stg_countries = row.names(stg_eval)
stg_countries
stg_countries[length(stg_countries)] = "UK:Great Britain"
euronums = match(stg_countries, euromap$names)
euronums
#euronums[32] = 57
euronumnoNA = euronums[!is.na(euronums)]
countriesnoNA = stg_countries[!is.na(euronums)]

!is.na(euronums)

euromap$names[euronumnoNA]
colorby_ga_noNA = colorby_ga[!is.na(euronums)]
vecbycountry = rep("#dddddd", length(euromap$names) )
vecbycountry[euronumnoNA] = colorby_ga_noNA
vecbycountry[euronumnoNA]
vecbycountry
for (ctry in countriesnoNA){
	vecbycountry[grep(ctry,euromap$names)] = colorby_ga_noNA[ grep(ctry,countriesnoNA)]
} 

grayscale = colorRampPalette(c("#999999","#eeeeee"))(4)


wc = world.cities

wcaps = wc[wc$capital==1,]
# Montenegro not included, because data are from 2006
# get data manually
mnc = c("Podgorica","Montenegro",1, 42.441286, 19.262892,1)

# extract capitals for relevant countries
capsonly = wcaps[match(c(countriesnoNA), wcaps[1:(dim(wcaps)[1]),2],nomatch=FALSE),]
capsonly
dim(capsonly)

#
grantedcounts_w_null = rep(0,length(stg_eval))
grantedcounts_w_null[stg_granted_countries] = rowSums(stg_grant)
grantedcounts_w_null[is.na(grantedcounts_w_null)] = 0
printvals = paste(grantedcounts_w_null,rowSums(stg_eval),sep="/")
printvals

# filter for those on the map

capslat = c( capsonly[["lat"]], 51.507222 )
capslon = c( capsonly[["long"]], -0.1275 )
# plot numbers on top of each capital
countriesnoNA
capsonly[["country.etc"]]
caps_no_na_match = c( match( capsonly[["country.etc"]], stg_countries, ), 40 )
caps_no_na_match
cbind( printvals, row.names(stg_eval), caps_no_na_match )

pdf(file="~/git/misc-analyses/erc/erc_2019_StG_granted_projects_all_panels_ratio.pdf", width=8, height=8)
# make map
euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
# make legend in north africa
rect(seq(-5, -5+length(ga_colors)-1 ,1),rep(32,length(ga_colors)), seq(-4,-4+length(ga_colors)-1,1) ,rep(33,length(ga_colors)),col=ga_colors)
text(-5,34,"0", cex=2)
text(-5+length(ga_colors)-1,34, length(ga_colors) , cex=2)
rect(-9,30,20,32,border=FALSE,col="#dddddd")
text(-5+(length(ga_colors)/2),31,"% ERC Starting Grants Awarded", cex=2)
dev.off()

pdf(file="~/git/misc-analyses/erc/erc_2019_StG_granted_projects_all_panels_ratio_w_counts.pdf", width=8, height=8)
# make map
euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
rect(seq(-5, -5+length(ga_colors)-1 ,1),rep(32,length(ga_colors)), seq(-4,-4+length(ga_colors)-1,1) ,rep(33,length(ga_colors)),col=ga_colors)
text(-5,34,"0", cex=2)
text(-5+length(ga_colors)-1,34, length(ga_colors) , cex=2)
rect(-9,30,20,32,border=FALSE,col="#dddddd")
text(-5+(length(ga_colors)/2),31,"% ERC Starting Grants Awarded", cex=2)
text(capslon, capslat, printvals[caps_no_na_match], cex=1 )
dev.off()

###
### SAME PLOTS FOR CONSOLIDATOR GRANTS
###

cog_eval = read.table("~/git/misc-analyses/erc/erc_2019_CoG_evaluated_projects_all_panels.tab",header=TRUE,sep="\t",row.names=1)
cog_grant = read.table("~/git/misc-analyses/erc/erc_2019_CoG_granted_projects_all_panels.tab",header=TRUE,sep="\t",row.names=1)

cog_eval
cog_grant

pdf(file="~/git/misc-analyses/erc/erc_2019_CoG_all_panels_overview_barplot.pdf", width=7, height=6)
par(mar=c(3,4.5,4,1))
barmain = "ERC Consolidator Grants 2013-2019"
barplot( rev(colSums(cog_eval)), names=rev(sub("X","",names(cog_eval))), ylim=c(0,4000), col="#ffffbf", cex.names=1.2, cex.axis=1.4, main=barmain  )
par(new=TRUE)
barplot( rev(colSums(cog_grant[,])), names=FALSE, ylim=c(0,4000), col="#313695", cex.names=1.3, cex.axis=1.4, axes=FALSE  )
legend(4,4000,legend=c("Submitted", "Granted"), fill=c("#ffffbf", "#313695"), bty='n', cex=1.5)
par(new=FALSE)
dev.off()

cog_N_countries = dim(cog_grant)[1]
cog_N_yrs = dim(cog_eval)[2]

cog_granted_countries = match( row.names(cog_grant), row.names(cog_eval))
cog_granted_countries
cog_eval_sums = rev(colSums(cog_eval[,]))
cog_grant_sums = rev(colSums(cog_grant[,]))

cog_null_eval_sums = rep(0, dim(cog_eval)[1])
cog_null_eval_sums[cog_granted_countries] = rowSums(cog_grant[,])
cog_null_eval_sums
rowSums(cog_eval)
cog_countryaverage = cog_null_eval_sums/rowSums(cog_eval)
cog_countryaverage
max(cog_countryaverage)

ga_colors = colorRampPalette(c("#8e0152","#ffffbf","#313695"))(26)
plot(1:length(ga_colors),1:length(ga_colors),cex=5,pch=16,type="p",col=ga_colors)

colorby_ga = ga_colors[floor(cog_countryaverage*100)+1]
colorby_ga

#attributes(euromap)

cog_countries = row.names(cog_eval)
cog_countries[length(cog_countries)] = "UK:Great Britain"
euronums = match(cog_countries, euromap$names)
euronums
euronumnoNA = euronums[!is.na(euronums)]
euronumnoNA
countriesnoNA = cog_countries[!is.na(euronums)]
countriesnoNA
colorby_ga_noNA = colorby_ga[!is.na(euronums)]
colorby_ga_noNA
vecbycountry = rep("#dddddd", length(euromap$names) )
vecbycountry[euronumnoNA] = colorby_ga_noNA

countriesnoNA[length(countriesnoNA)] = "UK"
for (ctry in countriesnoNA){
	vecbycountry[grep(ctry,euromap$names)] = colorby_ga_noNA[ grep(ctry,countriesnoNA)]
}

pdf(file="~/git/misc-analyses/erc/erc_2019_CoG_granted_projects_all_panels_ratio.pdf", width=8, height=8)
# make map
euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
# make legend in north africa
rect(seq(-5, -5+length(ga_colors)/2-0.5 ,0.5),rep(32,length(ga_colors)), seq(-4,-4+length(ga_colors)/2-0.5,0.5) ,rep(33,length(ga_colors)),col=ga_colors)
text(-5,34,"0", cex=2)
text(-5+length(ga_colors)/2,34, length(ga_colors) , cex=2)
rect(-8,30,24,32,border=FALSE,col="#dddddd")
text(-8,31,"% Consolidator Grants Awarded", cex=2,pos=4)
#text(capslon, capslat, printvals[caps_no_na_match], cex=1 )
dev.off()



###
### SAME PLOTS FOR ADVANCED GRANTS
###


adg_eval = read.table("~/git/misc-analyses/erc/erc_2019_AdG_evaluated_projects_all_panels.tab",header=TRUE,sep="\t",row.names=1)
adg_grant = read.table("~/git/misc-analyses/erc/erc_2019_AdG_granted_projects_all_panels.tab",header=TRUE,sep="\t",row.names=1)

adg_eval
adg_grant


pdf(file="~/git/misc-analyses/erc/erc_2019_AdG_all_panels_overview_barplot.pdf", width=7, height=6)
par(mar=c(3,4.5,4,1))
barmain = "ERC Advanced Grants 2008-2019"
barplot( rev(colSums(adg_eval)), names=rev(sub("X","",names(adg_eval))), ylim=c(0,3000), col="#ffffbf", cex.names=1.1, cex.axis=1.4, main=barmain  )
par(new=TRUE)
barplot( rev(colSums(adg_grant[,])), names=FALSE, ylim=c(0,3000), col="#317785", cex.names=1.3, cex.axis=1.4, axes=FALSE  )
legend(4,3000,legend=c("Submitted", "Granted"), fill=c("#ffffbf", "#317785"), bty='n', cex=1.5)
par(new=FALSE)
dev.off()

adg_N_countries = dim(adg_grant)[1]
adg_N_yrs = dim(adg_eval)[2]

adg_granted_countries = match( row.names(adg_grant), row.names(adg_eval))
adg_granted_countries
adg_eval_sums = rev(colSums(adg_eval[,]))
adg_grant_sums = rev(colSums(adg_grant[,]))

adg_null_eval_sums = rep(0, dim(adg_eval)[1])
adg_null_eval_sums[adg_granted_countries] = rowSums(adg_grant[,])
adg_null_eval_sums
rowSums(adg_eval)
adg_countryaverage = adg_null_eval_sums/rowSums(adg_eval)
adg_countryaverage
max(adg_countryaverage)

ga_colors = colorRampPalette(c("#8e0152","#ffffbf","#317785"))(28)
plot(1:length(ga_colors),1:length(ga_colors),cex=5,pch=16,type="p",col=ga_colors)

colorby_ga = ga_colors[floor(adg_countryaverage*100)+1]
colorby_ga

adg_countries = row.names(adg_eval)
adg_countries[length(adg_countries)] = "UK:Great Britain"
euronums = match(adg_countries, euromap$names)
euronums
euronumnoNA = euronums[!is.na(euronums)]
euronumnoNA
countriesnoNA = adg_countries[!is.na(euronums)]
countriesnoNA
colorby_ga_noNA = colorby_ga[!is.na(euronums)]
colorby_ga_noNA
vecbycountry = rep("#dddddd", length(euromap$names) )
vecbycountry[euronumnoNA] = colorby_ga_noNA

countriesnoNA[length(countriesnoNA)] = "UK"
for (ctry in countriesnoNA){
	vecbycountry[grep(ctry,euromap$names)] = colorby_ga_noNA[ grep(ctry,countriesnoNA)]
}

pdf(file="~/git/misc-analyses/erc/erc_2019_adg_granted_projects_all_panels_ratio.pdf", width=8, height=8)
# make map
euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
# make legend in north africa
rect(seq(-5, -5+length(ga_colors)/2-0.5 ,0.5),rep(32,length(ga_colors)), seq(-4.5,-4.5+length(ga_colors)/2-0.5,0.5) ,rep(33,length(ga_colors)),col=ga_colors)
text(-5,34,"0", cex=2)
text(-5+length(ga_colors)/2,34, length(ga_colors) , cex=2)
rect(-8,30,24,32,border=FALSE,col="#dddddd")
text(-8,31,"% Advanced Grants Awarded", cex=2,pos=4)
dev.off()










#