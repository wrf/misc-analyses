#


library(dplyr)

# Xu 2024 The amino acid pattern and dynamics of body protein, body fat deposition in male and female broilers under different temperatures
# https://pmc.ncbi.nlm.nih.gov/articles/PMC10906514
chicken_aa_datafile = "~/git/misc-analyses/land_usage/data/xu_2024_table14.txt"
chicken_aa_data = read.table(chicken_aa_datafile, header=TRUE, sep="\t")

chicken_aa_data.f = filter(chicken_aa_data, source=="Carcass") %>%
  arrange(desc(AA.content_0.14d))
unique(chicken_aa_data$source)



chicken_aa_df = data.frame(aa=chicken_aa_data$AA[1:17], 
                carcass=chicken_aa_data$AA.content_0.14d[1:17],
                feather=chicken_aa_data$AA.content_0.14d[18:34])
chicken_aa_df.a = arrange(chicken_aa_df, desc(carcass))


is_meat = chicken_aa_data$source=="Carcass"

b = barplot( chicken_aa_data.f$AA.content_0.14d , col="#",
         names.arg = chicken_aa_data.f$AA_abv , cex.names=0.8, las=1)

plot( chicken_aa_df.a$carcass , axes=FALSE, ylim=c(0,15),
      pch=21, col="#000000aa", bg="#880000aa", cex=2)
points( 1:17, chicken_aa_df.a$feather,
        pch=21, col="#000000aa", bg="#000088aa", cex=2)
axis(2)
axis(1, at=1:17, labels=chicken_aa_df.a$aa , tick = FALSE , las=2)


# Zakhariev 1980 Amino acid makeup of beef
# https://pubmed.ncbi.nlm.nih.gov/7269220/
# It was established that in the proteins of the muscle investigated are contained 
# the following aminoacids, expressed in g/16 g N: 
# lysine--7.77; treonine--4.09, valine--5.12, methyonine--2.50, isoleucine--4.67, 
# leucine--8.42, phenylalanine--4.34, triptophane--1.40, histidine--3.37, 
# arginine--6.17, aspartic acid--7.92, serine--3.31, glutamine acid--13.30, 
# proline--3.73, glycine--4.79, alanine--4.99, tirosine--3.84 and hydroxyproline--0.59. 
#


# Mohanty 2014 Amino Acid Compositions of 27 Food Fishes and Their Importance in Clinical Nutrition
# https://pmc.ncbi.nlm.nih.gov/articles/PMC4213980/



# Seong 2018 Comparative study of nutritional composition and color traits of meats obtained from the horses and Korean native black pigs raised in Jeju Island
# https://pmc.ncbi.nlm.nih.gov/articles/PMC6325386/


# Mahan 1998 Essential and nonessential amino acid composition of pigs from birth to 145 kilograms of body weight, and comparison to other studies
# https://pubmed.ncbi.nlm.nih.gov/9498360/



# Gorissen 2018 Protein content and amino acid composition of commercially available plant-based protein isolates
# https://pmc.ncbi.nlm.nih.gov/articles/PMC6245118/
# Figure 1 and Figure 2
eaa_data_text = "source	type	average_protein_pct	protein_var_lower	protein_var_upper	EAA_pct_protein
Oat	Plant	64	NA	NA	21.2
Lupin	Plant	61	NA	NA	21.3
Wheat	Plant	80	72	88	22.1
Hemp	Plant	51	NA	NA	22.6
Microalgae	Plant	68	NA	NA	22.7
Soy	Plant	71	61	76	27.3
Brown rice	Plant	79	NA	NA	27.8
Pea	Plant	80	77	82	29.3
Corn	Plant	65	58	69	32.1
Potato	Plant	80	77	83	36.4
Whey	Animal	77.8	72	84	43.3
Milk	Animal	77.4	NA	NA	39.0
Caseinate	Animal	85.4	NA	NA	38.2
Casein	Animal	72.4	67	78	34.0
Egg	Animal	51.1	NA	NA	32.2
Human muscle	ref	84		86.7	37.9"



# Belhaj 2021 Proximate Composition, Amino Acid Profile, and Mineral Content of Four Sheep Meats Reared Extensively in Morocco: A Comparative Study
# https://pmc.ncbi.nlm.nih.gov/articles/PMC7846400/


#