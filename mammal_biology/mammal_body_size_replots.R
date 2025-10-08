#
#


# data from
# Kenagy and Trombulak 1986 Size and Function of Mammalian Testes in Relation to Body Size
# https://www.jstor.org/stable/1380997

mammal_data_file = "~/git/misc-analyses/mammal_biology/data/kenagy_1986_table1_mammal_testes_vs_size.txt"
mammal_data = read.table(mammal_data_file, header=TRUE, sep="\t")
head(mammal_data)

mammal_data$Relative_testes_size_note2
table( mammal_data$Mating_system_note3 )
table( mammal_data$Mating_system_ref )

unique(mammal_data$Group)
group_symbols = c(21, 22, 21, 25, 24, 24, 21, 23, 21, 24, 25, 21, 24)
group_colors = c("#a8761288", "#a8a8a888", "#a8761288", "#cf345688", "#12563488",
                 "#1234bc88", "#12345688", "#12345688", "#12345688", "#12345688",
                 "#1234bc88", "#12345688", "#12345688" )
key_species = c("Homo sapiens")
is_named_sp = mammal_data$Species %in% key_species

body_testes_lm = lm(Testes_mass_g ~ Body_mass_g, data = mammal_data)

plot( log10(mammal_data$Body_mass_g) , log10(mammal_data$Testes_mass_g ) ,
      xlim=c(0,8), ylim=c(-2,4),
      xlab="Body mass (log g)", ylab="Testes mass (log g)",
      pch=group_symbols[match( mammal_data$Group, unique(mammal_data$Group))], 
      bg=group_colors[match( mammal_data$Group, unique(mammal_data$Group))] )
points( log10(mammal_data$Body_mass_g)[is_named_sp] , log10(mammal_data$Testes_mass_g )[is_named_sp], 
      col="#e8487888", bg=NA, lwd=3)
text( log10(mammal_data$Body_mass_g)[is_named_sp] , log10(mammal_data$Testes_mass_g )[is_named_sp], 
      mammal_data$Common_name[is_named_sp], 
      pos=ifelse(mammal_data$Testes_body_percent > 1.5, 2, 4) )

is_primate = which(mammal_data$Group=="Primates")
mammal_data.primate = mammal_data[is_primate,]
mammal_data.primate
is_M_mating = mammal_data.primate$Mating_system_note3=="M"
M_mating_xval = ifelse(is_M_mating, 0.6, 0.3 )

pdf(file="~/git/misc-analyses/mammal_biology/images/primate_mammal_testes_vs_size.pdf", width=6, height=4, title="Testes size by mating system in primates")
par(mar=c(2,4.5,1,1))
plot( M_mating_xval , mammal_data.primate$Relative_testes_size_note2 , xlim=c(0.3,0.9), ylim=c(0,3),
      axes=FALSE, ylab="Relative testes size", xlab=NA,
      pch=21, cex=3 , bg=c(rep("#a8a8a888",27),"#e8487888") , cex.lab=1.3)
print_mammals = c(1:2,4,6:14,15:16,25:28)
#text( M_mating_xval[] , mammal_data.primate$Relative_testes_size_note2[], mammal_data.primate$Common_name[], pos=4 )
text( M_mating_xval[print_mammals] , mammal_data.primate$Relative_testes_size_note2[print_mammals], 
      mammal_data.primate$Common_name[print_mammals], pos=4 )
axis(2)
axis(1, at=c(0.4, 0.7), labels=c("Single-male","Multi-male"), tick = FALSE, line=-1 )
dev.off()

#
plot( log10(mammal_data$Body_mass_g) , log10(mammal_data$Testes_body_percent) ,
      xlim=c(0,8), ylim=c(-2,1),
      xlab="Body mass (log g)", ylab="Testes mass (log g)",
      pch=21, bg="#12345688")
text( log10(mammal_data$Body_mass_g) , log10(mammal_data$Testes_body_percent) , mammal_data$Common_name , pos=4)




#