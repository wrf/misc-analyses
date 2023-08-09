# plot science pubs vs gdp or population

file1 = "~/misc-non_work/nature_weighted_paper_counts.csv"

alldat = read.table(file1, header=TRUE, sep=",")

countrylabs = alldat[,1]
wfc = alldat[,2]
pop = alldat[,3]
gdp = alldat[,4]
ppp = alldat[,5]
rnd = alldat[,6]
rdd = rnd*ppp/100

wlv = max(wfc)/40
plv = max(pop)/50
glv = max(gdp)/60

gdppers = gdp/pop
gplv = max(gdppers)/50

par(mar=c(4,4,1,2))

#png("~/misc-non_work/rnd_vs_papers_prndppp_v1.png", height=600, width=600)

# not very useful graph
#plot(pop/1000, wfc, type='p', frame.plot=FALSE, xlab="Population (M)", ylab="Papers (WFC)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(pop/1000+plv/1200, wfc+wlv, labels=countrylabs)

#plot(gdp, wfc/pop, type='p', frame.plot=FALSE, ylim=c(0,0.15), xlab="Nominal GDP (M$USD)", ylab="Papers/person (WFC/k)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(gdp+glv, wfc/pop+0.005, labels=countrylabs)

#plot(rnd, wfc, type='p', frame.plot=FALSE, xlab="R&D Spending % of GDP PPP", ylab="Papers (WFC)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(rnd+0.1, wfc, labels=countrylabs)

#plot(rnd*ppp/100, wfc, type='p', frame.plot=FALSE, xlab="R&D Spending (M$USD)", ylab="Papers (WFC)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(rnd*ppp/100+0.1, wfc, labels=countrylabs)

#plot(rnd, wfc/ppp, type='p', frame.plot=FALSE, xlab="R&D Spending % of GDP PPP", ylab="Papers/$ (WFC/M$USD PPP)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(rnd+0.1, wfc/ppp, labels=countrylabs)

plot(rnd, wfc/rdd, type='p', frame.plot=FALSE, ylim=c(0,0.14), xlab="R&D Spending % of GDP PPP", ylab="Papers/R&D $ (WFC/M$USD PPP)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
text(rnd+0.1, wfc/rdd+0.005, labels=countrylabs)


#plot(gdp, wfc, type='p', frame.plot=FALSE, xlab="Nominal GDP (M$USD)", ylab="Papers (WFC)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(gdp+glv, wfc+wlv, labels=countrylabs)
#points(ppp, wfc, pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2, col="red")
#text(ppp+glv, wfc+wlv, labels=countrylabs, col="red")

# also not useful
#plot(log(ppp), wfc, type='p', frame.plot=FALSE, xlab="Log GDP PPP (M$USD)", ylab="Papers (WFC)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(log(ppp)+0.2, wfc+wlv, labels=countrylabs)

#plot(log(ppp), wfc/pop, type='p', frame.plot=FALSE, xlim=c(12,17), ylim=c(0,0.15), xlab="GDP PPP (log$USD)", ylab="Papers/person (WFC/k)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(log(ppp)+0.1, wfc/pop+0.005, labels=countrylabs)

#plot(log(ppp/pop), wfc, type='p', frame.plot=FALSE, xlab="GDP per person PPP (log$USD)", ylab="Papers (WFC)", pch=16, cex=1.1, cex.axis=1.2, cex.lab=1.2)
#text(log(ppp/pop)+0.1, wfc+wlv, labels=countrylabs)

#dev.off()