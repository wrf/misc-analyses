# random visualization test
# 2021-06-14

n = 0:99
x = n %% 10 # x position on grid
y = floor(n/10) # y position on grid

# make 4 plots
pdf(file = "~/git/misc-analyses/visualizing_randomness/block_test_various_percent.pdf", width = 8, height = 8)
par(mar=c(2,2,4,2), mfrow=c(2,2))
colorset = rep("#d3c597ff",100)
is_blue = sample(n,2)
colorset[is_blue] = "#2aa074ff"
plot(x,y, cex=3, pch=15, col=colorset, frame.plot=FALSE, axes=FALSE, 
     main = "2 random out of 100", xlab = "", ylab = "", cex.main=2)
colorset = rep("#d3c597ff",100)
is_blue = sample(n,10)
colorset[is_blue] = "#2aa074ff"
plot(x,y, cex=3, pch=15, col=colorset, frame.plot=FALSE, axes=FALSE, 
     main = "10 random out of 100", xlab = "", ylab = "", cex.main=2)
colorset = rep("#d3c597ff",100)
is_blue = sample(n,51)
colorset[is_blue] = "#2aa074ff"
plot(x,y, cex=3, pch=15, col=colorset, frame.plot=FALSE, axes=FALSE, 
     main = "51 random out of 100", xlab = "", ylab = "", cex.main=2)
colorset = rep("#d3c597ff",100)
is_blue = sample(n,66)
colorset[is_blue] = "#2aa074ff"
plot(x,y, cex=3, pch=15, col=colorset, frame.plot=FALSE, axes=FALSE, 
     main = "66 random out of 100", xlab = "", ylab = "", cex.main=2)
dev.off()
