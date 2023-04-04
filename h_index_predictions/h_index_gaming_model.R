# h index model for diagram
#

outfile_name = "~/git/misc-analyses/h_index_predictions/h_index_gaming_strategy_v2.pdf"

pdf(outfile_name, width=8, height=4)
par(mfrow=c(1,2), mar=c(3,4.5,3,0.5))
# high impact version
pubs = c(30,60,150, 15, rep(3,1), rep(1,1), rep(0,9), rep())
ordered_pubs = sort(pubs, decreasing = TRUE)
barplot(ordered_pubs, space=0, width = c(1), ylim = c(0,150),
        main="High impact strategy", 
        ylab="Citations (n)", cex.lab=1.3, axes=FALSE,
        col = c(rep("#3147b1",4),rep("gray",11)))
axis(2,at=seq(0,150,30), cex.axis=1.2)
mtext("Papers by ordinal rank", 1, 1, cex=1.3)
text(4,30, "4 papers with 4+ citations", pos=4, cex=1.1, col="#3147b1")
#rect(0,0,4,4, lwd=3, lty=2, col="#0000bb66" )# border = "#9c1745aa")
text(4,120, paste("h-index : 4\nCitations:",sum(pubs)), pos=4, cex=1.2)

# gamed version
pubs = c(1:15)
ordered_pubs = sort(pubs, decreasing = TRUE)
barplot(ordered_pubs, space =0, width = c(1), ylim = c(0,150),
        main="h-hacking strategy", 
        ylab="Citations (n)", cex.lab=1.3, axes=FALSE,
        col = c(rep("#b1316f",8),rep("gray",7)))
#axis(2,at=seq(0,15,3), cex.axis=1.2)
axis(2,at=seq(0,150,30), cex.axis=1.2)
mtext("Papers by ordinal rank", 1, 1, cex=1.3)
text(4,30, "8 papers with 8+ citations", pos=4, cex=1.1, col="#b1316f")
#rect(0,0,8,8, lwd=3, lty=2, col="#bb00bb66" )# border = "#9c1745aa")
text(4,120, paste("h-index : 8\nCitations:",sum(pubs)), pos=4, cex=1.2)
dev.off()




#