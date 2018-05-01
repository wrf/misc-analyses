#!/usr/bin/env Rscript
# make barplot of kingdom, phylum and classes
# v1 created by WRF 2018-04-05

args = commandArgs(trailingOnly=TRUE)

inputfile = args[1]
#inputfile = "~/git/misc-analyses/taxonomy_database/sra_trace_species_list_2018-04-05.tab"
outputfile = gsub("([\\w/]+)\\....$","\\1.pdf",inputfile,perl=TRUE)

taxondata = read.table(inputfile, header=TRUE, sep="\t")

kingdoms = sort(table(taxondata[["kingdom"]]),decreasing=FALSE)

kingrefs = c("Fungi",   "Metazoa", "None",   "Viridiplantae", "Bacteria", "Archaea")
kingcols = c("#4075b2", "#9354cf", "#888888", "#18d025",      "#c34741" , "#de851b")
kingdomorder = match(names(kingdoms),kingrefs)

xmax = max(pretty(max(kingdoms)))

phyla = sort(table(taxondata[["phylum"]]),decreasing=FALSE)
phyla = phyla[phyla>xmax*0.0002]

# cnidaria was "#881685"
# echinodermata was "#800968"
# ascomycota was "#389192"

metaphyla = c("Arthropoda","Chordata","Mollusca", "Cnidaria", "Echinodermata","Platyhelminthes","Nematoda","Annelida", "Porifera", "Rotifera", "Ctenophora", "Tardigrada")
plantaphyla = c("Streptophyta", "Chlorophyta", "Bacillariophyta")
fungiphyla = c("Ascomycota","Basidiomycota","Mucoromycota","Chytridiomycota")
phaeophyla = c("Phaeophyceae","Apicomplexa")
bactphyla = c("Proteobacteria", "Firmicutes", "Actinobacteria", "Bacteroidetes", "Spirochaetes", "Cyanobacteria", "Tenericutes", "Chloroflexi", "Chlamydiae", "Verrucomicrobia")
archaphyla = c("Euryarchaeota", "Thaumarchaeota", "Crenarchaeota", "Parvarchaeota")

phylarefs = c(bactphyla,archaphyla,phaeophyla,fungiphyla,plantaphyla,metaphyla)
# assumes "None" is first entry, so #888888
phylacols = c("#888888",  rep(c("#c34741"),length(bactphyla)),  rep(c("#de851b"),length(archaphyla)),  rep(c("#8d8f0d"),length(phaeophyla)),  rep(c("#4075b2"),length(fungiphyla)),  rep(c("#18d025"),length(plantaphyla)),  rep(c("#9354cf"),length(metaphyla)) )
phylaorder = match(names(phyla),phylarefs,nomatch=0)+1


is_arthropod = taxondata[["phylum"]]=="Arthropoda"
is_arthropod = taxondata[["phylum"]]=="Arthropoda" | taxondata[["phylum"]]=="Chordata"
arthclasses = sort(table(taxondata[["class"]][is_arthropod], exclude=0),decreasing=FALSE)

is_streptophyte = taxondata[["phylum"]]=="Streptophyta"
streptoclasses = sort(table(taxondata[["class"]][is_streptophyte], exclude=0),decreasing=FALSE)

is_chordate = taxondata[["phylum"]]=="Chordata"
chordclasses = sort(table(taxondata[["class"]][is_chordate], exclude=0),decreasing=FALSE)

### change classes here to arthclasses, streptoclasses, or chordclasses depending on the desired phylum
thirdgraph = arthclasses

pdf(file=outputfile, width=8, height=14)

par(mar=c(1,10,3,1.6))
layout(matrix(c(1,2),nrow=2),heights=c(1,4))
bp1 = barplot(kingdoms, horiz=TRUE, las=1, xlim=c(0,xmax), col=kingcols[kingdomorder], main=inputfile, cex.lab=1.4, cex.axis=1.3)
kt_positions = kingdoms/2
kt_positions[kingdoms<xmax*0.06] = kingdoms[kingdoms<xmax*0.06]+xmax*0.05
text(kt_positions, bp1[,1], kingdoms)

par(mar=c(4,10,1,1.6))
bp2 = barplot(phyla, horiz=TRUE, xlim=c(0,xmax), las=1, cex.axis=1.3, col=phylacols[phylaorder])
text(phyla+xmax*0.01, bp2[,1], phyla, pos=4)
text(xmax*0.6,max(bp2)*0.8,"Note: 'None' may include many bacterial\nor single-celled eukaryotic groups\nthat lack higher-level rankings\nin the NCBI Taxonomy database.", cex=1.5)

par(fig = c(grconvertX(c(xmax*0.5,xmax), from="user", to="ndc"), grconvertY(c(0.25,0.65)*max(bp2), from="user", to="ndc")), mar = c(0,0,0,0), new = TRUE)
bp3 = barplot(thirdgraph[thirdgraph>0], horiz=TRUE, las=1, xlim=c(0,xmax/2), col=c("#9354cf"), cex.lab=1.3, axes=FALSE)
text(thirdgraph[thirdgraph>0], bp3, thirdgraph[thirdgraph>0], pos=4, cex=0.9)


dev.off()


#