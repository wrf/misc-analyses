# plot human intron lengths
# generated with gtfstats.py
#
# gtfstats.py -i ~/genomes/human/GCF_000001405.37_GRCh38.p11_genomic.gff.gz --print-introns > human_introns.tab
#

introndata = read.table("~/git/misc-analyses/intron_evolution/phopy_intergenic_lengths.tab", header=FALSE, sep=" ")

intronlengths = introndata[,6]

meanlength = mean(introndata[,6])
meanlength
medianlength = median(introndata[,6])
medianlength

smallest_intron = min(intronlengths)
smallest_intron
biggest_intron = max(intronlengths)
biggest_intron

intronlengths[intronlengths>200001] = 200001

interhist = hist(intronlengths, breaks=seq(1,200001,100), plot=FALSE)

bluecolor = "#0868ac"

pdf("~/git/misc-analyses/intron_evolution/phopy_intergenic_lengths.pdf", width=8, height=7)
par(mar=c(4.5,4.5,2,2))
plot(interhist$mids, interhist$counts, col="#24bb51", type='l', lwd=5, xlim=c(0,100000), xlab="Intergenic length (bp)", ylab="Number of regions", main="PHOPY v1.3 annotation intergenic lengths", frame.plot=FALSE, axes=FALSE, cex.lab=1.3, cex.main=1.5)
axis(1, cex.axis=1.4)
axis(2, at=seq(0,500,100), labels=seq(0,500,100), cex.axis=1.4)

points(meanlength,interhist$counts[interhist$mids>meanlength][1]+30,pch=6, cex=2, lwd=3)
text(meanlength,interhist$counts[interhist$mids>meanlength][1]+100, paste("Mean:", round(meanlength,digits=2)), col="#24bb51", cex=1.8, pos=4, offset=0)

points(medianlength,interhist$counts[interhist$mids>medianlength][1]+50,pch=6, cex=2, lwd=3)
text(medianlength, interhist$counts[interhist$mids>medianlength][1]+120, paste("Median:", round(medianlength,digits=2)), col="#24bb51", cex=1.8, pos=4, offset=0)

dev.off()


#