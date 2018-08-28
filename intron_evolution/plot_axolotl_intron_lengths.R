# plot axolotl intron lengths
# generated with gtfstats.py
#
# gtfstats.py -i Am_34longer300.annotated.longer150aa.gff --print-introns > Am_34longer300.annotated.longer150aa.introns.tab
#


introndata = read.table("~/genomes/ambystoma_mexicanum/Am_34longer300.annotated.longer150aa.introns.tab", header=FALSE, sep=" ")

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

amhist = hist(intronlengths, breaks=seq(1,200001,100), plot=FALSE)

pdf("~/git/misc-analyses/intron_evolution/Am_34_intron_hist.pdf", width=8, height=7)
par(mar=c(4.5,4.5,2,2))
plot(amhist$mids, amhist$counts, col="#bf6dda", type='l', lwd=5, xlim=c(0,60000), xlab="Intron length (bp)", ylab="Number of introns", main="Axolotl Am34 annotation intron lengths", frame.plot=FALSE, axes=FALSE, cex.lab=1.3, cex.main=1.5)
axis(1, cex.axis=1.4)
axis(2, at=seq(0,10000,2000), labels=c("0","2k","4k","6k","8k","10k"), cex.axis=1.4)

points(meanlength,amhist$counts[amhist$mids>meanlength][1]+300,pch=6, cex=2, lwd=3)
text(meanlength,amhist$counts[amhist$mids>meanlength][1]+1000, paste("Mean:", round(meanlength,digits=2)), col="#bf6dda", cex=1.8)

points(medianlength,amhist$counts[amhist$mids>medianlength][1]+300,pch=6, cex=2, lwd=3)
text(medianlength, amhist$counts[amhist$mids>medianlength][1]+3000, paste("Median:", round(medianlength,digits=2)), col="#bf6dda", cex=1.8)

dev.off()

sum(amhist$counts[1:10])/ sum(amhist$counts)

sum(as.integer(intronlengths<1001))

#