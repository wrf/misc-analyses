# bootstrap as a random draw of marbles
# created by WRF 2018

# read data from python model
rh = read.table("~/git/misc-analyses/random_bootstrap/sample_1000x.txt",header=FALSE,sep=" ")
colset = rep("#000000",length(rh[,1]))
colset[rh[,1]<0] = "#70de57"
colset[rh[,1]>0] = "#e86365"
pdf(file="~/git/misc-analyses/random_bootstrap/images/sample_1000x.pdf", width=6, height=4, title="Random draw of reds from 1000 samples")
plot(rh[,1], rh[,2], type='h', lwd=3, col=colset, ylab="Counts", xlab="Number of reds drawn")
dev.off()

################################################################################
# remake of model

# most sites U are uninformative
# other sites favor topology P or C or A
sitewinner_text = rep(c("u","p","c","a"),c(20000,150,200,25))

colorset = c("#fc8d62aa", "#66c2a5aa", "#377eb888")

winner_counts = c()
for (i in 1:1000){
  bootstrap_sample = sample(sitewinner_text, length(sitewinner_text), replace = TRUE)
  bootstrap_table = table(bootstrap_sample)
  winner_counts = rbind(winner_counts, bootstrap_table)
}
w_counts = apply(winner_counts, 2, FUN=table )
w_merged_cp = merge( data.frame(label=as.integer(names(w_counts$c)),n=w_counts$c), data.frame(label=as.integer(names(w_counts$p)),n=w_counts$p), by="label", all=TRUE)
#w_merged_cpa = merge( w_merged_cp, data.frame(label=names(w_counts$a),n=w_counts$a), by="label", all=TRUE)
w_merged.b = w_merged_cp[,c(1,3,5)]

pdf(file="~/git/misc-analyses/random_bootstrap/images/sample_twoway_1000x.pdf", width=6, height=5, title="Marble draw as bootstrap model")
#png(file="~/git/misc-analyses/random_bootstrap/images/sample_twoway_1000x.png", width=600, height=500, res=100, bg="white" )
plot(w_merged.b$label, w_merged.b$n.Freq.x, type='n', ylab="Frequency", xlab="Number of sites favoring hypothesis from 1000 draws", frame.plot = FALSE )
segments(as.integer(w_merged.b$label), rep(0,length(w_merged.b$n.Freq.x)), as.integer(w_merged.b$label), w_merged.b$n.Freq.x, 
         lwd=2, col="#fc8d62" )
segments(as.integer(w_merged.b$label), rep(0,length(w_merged.b$n.Freq.x))+ifelse(is.na(w_merged.b$n.Freq.x),0,w_merged.b$n.Freq.x),
         as.integer(w_merged.b$label), w_merged.b$n.Freq.y+ifelse(is.na(w_merged.b$n.Freq.x),0,w_merged.b$n.Freq.x), 
         lwd=2, col="#66c2a5" )
dev.off()


################################################################################
# last modified 2025-12-07

sitewise_data = read.table("~/project/phylogeny/RAxML_perSiteLLs.simion2017_para-animals_v_porisis.tab.gz", header=TRUE, sep="\t")

# sums for whole dataset
total_likelihoods = colSums(sitewise_data[,2:4])

hist(sitewise_data$tr1, breaks=50, col="#fc8d62")

#
sitewise_meansitelnl = mean(sitewise_data[,2])
sitewise_rowmaxs = apply( sitewise_data[,2:4], 1, which.max)
sitewise_maxsitelnl = apply( sitewise_data[,2:4], 1, max)
sitewise_medianln = apply( sitewise_data[,2:4], 1, median )
sitewise_first_v_second_lnl = sitewise_maxsitelnl - sitewise_medianln


# lambda_hat = 1 / mean(sitewise_first_v_second_lnl)
# sd(sitewise_first_v_second_lnl)
# hist(sitewise_first_v_second_lnl, prob=TRUE, breaks=500, col="#fc8d62aa", xlim=c(0,1), ylim=c(0,1))
# curve(lambda_hat * exp(-lambda_hat * x), col = "red", add = TRUE)
# curve( (2*lambda_hat) * exp(-(2*lambda_hat) * x), col = "blue", add = TRUE)

h = hist(sitewise_first_v_second_lnl, breaks=seq(0,10,0.01), xlim=c(0,1), ylim=c(0,10000), col="#fc8d62aa")
sum(h$counts[51:1000])
sum(h$counts[51:1000])/sum(h$counts)
sum(sitewise_first_v_second_lnl[sitewise_first_v_second_lnl<0.05])
sum(sitewise_first_v_second_lnl[sitewise_first_v_second_lnl<0.1])
sum(sitewise_first_v_second_lnl[sitewise_first_v_second_lnl>0.5])


winner_tree = c()
winner_magnitudes = c()
for (i in 1:1000){
  bs1 = sample(sitewise_data$site, length(sitewise_data$site), replace = TRUE)
  bs_sampled_sites = sitewise_data[bs1,2:4]
  sll_sums = colSums(bs_sampled_sites)
  winner_magnitudes = c(winner_magnitudes, max(sll_sums)-median(sll_sums))
  print(paste("Iteration",i, max(sll_sums), which.max(sll_sums)))
  winner_tree = c(winner_tree, which.max(sll_sums) )
}
table(winner_tree)
hist(winner_magnitudes, breaks=50, xlim=c(0,10000), main="Winner of 1000 bootstrap replicates", 
     xlab="dlnl(winner - second best)", col="#fc8d62", border = NA)
pdf(file="~/git/misc-analyses/random_bootstrap/images/sample_sLL_simion2017_1000x.pdf", width=6, height=5, title="1000 random draws of sLL from Simion et al 2017")
#png(file="~/git/misc-analyses/random_bootstrap/images/sample_sLL_simion2017_1000x.png", width=600, height=500, res=100, bg="white")
hist(winner_magnitudes, breaks=50, xlim=c(6500,8500), main="1000 random draws of sLL from Simion et al 2017", 
     xlab=paste("dlnl(winner - second best) out of",round(sum(sitewise_first_v_second_lnl))), col="#fc8d62aa")
dev.off()
#hist(winner_magnitudes/ max(colSums(sitewise_data[,2:4])), breaks=50, xlim=c(-0.0005,0), col="#fc8d62", border = NA)





#