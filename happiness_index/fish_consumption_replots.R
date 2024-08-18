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
#                  Americas     Asia         Europe            ME + NA      Africa
region_colors = c("#ad040488", "#045aad88", "#81048d88", "#8d890488", "#04ad1d88")
region_areas = c("Americas", "Asia-Pacific", "Europe", "Middle East and North Africa", "Sub-Saharan Africa")
region_colors.matched = region_colors[match(unique(fish_data$area),region_areas)]
region_matches = match( fish_data$area, unique(fish_data$area) )

#pdf(file="~/git/misc-analyses/happiness_index/images/hibbeln_1998_fish_vs_depression.pdf", height=5, width=5 , title="Replot of Figure 1 from Hibbeln 1998")
png(file="~/git/misc-analyses/happiness_index/images/hibbeln_1998_fish_vs_depression.png", height=450, width=450, res = 90 )
par(mar=c(4.5,5.5,4,1))
plot(fish_data[["fish_lbs_person"]], fish_data[["pct_depression"]],
     xlim=c(20,160),
     xlab = "Fish consumption (lbs per person)",
     ylab = "Annual Prevalence of Major depression\n(rate / 100 people)",
     main = "Figure 1 from Hibbeln 1998",
     pch=16, cex=2, col=region_colors.matched[region_matches],
     cex.lab=1.3, cex.axis=1.2)
text(fish_data[["fish_lbs_person"]], fish_data[["pct_depression"]],
     fish_data[["country"]], pos=c(rep(4,4),2,rep(4,3),2), font=2)
rline = lm( fish_data[["pct_depression"]] ~ fish_data[["fish_lbs_person"]] )
abline(rline, lty=2, lwd=2, col="#00000088")
text(130, 5, paste("R2:",round(c(summary(rline)$r.squared),digits=4) ), font=1 )
text(130, 4.5, paste("Coeff:",round(rline$coefficients[2],digits=4) ), font=1 )
text(130, 4, paste("P-val:",round(summary(rline)$coefficients[2,4],digits=6) ), font=1 )
dev.off()


################################################################################
# data from
# Hibbeln 2006 Healthy intakes of n−3 and n–6 fatty acids: estimations considering worldwide diversity
# https://doi.org/10.1093/ajcn/83.6.1483S


omega_data_file = "~/git/misc-analyses/happiness_index/data/hibbeln_2006_worldwide_omega_fat_table2.txt"
omega_data = read.table(omega_data_file, header=TRUE, sep="\t")

region_colors = c("#ad040488", "#045aad88", "#81048d88", "#8d890488", "#04ad1d88")
region_areas = c("Americas", "Asia-Pacific", "Europe", "Middle East and North Africa", "Sub-Saharan Africa")
region_colors.matched = region_colors[match(unique(omega_data$area),region_areas)]
region_matches = match( omega_data$area, unique(omega_data$area) )

names(omega_data)
condition_list = c("CHD_mortality_M", "Stroke_mortality_M", "CVD_mortality_M",
                   "Postpartum_depression3", "Major_depression4", "Bipolar_disorder5")
ylab_list = c(rep("Mortality per 100k people",3), "Point prevalence %", "Annual prevalence %", "Lifetime prevalence %")
main_list = c("CHD mortality (male)", "Stroke mortality (male)", "CVD mortality (male)", "Postpartum depression", "Major depression", "Bipolar disorder")

i=1

pdf(file="~/git/misc-analyses/happiness_index/images/hibbeln_2006_worldwide_omega_fat_table2.pdf", width=8, height = 6, title="Omega-3 LCFA and health")
par(mar=c(4.5,4.5,3,2), mfrow=c(2,3))
for (i in 1:6){
plot(omega_data$Dietary_n3_LCFAs_pct, omega_data[[condition_list[i]]],
     xlim = c(0,0.55), ylim = c(0, max(na.omit(omega_data[[condition_list[i]]]))*1.1 ),
     xlab = ifelse(i %in% c(2,5),"Omega-3 LCFA consumption (% diet)",""),
     ylab = ylab_list[i],
     main = main_list[i],
     pch=16, cex=2, col=region_colors.matched[region_matches],
     cex.lab=1.3, cex.axis=1.2 )
text( omega_data$Dietary_n3_LCFAs_pct, omega_data[[condition_list[i]]],
      omega_data$Country, pos=4)
}
dev.off()




fat_data_file = "~/git/misc-analyses/happiness_index/data/hibbeln_2006_worldwide_omega_fat_table1.txt"
fat_data = read.table(fat_data_file, header=TRUE, sep="\t", row.names = 1)# %>% replace(is.na(.), 0)

head(fat_data)

fat_bar_colors = c("#fbd283ff", "#d48218ff", 
                   "#8cd7fbff", "#2eabd5ff", "#2270a0ff", "#14415cff")

pdf(file="~/git/misc-analyses/happiness_index/images/hibbeln_2006_worldwide_omega_fat_table1.pdf", width=8, height=11, paper="a4", title="Food sources of Omega-3 fats")
par(mar=c(4,11,3,2))
barplot( t(as.matrix(fat_data[(55:1),])) , horiz=TRUE, xlim=c(0,4000),
         xlab="Fatty acids (mg/100g)", cex.axis=1.2, cex.lab=1.2,
         col=fat_bar_colors,
         las=1, names.arg = rev(fat_data$Commodities2), cex.names=0.6 )
legend(2000,60,legend=names(fat_data), bty='n', pch=15, col=fat_bar_colors, cex=1.2 )
dev.off()

################################################################################

food_data_file = "~/git/misc-analyses/happiness_index/data/us_food_supply_1907-1997_table_12_polyunsaturated_fats.txt"
food_data = read.table(food_data_file, header=TRUE, sep="\t")

head(food_data)

food_data_years = sapply(strsplit(food_data$Year, "-"),"[",1)
plot(food_data_years, food_data$Edible.oils, type='n' , ylim=c(0,50) )
lines(food_data_years, food_data$Butter, lwd=8, col="#fbd283aa")
lines(food_data_years, food_data$Edible.oils, lwd=8, col="#d48218aa")
lines(food_data_years, food_data$Lard.and.beef.tallow, lwd=8, col="#b43218aa")


#