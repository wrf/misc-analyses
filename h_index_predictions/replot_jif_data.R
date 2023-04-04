# journal impact factor replots
# taking data from the analysis by
# https://github.com/rmflight/curry_jif_paper
# which was meant to replicate
# https://www.biorxiv.org/content/10.1101/062109v2.full
# modified 2023-04-04

pdf(file="~/git/misc-analyses/h_index_predictions/citation_distributions_2014_v1.pdf", width=8, height=11)

par(mfrow=c(4,2), mar=c(2,4.5,3,1))
jdata_files = c("~/git/misc-analyses/h_index_predictions/data/nature_main.txt.gz",
              "~/git/misc-analyses/h_index_predictions/data/science_aaas.txt.gz",
              "~/git/misc-analyses/h_index_predictions/data/naturecommunications.txt.gz",
              "~/git/misc-analyses/h_index_predictions/data/elife.txt.gz",
              "~/git/misc-analyses/h_index_predictions/data/embojournal.txt.gz",
              "~/git/misc-analyses/h_index_predictions/data/plosbiology.txt.gz",
              "~/git/misc-analyses/h_index_predictions/data/plosgenetics.txt.gz" )
journal_names = c("Nature", "Science", "Nature Communications", "eLife", 
                  "EMBO Journal", "PLOS Biology", "PLOS Genetics")

nature_data = read.table(jdata_files[1], header = TRUE, sep = ",", skip = 4)
j2014_citations = sort(nature_data$X2014, decreasing=TRUE)
NAT_jif_line = mean(j2014_citations)
jif_cutoff = min(which(j2014_citations < NAT_jif_line))
p_below_jif = sum(as.integer(j2014_citations < NAT_jif_line))
total_p = length(j2014_citations)
barplot( j2014_citations , col="#00000088", space=0, border = NA, main=journal_names[1],
         ylab="Citations (n)", cex.lab=1.1)
mtext(paste(length(j2014_citations),"Papers (ranked by citations)"),side = 1, line = 0.5, cex = 0.8)
text(jif_cutoff, 2*NAT_jif_line, paste("IF:",round(NAT_jif_line,1)), pos=4 )
text(jif_cutoff, 4*NAT_jif_line, 
     paste(p_below_jif, "out of", total_p, "papers below IF (",round(p_below_jif/total_p*100,1),"%)"), pos=4 )
segments(0, NAT_jif_line, length(j2014_citations), NAT_jif_line, col="#0ebc51aa", lwd=4)
segments(jif_cutoff, 0, jif_cutoff, max(j2014_citations), col="#0ebc51aa", lwd=4)


for (i in 2:7){
  jdata_file = read.table(jdata_files[i], header = TRUE, sep = ",", skip = 4)
  j2014_citations = sort(jdata_file[["X2014"]], decreasing=TRUE)
  jif_line = mean(j2014_citations)
  jif_cutoff = min(which(j2014_citations < jif_line))
  n_better_than_Nat = sum(as.integer(j2014_citations > NAT_jif_line))

  barplot( j2014_citations , col="#00000088", space=0, border = NA, main=journal_names[i],
           ylab="Citations (n)", cex.lab=1.1)
  mtext(paste(length(j2014_citations),"Papers (ranked by citations)"),side = 1, line = 0.5, cex = 0.8)
  segments(0, jif_line, length(j2014_citations), jif_line, col="#0e5190aa", lwd=4)
  segments(0, NAT_jif_line, length(j2014_citations), NAT_jif_line, col="#0ebc51aa", lwd=4)
  segments(jif_cutoff, 0, jif_cutoff, max(j2014_citations), col="#0e5190aa", lwd=4)
  text(jif_cutoff, jif_line + max(j2014_citations)*0.05, paste("IF:",round(jif_line,1)), pos=4 )
  text(jif_cutoff, NAT_jif_line + max(j2014_citations)*0.15, 
       paste(n_better_than_Nat, "papers (", round(n_better_than_Nat/length(j2014_citations)*100,1),  "%)", "\nwith more ciations than Nature IF"),
       pos=4)
}

dev.off()






