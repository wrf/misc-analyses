# replots of essential fatty acids vs health topics
# created by WRF 2024-08-09
#

# epidemiology of proposed role of omega 3 with depression
# Hibbeln JR 1998 Fish consumption and major depression. Lancet
# https://doi.org/10.1016/S0140-6736(05)79168-6

fish_data = read.table("~/git/misc-analyses/happiness_index/data/hibbeln_1998_fish_vs_depression.tab", header=TRUE, sep='\t')
fish_data
unique(fish_data$area) 

# match colors from other plots
#                  Asia         Europe       Americas     ME + NA      Africa
region_colors = c("#045aad88", "#81048d88", "#ad040488", "#8d890488", "#04ad1d88")
region_matches = match( fish_data$area, unique(fish_data$area) )

#pdf(file="~/git/misc-analyses/happiness_index/images/hibbeln_1998_fish_vs_depression.pdf", height=5, width=5 , title="Replot of Figure 1 from Hibbeln 1998")
png(file="~/git/misc-analyses/happiness_index/images/hibbeln_1998_fish_vs_depression.png", height=450, width=450, res = 90 )
par(mar=c(4.5,5.5,4,1))
plot(fish_data[["fish_lbs_person"]], fish_data[["pct_depression"]],
     xlim=c(20,160),
     xlab = "Fish consumption (lbs per person)",
     ylab = "Annual Prevalence of Major depression\n(rate / 100 people)",
     main = "Figure 1 from Hibbeln 1998",
     pch=16, cex=2, col=region_colors[region_matches],
     cex.lab=1.3, cex.axis=1.2)
text(fish_data[["fish_lbs_person"]], fish_data[["pct_depression"]],
     fish_data[["country"]], pos=c(rep(4,4),2,rep(4,3),2), font=2)
rline = lm( fish_data[["pct_depression"]] ~ fish_data[["fish_lbs_person"]] )
abline(rline, lty=2, lwd=2, col="#00000088")
text(130, 5, paste("R2:",round(c(summary(rline)$r.squared),digits=4) ), font=1 )
text(130, 4.5, paste("Coeff:",round(rline$coefficients[2],digits=4) ), font=1 )
text(130, 4, paste("P-val:",round(summary(rline)$coefficients[2,4],digits=6) ), font=1 )
dev.off()






#