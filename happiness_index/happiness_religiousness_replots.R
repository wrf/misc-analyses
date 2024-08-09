# replots on religiousness and happiness
# created 2024-08-09

# dataset from:
# Okulicz-Kozaryn (2011) Does religious diversity make us unhappy
# http://dx.doi.org/10.1080/13674676.2010.550277
# Table 5 Means of main variables by country

happy_data_file = "~/git/misc-analyses/happiness_index/data/okulicz-kozaryn_2011_table5.txt"
happy_data = read.table(happy_data_file, header=TRUE, sep="\t")

#               "Europe"    "Americas"  "Asia-Pacific" "Middle East and North Africa" "Sub-Saharan Africa"
region_colors = c("#81048d88", "#ad040488", "#045aad88", "#8d890488", "#04ad1d88")
region_matches = match( happy_data$region, unique(happy_data$region) )

# remake of Figure 1
pdf(file="~/git/misc-analyses/happiness_index/images/okulicz-kozaryn_2011_figure1_redo.pdf", width=7, height=6, title="Figure 1 Religious fractionalisation and well-being")
par(mar=c(4.5,4.5,3,2))
happy_fract = lm( happiness ~ fractionalization, data=happy_data )
fract_x = seq(0, 1, length.out=dim(happy_data)[1])
fract_pred = predict(happy_fract, data.frame(fractionalization=fract_x), interval = 'confidence')
plot(happy_data$fractionalization, happy_data$happiness, frame.plot=FALSE,
     xlim=c(0,1), ylim=c(3.5,8.5), cex.axis=1.3, cex.lab=1.3,
     xlab="Fractionalization (degree that religious groups are fragmented)", 
     ylab="Happiness (by life satisfaction survey)", 
     main="Religious fractionalisation and well-being", type='n')
abline(happy_fract, lwd=2, col="#00000066")
polygon(c(rev(fract_x), fract_x), c(rev(fract_pred[ ,3]), fract_pred[ ,2]), col = "#00000011", border = NA)
lines(fract_x, fract_pred[,2], lty = 2, col="#00000066")
lines(fract_x, fract_pred[,3], lty = 2, col="#00000066")
points(happy_data$fractionalization, happy_data$happiness,
       col=region_colors[region_matches], pch=19, cex=2 )
text(happy_data$fractionalization, happy_data$happiness, happy_data$code, cex=0.5, pos=1)
dev.off()

# remake of Figure 2
pdf(file="~/git/misc-analyses/happiness_index/images/okulicz-kozaryn_2011_figure2_redo.pdf", width=7, height=6, title="Figure 2 Religious polarisation and well-being")
par(mar=c(4.5,4.5,3,2))
happy_data.no_na = happy_data[!is.na(happy_data$polarization),]
happy_polar = lm( happiness ~ polarization, data=happy_data.no_na )
polar_x = seq(0, 1, length.out=dim(happy_data.no_na)[1])
polar_pred = predict(happy_polar, data.frame(polarization=polar_x), interval = 'confidence')
plot(happy_data.no_na$polarization, happy_data.no_na$happiness, frame.plot=FALSE,
     xlim=c(0,1), ylim=c(3.5,8.5), cex.axis=1.3, cex.lab=1.3,
     xlab="Polarization (degree people are divided into two relgious groups)", 
     ylab="Happiness (by life satisfaction survey)", 
     main="Religious polarisation and well-being", type='n' )
abline(happy_polar, lwd=2, col="#00000066")
polygon(c(rev(polar_x), polar_x), c(rev(polar_pred[ ,3]), polar_pred[ ,2]), col = "#00000011", border = NA)
lines(polar_x, polar_pred[,2], lty = 2, col="#00000066")
lines(polar_x, polar_pred[,3], lty = 2, col="#00000066")
points(happy_data.no_na$polarization, happy_data.no_na$happiness, 
       col=region_colors[region_matches][!is.na(happy_data$polarization)], pch=19, cex=2)
text(happy_data.no_na$polarization, happy_data.no_na$happiness, happy_data.no_na$code, cex=0.5, pos=1)
dev.off()


#