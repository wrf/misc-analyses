# plot random intron lengths, modeled by random_intron_expansion.py
# created by wrf 2018-07-02

w_ext_data = read.table("~/git/misc-analyses/intron_evolution/random_1M_on_100k_w_ex.10rep.tab", header=TRUE, sep="\t")
no_ext_data = read.table("~/git/misc-analyses/intron_evolution/random_1M_on_100k.10rep.tab", header=TRUE, sep="\t")

pdf(file="~/git/misc-analyses/intron_evolution/random_intron_length_plot.pdf", width=8, height=7)
par(mar=c(4.5,4.5,2,2))

mainlab = "Intron lengths after 1M iterations"
plot(0,0,type='n', xlim=c(0,40), ylim=c(0,12500), xlab="Intron length (l)", ylab="Number of introns", frame.plot=FALSE, cex.axis=1.3, cex.lab=1.4, main="")

for ( i in seq(2,dim(no_ext_data)[2]) ) {
	print( mean( rep(no_ext_data[,1], no_ext_data[,i]) ) )
	lines(no_ext_data[,1], no_ext_data[,i], lwd=3, col="#d95f0e33")
}
text(13,10000,"Equal probability", col="#d95f0e", cex=1.8, pos=4)


for ( i in seq(2,dim(w_ext_data)[2]) ) {
	print( mean( rep(w_ext_data[,1], w_ext_data[,i]) ) )
	lines(w_ext_data[,1], w_ext_data[,i], lwd=3, col="#0868ac33")
}
text(21,2500,"Length-dependent\nprobability", col="#0868ac", cex=1.8, pos=4)

dev.off()





#