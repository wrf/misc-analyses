# plot organ O2 levels
# created 2024-08-04
# datasets from reviews, and references therein:
# Ortiz-Prado et al (2019) Partial pressure of oxygen in the human body: a general review. Am J Blood Res.
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6420699/
#
# Carreau et al (2011) Why is the partial oxygen pressure of human tissues a crucial parameter? Small molecules and hypoxia. J Cell Mol Med.
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4373326/
# 
# Vaupel et al (2007) Detection and characterization of tumor hypoxia using pO2 histography. Antioxid Redox Signal
# https://pubmed.ncbi.nlm.nih.gov/17536958/
# 10.1089/ars.2007.1628

oxy_data_file = "~/git/misc-analyses/animal_oxygen/data/human_organ_oxygen_data.tab"
oxy_data = read.table(oxy_data_file, header=TRUE, sep="\t")

bar_colors = c("#ffffff","#b6e5edff")

pdf(file="~/git/misc-analyses/animal_oxygen/images/human_organ_oxygen_replot_v1.pdf", width=6, height=11 , title="Partial pressure of oxygen in the human body")
#png(file="~/git/misc-analyses/animal_oxygen/human_organ_oxygen_replot_v1.png", width=540, height=990 , res = 90)
par(mar=c(4.5,12,4,1))
m = matrix(c( rev(oxy_data$PtO2_mmHg_lower), rev(oxy_data$PtO2_upper)-rev(oxy_data$PtO2_mmHg_lower)), nrow=2, byrow=TRUE)
b = barplot(m, horiz=TRUE, 
        xlab="Oxygen Partial Pressure (mmHg)", border = FALSE,
        las=1, names=rev(oxy_data$Organ_and_Tissue), col=bar_colors,
        cex.lab = 1.2)
points( rev(oxy_data$PtO2_midpoint)[1:(nrow(oxy_data)-1)] , b[1:(nrow(oxy_data)-1)], pch=18, cex=2)
axis(3, line = -1)
mtext("Oxygen tension in human organs and tissues", at=20, line=2, font=2, cex=1.5)
dev.off()




################################################################################
# data from
# Vaupel et al (2007) Detection and characterization of tumor hypoxia using pO2 histography. Antioxid Redox Signal
# https://pubmed.ncbi.nlm.nih.gov/17536958/
# 10.1089/ars.2007.1628


cancer_oxy_file = "~/git/misc-analyses/animal_oxygen/data/vaupel2007_figure2_cancer_O2.txt"
cancer_oxy_data = read.table(cancer_oxy_file, header=TRUE, sep="\t")

o2_measurements.s = rep(unique(cancer_oxy_data$O2_mmHg),cancer_oxy_data.s$estimated_proportion)
#median(o2_measurements.s)
#hist(o2_measurements.s, bins=seq(0,100,2.5))

pdf(file="~/git/misc-analyses/animal_oxygen/images/vaupel2007_figure2_cancer_O2.pdf", width=8, height=7, title="Replot of Figure 2 from Vaupel 2007")
#png(file="~/git/misc-analyses/animal_oxygen/images/vaupel2007_figure2_cancer_O2.png", width=720, height=630, res=90 )
par(mar=c(4.5,4.5,3,1.2), mfrow=c(2,2))
cancer_oxy_data.s = cancer_oxy_data[which(cancer_oxy_data$tissue=="breast" & cancer_oxy_data$state=="normal"),]
b = barplot(cancer_oxy_data.s$estimated_proportion, ylim=c(0,80), col="#66b9c6ff",
            xlab="Tissue pO2 (mmHg)", ylab="N samples (out of 1009)", 
            main="Healthy breast",
            cex.axis=1.2, cex.lab=1.2 )
axis(1, at=seq(0.1, 48.1, 2.4), labels = rep(c(""),21), tick = TRUE )
axis(1, at=seq(0.1, 48.1, 4.8), labels = seq(0,100,10), tick = FALSE, cex=1.4 )
segments(b[26]+0.6,0,b[26]+0.6,80, lwd=2, col="#86100d88", lty=2)
text(b[26]+0.6, 72, "Median = 65mmHg",  col="#5d0b09ff", pos=2, cex=1.2)

cancer_oxy_data.s = cancer_oxy_data[which(cancer_oxy_data$state=="cancer" & cancer_oxy_data$tissue=="breast" ),]
b = barplot(cancer_oxy_data.s$estimated_proportion, ylim=c(0,250), col="#a18c80ff",
            xlab="Tissue pO2 (mmHg)", ylab="N samples (out of 851)", 
            main="Breast cancer (T1b - T4)",
            cex.axis=1.2, cex.lab=1.2 )
axis(1, at=seq(0.1, 48.1, 2.4), labels = rep(c(""),21), tick = TRUE )
axis(1, at=seq(0.1, 48.1, 4.8), labels = seq(0,100,10), tick = FALSE, cex=1.4 )
segments(b[4]+0.6,0,b[4]+0.6,250, lwd=2, col="#86100d88", lty=2)
text(b[4]+0.6, 225, "Median = 10mmHg",  col="#5d0b09ff", pos=4, cex=1.2)

cancer_oxy_data.s = cancer_oxy_data[which(cancer_oxy_data$tissue=="cervix" & cancer_oxy_data$state=="normal"),]
b = barplot(cancer_oxy_data.s$estimated_proportion, ylim=c(0,40), col="#66b9c6ff",
            xlab="Tissue pO2 (mmHg)", ylab="N samples (out of 432)", 
            main="Healthy cervix (nullipara)",
            cex.axis=1.2, cex.lab=1.2 )
axis(1, at=seq(0.1, 48.1, 2.4), labels = rep(c(""),21), tick = TRUE )
axis(1, at=seq(0.1, 48.1, 4.8), labels = seq(0,100,10), tick = FALSE, cex=1.4 )
segments(b[17]+0.6,0,b[17]+0.6,40, lwd=2, col="#86100d88", lty=2)
text(b[17]+0.6, 35, "Median = 42mmHg",  col="#5d0b09ff", pos=4, cex=1.2)

cancer_oxy_data.s = cancer_oxy_data[which(cancer_oxy_data$state=="cancer" & cancer_oxy_data$tissue=="cervix" ),]
b = barplot(cancer_oxy_data.s$estimated_proportion, ylim=c(0,4000), col="#a18c80ff",
            xlab="Tissue pO2 (mmHg)", ylab="N samples (out of 13596)", 
            main="Squamous cell carcinoma of uterine cervix",
            cex.axis=1.2, cex.lab=1.2 )
axis(1, at=seq(0.1, 48.1, 2.4), labels = rep(c(""),21), tick = TRUE )
axis(1, at=seq(0.1, 48.1, 4.8), labels = seq(0,100,10), tick = FALSE, cex=1.4 )
segments(b[4]+0.1,0,b[4]+0.1,4000, lwd=2, col="#86100d88", lty=2)
text(b[4]+0.1, 3500, "Median = 9mmHg",  col="#5d0b09ff", pos=4, cex=1.2)

dev.off()






#