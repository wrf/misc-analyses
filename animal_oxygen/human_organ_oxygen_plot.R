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

oxy_data_file = "~/git/misc-analyses/animal_oxygen/human_organ_oxygen_data.tab"
oxy_data = read.table(oxy_data_file, header=TRUE, sep="\t")

bar_colors = c("#ffffff","#b6e5edff") #66b9c6ff

pdf(file="~/git/misc-analyses/animal_oxygen/human_organ_oxygen_replot_v1.pdf", width=6, height=11 , title="Partial pressure of oxygen in the human body")
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



#