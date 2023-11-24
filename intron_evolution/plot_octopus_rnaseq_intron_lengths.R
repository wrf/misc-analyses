# plot octopus intron lengths, to compare to "bimodal" distribution of Albertin 2015
# generated with gtfstats.py
#
# python3 ~/git/sequences/gtfstats.py -i obi-rnaseq-stringtie.gtf.gz --print-introns > obi_rnaseq_intron_lengths.tab
#

introndata = read.table("~/git/misc-analyses/intron_evolution/obi_rnaseq_intron_lengths.tab.gz", header=FALSE, sep=" ")

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

octohist = hist(intronlengths, breaks=seq(1,200001,20), plot=FALSE)
#octohist$counts[1:1000]

directcounts = table(intronlengths)
plot(1:1000,directcounts[1:1000], type='l', lwd=2)

pdf("~/git/misc-analyses/intron_evolution/octopus_rnaseq_intron_hist.pdf", width=8, height=7)
par(mar=c(4.5,4.5,2,2))
plot(octohist$mids, octohist$counts, col="#810f7c", type='l', lwd=5, xlim=c(0,20000), ylim=c(0,2500), xlab="Intron length (bp)", ylab="Number of introns", main="Octopus bimaculoides RNAseq intron lengths", frame.plot=FALSE, axes=FALSE, cex.lab=1.3, cex.main=1.5)
axis(1, cex.axis=1.4)
axis(2, at=seq(0,2500,500), cex.axis=1.4)

points(meanlength,octohist$counts[octohist$mids>meanlength][1]+100,pch=6, cex=2, lwd=3)
text(meanlength,octohist$counts[octohist$mids>meanlength][1]+250, paste("Mean:", round(meanlength,digits=2)), col="#810f7c", cex=1.8, pos=4, offset=0)

points(medianlength,octohist$counts[octohist$mids>medianlength][1]+500,pch=6, cex=2, lwd=3)
text(medianlength, octohist$counts[octohist$mids>medianlength][1]+650, paste("Median:", round(medianlength,digits=2)), col="#810f7c", cex=1.8, pos=4, offset=0)

dev.off()


#