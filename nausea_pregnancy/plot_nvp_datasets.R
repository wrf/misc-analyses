# plot NVP data from Tierson 1986
# https://doi.org/10.1016/0002-9378(86)90337-6
# plot aversion/craving data from Flaxman 2000
# http://www.jstor.org/stable/10.2307/2664252
#
# last modified 2022-06-06

library(ggplot2)
library(tidyr)

nvp_data_file = "~/git/misc-analyses/nausea_pregnancy/data/tierson_1986_fig3_nvp.txt"
nvp_data = read.table(nvp_data_file, header=TRUE, sep="\t")

gg = ggplot(data=nvp_data, aes(x=weeks, y=nausea_percent) ) +
  theme(legend.position="none",
        axis.text=element_text(size=16),
        axis.title=element_text(size=18),
        plot.title = element_text(size=20) ) +
  labs(x="Weeks", y="Percentage of women",
       title="Women reporting NVP by week of pregnancy",
       caption="Data from Tierson 1986 Am J Obstet Gynecol Figure 3") +
  geom_line(size=5, color="#fe9929cc", lineend="round") +
  geom_line(data=nvp_data, aes(x=weeks, y=vomiting_percent), size=5, color="#62801dcc", lineend="round") +
  # rect is appx of 40th day to 4 months, calculated as 40/7 and 4*(365/12)/7
  annotate(geom="rect", xmin=5.7, xmax=17.3, ymin=15, ymax=20, fill="#238b45aa") +
  annotate(geom="text", x=7, y=7, label="Vomiting period\naccording to Soranus (40 days to 4 months)", color="#238b45", size=5, hjust=0) +
  annotate(geom="text", x=11, y=70, label="Nausea", color="#fe9929", size=5, hjust=0) +
  annotate(geom="text", x=7, y=45, label="Vomiting", color="#62801d", size=5, hjust=0)

ggsave("~/git/misc-analyses/nausea_pregnancy/images/nvp_from_tierson_1986_fig3.pdf", gg,
       device="pdf", height=4, width=8)


####################
####################
# make second figure

f2000_fa_file = "~/git/misc-analyses/nausea_pregnancy/data/flaxman_2000_fig7.txt"
f2000_fa = read.table(f2000_fa_file, header=TRUE, sep="\t")
f2000_fa_pivot = pivot_longer(f2000_fa, cols=c("aversions","cravings"), 
                              names_to = "reaction",
                              values_to = "percentage")

f2000_fa_pivot$food_item = factor(f2000_fa_pivot$food_item, levels=f2000_fa$food_item)

gg = ggplot(data=f2000_fa_pivot, aes(x=food_item, y=percentage, fill=reaction) ) +
  theme(legend.position="none",
        axis.text=element_text(size=10),
        axis.title=element_text(size=18),
        plot.title = element_text(size=20) ) +
  labs(x=NULL, y="Percentage of women",
       title="Women reporting food aversions or cravings while pregnant",
       caption="Data from Flaxman 2000 Q Rev Biol Figure 7") +
  scale_fill_manual( values=c("#fe9929", "#7879c6") ) +
  scale_y_continuous( limits = c(0,30), expand = expansion(0,0.01) ) +
  scale_x_discrete( labels = gsub(" ","\n",as.character(f2000_fa$food_item)) ) +
  geom_col(position = "dodge", width=0.8) +
  annotate(geom="text", x=1.5, y=25, label="Aversions", color="#fe9929", size=8, hjust=0) +
  annotate(geom="text", x=9, y=25, label="Cravings", color="#7879c6", size=8, hjust=1)

ggsave("~/git/misc-analyses/nausea_pregnancy/images/food_cravings_flaxman_2000_fig7.pdf", gg,
       device="pdf", height=5, width=8)


################################################################################

# plot data from
# Rodriguez et al (2001) Symptoms across pregnancy in relation to psychosocial and biomedical factors
# https://doi.org/10.1034/j.1600-0412.2001.080003213.x

symptom_datafile = "~/git/misc-analyses/nausea_pregnancy/data/rodriguez_2001_table2.txt"
symptom_data = read.table(symptom_datafile, header = TRUE, sep="\t", stringsAsFactors = FALSE)

week_labs = c("10-12", "20", "28", "32-36")

occ_cols = rep(c("#eecc66", "#d082e2", "#aaaaaa", "#d88496"), c(8, 8, 7, 4) )
frq_cols = rep(c("#cc9966", "#8b12a7", "#666666", "#ca123b"), c(8, 8, 7, 4) )
               
pdf(file="~/git/misc-analyses/nausea_pregnancy/images/rodriguez_2001_table2.all.pdf", width=8, height=11)
par(mfrow=c(5,3), mar=c(4,4,2,1)) # 5 rows per page, 27 plots total
for (i in 1:dim(symptom_data)[1]){
  subdataset = symptom_data[i,]
  bp_df = data.frame( subdataset[grep("frq",names(symptom_data))] ,
                      subdataset[grep("occ",names(symptom_data))] )
  #bp_df
  bp_m = matrix(bp_df, nrow=2, byrow = TRUE)
  #bp_m
  barplot(bp_m,  ylim=c(0,100), col = c(frq_cols[i], occ_cols[i]),
          cex.axis = 1.2, cex.names = 1.2, axes = FALSE,
          main = subdataset[1], cex.main=1.5,
          beside=FALSE, names.arg = week_labs )
  axis(2,at=c(0,25,50,75,100), cex.axis=1.2)
  mtext("Week:", 1, at=-0.4, line=1, cex=0.9 )
  # plot legend for left plot on each row
  if(i %in% c(1,4,7,10,13,16,19,22,25)){ 
    legend(0,100, legend=c("Occasional", "Frequent"), bty = 'n', 
           col=c(occ_cols[i], frq_cols[i]), pch=15, cex=1.5 )
    }
}
dev.off()


################################################################################
# data from:
# Zhang et al 2020 Risk Factors of Prolonged Nausea and Vomiting During Pregnancy.
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7682611/

risk_data_file = "~/git/misc-analyses/nausea_pregnancy/data/zhang_2020_table2.txt"
risk_data = read.table(risk_data_file, header=TRUE, sep="\t")

head(risk_data)

risk_variables = unique(risk_data$variable[3:46])[5:14]
risk_variables

mild_cols = rep(c("#eeeeee", "#f1c0ca", "#c0c7f1" ), c(0, 10, 0) )
modt_cols = rep(c("#aaaaaa", "#d88496", "#8492d8" ), c(0, 10, 0) )
sevr_cols = rep(c("#666666", "#ca123b", "#6666cc" ), c(0, 10, 0) )
sig_stars = c("**", "**", "*", "", "", "", "**", "", "*", "")

pdf(file="~/git/misc-analyses/nausea_pregnancy/images/zhang_2020_table2.pdf", height=11, width=8, paper="a4", title="NVP risk factors")
par(mfrow=c(10,2))
for (i in 1:length(risk_variables)){
  par(mar=c(3,1,1,2))
  factor_rows = which(risk_data$variable==risk_variables[i])
  factor_rows
  risk_factor = risk_data[rev(factor_rows),c(4,6,8)]
  risk_factor
  risk_factor.pct = risk_data[rev(factor_rows),c(5,7,9)]
  #chisq.test(risk_factor)
  barplot( t(as.matrix(risk_factor)), horiz=TRUE, axisnames=FALSE,
           main=risk_variables[i],
           col=c(mild_cols[i], modt_cols[i], sevr_cols[i]) )
  mtext(sig_stars[i], side=4, line=1, las=1, cex=2 )
  par(mar=c(3,6,1,1))
  barplot( t(as.matrix(risk_factor.pct)), horiz=TRUE, 
           main=paste(risk_variables[i],"(percent)"),
           names = rev(risk_data[factor_rows,3]), las=1,
           col=c(mild_cols[i], modt_cols[i], sevr_cols[i]) )
}
dev.off()

################################################################################
# data from:
# Grooten et al 2017 Helicobacter pylori infection: a predictor of vomiting severity in pregnancy and adverse birth outcome.
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5426529/

hpyl_data_file = "~/git/misc-analyses/nausea_pregnancy/data/grooten_2017_table1.txt"
hpyl_data = read.table(hpyl_data_file, header=TRUE, sep="\t")




#