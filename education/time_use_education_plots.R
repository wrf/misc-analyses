# education hours compared to adult work
# 
#

# American Time Use Survey - 2022
# https://www.bls.gov/tus/data/datafiles-2022.htm
# 


# OECD Teaching and Learning International Survey (TALIS)
# https://www.oecd.org/en/data/datasets/talis-2018-database.html
# https://webfs.oecd.org/talis/index.html


#atus2022_file = "~/git/misc-analyses/education/ATUS/atussum-2022/atussum_2022.dat"
atus2022_file = "~/git/misc-analyses/education/ATUS/atusact-2022/atusact_2022.dat"
atus2022_data = read.table( atus2022_file , header=TRUE, sep=",")


table( atus2022_data$TUACTDUR24 )

# OECD Survey of Adult Skills
# Programme for the International Assessment of Adult Competencies (PIAAC)
# https://www.oecd.org/en/about/programmes/piaac.html


#Table A.4.16
#Effect of qualification mismatches, skills mismatches and field of study mismatches on wages
oecd_overqualified_data = read.table(text="OECD_country	overqualified_b100	overqualified_p-value
Austria	-6.58282	0.00026473
Canada	-12.32878	0.00000000
Chile	-20.00619	0.00236740
Czechia	-8.69129	0.00001234
Denmark	-12.76837	0.00000000
Estonia	-10.76391	0.00000010
Finland	-7.41853	0.00038262
France	-11.83078	0.00000000
Germany	-12.98347	0.00000000
Hungary	-15.13019	0.00000001
Ireland	-13.41852	0.00000120
Israel	-13.87199	0.00743763
Italy	2.45573	0.48707141
Japan	-9.62093	0.00000001
Korea	-7.29480	0.13025650
Latvia	-10.31076	0.00009766
Lithuania	-16.91890	0.00000000
Netherlands	-12.11547	0.00000010
New Zealand	-17.22842	0.00000000
Norway	-12.15596	0.00000006
Poland	-5.98630	0.04909025
Portugal	-16.90517	0.00000028
Slovak Republic	-16.81065	0.00000000
Spain	-16.71314	0.00000000
Sweden	-6.93962	0.00000048
Switzerland	-16.92885	0.00000000
United States	-18.89302	0.00000002
England (UK)	-17.91612	0.00000000
Flemish Region (Belgium)	-15.99966	0.00000000
Croatia	-7.29881	0.00933542
Singapore	-20.00488	0.00000000", header=TRUE, sep="\t" )

oecd_overqualified_data.sort_index = sort(oecd_overqualified_data$overqualified_b100, decreasing = TRUE , index.return=TRUE )

b = barplot( oecd_overqualified_data$overqualified_b100[oecd_overqualified_data.sort_index$ix],
         col=ifelse( oecd_overqualified_data$overqualified_p.value[oecd_overqualified_data.sort_index$ix] < 0.05 , "#cc4411aa", "#aa9988aa") )
text(b+0.6, c(0,oecd_overqualified_data$overqualified_b100[oecd_overqualified_data.sort_index$ix][-1])-1, 
     oecd_overqualified_data$OECD_country[oecd_overqualified_data.sort_index$ix] , srt=90, pos=2 )



################################################################################
# PISA 2015 Results

pisa2015_math_data = read.table("~/git/misc-analyses/education/data/PISA 2015 Table 323 Cumulative expenditure.txt", header=TRUE, sep="\t")

region_colors = c("#99000088", "#f00b3788",
                  "#261f9288", "#4b9eed88", "#045aad88", "#19bac488", 
                  "#81048d88", "#d658e388",
                  "#8d890488", "#04ad1d88")
region_areas = c("North America", "Latin America and Caribbean",
                 "South Asia", "South-East Asia", "East Asia", "Oceania", 
                 "Western Europe", "Eastern Europe and Central Asia",
                 "Middle East and North Africa", "Sub-Saharan Africa")
region_colors.matched = region_colors[match(unique(pisa2015_math_data$region),region_areas)]
region_matches = match( pisa2015_math_data$region, unique(pisa2015_math_data$region) )

pdf(file="~/git/misc-analyses/education/images/pisa2015_spending_vs_math_score.pdf", height=6, width=9, title="PISA 2015")
plot( pisa2015_math_data$Cumulative_expenditure_Total.6.to.15.year.olds , pisa2015_math_data$Math_Mean_score ,
      xlim=c(0,200000),  ylim=c(250,600), axes=FALSE,
      xlab="Average spending per student, aged 6-15 (USD 2013, PPP)", ylab="Mean mathematics score (PISA 2015)",
      pch=16, cex=3, col=region_colors.matched[region_matches] )
axis(1)
axis(2, at=seq(250,550,50), labels=c(NA,300,NA,400,NA,500,NA))
text( pisa2015_math_data$Cumulative_expenditure_Total.6.to.15.year.olds , pisa2015_math_data$Math_Mean_score, 
      pisa2015_math_data$Country , pos=4 , col="#00000099")
dev.off()

pisa2015_math_data$Country

plot( pisa2015_math_data$Cumulative_expenditure_Total.6.to.15.year.olds , pisa2015_math_data$Science_Mean_score ,
      xlim=c(0,200000),  ylim=c(0,600),
      xlab="Average spending per student, aged 6-15 (USD 2013, PPP)", ylab="Mean science score (PISA 2015)",
      pch=16, cex=3, col=region_colors.matched[region_matches] )

plot( pisa2015_math_data$Reading_Mean_score , pisa2015_math_data$Math_Mean_score ,
      xlim=c(200,600),  ylim=c(200,600),
      xlab="Mean reading score (PISA 2015)", ylab="Mean mathematics score (PISA 2015)",
      pch=16, cex=3, col=region_colors.matched[region_matches] )
segments(200,200,600,600, lwd=2, col="#00000033")
text( pisa2015_math_data$Reading_Mean_score , pisa2015_math_data$Math_Mean_score ,
      pisa2015_math_data$Country , pos=4 , col="#00000099")


################################################################################










#