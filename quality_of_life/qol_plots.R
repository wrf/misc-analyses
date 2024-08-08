# plot tax revenue vs quality of life index, and other measures
# data from:
# https://www.numbeo.com/quality-of-life/rankings_by_country.jsp
# https://en.wikipedia.org/wiki/List_of_countries_by_tax_revenue_to_GDP_ratio
# created by WRF 2022-11-07

tax_revenue_file = "~/git/misc-analyses/quality_of_life/data/tax_revenue_vs_GDP_by_country_2020_wiki.tab"
tax_revenue = read.table(tax_revenue_file, header = TRUE, sep = "\t", quote = '"')
tax_rev_countries = tax_revenue$country

qol_data_file = "~/git/misc-analyses/quality_of_life/data/quality_of_life_index_2021_numbeo.tab"
qol_data = read.table(qol_data_file, header = TRUE, sep = "\t", quote = '"')

qol_countries = qol_data$Country

matched_countries = na.omit( match(qol_countries, tax_rev_countries) )
matched_countries

# color code by region
# very few sub saharan africa
# > table(tax_revenue$Region[matched_countries])
# Americas                 Asia-Pacific                       Europe 
# 12                           18                           38 
# Middle East and North Africa           Sub-Saharan Africa 
# 11                            3 
unique(tax_revenue$Region[matched_countries])
region_matches = match(tax_revenue$Region[matched_countries], unique(tax_revenue$Region[matched_countries]))
region_colors = c("#81048d88", "#045a8d88", "#8d890488", "#8d040488", "#048d1d88")

td = data.frame(tax = tax_revenue$tax_revenue_pct_GDP[matched_countries],
                qol = qol_data$Quality.of.Life.Index[-41] )
qol_vs_tax = lm( qol ~ tax, td )
qol_vs_tax.r = round(summary(qol_vs_tax)$r.squared,digits=4)
tax_x = seq(0, 50, length.out=dim(td)[1] )
qol_pred = predict(qol_vs_tax, data.frame(tax=tax_x), interval = 'confidence')

# move some to left side for clearer display
label_move_left=c(3, 9, 19, 22, 26, 32, 40, 44, 48, 51, 60, 70, 73, 77, 81)
label_pos = rep(4,length(matched_countries))
label_pos[label_move_left] = 2

# v2 plot
pdf(file = "~/git/misc-analyses/quality_of_life/images/qol_vs_tax_revenue_v2.pdf", width = 10, height = 8)
par(mar=c(4.5,4.5,1,2))
plot( tax_revenue$tax_revenue_pct_GDP[matched_countries] , qol_data$Quality.of.Life.Index[-41],
      xlim = c(0,55), ylim = c(0,200), frame.plot = FALSE, cex.axis=1.3, cex.lab=1.3,
      xlab = "Tax revenue as percent GDP 2020", ylab = "Quality of Life Index 2021",
      type='n' )
segments(0,qol_vs_tax$coefficients[1],50,qol_vs_tax$coefficients[1]+50*qol_vs_tax$coefficients[2], 
         lwd=3, col="#00000033")
polygon(c(rev(tax_x), tax_x), c(rev(qol_pred[ ,3]), qol_pred[ ,2]), col = "#00000011", border = NA)
lines(tax_x, qol_pred[,2], lty = 2, col="#00000023")
lines(tax_x, qol_pred[,3], lty = 2, col="#00000023")
points( tax_revenue$tax_revenue_pct_GDP[matched_countries] , qol_data$Quality.of.Life.Index[-41],
      pch=16, cex=3, col=region_colors[region_matches] )
text(tax_revenue$tax_revenue_pct_GDP[matched_countries] , qol_data$Quality.of.Life.Index[-41], 
     tax_rev_countries[matched_countries], pos = label_pos )
text(0, 10, bquote( "R"^2 == .(rs), list(rs=qol_vs_tax.r) ), col="black", cex=1.5, pos=4 )
legend(30,60, legend = unique(tax_revenue$Region[matched_countries]), 
       pch = 16, pt.cex = 3, cex = 1.5, col = region_colors)
dev.off()


