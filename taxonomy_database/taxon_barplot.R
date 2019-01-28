#!/usr/bin/env Rscript
# make barplot of kingdom, phylum and classes
# v1 created by WRF 2018-04-05

args = commandArgs(trailingOnly=TRUE)

inputfile = args[1]
#inputfile = "~/git/misc-analyses/taxonomy_database/sra_trace_species_list_2018-04-05.tab"
#inputfile = "~/git/misc-analyses/taxonomy_database/NCBI_SRA_Metadata_Full_20180402.unique_ncbi_ids_w_king.tab"
#inputfile = "~/git/misc-analyses/taxonomy_database/NCBI_SRA_Metadata_Full_20180402.ncbi_ids_w_kingdom.tab"
outputfile = gsub("([\\w/]+)\\....$","\\1.pdf",inputfile,perl=TRUE)

taxondata = read.table(inputfile, header=TRUE, sep="\t")

### define kingdom and color

kingdoms = sort(table(taxondata[["kingdom"]]),decreasing=FALSE)

kingrefs = c( "None",   "Fungi",   "Metazoa", "Viridiplantae", "Bacteria", "Archaea")
kingcols = c("#888888", "#4075b2", "#9354cf",  "#18d025",      "#c34741" , "#de851b")
kingdomorder = match(names(kingdoms),kingrefs)

totalspecies = sum(kingdoms)

xmax = max(pretty(max(kingdoms)))

### define phyla and color

phyla = sort(table(taxondata[["phylum"]]),decreasing=TRUE)
phylamax = min(c(50,length(phyla)))
phyla = phyla[phylamax:1]

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


### define class and color by matching kingdom, with a few rogue classes
classes = sort(table(taxondata[["class"]]),decreasing=TRUE)
classcols = rep(c("#888888"), length(classes)) # default is gray for all
for (i in 2:length(kingrefs)) {
within_king = taxondata[["kingdom"]]==kingrefs[i]
cl_by_king = table(droplevels(taxondata[["class"]][within_king]))
class_positions = match(names(cl_by_king),names(classes))
classcols[class_positions] = kingcols[i]
}
rogue_classes = c("None","Aconoidasida","Bacillariophyceae", "Dinophyceae","Chrysophyceae", "Bangiophyceae","Florideophyceae")
rogue_colors = c( "#888888", "#8d8f0d","#8d8f0d","#8d8f0d","#8d8f0d",   "#bf198a", "#bf198a")
rogue_matches = match(rogue_classes,names(classes))
rogue_matches = rogue_matches[!is.na(rogue_matches)]
classcols[rogue_matches] = rogue_colors

numclasses = 40
thirdgraph = classes[numclasses:1]

### generate PDF

pdf(file=outputfile, width=8, height=11)

par(mar=c(1,10,3,1.6))
layout(matrix(c(1,2),nrow=2),heights=c(1,4))
bp1 = barplot(kingdoms, horiz=TRUE, las=1, xlim=c(0,xmax), col=kingcols[kingdomorder], main=inputfile, cex.lab=1.4, cex.axis=1.3)
kt_positions = kingdoms/2
kt_positions[kingdoms<xmax*0.06] = kingdoms[kingdoms<xmax*0.06]+xmax*0.05
text(kt_positions, bp1[,1], kingdoms)
text(xmax,bp1[1,1], paste("Total:",totalspecies), cex=1.3, pos=2)

par(mar=c(4,10,1,1.6))
bp2 = barplot(phyla, horiz=TRUE, xlim=c(0,xmax), las=1, cex.axis=1.3, col=phylacols[phylaorder])
text(phyla+xmax*0.01, bp2[,1], phyla, pos=4)
#text(xmax*0.6,max(bp2)*0.8,"Note: 'None' may include many bacterial\nor single-celled eukaryotic groups\nthat lack higher-level rankings\nin the NCBI Taxonomy database.", cex=1.5)

par(fig = c(grconvertX(c(xmax*0.5,xmax), from="user", to="ndc"), grconvertY(c(-0.02,0.85)*max(bp2), from="user", to="ndc")), mar = c(0,0,0,0), new = TRUE)
bp3 = barplot(thirdgraph[thirdgraph>0], horiz=TRUE, las=1, xlim=c(0,xmax/2), col=classcols[numclasses:1], cex.lab=1.1, axes=FALSE)
classpos = thirdgraph[thirdgraph>0]
classpos[classpos>xmax/2] = classpos[classpos>xmax/2]/3
text(classpos, bp3, thirdgraph[thirdgraph>0], pos=4, cex=0.9)

dev.off()


#