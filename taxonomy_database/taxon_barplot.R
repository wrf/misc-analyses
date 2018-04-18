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
kingcols = c("#389192","#9354cf","#bc3c0a","#18d025")
kingdomorder = match(names(kingdoms),kingrefs)

phyla = sort(table(taxondata[["phylum"]]),decreasing=FALSE)
phylarefs = c("Arthropoda","Streptophyta","Chordata","None","Mollusca", "Cnidaria","Ascomycota","Basidiomycota","Phaeophyceae","Chlorophyta", "Echinodermata","Platyhelminthes","Nematoda","Annelida")
phylacols = c("#888888","#9354cf","#18d025","#9354cf","#bc3c0a", "#9354cf","#881685","#389192","#4075b2","#8d8f0d", "#18d025","#800968","#9354cf","#9354cf","#9354cf")
phylaorder = match(names(phyla),phylarefs,nomatch=0)+1


is_arthropod = taxondata[["phylum"]]=="Arthropoda"
arthclasses = sort(table(taxondata[["class"]][is_arthropod], exclude=0),decreasing=FALSE)

is_streptophyte = taxondata[["phylum"]]=="Streptophyta"
streptoclasses = sort(table(taxondata[["class"]][is_streptophyte], exclude=0),decreasing=FALSE)

is_chordate = taxondata[["phylum"]]=="Chordata"
chordclasses = sort(table(taxondata[["class"]][is_chordate], exclude=0),decreasing=FALSE)

xmax = max(pretty(max(kingdoms)))

pdf(file=outputfile, width=8, height=11)
par(mar=c(1,10,3,1.6))
layout(matrix(c(1,2),nrow=2),heights=c(1,4))
bp1 = barplot(kingdoms, horiz=TRUE, las=1, xlim=c(0,xmax), col=kingcols[kingdomorder], main=inputfile, cex.lab=1.4, cex.axis=1.3)
text(kingdoms/2, bp1[,1], kingdoms)
par(mar=c(4,10,1,1.6))
bp2 = barplot(phyla, horiz=TRUE, xlim=c(0,xmax), las=1, cex.axis=1.3, col=phylacols[phylaorder])
text(phyla+xmax*0.01, bp2[,1], phyla, pos=4)
text(xmax*0.6,max(bp2)*0.8,"Note: 'None' may include many bacterial\nor single-celled eukaryotic groups\nthat lack higher-level rankings\nin the NCBI Taxonomy database.", cex=1.5)

par(fig = c(grconvertX(c(xmax/2,xmax), from="user", to="ndc"), grconvertY(c(0.3,0.65)*max(bp2), from="user", to="ndc")), mar = c(2,0,0,0), new = TRUE)
bp3 = barplot(arthclasses[arthclasses>0], horiz=TRUE, las=1, xlim=c(0,xmax/2), col=c("#9354cf"), cex.lab=1.3, axes=FALSE)
text(arthclasses[arthclasses>0], bp3, arthclasses[arthclasses>0], pos=4, cex=0.9)


dev.off()


#