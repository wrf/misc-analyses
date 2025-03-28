# diversity replots of published datasets
# https://github.com/wrf/misc-analyses/tree/master/eco_diversity


library(vegan)


################################################################################
################################################################################
# from
# Hugerth et al 2019 No distinct microbiome signature of irritable bowel syndrome
# https://pmc.ncbi.nlm.nih.gov/articles/PMC7282555/

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/hugerth_2019_supptable.txt.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t", row.names = 1 )
otu_counts.n = otu_counts[,1:561]

sample_type = sapply( strsplit(names(otu_counts.n),"_"), "[", 4 )
sample_type_counts = table(sample_type)
category_color_index = match(sample_type, names(sample_type_counts) )
category_color = c( "#9b5411aa", "#ebc84eaa" )

otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

pdf(file="~/git/misc-analyses/eco_diversity/images/hugerth_2019_otus_vs_alpha_diversity_v1.pdf", height=5, width=5, title="Data from Hugerth et al 2019 Gut", useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,800), main="Data from Hugerth et al 2019 Gut",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(800,2.1,"feces-185", cex=1.1, col="#9b5411", pos=2)
text(800,1.8,"sigmoideum-376", cex=1.1, col="#e0b319", pos=2)
dev.off()

pdf(file="~/git/misc-analyses/eco_diversity/images/hugerth_2019_reads_vs_alpha_diversity_v1.pdf", height=5, width=5, title="Data from Hugerth et al 2019 Gut", useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(sample_counts_by_all_sp, otu_shannon_index, 
     xlim=c(0,82000), main="Data from Hugerth et al 2019 Gut",
     xlab="Clustered OTU counts (reads)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(80000,2.1,"feces-185", cex=1.1, col="#9b5411", pos=2)
text(80000,1.8,"sigmoideum-376", cex=1.1, col="#e0b319", pos=2)
dev.off()



################################################################################
################################################################################

# from
# Schuster 2021 Effects of Seasonal Anoxia on the Microbial Community Structure
# https://journals.asm.org/doi/10.1128/msphere.00991-20
# https://github.com/astridschuster/Microbiome_MS_2020

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/schuster2021_otutable.txt.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t", row.names = 1, fill = TRUE )
sample_metadata = read.table("~/git/misc-analyses/eco_diversity/data/schuster2021_metadata.tab", header = TRUE, sep = "\t")
#names(otu_counts)
#table(sample_metadata$Species_name)
schuster2021_sample_ids = gsub("-", ".", sample_metadata$SeqID)
schuster2021_kept_samples = match( schuster2021_sample_ids, names(otu_counts) )
otu_counts.n = otu_counts[,schuster2021_sample_ids]

category_color_index = match( sample_metadata$Species_name , c("Water", "Sediment", ""), nomatch = 4 )
category_color = c( "#2e1cadcc", "#927241cc", "#2e1cadcc", "#a353c0cc" )

otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

pdf(file="~/git/misc-analyses/eco_diversity/images/ireland_sponge_reads_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(sample_counts_by_all_sp, otu_shannon_index, 
     xlim=c(0,100000), main="Data from Schuster et al 2021 mSphere",
     xlab="Clustered OTU counts (reads)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3, axes = FALSE,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
axis(2, cex.axis=1.3)
axis(1, at = c(0,25000,50000,75000,100000),  cex.axis=1.3)
text(10000,6.5,"sediment-7", cex=1.1, col="#927241")
text(22000,5.5,"seawater-17", cex=1.1, col="#2e1cad")
text(17000,3.0,"sponges", cex=1.1, col="#a353c0")
dev.off()

pdf(file="~/git/misc-analyses/eco_diversity/images/ireland_sponge_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index,
     xlim=c(0,2800), main="Data from Schuster et al 2021 mSphere",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.2, cex.lab=1.3,
     pch=16, cex=log10(sample_counts_by_all_sp)-3, col=category_color[category_color_index])
text(1200,6.2,"sediment-7", cex=1.1, col="#927241")
text(800,5.5,"seawater-17", cex=1.1, col="#2e1cad")
text(1500,2.0,"sponges", cex=1.1, col="#a353c0")
dev.off()



################################################################################
################################################################################


# data from Supplemental Table 4 of
# Ravel 2011 Vaginal microbiome of reproductive-age women
# https://www.pnas.org/doi/full/10.1073/pnas.1002611107

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/ravel2011_st04.tsv.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t" )
otu_counts.n = otu_counts[,8:ncol(otu_counts)]

otu_counts.meta = otu_counts[,1:7]

category_color_index = match(otu_counts$Community.groupc, unique(otu_counts$Community.groupc) )
category_color = c( "#dd3589aa", "#e95a5acc", "#ef88abaa", "#2e1cadaa","#f8aacdcc", "#888888cc" )

ethnic_group = match(otu_counts$Ethnic.Groupa, unique(otu_counts$Ethnic.Groupa))
#          [1] "Asian"    "White"    "Black"    "Hispanic"
eth_colors = c("#f9b620", "#cdbab4", "#401e11", "#c03c18")

otu_n_species = rowSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = rowSums(otu_counts.n)
sp_counts_by_all_samples = colSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=1)
otu_invsimpson_index = diversity(otu_counts.n, index="invsimpson", MARGIN=1)

pdf(file="~/git/misc-analyses/eco_diversity/images/ravel2011_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,100), main="Data from Ravel et al 2011 PNAS",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(40,1.4,"CST-I-105", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(40,1.2,"CST-II-25", cex=1.1, col="#e95a5a", pos=4) # Lactobacillus gasseri
text(40,1.0,"CST-III-135", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(40,0.8,"CST-IV-108", cex=1.1, col="#2e1cad", pos=4) # mixed
text(40,0.6,"CST-V-21", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(71,1.4,"L. crispatus", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus crispatus
text(71,1.2,"L. gasseri", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus gasseri
text(71,1.0,"L. iners", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus iners
text(71,0.8,"Prevotella", cex=1.1, col="#000000", pos=4, font=3) # mixed
text(71,0.6,"L. jenseni", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus jenseni
dev.off()

# plot inverse simpson index, instead of shannon index
pdf(file="~/git/misc-analyses/eco_diversity/images/ravel2011_otus_vs_invsimpson_diversity_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_invsimpson_index, 
     xlim=c(0,100), main="Data from Ravel et al 2011 PNAS",
     xlab="Total species per sample (OTUs)", ylab="Inverse Simpson Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(58, 11,"CST-I-105", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(58,  9,"CST-II-25", cex=1.1, col="#e95a5a", pos=4) # Lactobacillus gasseri
text(58,  7,"CST-III-135", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(58,  5,"CST-IV-108", cex=1.1, col="#2e1cad", pos=4) # mixed
text(58,  3,"CST-V-21", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(71, 10.2,"L. crispatus", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus crispatus
text(71, 8.2, "L. gasseri", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus gasseri
text(71, 6.2, "L. iners", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus iners
text(71, 4.2, "Prevotella", cex=1.1, col="#000000", pos=4, font=3) # mixed
text(71, 2.2, "L. jenseni", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus jenseni
dev.off()

# plot two inverse simpson index against shannon index
pdf(file="~/git/misc-analyses/eco_diversity/images/ravel2011_invsimpson_vs_shannon_diversity_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_invsimpson_index, otu_shannon_index, 
     xlim=c(0,12), main="Data from Ravel et al 2011 PNAS",
     xlab="Inverse Simpson Index", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(4.0,1.4,"CST-I-105", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(4.0,1.2,"CST-II-25", cex=1.1, col="#e95a5a", pos=4) # Lactobacillus gasseri
text(4.0,1.0,"CST-III-135", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(4.0,0.8,"CST-IV-108", cex=1.1, col="#2e1cad", pos=4) # mixed
text(4.0,0.6,"CST-V-21", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(8.1,1.4,"L. crispatus", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus crispatus
text(8.1,1.2,"L. gasseri", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus gasseri
text(8.1,1.0,"L. iners", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus iners
text(8.1,0.8,"Prevotella", cex=1.1, col="#000000", pos=4, font=3) # mixed
text(8.1,0.6,"L. jenseni", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus jenseni
dev.off()


# add multidimensional scaling
ordmds = metaMDS( otu_counts.n , trace=FALSE )
pdf(file="~/git/misc-analyses/eco_diversity/images/ravel2011_mds_v1.pdf", height=5, width=5, title="Data from Ravel et al 2011 PNAS", useDingbats = FALSE)
par(mar=c(4,4,3,1))
plot(ordmds, type='n', main="Data from Ravel et al 2011 PNAS") # expects taxa as columns and sites/patients as rows
points(ordmds, display = "sites", cex = 2, pch=16, col=category_color[category_color_index] )
text(-2.1,-1.4,"CST-I-105", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(1,-1.8,"CST-II-25", cex=1.1, col="#e95a5a", pos=4) # Lactobacillus gasseri
text(-2,1.5,"CST-III-135", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(0.8,1.5,"CST-IV-108", cex=1.1, col="#2e1cad", pos=4) # mixed
text(-1.7,-1.9,"CST-V-21", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(-2.1,-1.6,"L. crispatus", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus crispatus
text(1,-2.0,"L. gasseri", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus gasseri
text(-2.0,1.3,"L. iners", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus iners
text(0.8,1.3,"Prevotella", cex=1.1, col="#000000", pos=4, font=3) # mixed
text(-1.7,-2.1,"L. jenseni", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus jenseni
dev.off()


# unconstrained redundancy
eth_rda.u = rda( otu_counts.n , scale=FALSE )
# plot() makes $CA$u scaled with some factor
pdf(file="~/git/misc-analyses/eco_diversity/images/ravel2011_unconst_rda_v1.pdf", height=5, width=5, title="Data from Ravel et al 2011 PNAS", useDingbats = FALSE)
par(mar=c(4,4,3,1))
plot( eth_rda.u$CA$u[,1], eth_rda.u$CA$u[,2], 
      xlab="RDA1 (unconstrained, unscaled)", ylab="RDA2 (unconstrained, unscaled)",
      main = "Data from Ravel et al 2011 PNAS",
      type='p' ,pch=16, col=category_color[category_color_index], cex=2 )
tcs = c(-0.085,0.03)
text(tcs[1],-0.03,"CST-I-105", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(tcs[1],-0.055,"CST-II-25", cex=1.1, col="#e95a5a", pos=4) # Lactobacillus gasseri
text(tcs[2],-0.055,"CST-III-135", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(tcs[1],-0.08,"CST-IV-108", cex=1.1, col="#2e1cad", pos=4) # mixed
text(tcs[2],-0.08,"CST-V-21", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(tcs[1]+0.005,-0.038,"L. crispatus", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus crispatus
text(tcs[1]+0.005,-0.063,"L. gasseri", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus gasseri
text(tcs[2]+0.005,-0.063,"L. iners", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus iners
text(tcs[1]+0.005,-0.088,"Prevotella", cex=1.1, col="#000000", pos=4, font=3) # mixed
text(tcs[2]+0.005,-0.088,"L. jenseni", cex=1.1, col="#000000", pos=4, font=3) # Lactobacillus jenseni
dev.off()

table(otu_counts.meta$pH)
ph_category = match(otu_counts.meta$pH, names(table(otu_counts.meta$pH)))
ph_cols = c(colorRampPalette(c("#35dd89","#2e1cad"))(9),"#000000aa")
# constrained by all factors
eth_rda = rda(formula = otu_counts.n ~ pH + Ethnic.Groupa + Nugent.score , data = otu_counts.meta[,2:4] )
pdf(file="~/git/misc-analyses/eco_diversity/images/ravel2011_constrained_rda_tricolor_v1.pdf", height=3, width=8, title="Data from Ravel et al 2011 PNAS", useDingbats = FALSE)
par(mfrow=c(1,3), mar=c(4,4,3,1))
plot( eth_rda$CCA$wa[,1], eth_rda$CCA$wa[,2], 
      xlab="RDA1 (pH + ethnicity + Nugent)", ylab="RDA2 (pH + ethnicity + Nugent)",
      main = "Community state type (CST)",
      type='p' ,pch=16, col=category_color[category_color_index], cex=2 )
legend("topright", legend=c("CST-I-105","CST-II-25","CST-III-135","CST-IV-108","CST-V-21"), bty='n',
       col=c("#dd3589","#e95a5a","#ef88ab","#2e1cad","#f8aacd"), pch=15, pt.cex=2, 
       text.col = c("#dd3589","#e95a5a","#ef88ab","#2e1cad","#f8aacd") )
plot( eth_rda$CCA$wa[,1], eth_rda$CCA$wa[,2], 
      xlab="RDA1 (pH + ethnicity + Nugent)", ylab="RDA2 (pH + ethnicity + Nugent)",
      main = "Self-declared ethnicity",
      type='p' ,pch=16, col=paste0(eth_colors,"bb")[ethnic_group], cex=2 )
legend("topright", legend=c("Asian-96","White-97","Black-104","Hispanic-97"), bty='n',
       col=eth_colors, pch=15, pt.cex=2, 
       text.col = eth_colors )
plot( eth_rda$CCA$wa[,1], eth_rda$CCA$wa[,2], 
      xlab="RDA1 (pH + ethnicity + Nugent)", ylab="RDA2 (pH + ethnicity + Nugent)",
      main = "Measured pH",
      type='p' ,pch=16, col=ph_cols[ph_category], cex=2 )
legend("topright", legend=c("pH 4.0","pH 4.5","pH 5.0","pH 5.5","pH 5.8"), bty='n',
       col=ph_cols[c(1,3,5,7,9)], pch=15, pt.cex=2 )
dev.off()

################################################################################
################################################################################


# data from
# Albert 2015 A study of the vaginal microbiome in healthy Canadian women
# https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0135620

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/Albert2015_pone.0135620.s006.tab.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t", )
otu_counts.n = otu_counts[grep("OTU",x = otu_counts$OTU),grep("Vogue",x = names(otu_counts))]

top_otu = apply( otu_counts.n , 2 , which.max )
category_color_index = ifelse( top_otu > 7, 8, top_otu )
category_color = c( "#dd3589aa", "#ef88abaa", "#2e1cadaa","#f8aacdcc", "#3774dbcc", "#7353e0cc", "#e95a5acc", "#888888cc" )

otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

pdf(file="~/git/misc-analyses/eco_diversity/images/albert2015_reads_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(sample_counts_by_all_sp, otu_shannon_index, 
     xlim=c(0,100000), main="Data from Albert et al 2015 PLOS ONE",
     xlab="Clustered OTU counts (reads)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3, axes = FALSE,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
axis(2, cex.axis=1.3)
axis(1, at = c(0,25000,50000,75000,100000), cex.axis=1.3 )
text(60000,4.0,"CST-I-147", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(60000,3.7,"CST-III-58", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(60000,3.4,"CST-IVc-18", cex=1.1, col="#2e1cad", pos=4) # Gardnerella A
text(60000,3.1,"CST-V-20", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(60000,2.8,"CST-IVd-13", cex=1.1, col="#3774db", pos=4) # Gardnerella C
text(60000,2.5,"CST-IVa-6", cex=1.1, col="#7353e0", pos=4) # various
text(60000,2.2,"CST-IVa-10", cex=1.1, col="#e95a5a", pos=4) # various
dev.off()

pdf(file="~/git/misc-analyses/eco_diversity/images/albert2015_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,500), main="Data from Albert et al 2015 PLOS ONE",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(270,2.3,"CST-I-147", cex=1.1, col="#dd3589", pos=4) # Lactobacillus crispatus
text(270,2.0,"CST-III-58", cex=1.1, col="#ef88ab", pos=4) # Lactobacillus iners
text(270,1.7,"CST-IVc-18", cex=1.1, col="#2e1cad", pos=4) # Gardnerella A
text(270,1.4,"CST-V-20", cex=1.1, col="#f8aacd", pos=4) # Lactobacillus jenseni
text(270,1.1,"CST-IVd-13", cex=1.1, col="#3774db", pos=4) # Gardnerella C
text(270,0.8,"CST-IVa-6", cex=1.1, col="#7353e0", pos=4) # various
text(270,0.5,"CST-IVa-10", cex=1.1, col="#e95a5a", pos=4) # various
dev.off()


################################################################################
################################################################################

# Aronson 2016 The specific and exclusive microbiome of the deep-sea bone-eating snail, Rubyspira osteovora
# https://academic.oup.com/femsec/article/93/3/fiw250/2701681
# https://datadryad.org/stash/dataset/doi:10.5061/dryad.5h1q1

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/Snail_data_OTUs_4_Dryad.tab.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t" )
otu_counts.n = otu_counts[,3:20]

sample_type = sapply( strsplit(names(otu_counts.n),"\\."), "[", 2 )
sample_type_counts = table(sample_type)
category_color_index = match(sample_type, names(sample_type_counts) )
category_color = c( "#cdde1dcc", "#9b5411cc", "#82c27ccc","#82c27ccc", "#b79687cc", "#dba337cc", "#749b11cc" )

# counts are normalized by lowest read count of 21615 reads
otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

pdf(file="~/git/misc-analyses/eco_diversity/images/aronson2016_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,4000), main="Data from Aronson et al 2016 FEMS ME",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(2900,2.2,"digestive gland-4", cex=1.1, col="#cdde1d")
text(2900,3.7,"fecal pellet-1", cex=1.1, col="#9b5411")
text(2900,3.2,"snail intestine-6", cex=1.1, col="#82c27c")
text(2900,6.2,"whale bone-1", cex=1.1, col="#b79687")
text(2900,5.7,"sediment-1", cex=1.1, col="#dba337")
text(2900,2.7,"snail stomach-5", cex=1.1, col="#749b11")
dev.off()



# species accumulation curve
s = specaccum(t(otu_counts.n))
plot(s, lwd=12, col="#12780188", ci.lty = 0, ci.type="polygon", ci.col="#12780144")




m = metaMDS(t(otu_counts.n), trace = FALSE)
# make pca graph
pdf(file="~/git/misc-analyses/eco_diversity/images/aronson2016_mds_analysis_v1.pdf", height=5, width=5, title="Data from Aronson et al 2016", useDingbats = FALSE)
par(mar=c(4,4,3,1))
plot(m, type='n', main="Data from Aronson et al 2016 FEMS ME")
points(m, display = "sites", cex = 3, pch=16, col=category_color[category_color_index] )
text(2.8,1.6,"snail intestine-6", cex=1.1, col="#82c27c", pos=2)
text(2.8,1.3,"snail stomach-5", cex=1.1, col="#749b11", pos=2)
text(2.8,1.0,"digestive gland-4", cex=1.1, col="#cdde1d", pos=2)
text(2.8,0.7,"fecal pellet-1", cex=1.1, col="#9b5411", pos=2)
text(2.8,-1.5,"whale bone-1", cex=1.1, col="#b79687", pos=2)
text(2.8,-1.8,"sediment-1", cex=1.1, col="#dba337", pos=2)
dev.off()


rda.u = rda( t(otu_counts.n) , scale=FALSE )
pdf(file="~/git/misc-analyses/eco_diversity/images/aronson2016_unconst_rda_v1.pdf", height=5, width=5, title="Data from Aronson et al 2016", useDingbats = FALSE)
par(mar=c(4,4,3,1))
plot( rda.u$CA$u[,1], rda.u$CA$u[,2], 
      xlab="RDA1 (unconstrained, unscaled)", ylab="RDA2 (unconstrained, unscaled)",
      main = "Data from Aronson et al 2016 FEMS ME",
      type='p' , pch=16, col=category_color[category_color_index], cex=3 )
text(-0.5,-0.4,"snail intestine-6", cex=1.1, col="#82c27c", pos=4)
text(-0.5,-0.3,"snail stomach-5", cex=1.1, col="#749b11", pos=4)
text(-0.5,0.4,"digestive gland-4", cex=1.1, col="#cdde1d", pos=4)
text(-0.5,-0.5,"fecal pellet-1", cex=1.1, col="#9b5411", pos=4)
text(-0.5,0.3,"whale bone-1", cex=1.1, col="#b79687", pos=4)
text(-0.1,0.3,"sediment-1", cex=1.1, col="#dba337", pos=4)
dev.off()


################################################################################
################################################################################

# Blyton 2019 Faecal inoculations alter the gastrointestinal microbiome and allow dietary expansion in a wild specialist herbivore, the koala
# https://animalmicrobiome.biomedcentral.com/articles/10.1186/s42523-019-0008-0
# https://datadryad.org/stash/dataset/doi:10.5061/dryad.45ct519

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/Koala_OTU_table_rarefied_10000.csv.gz"
otu_counts = read.csv(otu_counts_file, header = TRUE )
otu_counts.n = data.frame( otu_counts[,4:2480] )

sample_type_counts = table(otu_counts[,3])
category_color_index = match(otu_counts[,3], names(sample_type_counts) )
category_color = c( "#158221cc", "#4b4b4bcc", "#825615cc" )

# counts are normalized to 10000 reads
otu_n_species = rowSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = rowSums(otu_counts.n)
sp_counts_by_all_samples = colSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=1)

pdf(file="~/git/misc-analyses/eco_diversity/images/blyton2019_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,300), main="Data from Blyton et al 2019 Animal Microbiome",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(0,4.2,"control koala-35", cex=1.1, col="#158221", pos=4)
text(0,4.0,"treatment koala-35", cex=1.1, col="#825615", pos=4)
text(0,3.8,"reference-33", cex=1.1, col="#4b4b4b", pos=4)
dev.off()


################################################################################
################################################################################

# Junqueira et al 2017 The microbiomes of blowflies and houseflies as bacterial transmission reservoirs
# https://www.nature.com/articles/s41598-017-16353-x/
# https://static-content.springer.com/esm/art%3A10.1038%2Fs41598-017-16353-x/MediaObjects/41598_2017_16353_MOESM4_ESM.xlsx


otu_counts_file = "~/git/misc-analyses/eco_diversity/data/junqueira2018_41598_2017_16353_MOESM4_ESM.table3.tab.gz"
otu_counts = read.table(otu_counts_file, header = TRUE , sep = "\t" , comment.char = "" )
otu_counts.n = otu_counts[1:430,3:118]


sample_type = sapply( strsplit(names(otu_counts.n),"\\."), "[", 1 )
sample_type_counts = table(sample_type)
category_color_index = match(sample_type, names(sample_type_counts) )
category_color = c( "#3ca22fcc", "#9b6514cc" )

# counts are normalized to 10000 reads
otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

pdf(file="~/git/misc-analyses/eco_diversity/images/junqueira2017_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,120), main="Data from Junqueira et al 2017 Sci Rep",
     xlab="Total species per sample (by mapped reads)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(60,0.8,"blowflies-63", cex=1.1, col="#3ca22f", pos=4)
text(60,0.4,"houseflies-53", cex=1.1, col="#9b6514", pos=4)
dev.off()

# MDS analysis
m = metaMDS(t(otu_counts.n), trace = FALSE)
plot(m, type='n')
points(m, display = "sites", cex = 2, pch=16, col=category_color[category_color_index] )
text(-3,-1,"blowflies-63", cex=1.1, col="#3ca22f", pos=4)
text(1,2,"houseflies-53", cex=1.1, col="#9b6514", pos=4)



################################################################################
################################################################################

# data from
# Galand 2023 Diversity of the Pacific Ocean coral reef microbiome
# https://www.nature.com/articles/s41467-023-38500-x
# https://zenodo.org/record/4451892

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/TARA_PACIFIC_16S_otu.tsv.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t", )
otu_counts.n = otu_counts[,grep("TARA_",x = names(otu_counts))]
sample_type_counts = table(sapply( strsplit(names(otu_counts),"\\."), "[", 1 ) ) 




################################################################################
################################################################################

# data from
# Gajer 2012 Temporal Dynamics of the Human Vaginal Microbiota
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3722878/

#b Low=1-3,intermediate=4-6 and High=7-10; 
#c Community state types as defined in Figure S1; 
#d Total number of high-quality 16S rRNA gene sequence reads; 
#e RDP+speciateIT Taxonomic assignments 

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/gajer2012_NIHMS428591-supplement-Table_S2.tab.gz"
otu_counts_timeseries = read.table(otu_counts_file, header = TRUE, sep = "\t", skip=4 )
#otu_counts.n = data.frame(t(as.matrix(otu_counts[,8:ncol(otu_counts)] ) ) )
subject_ids = unique(otu_counts_timeseries$Subject.ID)
subject_ids
#names(otu_counts_timeseries.d)[1:50]

category_color_index = match(otu_counts_timeseries$Community.State.Typec , unique(otu_counts_timeseries$Community.State.Typec) )
#                   prevotella   L iners      L gasseri    Gardnerella  L crispatus
category_color = c( "#7353e0aa", "#ef88abaa", "#e95a5acc", "#2e1cadaa", "#dd3589aa" )


#a Self-described ethnic group- White=1 , Black=0 , Hispanic=5 , others=4; 
eth_colors = c("#401e11", "#f9eae4", "blue", "blue", "#f9b620ff", "#c03c18")

# colorize diversity index
div_colors = colorRampPalette(c("#212f11ff","#b7e61aff","#e2fe82ff"))(10)

# alternating light and dark bars, then assign colors to known taxa
bar_colors = rep(c("#aaaaaa","#555555"),dim(otu_counts_timeseries)[2]-10)
bar_colors[c(2,4,8,1,  18,20,22,78,90, 
             3,9,5,   7,21, 
             12,13,28,   6,10,17, 
             45,61,33, 
             14,24,37,
             42)] = c(
               "#dd3589", "#e95a5a", "#f8aacd", "#ef88ab", #Lcrispatus Lgasseri Ljenseni Liners
               "#f0b2b2","#f0b2b2","#f0b2b2","#f0b2b2", "#f0b2b2", #L otus
               "#2e1cad", "#3774db", "#7353e0", # GardnerellaA, C, Prevotella
               "#183360", "#28b8eb", # Sneathia Bifidobacterium
               "#127801", "#92d18c", "#4b6c48", # Streptococcus Corynebacterium Staphylococcus
               "#269750", "#1ca62b", "#0f5716", # Parvimonas Peptoniphilus Finegoldia
               "#927638", "#927638", "#6d582a", # Enterococcus Enterococcus Escherichia
               "#be7c05", "#be7c25", "#be7c45", # Ruminococcaceae.3 Ruminococcaceae.5 Ruminococcaceae.2
               "#eeeeee" ) # Ureaplasma

# collect values in for loop
beta_div_all = c()
total_species_all = c()
# make fig
pdf(file="~/git/misc-analyses/eco_diversity/images/gajer2012_timeseries_all_w_mds.pdf", width=8, height=11, paper="a4", title = "Replot of Gajer 2012 timeseries", useDingbats = FALSE )
par(mar=c(2.5,4,4,1), mfrow=c(4,2), xpd=TRUE)
i = 10
for (i in 1:length(subject_ids)){
  # filter to match subject ID
  otu_counts_timeseries.s = otu_counts_timeseries[which(otu_counts_timeseries$Subject.ID==i),]
  # make table for only data columns, not metadata
  otu_counts_timeseries.d = otu_counts_timeseries.s[11:dim(otu_counts_timeseries)[2]]
  otu_shannon_index = diversity(otu_counts_timeseries.d, index="shannon", MARGIN=1)
  # test that rows sum to 100, meaning datapoints are percentage
  rowSums(otu_counts_timeseries.s[,11:dim(otu_counts_timeseries)[2]])
  b = barplot(t(as.matrix(otu_counts_timeseries.d)), 
          ylab="Percent 16S OTUs", cex.lab=1.2,
          names=otu_counts_timeseries.s$Time.in.study, cex.names=0.8, las=2,
          col=bar_colors)
  title(paste("Subject",i), line=1.5, adj=0, cex.main=2, font.main=1)
  mtext("Days", side=1, line=0.8, at=0, adj=1, cex=0.7)
  # plot ethnicity on left edge
  points(0.1,50, pch=21, cex=2, bg=eth_colors[(otu_counts_timeseries.s$Racea[1]+1)])
  # plot diversity index colorized on top of bars as triangles
  points(b, rep(c(103),length(b)), pch=24, bg=div_colors[round(otu_shannon_index*2)+1],  )
  
  #beta_div = ncol(otu_counts_timeseries.d)/mean(specnumber(otu_counts_timeseries.d)) - 1
  beta_div = mean( vegdist(otu_counts_timeseries.d) )
  total_sp_count = sum(na.omit(colSums(otu_counts_timeseries.d)/colSums(otu_counts_timeseries.d)))
  beta_div_all = c(beta_div_all,beta_div)
  total_species_all = c(total_species_all,total_sp_count)

  # run MDS for PCA type plot
  m = metaMDS(otu_counts_timeseries.d, trace = FALSE)
  # plot MDS object
  plot(m, type='n' )
  title(paste("Subject",i), line=1.5, adj=0, cex.main=2, font.main=1)
  title(paste("beta =", round(beta_div,3)), line=1.5, adj=0.8, cex.main=1.5, font.main=1)
  # draw line of timeseries in order
  lines(m$points[,1],m$points[,2] )
  # normal points, colored by community state
  points(m, display = "sites", cex = 2, pch=16, col=category_color[category_color_index[which(otu_counts_timeseries$Subject.ID==i)]] )
  # highlight first point in gray
  points(m$points[1,1],m$points[1,2], cex=2, pch=21, lwd=4, col="#00000088")
}
dev.off()

#if(i%%8==0){}

# run above FOR loop first to fill up vectors
# generate fig showing little connection between total species per patient and beta diversity
pdf(file="~/git/misc-analyses/eco_diversity/images/gajer2012_beta_diversity.pdf", height=5, width=5, title="Beta diversity from Gajer 2012", useDingbats = FALSE )
par(mar=c(4.5,4.5,3,1))
plot( total_species_all, beta_div_all , xlim=c(0,180), 
      main="Data from Gajer 2012 Sci Transl Med",
      xlab="Total species (per subject)", ylab="Beta diversity (per subject)",
      bg=eth_colors[(otu_counts_timeseries$Racea[which(otu_counts_timeseries$Time.in.study==1)]+1)][match(1:32,subject_ids)],
      pch=21, cex=2, cex.lab=1.3, cex.axis=1.3 )
text( total_species_all, beta_div_all, c(1:32), pos=ifelse(1:32 %in% c(5,7,11,12,13,14,15,17,19,21,22,26,31,30),4,2) )
dev.off()



# diversity index when in raw counts, not percentage
#otu_counts.t = otu_counts_timeseries.d[1,] * otu_counts_timeseries.s$Total.Read.Countsd[1] / 100
#diversity(otu_counts.t, index="shannon")
#otu_shannon_index


otu_counts_timeseries.d.f = otu_counts_timeseries.d[,which(colSums(otu_counts_timeseries.d)>0)]
dim(otu_counts_timeseries.d.f)
m = metaMDS(otu_counts_timeseries.d.f, trace = FALSE)
plot(m, type='n' )
points(m, display = "sites", cex = 2, pch=16, col=category_color[category_color_index[which(otu_counts_timeseries$Subject.ID==i)]] )
lines(m$points[,1],m$points[,2] )
text(m, display = "species")



################################################################################
################################################################################





################################################################################
################################################################################
# data from
# https://gitlab.com/alsulit08/uoc_response_rectalca
# possibly from this article
# Sulit et al 2023 Human gene and microbial analyses in rectal cancer complete responses to radiotherapy
# https://academic.oup.com/bjsopen/article/7/3/zrad035/7158800

# UNSURE IF THIS IS REALLY AMPLICON SEQUENCING
otu_counts_file = "~/git/misc-analyses/eco_diversity/data/sulit_2023_alltaxon_gensp.tsv.gz"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t", quote="", comment.char = "", row.names = 1)
otu_counts.n = otu_counts[,11:90]


sample_metadata_file = "~/git/misc-analyses/eco_diversity/data/rectal_CA_final.txt"
sample_metadata = read.table(sample_metadata_file, header = TRUE, sep = "\t")
sample_metadata

sample_type_counts = table(sample_metadata$tissue_type)
category_color_index = match(sample_metadata$tissue_type, names(sample_type_counts) )
category_color = c( "#e54aecaa", "#9d360faa" )

otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

pdf(file="~/git/misc-analyses/eco_diversity/images/sulit_2023_alpha_diversity_v1.pdf", height=5, width=5, title="Data from Sulit et al 2023", useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index,
     xlim=c(0,12000), ylim=c(1.2,4.5), main="Data from Sulit et al 2023 BSJ Open",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.2, cex.lab=1.3,
     pch=16, cex=log10(sample_counts_by_all_sp)-3, col=category_color[category_color_index])
text(0,4.0,"normal-40", cex=1.1, col="#e54aec", pos=4)
text(0,3.5,"cancer-40", cex=1.1, col="#9d360f", pos=4)
dev.off()


#