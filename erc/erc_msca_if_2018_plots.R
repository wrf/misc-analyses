

cutoff = c(91.2, 92.4, 87, 92.8, 89.4, 93, 92.4, 93.6, 92.6, 90.8, 92.6, 92.4, 93.2, 90, 92.6, 91, 94.2, 90.2, 90.4)

total_projects = c(423, 593, 340, 1056, 152, 901, 923, 1789, 194, 847, 1637, 62, 23, 89, 120, 174, 14, 92, 247)

mscadata = read.table("~/git/misc-analyses/erc/erc_2018_msca_if_cumulative_pct_above_thres.tab", sep='\t', header=TRUE, row.names=1)

# mscadata[["ST.LIF"]] is mscadata[,8]

pct_by_score = rev(diff(mscadata[,8]))
pct_by_score

pdf(file="~/git/misc-analyses/erc/erc_2018_msca_if_cumulative_pct_st-lif.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,1))
plot(0,0, type='n', xlim=c(70,100), ylim=c(0,5), xlab="Score", ylab="Percent of proposals", main="MSCA-IF ST-LIF 2018", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
polygon( c( cutoff[8],94:99, rev( c(cutoff[8],94:99)) ) , y=c(rep(0,7), diff(mscadata[,8])[1:7]), col="#539c57",border=FALSE )
lines(70:99, pct_by_score, lwd=10, col="#8e0152" )
dev.off()




#