# diversity replots of published datasets
# https://github.com/wrf/misc-analyses/tree/master/eco_diversity


library(vegan)


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
text(60000,4.0,"CST-I-147", cex=1.1, col="#dd3589", pos=4)
text(60000,3.7,"CST-III-58", cex=1.1, col="#ef88ab", pos=4)
text(60000,3.4,"CST-IVc-18", cex=1.1, col="#2e1cad", pos=4)
text(60000,3.1,"CST-V-20", cex=1.1, col="#f8aacd", pos=4)
text(60000,2.8,"CST-IVd-13", cex=1.1, col="#3774db", pos=4)
text(60000,2.5,"CST-IVa-6", cex=1.1, col="#7353e0", pos=4)
text(60000,2.2,"CST-IVa-10", cex=1.1, col="#e95a5a", pos=4)
dev.off()

pdf(file="~/git/misc-analyses/eco_diversity/images/albert2015_otus_vs_diversity_index_v1.pdf", height=5, width=5, useDingbats = FALSE)
par(mar=c(4.5,4.5,2,1.2))
plot(otu_n_species, otu_shannon_index, 
     xlim=c(0,500), main="Data from Albert et al 2015 PLOS ONE",
     xlab="Total species per sample (OTUs)", ylab="Shannon Index", cex.axis=1.3, cex.lab=1.3,
     frame.plot = TRUE,
     pch=16, cex=2, col=category_color[category_color_index])
text(270,2.3,"CST-I-147", cex=1.1, col="#dd3589", pos=4)
text(270,2.0,"CST-III-58", cex=1.1, col="#ef88ab", pos=4)
text(270,1.7,"CST-IVc-18", cex=1.1, col="#2e1cad", pos=4)
text(270,1.4,"CST-V-20", cex=1.1, col="#f8aacd", pos=4)
text(270,1.1,"CST-IVd-13", cex=1.1, col="#3774db", pos=4)
text(270,0.8,"CST-IVa-6", cex=1.1, col="#7353e0", pos=4)
text(270,0.5,"CST-IVa-10", cex=1.1, col="#e95a5a", pos=4)
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

################################################################################
################################################################################

# Blyton 2019 Faecal inoculations alter the gastrointestinal microbiome and allow dietary expansion in a wild specialist herbivore, the koala
# https://animalmicrobiome.biomedcentral.com/articles/10.1186/s42523-019-0008-0
# https://datadryad.org/stash/dataset/doi:10.5061/dryad.45ct519

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/Koala_OTU_table_rarefied_10000.csv"
otu_counts = read.csv(otu_counts_file, header = TRUE )
otu_counts.n = data.frame( t( otu_counts[,4:2480] ) )

sample_type_counts = table(otu_counts[,3])
category_color_index = match(otu_counts[,3], names(sample_type_counts) )
category_color = c( "#158221cc", "#4b4b4bcc", "#825615cc" )

# counts are normalized to 10000 reads
otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)
sample_counts_by_all_sp = colSums(otu_counts.n)
sp_counts_by_all_samples = rowSums(otu_counts.n)
otu_shannon_index = diversity(otu_counts.n, index="shannon", MARGIN=2)

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


otu_counts_file = "~/git/misc-analyses/eco_diversity/data/41598_2017_16353_MOESM4_ESM.table3.tab"
otu_counts = read.table(otu_counts_file, header = TRUE , sep = "\t" , comment.char = "" )
otu_counts.n = otu_counts[1:430,3:118]
names()

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



#