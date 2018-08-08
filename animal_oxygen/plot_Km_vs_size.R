#

kmdata = read.table("~/git/misc-analyses/animal_oxygen/fenchel_finlay_1995_km_by_size.tab", header=TRUE, sep="\t")

microbes = c(11,12,13,14,15)

typecols = rep("#1c9099", length(kmdata[,1]))
typecols[microbes] = "#78c679"

type_pch = rep(17,length(kmdata[,1]))
type_pch[microbes] = 19

pdf(file="~/git/misc-analyses/animal_oxygen/fenchel_finlay_1995_km_by_size.pdf", width=6, height=6)
par(mar=c(4.5,4.5,4,2))
plot(kmdata[,3], kmdata[,4], log='xy', xlim=c(1e-4, 100), ylim=c(0.01, 100), frame.plot=FALSE, xlab="Size (cm)", ylab="Km (%AS)", main="Fenchel & Finlay 1995", col="#1c9099", pch=type_pch, cex=2, cex.lab=1.3, cex.axis=1.3)

dev.off()

#