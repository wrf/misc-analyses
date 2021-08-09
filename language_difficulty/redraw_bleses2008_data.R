# recreation of figures from Bleses 2008 Early vocabulary development in Danish and other languages: A CDI-based comparison
# https://doi.org/10.1017/S0305000908008714
# created by WRF 2021-08-09

fig1data_file = "~/git/misc-analyses/language_difficulty/data/bleses_2008_fig1_data.tab"
fig1data = read.table(fig1data_file, header=TRUE, sep="\t")


#                 DK           SW           NL           UK           US           MX           ES
colorset_fig1 = c("#c427ffbb", "#a50fa0bb", "#0f41a5bb", "#2a0fa5bb", "#3f1ddbbb", "#54c565bb", "#0c840cbb",
                  "#8cba11bb", "#000000bb", "#225e3fbb", "#e2a10ebb", "#495508bb", "#8f2525bb")
#                 GL           EU           FR           HR           IT           FI

country_list = c("Danish", "Swedish", "Dutch", "UK-english", "US-english", "MX-spanish", "ES-spanish", "Galician", "Basque", "French", "Croatian", "Italian", "Finnish")
pointset_fig1 = c(1,2,4,5,6,8,9,12,13,15,17,18,25)

pdf(file="~/git/misc-analyses/language_difficulty/images/bleses_2008_fig1_data.pdf", width=8, height=7)
par(mar=c(4.5,4.5,3,1))
plot(0,0, type="n", xlim=c(8,15), ylim=c(0,200), xlab="Age (months)", ylab="Number of comprehended items", main="Fig 1 from Bleses 2008: Median vocabulary comprehension scores", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 2:14){
  word_comp_data_raw = fig1data[,i]
  word_comp_not_na = !is.na(word_comp_data_raw)
  lines(fig1data[,1][word_comp_not_na], fig1data[,i][word_comp_not_na], lwd=10, col=colorset_fig1[i-1])
  points(fig1data[,1][word_comp_not_na], fig1data[,i][word_comp_not_na], pch=pointset_fig1[i-1], col=colorset_fig1[i-1], cex=2)
}
legend(8,200, legend=country_list, bty='n', lwd=6, col=colorset_fig1, pch=pointset_fig1, cex=1.1, pt.cex=1.4, pt.lwd=1)
dev.off()


# figure 3

fig3data_file = "~/git/misc-analyses/language_difficulty/data/bleses_2008_fig3_data.tab"
fig3data = read.table(fig3data_file, header=TRUE, sep="\t")

fig3_country_subset = c(1,2,3,5,6,7,10,8,13)

pdf(file="~/git/misc-analyses/language_difficulty/images/bleses_2008_fig3_data.pdf", width=8, height=7)
par(mar=c(4.5,4.5,3,1))
plot(0,0, type="n", xlim=c(8,15), ylim=c(0,30), xlab="Age (months)", ylab="Number of comprehended phrases", main="Fig 3 from Bleses 2008: Median comprehended phrases scores", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 2:10){
  word_comp_data_raw = fig3data[,i]
  word_comp_not_na = !is.na(word_comp_data_raw)
  lines(fig3data[,1][word_comp_not_na], fig3data[,i][word_comp_not_na], lwd=10, col=colorset_fig1[fig3_country_subset][i-1])
  points(fig3data[,1][word_comp_not_na], fig3data[,i][word_comp_not_na], pch=pointset_fig1[fig3_country_subset][i-1], col=colorset_fig1[fig3_country_subset][i-1], cex=2)
}
legend(8,30, legend=country_list[fig3_country_subset], bty='n', lwd=6, col=colorset_fig1[fig3_country_subset], pch=pointset_fig1[fig3_country_subset], cex=1.1, pt.cex=1.4, pt.lwd=1)
dev.off()


# figure 4

fig4data_file = "~/git/misc-analyses/language_difficulty/data/bleses_2008_fig4_data.tab"
fig4data = read.table(fig4data_file, header=TRUE, sep="\t")

pdf(file="~/git/misc-analyses/language_difficulty/images/bleses_2008_fig4_data.pdf", width=8, height=7)
par(mar=c(4.5,4.5,3,1))
plot(0,0, type="n", xlim=c(8,15), ylim=c(0,30), xlab="Age (months)", ylab="Number of items", main="Fig 4 from Bleses 2008: Median vocabulary production scores", frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 2:14){
  word_comp_data_raw = fig4data[,i]
  word_comp_not_na = !is.na(word_comp_data_raw)
  lines(fig4data[,1][word_comp_not_na], fig4data[,i][word_comp_not_na], lwd=10, col=colorset_fig1[i-1])
  points(fig4data[,1][word_comp_not_na], fig4data[,i][word_comp_not_na], pch=pointset_fig1[i-1], col=colorset_fig1[i-1], cex=2)
}
legend(8,30, legend=country_list, bty='n', lwd=6, col=colorset_fig1, pch=pointset_fig1, cex=1.1, pt.cex=1.4, pt.lwd=1)
dev.off()


#



