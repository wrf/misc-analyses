# schuster 2021 data
# from
# https://github.com/astridschuster/Microbiome_MS_2020

otu_counts_file = "~/git/misc-analyses/eco_diversity/data/schuster2021_otutable.txt"
otu_counts = read.table(otu_counts_file, header = TRUE, sep = "\t", row.names = 1, fill = TRUE )
sample_metadata = read.table("~/git/misc-analyses/eco_diversity/data/schuster2021_metadata.tab", header = TRUE, sep = "\t")
names(otu_counts)
table(sample_metadata$Species_name)
schuster2021_sample_ids = gsub("-", ".", sample_metadata$SeqID)
schuster2021_kept_samples = match( schuster2021_sample_ids, names(otu_counts) )
otu_counts.n = otu_counts[,schuster2021_sample_ids]
otu_n_species = colSums(otu_counts.n/otu_counts.n,na.rm = TRUE)


category_color_index = match( sample_metadata$Species_name , c("Water", "Sediment", ""), nomatch = 4 )
category_color = c( "#2e1cadcc", "#927241cc", "#2e1cadcc", "#a353c0cc" )

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


#