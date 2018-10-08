# plot random prots

hist1 = read.table("~/git/misc-analyses/random_dna/data/random_40gc_prot.hist", sep="\t")
hist2 = read.table("~/git/misc-analyses/random_dna/data/random_50gc_prot.hist", sep="\t")
hist3 = read.table("~/git/misc-analyses/random_dna/data/random_60gc_prot.hist", sep="\t")

colset = c("#1f78b4", "#ff7f00", "#cab2d6")

pdf(file="~/git/misc-analyses/random_dna/random_hist_comparison.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,2))
plot(0,0, type='n', xlim=c(0,300), ylim=c(0,30000), xlab="Longest protein (AAs)", ylab="Number of proteins", frame.plot=FALSE, cex.lab=1.4, cex.axis=1.4)
lines(hist1[,2], hist1[,1], lwd=3, col=colset[1])
lines(hist2[,2], hist2[,1], lwd=3, col=colset[2])
lines(hist3[,2], hist3[,1], lwd=3, col=colset[3])
legend(150,30000,legend=c("40% GC","50% GC","60% GC"), col=colset, cex=1.8, lwd=6)

dev.off()


#