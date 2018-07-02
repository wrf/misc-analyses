# plot human intron lengths
# generated with gtfstats.py
#
# gtfstats.py -i ~/genomes/human/GCF_000001405.37_GRCh38.p11_genomic.gff.gz --print-introns > human_introns.tab
#

introndata = read.table("~/git/misc-analyses/intron_evolution/human_introns.tab", header=FALSE, sep=" ")

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

humhist = hist(intronlengths, breaks=seq(1,200001,100), plot=FALSE)

bluecolor = "#0868ac"

pdf("~/git/misc-analyses/intron_evolution/human_GRCh38_intron_hist.pdf", width=8, height=7)
par(mar=c(4.5,4.5,2,2))
plot(humhist$mids, humhist$counts, col="#af1951", type='l', lwd=5, xlim=c(0,10000), xlab="Intron length (bp)", ylab="Number of introns", main="Human GRCh38 annotation intron lengths", frame.plot=FALSE, axes=FALSE, cex.lab=1.3, cex.main=1.5)
axis(1, cex.axis=1.4)
axis(2, at=seq(0,100000,20000), labels=c("0","20k","40k","60k","80k","100k"), cex.axis=1.4)

points(meanlength,humhist$counts[humhist$mids>meanlength][1]+3000,pch=6, cex=2, lwd=3)
text(meanlength,humhist$counts[humhist$mids>meanlength][1]+10000, paste("Mean:", round(meanlength,digits=2)), col="#af1951", cex=1.8, pos=4, offset=0)

points(medianlength,humhist$counts[humhist$mids>medianlength][1]+5000,pch=6, cex=2, lwd=3)
text(medianlength, humhist$counts[humhist$mids>medianlength][1]+12000, paste("Median:", round(medianlength,digits=2)), col="#af1951", cex=1.8, pos=4, offset=0)

dev.off()


#