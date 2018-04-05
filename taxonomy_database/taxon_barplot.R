#!/usr/bin/env Rscript
# make barplot of kingdom, phylum and classes
# v1 created by WRF 2018-04-05

args = commandArgs(trailingOnly=TRUE)

inputfile = args[1]
#inputfile = "~/git/misc-analyses/taxonomy_database/sra_trace_species_list_2018-04-05.tab"
outputfile = gsub("([\\w/]+)\\....","\\1.pdf",inputfile,perl=TRUE)

taxondata = read.table(inputfile, header=TRUE, sep="\t")

kingdoms = sort(table(taxondata[["kingdom"]]),decreasing=FALSE)

kingrefs = c("Fungi","Metazoa","None","Viridiplantae")
kingcols = c("#389192","#6816b5","#bc3c0a","#18d025")
kingdomorder = match(names(kingdoms),kingrefs)

phyla = sort(table(taxondata[["phylum"]]),decreasing=FALSE)
phylarefs = c("Arthropoda","Streptophyta","Chordata","None","Mollusca","Cnidaria","Ascomycota","Basidiomycota","Phaeophyceae","Chlorophyta","Echinodermata")
phylacols = c("#888888","#6816b5","#18d025","#6816b5","#bc3c0a","#6816b5","#881685","#389192","#4075b2","#8d8f0d","#18d025","#800968")
phylaorder = match(names(phyla),phylarefs,nomatch=0)+1

xmax = max(pretty(max(kingdoms)))

pdf(file=outputfile, width=8, height=11)
par(mar=c(1,10,3,1.6))
layout(matrix(c(1,2),nrow=2),heights=c(1,4))
barplot(kingdoms, horiz=TRUE, las=1, xlim=c(0,xmax), col=kingcols[kingdomorder], main=inputfile, cex.lab=1.4, cex.axis=1.3)
par(mar=c(4,10,1,1.6))
barplot(phyla, horiz=TRUE, xlim=c(0,xmax), las=1, cex.axis=1.3, col=phylacols[phylaorder])
text(xmax/2,10,"Note: None may include many bacterial\nor single-celled eukaryotic groups\nthat lack higher-level rankings\nin the NCBI Taxonomy database.", cex=1.5)
dev.off()


#