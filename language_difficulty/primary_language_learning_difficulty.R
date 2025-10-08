# difficulties in learning a primary language
# created by WRF 2021-08-09



# recreation of figures from Bleses 2008 Early vocabulary development in Danish and other languages: A CDI-based comparison
# https://doi.org/10.1017/S0305000908008714


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




# figure 7
fig7data_file = "~/git/misc-analyses/language_difficulty/data/bleses_2008_fig7_data.tab"
fig7data = read.table(fig7data_file, header=TRUE, sep="\t")

# reassign names and symbols
country_list = c("Danish", "Swedish", "Dutch", "UK-english", "US-english", "MX-spanish", "ES-spanish", "Galician", "Hebrew", "French", "Croatian", "Italian", "Finnish")
# point 13 is changed to 11
pointset_fig1 = c(1,2,4,5,6,8,9,12,11,15,17,18,25)

pdf(file="~/git/misc-analyses/language_difficulty/images/bleses_2008_fig7_data.pdf", width=8, height=7)
par(mar=c(4.5,4.5,3,1))
plot(0,0, type="n", xlim=c(16,30), ylim=c(0,600), xlab="Age (months)", ylab="Number of items", 
     main="Fig 7 from Bleses 2008: Median vocabulary production scores", 
     frame.plot=FALSE, cex.axis=1.4, cex.lab=1.4)
for (i in 2:14){
  word_comp_data_raw = fig7data[,i]
  word_comp_not_na = !is.na(word_comp_data_raw)
  lines(fig7data[,1][word_comp_not_na], fig7data[,i][word_comp_not_na], lwd=10, col=colorset_fig1[i-1])
  points(fig7data[,1][word_comp_not_na], fig7data[,i][word_comp_not_na], pch=pointset_fig1[i-1], col=colorset_fig1[i-1], cex=2)
}
legend(16,600, legend=country_list, bty='n', lwd=6, col=colorset_fig1, pch=pointset_fig1, cex=1.1, pt.cex=1.4, pt.lwd=1)
dev.off()


################################################################################
# Wordbank : An open database of children's vocabulary development

# https://wordbank.stanford.edu/data/?name=vocab_norms




################################################################################

# data from
# Seymour et al (2003) Foundation literacy acquisition in European orthographies
# https://pubmed.ncbi.nlm.nih.gov/12803812/

nonword_error_file = "~/git/misc-analyses/language_difficulty/data/seymour2003_figure6.txt"
nonword_error_data = read.table( nonword_error_file, header=TRUE, sep="\t")

# Pham 2020 Beginning to Read in Vietnamese: Kindergarten Precursors to First Grade Fluency and Reading Comprehension
# https://pmc.ncbi.nlm.nih.gov/articles/PMC7963025/
# from Figure 2. Reading fluency in kindergarten and first grade
# Children were shown a 5x10 array of items and were given one minute to read aloud as many as possible.
pham_2020_vietnamese.word = list("Vietnamese", 4, 28.8, 82 )

# Winskel 2010 Reading and spelling acquisition in Thai children
# https://link.springer.com/article/10.1007/s11145-009-9194-6
# from Fig. 1 The percentage of correct responses for reading and spelling of words and nonwords across grade
# The first list consisted of 28 vowel-related words and the second list consisted of 29 tone-related words.
# The task did not appear to be timed, meaning children were only scored on correctness.
winskel_2010_thai.word = list("Thai", 58, 75, 20 )

nonword_error_data.c = rbind( nonword_error_data, pham_2020_vietnamese.word , winskel_2010_thai.word, 
                              stringsAsFactors=FALSE )
nonword_error_data.c

#                 FI           GR           IT           ES           PT           FR           AT
colorset_fig6 = c("#8f2525bb", "#000000bb", "#0c840cbb", "#495508bb", "#8cba11bb", "#225e3fbb", "#00376cbb", 
                  "#07233dbb", "#3a0246bb", "#821b98bb", "#a50fa0bb", "#0f41a5bb", "#c427ffbb", "#2a0fa5bb",
                  "#ddd714bb", "#e5f75bbb")
#                 DE           NO           IC           SW           NL           DK           UK
#                 VN           TH



pdf(file="~/git/misc-analyses/language_difficulty/images/seymour2003_fig6_data-correct.pdf", width=6, height=4, title="Fig 6 from Seymore 2003")
#png(file="~/git/misc-analyses/language_difficulty/images/seymour2003_fig6_data-correct.png", width=600, height=400, res=100, bg="white")
par(mar=c(6,4.5,4,1), xpd=TRUE)
b = barplot( t(as.matrix(100-nonword_error_data.c[,2:3])), beside=TRUE, 
         ylim=c(0,100), ylab="% correct words",
         main="",
         names.arg = c(rbind(nonword_error_data.c$language, rep("",nrow(nonword_error_data.c)))), las=2,
         col=rep( colorset_fig6, each=2) , 
         density=rep(c(NA,50),nrow(nonword_error_data.c)) , 
         angle=rep(c(315,45),nrow(nonword_error_data.c)) )
mtext(paste("Reading words aloud\nfor Grade 1 students (N =",min(nonword_error_data.c$N),"-",max(nonword_error_data.c$N),")"),
      side=3, at=-8, adj=0, line=1, font=2 , cex=1.2 )
legend(max(b),135, legend=c("Familiar words", "Nonwords"), col="#2a0fa5bb", density=c(NA,50) , bty='n', xjust = 1, yjust = 1 )
#legend("topleft", legend=c("Familiar words", "Nonwords"), col="#2a0fa5bb", density=c(NA,50), bty='n' )
dev.off()



# Jap 2017 Towards identifying dyslexia in Standard Indonesian: the development of a reading assessment battery
# https://pmc.ncbi.nlm.nih.gov/articles/PMC5574966/
# tests 100 words per minute, not 50 like in Vietnamese study

# Ogino 2011 Reading skills of Japanese second-graders
# https://pubmed.ncbi.nlm.nih.gov/20723104/

# Lee 2020 An Early Reading Assessment Battery for Multilingual Learners in Malaysia
# https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2020.01700/full


################################################################################
# Eriksson 1999 Swedish early communicative development inventories: words and gestures
# https://journals.sagepub.com/doi/10.1177/014272379901905503














#