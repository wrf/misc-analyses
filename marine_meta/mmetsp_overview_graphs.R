# make overview graphs for MMETSP attributes
# data from Keeling et al 2014 PLOS Biology
# https://dx.doi.org/10.1371%2Fjournal.pbio.1001889

microdata = read.table("~/est/mmetsp_data/sample-attr_noap.tab", header=FALSE, sep="\t", stringsAsFactors=FALSE)

is_depth = (microdata[,3]=="depth")
depths = as.numeric(microdata[,4][is_depth])
temperatures = as.numeric(microdata[,4][(microdata[,3]=="environmental_temperature")])
exp_salinity = as.numeric(microdata[,4][(microdata[,3]=="experimental_salinity")])
phosphate = as.numeric(microdata[,4][(microdata[,3]=="phosphate")])
nitrate = as.numeric(microdata[,4][(microdata[,3]=="nitrate")])
length(depths)
depth_hist = hist(depths, breaks=100)
phoshist = hist(phosphate, breaks=25)
nitrhist = hist(nitrate, breaks=25)

# display all attributes as a table of number of items
table(microdata[,3])



countries_and_codes = table(microdata[,4][(microdata[,3]=="country")])
# has both country names as allcaps and 2 letter codes

# table of phyla, all groups are eukaryotic
# two phyla had typos
# fixed with:
# sed s/Forminafera/Foraminifera/ sample-attr_noap.tab > sample-attr_fx.tab
# replace original:
# mv sample-attr_fx.tab sample-attr_noap.tab

phylumcounts = sort(table(microdata[,4][(microdata[,3]=="phylum")]),descreasing=TRUE)
phylumcounts
phyrefs = c( "Unknown", "Bacillariophyta", "Dinophyta", "Pyrrophycophyta" , "Foraminifera", "Glaucophyta", "Chlorophyta",
            "Rhodophyta", "Cryptophyta" , "Ciliophora", "Sarcomastigophora", "Chlorarachniophyta", "Euglenozoa", "Cercozoa",
           "Ochrophyta", "Alveolata", "Haptophyta", "Labyrinthista", "Apicomplexa", "Perkinsozoa", "Bicosoecida", "Ascomycota")
phycols = c( "#888888", "#41ab5d"        , "#ec7014"  , "#a6bddb"         , "#a6bddb"     , "#ccebc5"    , "#41ab5d",
            "#ce1256"   , "#993404"     , "#9ebcda"   , "#e0ecf4"          , "#ffeda0"           , "#41ab5d"   , "#2166ac",
           "#9cb511"   , "#a6bddb"  , "#41ab5d"   , "#a6bddb"      , "#8c510a"    , "#c7eae5"    , "#a6bddb"    , "#b2182b" )
phyorder = match(names(phylumcounts),phyrefs)

# make color schemes for temp and salinity
tempcolors = c( colorRampPalette(c("#850026","#ffffbf"),alpha=TRUE)(15),colorRampPalette(c("#e0f3f8","#213685"),alpha=TRUE)(16) )
saltcolors = c( colorRampPalette(c("#fde0dd","#49006a"),alpha=TRUE)(20) )

# generate PDF
pdf(file="~/git/misc-analyses/marine_meta/sample-attr_oceanography.pdf", width=8, height=8)
layout(matrix(c(1,2,1,3), 2, 2, byrow = TRUE), widths=c(1,1), heights=c(1,1) )

# make barplot, as piecharts are useless
par( mar=c(4.5,9,1,1) )
bp1 = barplot(phylumcounts, horiz=TRUE, las=1, xlim=c(0,210), main="", xlab="Number of samples", cex.lab=1.4, cex.axis=1.3, col=phycols[phyorder])
text(phylumcounts+1, bp1[,1], phylumcounts, pos=4)

par( mar=c(4.5,4.5,1,2) )
# standard TS
hist(temperatures, breaks=seq(0,30,1), xlab="Temperature (degrees C)", cex.lab=1.5, cex.axis=1.4, main="", col=rev(tempcolors) )
text(0,20,paste(length(temperatures),"samples"),cex=1.5,pos=4)

hist(exp_salinity, breaks=seq(0,40,2), xlab="Salinity (0/00)", cex.lab=1.5, cex.axis=1.4, main="", col=saltcolors)
text(0,160,paste(length(exp_salinity),"samples"),cex=1.5,pos=4)

dev.off()



#