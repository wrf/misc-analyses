
Tazze = c(1,2,3,4,6,9,12,18)
price = c(20.99, 21.99, 22.99, 24.99, 27.99, 35.99, 42.99, 54.99)

discount = price * 0.8
ppc = price/Tazze

dppc = discount/Tazze

plot(Tazze, ppc, type='p', frame.plot=FALSE, xlim=c(0,18), ylim=c(0,22), ylab="Price per tazza (Euro)", pch=16, cex=1.6, cex.axis=1.5, cex.lab=1.4 )
points(Tazze, dppc, type='p', col="red", pch=15, cex=1.6 )