# replot of data from Fenchel and Finlay 1995 Ecology and Evolution in Anoxic Worlds
# Figure 5.9 The half saturation Po for respiration of different organisms/organelles as a function of their linear dimensions.
# https://academic.oup.com/book/54243
# last updated 2024-10-02

kmdata_file = "~/git/misc-analyses/animal_oxygen/data/fenchel_finlay_1995_km_by_size.tab"
kmdata = read.table(kmdata_file, header=TRUE, sep="\t")
kmdata

is_microbe = c(11,12,13,14,15)

typecols = c( rep("#1c9099aa", 10), rep("#78c679aa", 4 ), "#783a26aa" )
#typecols[is_microbe] = "#78c679aa"

type_pch = rep(17,length(kmdata[,1]))
type_pch[is_microbe] = 19

pdf(file="~/git/misc-analyses/animal_oxygen/images/fenchel_finlay_1995_km_by_size.pdf", width=6, height=6)
par(mar=c(4.5,4.5,4,2))
plot(kmdata[["size_cm"]], kmdata[["Km_pct_air_sat"]], frame.plot=FALSE, 
     log='xy', xlim=c(1e-4, 100), ylim=c(0.01, 100), 
     xlab="Size (cm)", ylab="Km (%AS)", main="Fenchel & Finlay 1995 Figure 5.9", 
     col=typecols, pch=type_pch, cex=3, cex.lab=1.3, cex.axis=1.3)
#text(kmdata[["size_cm"]], kmdata[["Km_pct_air_sat"]], kmdata[["Organism"]], pos=4)
dev.off()

#
