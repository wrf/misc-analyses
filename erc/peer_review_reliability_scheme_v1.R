# calculate chances of good peer review as a function of number of bad reviewers
# last modified 2022-06-29


n = seq(0,1,0.01)
p = (1-n)^3
half_n = which(p<0.5)[1]

pdf(file="~/git/misc-analyses/erc/images/peer_review_reliability_scheme_v1.pdf", width=5, height=4)
par(mar=c(4.5,4.5,2.5,1))
plot(n,p, type='n', lwd=2, frame.plot=FALSE, 
     cex.lab=1.3, cex.axis=1.2,
     main="How can we get a good peer review?",
     xlab="Fraction of bad reviewers in pool", ylab="Chance for 3 good reviewers")
polygon( c(n[1:half_n], n[half_n], 0), c(p[1:half_n], 0, 0) , col="orange",border = NA )
polygon( c(n[half_n], n[half_n:(length(n))], n[half_n]), c(p[half_n], p[half_n:(length(n))], 0) , col="red", border = NA )

segments( n[half_n] , 0, n[half_n], p[half_n])
segments( 0 , p[half_n], 1, p[half_n], lty=2)
text(n[half_n]+0.05, p[half_n], n[half_n], pos=3)
dev.off()

