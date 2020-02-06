# plot histogram of Marie Sklodowska Curie Actions - Individual Fellowships

# CAR    = career restart
# RI     = re-integration
# SE     = society and enterprise
# ST-CHE = standard application - chemistry
#   -ECO = economics
#   -ENG = engineering and computer science
#   -ENV = environment and geoscience
#   -LIF = life science
#   -MAT = mathematics
#   -PHY = physics
#   -SOC = social science and humanities
# GF-xxx = global fellowships

#
#
# 2018 data from:
# http://ec.europa.eu/research/participants/portal/doc/call/h2020/msca-if-2018/1847614-if2018_percentiles_en.pdf
#
#
# score cutoffs
cutoffs_2018 = c(91.2, 92.4, 87, 92.8, 89.4, 93, 92.4, 93.6, 92.6, 90.8, 92.6, 92.4, 93.2, 90, 92.6, 91, 94.2, 90.2, 90.4)
# projects by category
total_projects_2018 = c(423, 593, 340, 1056, 152, 901, 923, 1789, 194, 847, 1637, 62, 23, 89, 120, 174, 14, 92, 247)

# main data table
mscadata = read.table("~/git/misc-analyses/erc/erc_2018_msca_if_cumulative_pct_above_thres.tab", sep='\t', header=TRUE, row.names=1)

# mscadata[["ST.LIF"]] is mscadata[,8]

# difference of all points, add last score
pct_by_score = c(rev(diff(mscadata[,8])), mscadata[1,8])
pct_by_score

pdf(file="~/git/misc-analyses/erc/erc_2018_msca_if_cumulative_pct_st-lif.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,1))
plot(0,0, type='n', xlim=c(70,100), ylim=c(0,5), xlab="Score", ylab="Percent of proposals", main="MSCA-IF ST-LIF 2018", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
cutoff_to_max = ceiling(cutoffs_2018[8]):100
dist_to_max = length(cutoff_to_max)
polygon( c( cutoffs_2018[8],cutoff_to_max, rev( c(cutoffs_2018[8],cutoff_to_max)) ) , y=c(rep(0,(dist_to_max+1)), rev(pct_by_score)[1:(dist_to_max+1)]), col="#539c57",border=FALSE )
lines(70:100, pct_by_score, lwd=10, col="#8e0152" )
dev.off()

#
#
# plot all standard categories

colorset = c("#e41a1c", "#f781bf", "#ff7f00", "#a65628", "#4daf4a", "#eedd33", "#377eb8", "#984ea3")
colorset_semi = paste0( colorset, "88")
pdf(file="~/git/misc-analyses/erc/erc_2018_msca_if_cumulative_pct_standard_all_cats.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,1))
plot(0,0, type='n', xlim=c(70,100), ylim=c(0,6), xlab="Score", ylab="Percent of proposals", main="MSCA-IF Standard Applications 2018", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 4:11) {
	pct_by_score = c(rev(diff(mscadata[,i])), mscadata[1,i])
	lines(70:100, pct_by_score, lwd=10, col=colorset_semi[i-3] )
}
legend(94,6,legend=names(mscadata)[4:11],lwd=5, col=colorset, bty='n')
dev.off()





#
#
#
#
#
#
#
# 2019 set
# https://ec.europa.eu/info/funding-tenders/opportunities/docs/cap/h2020/msca-if-2019/1877616-if2019_percentiles_en.pdf

# 1    2   3   4       5       6       7       8       9       10      11      12      13      14      15      16      17      18      19
# CAR  RI  SE  ST-CHE  ST-ECO  ST-ENG  ST-ENV  ST-LIF  ST-MAT  ST-PHY  ST-SOC  GF-CHE  GF-ECO  GF-ENG  GF-ENV  GF-LIF  GF-MAT  GF-PHY  GF-SOC

# score cutoffs
cutoffs_2019 = c(89.4, 93.0, 82.2, 92.4, 91.6, 92.4, 93.4, 92.6, 91.2, 91.4, 93.0, 92.0, 89.4, 89.8, 91.6, 91.2, 94.2, 88.4, 90.0)
# projects by category
total_projects_2019 = c(440, 647, 196, 1061, 168, 951, 856, 1753, 181, 892, 1740, 58, 11, 88, 119, 148, 10, 74, 316)

# main data table
mscadata = read.table("~/git/misc-analyses/erc/erc_2019_msca_if_cumulative_pct_above_thres.tab", sep='\t', header=TRUE, row.names=1)

# difference of all points, add last score
pct_by_score = c(rev(diff(mscadata[,8])), mscadata[1,8])
pct_by_score

pdf(file="~/git/misc-analyses/erc/erc_2019_msca_if_cumulative_pct_st-lif.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,1))
plot(0,0, type='n', xlim=c(70,100), ylim=c(0,5), xlab="Score", ylab="Percent of proposals", main="MSCA-IF ST-LIF 2019", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
cutoff_to_max = ceiling(cutoffs_2019[8]):100
dist_to_max = length(cutoff_to_max)
polygon( c( ceiling(cutoffs_2019[8]),cutoff_to_max, rev( c( ceiling(cutoffs_2019[8]) ,cutoff_to_max)) ) , y=c(rep(0,(dist_to_max+1)), rev(pct_by_score)[1:(dist_to_max+1)]), col="#539c57",border=FALSE )
lines(70:100, pct_by_score, lwd=10, col="#8e0152" )
text(cutoffs_2019[8], 4, paste0("Cutoff:\n",cutoffs_2019[8],"%"), cex=1.5, col="#539c57", pos=4)
dev.off()

# plot all standard categories
colorset = c("#e41a1c", "#f781bf", "#ff7f00", "#a65628", "#4daf4a", "#eedd33", "#377eb8", "#984ea3")
colorset_semi = paste0( colorset, "88")
pdf(file="~/git/misc-analyses/erc/erc_2019_msca_if_cumulative_pct_standard_all_cats.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,1))
plot(0,0, type='n', xlim=c(70,100), ylim=c(0,7), xlab="Score", ylab="Percent of proposals", main="MSCA-IF Standard Applications 2019", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 4:11) {
	pct_by_score = c(rev(diff(mscadata[,i])), mscadata[1,i])
	lines(70:100, pct_by_score, lwd=10, col=colorset_semi[i-3] )
}
legend(94,7,legend=names(mscadata)[4:11],lwd=5, col=colorset, bty='n')
dev.off()

# plot all global fellowship categories
pdf(file="~/git/misc-analyses/erc/erc_2019_msca_if_cumulative_pct_globalfellowship_all_cats.pdf", width=7, height=6)
par(mar=c(4.5,4.5,2,1))
plot(0,0, type='n', xlim=c(70,100), ylim=c(0,15), xlab="Score", ylab="Percent of proposals", main="MSCA-IF Global Fellowships 2019", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 12:19) {
	pct_by_score = c(rev(diff(mscadata[,i])), mscadata[1,i])
	lines(70:100, pct_by_score, lwd=10, col=colorset_semi[i-11] )
}
legend(94,15,legend=names(mscadata)[12:19],lwd=5, col=colorset, bty='n')
dev.off()

#