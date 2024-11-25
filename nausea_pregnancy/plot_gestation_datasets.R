# plot various data about gestation and birth
# created 2024-10-31



# data from
# Morken 2014 Perinatal mortality by gestational week and size at birth in singleton pregnancies
# https://pmc.ncbi.nlm.nih.gov/articles/PMC4037279/

gestweek_data_file = "~/git/misc-analyses/nausea_pregnancy/data/morken_2014_perinatal_mortality_table3.txt"
gestweek_data = read.table(gestweek_data_file, header=TRUE, sep="\t")

total_births_non_sga = gestweek_data$Perinatal_deaths / (gestweek_data$Perinatal_deaths_per_1000/1000)
total_births_sga = gestweek_data$SGA_Perinatal_deaths / (gestweek_data$SGA_Perinatal_deaths_per_1000/1000)
total_births_combined = total_births_sga + total_births_non_sga 

total_birth_matrix = as.matrix(rbind(total_births_sga,total_births_non_sga))

pdf(file="~/git/misc-analyses/nausea_pregnancy/images/morken_2014_norway_births_by_week.pdf", height=5, width=6, title="Singleton births in Norway 1967-2006")
par(mar=c(3,4.5,4,1))
b = barplot( total_birth_matrix , names=c("37","38","39","40","41","42+") , 
         main="Singleton births in Norway 1967-2006", axes=FALSE,
         xlab="", ylab="Total Births by gestational week", cex.lab=1.4,
         col=c("#56349eff","#b59ce9ff") )
text(b, total_births_combined, paste0(round(total_births_combined/sum(total_births_combined)*100, digits=1),"%"), pos=1 )
legend(0,300000,legend=c("Small for\nGestational Age"), pch=15, pt.cex=2, col="#56349eff", xjust = 0, bty='n')
axis(2, at=c(0,1.25e5, 2.5e5, 3.75e5, 5e5))
dev.off()

#
# dataset 2
# from Yang 2010 Variation in Child Cognitive Ability by Week of Gestation Among Healthy Term Births
# https://pmc.ncbi.nlm.nih.gov/articles/PMC3435092/

gestweek_data_file = "~/git/misc-analyses/nausea_pregnancy/data/yang_2010_gestational_age_cognitive_ability_table1.txt"
gestweek_data = read.table(gestweek_data_file, header=TRUE, sep="\t", row.names = 1)
gestweek_data

boygirl_births = as.matrix( rbind( gestweek_data[1,1:7]*gestweek_data[4,1:7]/100,
                                   gestweek_data[1,1:7]*(100-gestweek_data[4,1:7])/100 ) )


pdf(file="~/git/misc-analyses/nausea_pregnancy/images/yang_2010_total_births.pdf", height=5, width=6, title="Singleton births in Norway 1967-2006")
par(mar=c(4.5,4.5,4,1))
barplot( boygirl_births , names=c(37:43), cex.axis=1.2,
         main="Singleton births from 1996-1997, in Belarus",
         xlab="Gestational week", ylab="Total Births", cex.lab=1.4,
         col=c("#1b2a9aff","#bd379bff") )
text( seq(0.7,7.9,1.2), gestweek_data[1,1:7], round(gestweek_data[1,1:7]/gestweek_data[1,8]*100,1),
      pos=c(3,3,3,1,3,3,3))
dev.off()



################################################################################
################################################################################
# datasets on birth time
#
# reviewed in 
# https://pmc.ncbi.nlm.nih.gov/articles/PMC5884320/

# also Zhang 2013
# https://pmc.ncbi.nlm.nih.gov/articles/PMC3660040/

# also Oladapo 2018
# https://pmc.ncbi.nlm.nih.gov/articles/PMC5770022/

# data from
# Suzuki et al (2010). Evaluation of the labor curve in nulliparous Japanese women.
# https://pubmed.ncbi.nlm.nih.gov/20494329/

suzukidata_file = "~/git/misc-analyses/nausea_pregnancy/data/suzuki_2010_cervical_dilation_time_table_2.tab"
suzukidata = read.table(suzukidata_file, header=TRUE, sep="\t")
cm_bin = (suzukidata$cm_low+suzukidata$cm_high)/2

plot( suzukidata$SH_percentile_95, suzukidata$cm_high, type='n', xlim=c(0,25), ylim=c(2.5,9.5),
      ylab="Cervical dilation (cm)", xlab="Time of first phase (hrs)" , frame.plot=FALSE, 
      cex.lab=1.3, cex.axis=1.3 )
lines( suzukidata$SH_median, cm_bin, col="#8e289088", lwd=12 )
polygon( c(suzukidata$SH_percentile_5, rev(suzukidata$SH_percentile_95)), 
         c(cm_bin, rev(cm_bin)), border = NA,
         col="#8e289066" )


################################################################################
# the apparently "classic" dataset from
# E.A.FRIEDMAN 1955 Primigravid labor; a graphicostatistical analysis
# https://pubmed.ncbi.nlm.nih.gov/13272981/
# 

delivdata_file = "~/git/misc-analyses/nausea_pregnancy/data/friedman_1955_primigravid_time_to_birth_fig2.txt"
delivdata = read.table(delivdata_file, header=TRUE, sep="\t")

delivaggs_file = "~/git/misc-analyses/nausea_pregnancy/data/friedman_1955_primigravid_time_to_birth_table1.txt"
delivaggs = read.table(delivaggs_file, header=TRUE, sep="\t")
delivaggs

# summary( rep(delivdata$hrs,delivdata$active_phase) )
# summary( rep(delivdata$hrs,delivdata$latent_phase) )
# summary( rep(delivdata$hrs_half[1:24],delivdata$max_slope_phase[1:24]) )
# summary( rep(delivdata$hrs_half[1:21],delivdata$deceleration_phase[1:21]) )

pdf(file="~/git/misc-analyses/nausea_pregnancy/images/friedman_1955_primigravid_time_to_birth_fig2a.pdf", width=8, height=8, title="Delivery time of 500 primigravid American women")
par(mar=c(4.5,4.5,3,1), mfrow=c(2,2))
plot( delivdata$hrs, delivdata$latent_phase, type='h', lwd=8, lend=1, frame.plot=FALSE,
      xlim=c(0,30), col=c(rep("#bf85c1",3),rep("#592db2ff",8),rep("#bf85c1",27)), 
      xlab="Latent phase time (hrs)", ylab="Count (out of 500 women)",
      main="Latent phase", cex.axis=1.2, cex.lab=1.2 )
segments(c(7.5,7.0),rep(0,2),c(7.5,7.0),rep(max(delivdata$latent_phase),2), lwd=6, col=c("#ae21eb88","#eb432188") )
plot( delivdata$hrs, delivdata$active_phase, type='h', lwd=9, lend=1, frame.plot=FALSE,
        xlim=c(0,25),  col=c(rep("#bf85c1",2),rep("#592db2ff",3),rep("#bf85c1",33)), 
        xlab="Active phase time (hrs)", ylab="Count (of 500 primigravid American women)",
        main="Active phase")
segments(c(4.0,3.3),rep(0,2),c(4.0,3.3),rep(max(delivdata$active_phase),2), lwd=6, col=c("#ae21eb88","#eb432188") )
plot( delivdata$hrs_half, delivdata$max_slope_phase, type='h', lwd=10, lend=1, frame.plot=FALSE,
      xlim=c(0,12), col=c(rep("#bf85c1",2),rep("#592db2ff",6),rep("#bf85c1",16)), 
      xlab="Max slope phase time (hrs)", ylab="Count (of 500 primigravid American women)",
      main="Max slope phase")
segments(c(2.5,2.4),rep(0,2),c(2.5,2.4),rep(max(delivdata$max_slope_phase[1:20]),2), lwd=6, col=c("#ae21eb88","#eb432188") )
plot( delivdata$hrs_half, delivdata$deceleration_phase, type='h', lwd=10, lend=1, frame.plot=FALSE,
      xlim=c(0,10), col=c(rep("#bf85c1",1),rep("#592db2ff",2),rep("#bf85c1",17)), 
      xlab="Deceleration phase time (hrs)", ylab="Count (of 500 primigravid American women)",
      main="Deceleration phase")
segments(c(0.8,0.6),rep(0,2),c(0.8,0.6),rep(max(delivdata$deceleration_phase[1:20]),2), lwd=6, col=c("#ae21eb88","#eb432188") )
dev.off()



# summary( rep(delivdata$hrs,delivdata$first_stage) )
# summary( rep(delivdata$hrs_minutes[1:30],delivdata$second_stage[1:30]) )

pdf(file="~/git/misc-analyses/nausea_pregnancy/images/friedman_1955_primigravid_time_to_birth_fig2b.pdf", width=8, height=4, title="Delivery time of 500 primigravid American women")
par(mar=c(4.5,4.5,3,1), mfrow=c(1,2))
plot( delivdata$hrs, delivdata$first_stage, type='h', lwd=6, lend=1, axes=FALSE,
      col=c(rep("#bf85c1",6),rep("#592db2ff",7),rep("#bf85c1",25)),
      xlab="First stage time (hrs)", ylab="Count (out of 500 women)",
      main="First stage of delivery", cex.axis=1.2, cex.lab=1.2 )
axis(2, cex.axis=1.3 )
axis(1, at=seq(0,38,1), labels=FALSE , lwd = 0.5 )
axis(1, at=seq(0,35,5), labels=seq(0,35,5), cex.axis=1.1 )
med_timing = median(rep(delivdata$hrs,delivdata$first_stage))
segments(med_timing, 0, med_timing, max(delivdata$first_stage), lwd=6, col="#eb432188")
legend("right", legend=c("Median"), lwd=5, col="#eb4321aa", bty='n' )
legend("topright", legend=c("Interquartile\nrange"), pt.cex = 2, col="#592db2ff", pch=15, bty='n' )
plot( delivdata$hrs_minutes, delivdata$second_stage, type='h', lwd=8, lend=1, frame.plot=FALSE,
      xlim=c(0,5), col=c(rep("#bf85c1",2),rep("#592db2ff",6),rep("#bf85c1",22)),
      xlab="Second stage time (hrs)", ylab="Count (out of 500 women)",
      main="Second stage of delivery", cex.axis=1.2, cex.lab=1.2 )
med_timing = median(rep(delivdata$hrs_minutes[1:25],delivdata$second_stage[1:25]))
segments(med_timing,0,med_timing,max(delivdata$second_stage[1:25]), lwd=6, col="#eb432188")
legend("right", legend=c("Median"), lwd=5, col="#eb4321aa", bty='n' )
legend("topright", legend=c("Interquartile\nrange"), pt.cex = 2, col="#592db2ff", pch=15, bty='n' )
dev.off()









#