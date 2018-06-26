

rh = read.table("~/git/misc-analyses/random_bootstrap/sample_1000x.txt",header=FALSE,sep=" ")


colset = rep("#000000",length(rh[,1]))
colset[rh[,1]<0] = "#70de57"
colset[rh[,1]>0] = "#e86365"

pdf(file="~/git/misc-analyses/random_bootstrap/sample_1000x.pdf", width=6, height=4)
plot(rh[,1], rh[,2], type='h', lwd=3, col=colset, ylab="Counts", xlab="Number of reds drawn")
dev.off()
#