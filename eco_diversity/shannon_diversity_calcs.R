#


HvalsR = c()
nmax = 100
for (n in seq(1,nmax,1)){
  counts = rep(1,n)
  s = sum(counts)
  p = counts/ s
  H = -1 * sum(p * log(p))
  HvalsR = c(HvalsR,H)
}
plot(seq(1,nmax,1), HvalsR, ylab="H", xlab="Num taxa", type='l', col="#12bc88", lwd=4)
# HvalsR[seq(1,10000,100)]
# [1]  4.605170  9.220291  9.908475 10.312280 10.599132 10.821776 11.003765 11.157678 11.291031 11.408675
# [11] 11.513925 11.609144 11.696080 11.776059 11.850112 11.919057 11.983554 12.044142 12.101268 12.155306
# [21] 12.206573 12.255339 12.301837 12.346269 12.388811 12.429616 12.468821 12.506548 12.542902 12.577981
# [31] 12.611871 12.644650 12.676389 12.707151 12.736995 12.765974 12.794137 12.821529 12.848190 12.874158
# [41] 12.899470 12.924156 12.948248 12.971773 12.994757 13.017225 13.039199 13.060701 13.081750 13.102365
# [51] 13.122563 13.142362 13.161776 13.180821 13.199510 13.217855 13.235871 13.253567 13.270956 13.288047
# [61] 13.304852 13.321378 13.337636 13.353634 13.369380 13.384881 13.400147 13.415182 13.429995 13.444592
# [71] 13.458978 13.473161 13.487145 13.500937 13.514541 13.527962 13.541205 13.554276 13.567177 13.579915
# [81] 13.592492 13.604913 13.617182 13.629301 13.641276 13.653109 13.664804 13.676363 13.687791 13.699089
# [91] 13.710261 13.721310 13.732238 13.743047 13.753742 13.764323 13.774793 13.785154 13.795410 13.805561
# max(HvalsR)
# #[1] 13.81551

HvalsC = c()
for (n in 1:nmax){
  counts = seq(1,n,1)
  s = sum(counts)
  p = counts/ s
  H = -1 * sum(p * log(p))
  HvalsC = c(HvalsC,H)
}


HvalsE = c()
for (n in 1:nmax){
  counts = cumsum(seq(1,n,1))
  s = sum(counts)
  p = counts/ s
  H = -1 * sum(p * log(p))
  HvalsE = c(HvalsE,H)
}

#plot(1:10000, counts)
pdf(file="~/git/misc-analyses/eco_diversity/shannon_diversity_model_v1.pdf", width=6, height=5)
par(mar=c(4.5,4.5,1,1))
plot(1:nmax, HvalsR, ylab="H (Shannon Index)", xlab="Num taxa", type='l', 
     cex.axis=1.4, cex.lab=1.4, frame.plot = FALSE, ylim=c(0,5),
     col="#12bc88", lwd=4)
lines(1:nmax, HvalsC, type='l', col="#1066dc", lwd=4)
lines(1:nmax, HvalsE, type='l', col="#fd8d3c", lwd=4)
legend(40,3,legend=c("All equal", "Increase by 1", "Square/2"), lwd=5, cex=1.1,
       col=c("#12bc88","#1066dc","#fd8d3c"), bty='n' )
legend(75,3,legend=c("(1,1,1...)", "(1,2,3...)", "(1,3,6...)"), cex=1.1, bty='n')
text(15,1,"Calculated as:\nH = -1 * sum(p * log(p))\nwhere p is proportion of taxon i in sample", pos=4)
dev.off()






#