# analysis of milk protein composition

# data from
# Jensen et al (1990) Lipids of Bovine and Human Milks: A Comparison. J Dairy Sci 73:223-240. REVIEW
# https://pubmed.ncbi.nlm.nih.gov/2184172/

# Pereira et al (2013) Composition of breast milk of lactating adolescents in function of time of lactation
# https://pubmed.ncbi.nlm.nih.gov/24506376/

# Andreas et al (2015) Human breast milk: A review on its composition and bioactivity. REVIEW
# https://pubmed.ncbi.nlm.nih.gov/26375355/

# Rio-Aige et al (2023) Breast milk immune composition varies during the transition stage of lactation: characterization of immunotypes in the MAMI cohort
# https://pmc.ncbi.nlm.nih.gov/articles/PMC10702228/

# Karcz et Krolak-Olejnik (2021) Vegan or vegetarian diet and breast milk composition - a systematic review
# https://pubmed.ncbi.nlm.nih.gov/32319307/

# Martin et al (2016) Review of Infant Feeding: Key Features of Breast Milk and Infant Formula
# https://pmc.ncbi.nlm.nih.gov/articles/PMC4882692/

milk_data_text = "Milk	Protein_pct	Casein_pct_of_protein	a-casein	b-casein	k-casein	Whey_pct_of_protein	a-Lactalbumin	b-Lactoglobulin	Lactotransferrin	Lysozyme	IgA	IgG	IgM	Serum_albumin	Fat	Lactose	Total_solids	Ash	Kilocalories
Human milk 36d	1.0	40	0.06	27	12	60	27	0	18	4	5	0.1	0.2	3	3.9	6.8	12.1	0.2	72
Human colostrum 3d	2.3	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	3	5.5	NA	NA	58
Baby formula	1.4	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	3.6	6.9	NA	NA	66
Bovine	3.4	80	39	28	13	20	4	11	0.01	0.01	0.1	1.8	0.3	0.9	3.7	4.8	12.7	0.7	75
Goat	3.4	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	3.8	4.1	NA	NA	NA
Sheep	6.2	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	7.9	4.9	NA	NA	NA
Water buffalo	3.8	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	7.4	4.8	NA	NA	NA
Yak	5.8	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	3.6	4.6	NA	NA	NA
Zebu	3.2	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	3.6	4.7	NA	NA	NA"


milk_data = read.table( text=milk_data_text, header=TRUE, sep="\t")
#milk_data.m = matrix(unlist(strsplit(milk_data_text, "\t|\n")),ncol = 17, byrow=TRUE)
#milk_data = as.data.frame( milk_data.m[-1,], col.names = milk_data.m[1,] )
human_v_cow_only = milk_data[c(1,4),]

names(milk_data)

proteins_only = cbind( human_v_cow_only[,c(4,5,6)], 
                       human_v_cow_only[,c(8:15)],
                       other_whey=human_v_cow_only$Whey_pct_of_protein - rowSums(human_v_cow_only[,c(8:15)]) )

#  [1] "Milk"                  "Protein_pct"           "Casein_pct_of_protein" "a.casein"              "b.casein"             
#  [6] "k.casein"              "Whey_pct_of_protein"   "a.Lactalbumin"         "b.Lactoglobulin"       "Lactotransferrin"     
# [11] "Lysozyme"              "IgA"                   "IgG"                   "IgM"                   "Serum_albumin"

prot_type_colors = c( "#24581eff", "#77a631ff", "#2b7622ff", #"#bbeb9fff", 
                      "#1e1ad2ff", "#6e6bedff",
                      "#b7581cff", "#df4b32ff", "#97156aff", "#e686c4ff", "#f9d3ecff", "#222576ff", "#a9cfedff" )
b = barplot( t(as.matrix( proteins_only )) , names.arg=c("Human milk", "Cow milk") , 
         ylab="Percent of total protein", col=prot_type_colors , border = "white",
         space = 0.5 , axes=FALSE )
axis(2, at=seq(0,100,10))
text( c(b[2],b[2],b[2],b[1],b[1],b[2]) , c(19,54,74,54,77,89), 
      c("a-Casein","b-Casein","k-Casein","a-Lactalbumin", "Lactoferrin","b-Lactoglobulin"), col="white")
polygon( x=c(1.5,2,2,1.5), y=c(0,39,67,27), border = NA, col="#40b03344" )
polygon( x=c(1.5,2,2,1.5), y=c(40,80,84,67), border = NA, col="#1e1ad244" )

y1 = c(0,cumsum(as.numeric(proteins_only[1,])))
y2 = c(0,cumsum(as.numeric(proteins_only[2,])))
pdf(file="~/git/misc-analyses/milk_composition/images/milk_protein_comparison_v1.pdf", height=8, width=6, title="Protein composition of human and bovine milks")
#png(file="~/git/misc-analyses/milk_composition/images/milk_protein_comparison_v1.png", height=720, width=540, res = 90 )
par(mar=c(1,3,1,3))
plot(0,0,type='n', xlim=c(0,5), ylim=c(0,140), axes=FALSE , xlab="", ylab="")
rect(rep(0,length(prot_type_colors)), y1[1:12]+40, rep(2,length(prot_type_colors)), y1[2:13]+40, 
     col=prot_type_colors, border = "white" )
rect(rep(3,length(prot_type_colors)), y2[1:12], rep(5,length(prot_type_colors)), y2[2:13] , 
     col=prot_type_colors, border = "white" )
polygon( x=c(2,3,3,2), y=c(1+40,41,65,25+40), border = NA, col="#77a63144" )
polygon( x=c(2,3,3,2), y=c(29+40,69,78,38+40), border = NA, col="#40b03344" )
polygon( x=c(2,3,3,2), y=c(41+40,81,84,65+40), border = NA, col="#1e1ad244" )
polygon( x=c(2,3,3,2), y=c(94+40,97,98,96+40), border = NA, col="#22257644" )
text( c(4,1,1,1,1,4,1,1,1) , c(19,54,74,54+40,77+40,89,86+40,90+40,95+40), 
      c("a-Casein","b-Casein","k-Casein",
        "a-Lactalbumin", "Lactoferrin\n(Lactotransferrin)","b-Lactoglobulin",
        "Lysozyme", "IgA", "Serum albumin"), col="white")
text( c(1) , c(97.7+40), 
      c("other whey"), col="black")
axis(2, at=seq(40,140,10), labels=seq(0,100,10) )
axis(4, at=seq(0,100,10), labels=seq(0,100,10) )
text( c(1,4) , c(30,110), c("Human", "Bovine"), col="#222222", cex=1.5)
dev.off()






milk_type_colors = c( "#e686c4ff", "#b32581ff", "#222576ff",
                      "#2b7622ff","#e1b016ff","#d08214ff", "#24581eff","#77a631ff","#147714ff")
pdf(file="~/git/misc-analyses/milk_composition/images/milk_composition_comparison_v1.pdf", width=10, height=3, title="Bulk composition of human and other milks")
par(mfrow=c(1,3), mar=c(0.5,8,6,2))
barplot( rev(milk_data$Protein_pct) , main="Protein (% of milk)", horiz=TRUE, 
         names.arg = rev(milk_data$Milk), las=2, col= rev(milk_type_colors), axes=FALSE )
axis(3)
barplot( rev(milk_data$Fat) , main="Fat (% of milk)", horiz=TRUE, xlim=c(0,8),
         names.arg = rev(milk_data$Milk), las=2, col= rev(milk_type_colors), axes=FALSE )
axis(3)
barplot( rev(milk_data$Lactose) , main="Lactose (% of milk)", horiz=TRUE, xlim=c(0,7),
         names.arg = rev(milk_data$Milk), las=2, col= rev(milk_type_colors), axes=FALSE )
axis(3)
dev.off()

barplot( milk_data$Fat , ylab="Fat (% of milk)", 
         names.arg = milk_data$Milk, las=2, col=milk_type_colors )
barplot( milk_data$Lactose , ylab="Lactose (% of milk)", 
         names.arg = milk_data$Milk, las=2, col=milk_type_colors )
barplot( t(as.matrix(milk_data[c(1,3),c(3,7)] )) , col=prot_type_colors  )


################################################################################
################################################################################



# Qin et al 2019 Variations in melatonin levels in preterm and term human breast milk during the first month after delivery
# https://pmc.ncbi.nlm.nih.gov/articles/PMC6884443/
qin2019_data_text = "Time_point	Breast_milk_pg_mL	Breast_milk_pg_mL_var
03:00	23.49	4.25
09:00	3.27	1.23
15:00	2.40	1.04
21:00	6.81	2.35"
qin2019_data = read.table(text=qin2019_data_text, header=TRUE, sep="\t")[c(3,4,1,2),]
qin2019_data

pdf(file="~/git/misc-analyses/milk_composition/images/qin2019_melatonin_in_milk.pdf", width=4, height=4, title="Melatonin in breast milk")
#png(file="~/git/misc-analyses/milk_composition/images/qin2019_melatonin_in_milk.png", width=360, height=360, res=90 )
par(mar=c(3,4.5,3,1))
b = barplot(qin2019_data$Breast_milk_pg_mL * 1000 / 232.281, ylim=c(0,120), axes=FALSE,
        names.arg=qin2019_data$Time_point , ylab="Melatonin in breast milk (pmol/L)", 
        main="Daily variation of melatonin in milk\nfrom 98 women in Shanghai, China", 
        col=c("#b376b6ff", "#f6ac24ff", "#e57c0cff", "#d05c7aff" ), cex.lab=1.2)
axis(2,at=seq(0,100,20), cex.axis=1.2)
#points(b, qin2019_data$Breast_milk_pg_mL* 1000 / 232.281, lwd=2, pch=1)
arrows(x0 = b, y0 = qin2019_data$Breast_milk_pg_mL* 1000 / 232.281, lwd=1, length = 0.1,
       x1 = b, y1=qin2019_data$Breast_milk_pg_mL* 1000 / 232.281+qin2019_data$Breast_milk_pg_mL_var* 1000 / 232.281, angle = 90)
arrows(x0 = b, y0 = qin2019_data$Breast_milk_pg_mL* 1000 / 232.281, lwd=1, length = 0.1,
       x1 = b, y1=qin2019_data$Breast_milk_pg_mL* 1000 / 232.281-qin2019_data$Breast_milk_pg_mL_var* 1000 / 232.281, angle = 90)
dev.off()

qin2019_data$Breast_milk_pg_mL * 1000 / 232.281 # =pM
# 23pg/mL = 23ng/L / 232g/mol = 0.101nM = 101pM
# this is 1000x lower than the 100nM concentrations used by:
# Honorio-Franca 2013 Human colostrum melatonin exhibits a day-night variation and modulates the activity of colostral phagocytes
# https://doi.org/10.2478/v10136-012-0039-2
# "were incubated with with 10 ul of Phorbol Myristate Acetate (PMA final concentration at 10 –7M) or 
# ...50 ul of melatonifinal concentration at 10-7M"


# Illnerova (1993) Melatonin rhythm in human milk. J Clin Endocrinol Metab
# https://pubmed.ncbi.nlm.nih.gov/8370707/
# https://doi.org/10.1210/jcem.77.3.8370707
illnerova_summary_text = "Melatonin_Source	Day_less_than_43_pM	Night_pM	Night_var_pM
Serum	0	280	34
Milk	0	99	26"
illnerova_summary = read.table(text=illnerova_summary_text, header=TRUE, sep="\t")

illnerova_data_text = "time_hrs	mother_A_milk_pM	mother_B_milk_pM	mother_C_milk_pM	mother_D_milk_pM	mother_E_milk_pM	mother_F_milk_pM
11	NA	3.9	4.2	NA	6.3	NA
12	6.4	NA	NA	NA	NA	NA
13	NA	NA	5.0	NA	6.3	8.4
15	NA	3.9	4.2	7.5	NA	NA
16	4.7	NA	NA	5.0	NA	NA
17	NA	NA	4.2	NA	8.0	9.2
18	NA	3.9	5.0	NA	NA	NA
19	5.6	NA	NA	6.7	NA	8.4
21	NA	64.2	116.7	NA	87.1	NA
22	65.9	NA	NA	NA	NA	NA
24	NA	250.3	204.2	172.5		94.8
25	NA	NA	NA	NA	190.9	NA
26	136.3	NA	NA	NA	NA	NA
27	NA	NA	NA	191.7	NA	NA
28	102.0	NA	154.2		111.0	NA
29	NA	NA	NA	NA	NA	121.7
30	52.5	176.5	NA	NA	73.1	NA
31	NA	NA	NA	5.8	NA	NA
32	NA	NA	53.3		NA	8.4
33	NA	NA	NA	NA	7.1	NA
34	3.1	2.2	5.0	5.0	NA	NA
35	NA	NA	NA	NA	7.1	7.6"
illnerova_data = read.table(text=illnerova_data_text, header=TRUE, sep="\t")
mother_color_set = c("#540005ff", "#b5272fff", "#cf8f93ff", "#cc32baff", "#580e62ff", "#cf8fc6ff", "#641bbcff", "#bca5d7ff" )


#pdf(file="~/git/misc-analyses/milk_composition/images/illnerova1993_melatonin_in_milk.pdf", width=4, height=4, title="Data from Illnerova et al 1993")
png(file="~/git/misc-analyses/milk_composition/images/illnerova1993_melatonin_in_milk.png", width=360, height=360, res=90)
par(mar=c(4.5,4.5,3,1))
plot(illnerova_data$time_hrs, illnerova_data$mother_B_milk_pM , type='n', 
     axes=FALSE, xlim=c(12,36), ylim=c(0,260), main="Nightly variation of melatonin\nin milk from 6 Czech mothers",
     xlab="Time of day (hours)", ylab="Melatonin in milk (pmol/L)", cex.lab=1.3 )
axis(1, at=seq(12,36,2), labels=NA)
axis(1, at=seq(12,36,4), labels=c(12,16,20,24,4,8,12), tick = FALSE)
axis(2, cex.axis=1.2 )
axis(2, at=c(150,250), tick=FALSE, cex.axis=1.2 )
segments(12,43,36,43,col="#4567c044", lwd=5)
text(12,100,"Detection\nlimit\n43pM", col="#284897ff", pos=4 )
for (i in 2:7){
  milk_time = illnerova_data$time_hrs[which(!is.na(illnerova_data[,i]))]
  milk_melatonin = illnerova_data[,i][which(!is.na(illnerova_data[,i]))]
  lines(milk_time, ifelse(milk_melatonin<43,0,milk_melatonin), col=gsub("ff","66",mother_color_set[i]), lwd=6 )
  points(milk_time, ifelse(milk_melatonin<43,0,milk_melatonin), col=gsub("ff","aa",mother_color_set[i]), pch=16, cex=1.5 )
}
dev.off()

# Cubero (2005) The circadian rhythm of tryptophan in breast milk affects the rhythms of 6-sulfatoxymelatonin and sleep in newborn
# https://pubmed.ncbi.nlm.nih.gov/16380706/
# https://www.researchgate.net/publication/7390109_The_circadian_rhythm_of_tryptophan_in_breast_milk_affects_the_rhythms_of_6-sulfatoxymelatonin_and_sleep_in_newborn
cubero2006_data_text = "Time	Tryptophan_uM	Urinary_6-sulfatoxymelatonin_breast_fed_ng_mL	Urinary_6-sulfatoxymelatonin_mothers_ng_mL	Urinary_6-sulfatoxymelatonin_formula_fed_ng_mL
4	NA	NA	NA	10.39
7	83.89	12.04	6.90	7.70
8	54.63	19.90	4.83	NA
9	71.30	21.43	16.21	13.58
10	NA	22.86	49.89	NA
11	67.04	13.88	42.99	NA
12	61.85	9.80	26.44	NA
13	56.67		9.43	NA
14	NA		31.03	16.96
15	50.56	2.09	20.69	NA
16	55.37	3.27	10.00	16.42
17	52.96	NA	5.40	2.60
18	50.00	NA	0.92	6.52
19	70.00	3.83	4.25	3.82
20	71.11	2.19	3.68	NA
21	71.85	5.56	3.10	NA
22	70.37	9.03	0.80	NA
23	68.70	NA	NA	NA"
cubero2006_data = read.table(text=cubero2006_data_text, header=TRUE, sep="\t")

pdf(file="~/git/misc-analyses/milk_composition/images/cubero2006_tryptophan_in_milk.pdf", width=4, height=4, title="Tryptophan in breast milk - Data from Cubero et al 2006")
#png(file="~/git/misc-analyses/milk_composition/images/cubero2006_tryptophan_in_milk.png", width=360, height=360, res=90)
par(mar=c(4.5,4.5,3,1))
plot( cubero2006_data$Time, cubero2006_data$Tryptophan_uM , xlim=c(0,24), ylim=c(0,90),
      xlab="Time of day (hours)", ylab="Tryptophan in mother's milk (umol/L)", 
      main="Tryptophan in breast milk\nfrom 15 women in Spain",
      pch=21, cex=2, bg="#FF5F50aa" , axes=FALSE , frame.plot = TRUE, cex.lab=1.2 )
axis(1, at=c(0:24), labels=FALSE )
axis(1, at=seq(0,24,3), labels=seq(0,24,3), tick = FALSE )
axis(2, cex.axis=1.2 )
trp_fit = 67.95 + 13.12 * sin (0.26 * seq(0,24,0.1) + 0.76) # formula copied from text
lines(seq(0,24,0.1), trp_fit, col="#FF7F5066", lwd=6 )
text(2,20,"Sinsoidal fitted curve from\nCubero et al 2006", pos=4, col="#541600ff")
segments(3,30,3,80, col="#541600ff")
dev.off()

aggregate( na.omit(cubero2006_data$Urinary_6.sulfatoxymelatonin_mothers_ng_mL), by=list( morning=ifelse( cubero2006_data$Time <= 12, 1, 2 )[2:17] ), FUN=mean, na.action = na.omit )

cubero2006_data$Urinary_6.sulfatoxymelatonin_mothers_ng_mL
list( morning=ifelse( cubero2006_data$Time <= 12, 1, 2 ) )
length(ifelse( cubero2006_data$Time <= 12, 1, 2 ))


pdf(file="~/git/misc-analyses/milk_composition/images/cubero2006_melatonin_in_urine.pdf", width=4, height=4, title="Urinary 6-sulfatoxymelatonin in mothers and babies - Data from Cubero et al 2006")
#png(file="~/git/misc-analyses/milk_composition/images/cubero2006_melatonin_in_urine.png", width=360, height=360, res=90)
par(mar=c(4.5,4.5,3,1))
plot( cubero2006_data$Time, cubero2006_data$Urinary_6.sulfatoxymelatonin_mothers_ng_mL* 1000 / 328.34 , xlim=c(0,24), ylim=c(0,200),
      xlab="Time (hours)", ylab="Urinary 6-sulfatoxymelatonin (nmol/L)", 
      main="6-sulfatoxymelatonin in urine\nfrom 16 women and babies in Spain",
      pch=21, cex=3, bg="#FF7F50aa" , axes=FALSE , frame.plot = TRUE, cex.lab=1.2 )
axis(1, at=c(0:24), labels=FALSE )
axis(1, at=seq(0,24,3), labels=seq(0,24,3), tick = FALSE )
axis(2, cex.axis=1.2 )
points( cubero2006_data$Time, cubero2006_data$Urinary_6.sulfatoxymelatonin_breast_fed_ng_mL * 1000 / 328.34,
        pch=24, cex=2, bg="#8B0000aa" )
points( cubero2006_data$Time, cubero2006_data$Urinary_6.sulfatoxymelatonin_formula_fed_ng_mL* 1000 / 328.34,
        pch=24, cex=2, bg="#00008Baa" )
lines(seq(0,24,0.1), ( 11.44 + 8.97 * sin(0.26 * seq(0,24,0.1) - 0.05))* 1000 / 328.34, col="#8B000066", lwd=6 ) # formula copied from text
lines(seq(0,24,0.1), ( 9.72 + 16.44 * sin(0.26 * seq(0,24,0.1) - 1.44))* 1000 / 328.34, col="#FF7F5066", lwd=6 ) # formula copied from text
lines(seq(0,24,0.1), ( 9.82 + 8.28 * sin(0.26 * seq(0,24,0.1) - 1.52))* 1000 / 328.34, col="#00008B66", lwd=6 ) # formula copied from text
legend("topright", legend=c("Maternal", "Breast-fed", "Formula-fed"), col=c("#FF7F50aa","#8B0000aa","#00008Baa"), pch=c(16,17,17), pt.cex=2 )
dev.off()

# https://pubchem.ncbi.nlm.nih.gov/compound/6-sulfatoxymelatonin
cubero2006_data$Urinary_6.sulfatoxymelatonin_mothers_ng_mL * 1000 / 328.34


colorRampPalette("darkblue")(1)


################################################################################


# Savino 2010 Lactobacillus reuteri DSM 17938 in infantile colic: a randomized, double-blind, placebo-controlled trial
# https://pubmed.ncbi.nlm.nih.gov/20713478/
# TABLE 2 Crying Time in the L reuteri and Placebo Groups
savino2010_data_text = "day_of_study	L_reuteri_crying_min_day	L_reuteri_crying_min_day_IQR	Placebo_crying_min_day	Placebo_crying_min_day_IQR	p_value_mannwhitney
0	370	120	300	150	0.127
7	95	85	185	149	0.082
14	60	70	150	145	0.099
21	35	85	90	148	0.022"
savino2010_data = read.table(text=savino2010_data_text, header=TRUE, sep="\t")

pdf(file="~/git/misc-analyses/milk_composition/images/savino2010_probiotic_infant_colic.pdf", width=5, height=5, title="Crying Time in the L reuteri and Placebo Groups")
#png(file="~/git/misc-analyses/milk_composition/images/savino2010_probiotic_infant_colic.png", width=450, height=450, res=90)
par(mar=c(4.5,4.5,3,1))
plot( savino2010_data$day_of_study, savino2010_data$L_reuteri_crying_min_day, type="n", ylim=c(0,500),
      ylab="Crying time (minutes/day)", xlab="Day of study", main="Reduction in Crying Time\nin the L.reuteri and Placebo Groups",
      axes=FALSE , cex.lab=1.3)
axis(2)
axis(1, at=seq(0,21,7), cex.axis=1.3)
polygon( c( savino2010_data$day_of_study,rev(savino2010_data$day_of_study)),
         c(savino2010_data$L_reuteri_crying_min_day+savino2010_data$L_reuteri_crying_min_day_IQR/2,
           rev(savino2010_data$L_reuteri_crying_min_day-savino2010_data$L_reuteri_crying_min_day_IQR/2) ),
         col="#FF5F5088", border = NA )
lines( savino2010_data$day_of_study, savino2010_data$L_reuteri_crying_min_day, 
       lwd=2, col="#FF5F50aa")
points( savino2010_data$day_of_study, savino2010_data$L_reuteri_crying_min_day, 
        pch=16, cex=3, col="#f21600aa")
polygon( c( savino2010_data$day_of_study,rev(savino2010_data$day_of_study)),
         c(savino2010_data$Placebo_crying_min_day+savino2010_data$Placebo_crying_min_day_IQR/2,
           rev(savino2010_data$Placebo_crying_min_day-savino2010_data$Placebo_crying_min_day_IQR/2) ),
         col="#99999988", border = NA )
lines( savino2010_data$day_of_study, savino2010_data$Placebo_crying_min_day, 
       lwd=2, col="#999999aa")
points( savino2010_data$day_of_study, savino2010_data$Placebo_crying_min_day, 
        pch=16, cex=3, col="#333333aa")
legend("topright", legend=c("Probiotic (25)","Placebo (21)"), col=c("#FF5F50ff","#999999ff"), pch=16, pt.cex = 2, cex=1.2)
dev.off()


################################################################################


# Table 3. Blood and Milk Alcohol Levels for Subjects 3-8
# Time after initial ingestion of alcohol in hours
# Levels are expressed as mL alcohol per 100 mL of sample fluid
lawton_data_text = "minutes	blood_EtOH_s1b	milk_EtOH_s1b	blood_EtOH_s1a	milk_EtOH_s1a	blood_EtOH_s2	milk_EtOH_s2	blood_EtOH_s3	milk_EtOH_s3	blood_EtOH_s4	milk_EtOH_s4	blood_EtOH_s5	milk_EtOH_s5	blood_EtOH_s6	milk_EtOH_s6	blood_EtOH_s7	milk_EtOH_s7	blood_EtOH_s8	milk_EtOH_s8
30	NA	NA	NA	NA	NA	NA	41	46	6	6	0	0	16	13	27	21	NA	NA
60	102.43	113.74	77.90	84.37	NA	NA	55	76	37	34	28	22	40	35	44	46	46	46
90	118.05	135.57	NA	NA	94	118	67	71	89	81	39	39	49	49	39	44	57	74
120	117.51	131.80	68.74	77.63	NA	NA	65	68	119	129	35	39	44	46	35	36	NA	NA
150	102.69	114.55	NA	NA	86	121	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	53	62
180	88.95	99.19	50.15	57.16	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA
210	79.52	86.53	NA	NA	85	101	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA
240	64.43	70.36	36.95	42.07	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA
270	56.08	59.58	NA	NA	65	73	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA
300	42.07	45.03	13	13.77	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA
330	NA	NA	NA	NA	43	52	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA"
lawton_data = read.table( text=lawton_data_text, header=TRUE, sep="\t")

mother_color_set_2 = rep(rep( mother_color_set, c(rep(c(2,1),c(1,7))) ),each=2)

plot( lawton_data$minutes, lawton_data$milk_EtOH_s1b , ylim=c(0,150), xlim=c(0,330) , type='n' )
for (i in seq(2,19,2)) {
  etoh_time = lawton_data$minutes[which(!is.na(lawton_data[,i]))]
  etoh_blood = lawton_data[,i][which(!is.na(lawton_data[,i]))]
  etoh_milk = lawton_data[,i+1][which(!is.na(lawton_data[,i+1]))]
  lines(etoh_time, etoh_blood, col=gsub("ff","66",mother_color_set_2[i-1]), lwd=6 )
  points(etoh_time, etoh_blood, col=gsub("ff","aa",mother_color_set_2[i-1]), pch=18, cex=1.5 )
  lines(etoh_time, etoh_milk, col=gsub("ff","66",mother_color_set_2[i]), lwd=6 )
  points(etoh_time, etoh_milk, col=gsub("ff","aa",mother_color_set_2[i]), pch=16, cex=1.5 )
}







#