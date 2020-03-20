# for WRF 2020-03

# based on editorial in Nature
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3770471/

#Key:
#n, number of articles written; 
n = 22

#h, current h-index; 
h = 11

#y, years since publishing first article; 
y = 7

#j, number of distinct journals published in; 
j = 20

#q, number of articles in Nature, Science, Nature Neuroscience, Proceedings of the National Academy of Sciences and Neuron.
q = 1

#Predicting next year (R2=0.92): 
h1  = 0.76 + 0.37*sqrt(n) + 0.97*h - 0.07*y + 0.02*j + 0.03*q
h1
# [1] 8.099777

#Predicting 5 years into the future (R2=0.67):
h5  = 4.00 + 1.58*sqrt(n) + 0.86*h - 0.35*y + 0.06*j + 0.2*q
h5
# [1] 19.82086

#Predicting 10 years into the future (R2=0.48):
h10 = 8.73 + 1.33*sqrt(n) + 0.48*h - 0.41*y + 0.52*j + 0.82*q
h10
# [1] 28.59825

barlabels = c("Current", "1 year", "5 year", "10 year")
barcolors = c("#287fed", "#ed7f28", "#e8a300", "#565656")
pdf(file="~/git/misc-analyses/h_index_predictions/2020_barplot.pdf", width=6, height=5)
par(mar=c(4,4.5,3,1))
hpred_bars = barplot( c(h, h1, h5, h10), ylim=c(0,32), col=barcolors, names=barlabels, main="Prospective H-index for WRF as of 2020", ylab="H-index", cex.names=1.4, cex.lab=1.5, cex.axis=1.5 )
text( hpred_bars, c(h, h1, h5, h10), round(c(h, h1, h5, h10), digits=1), pos=3 )
dev.off()

# recalculate for series of possible current papers
n= 1:50

h1  = 0.76 + 0.37*sqrt(n) + 0.97*h - 0.07*y + 0.02*j + 0.03*q
h5  = 4.00 + 1.58*sqrt(n) + 0.86*h - 0.35*y + 0.06*j + 0.2*q
h10 = 8.73 + 1.33*sqrt(n) + 0.48*h - 0.41*y + 0.52*j + 0.82*q

plot(n,h10, ylim=c(0,40), pch=16, col="#000000aa", cex=2, xlab="Number of papers (n)", ylab="h-index")
points(n,h5, pch=16, col="#e8a300aa", cex=2)
points(n,h1, pch=16, col="#ed7f28aa", cex=2)



#