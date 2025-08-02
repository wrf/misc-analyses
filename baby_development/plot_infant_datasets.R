# plot data for infant development
# 


# data from
# Rijt-Plooij and Plooij 1992 Infantile regressions: Disorganization and the onset of transition periods
# https://www.tandfonline.com/doi/abs/10.1080/02646839208403946
dutch_reg_text = "week	infant_A	infant_B	infant_C	infant_D	infant_E	infant_F	infant_G	infant_H	infant_I	infant_J	infant_K	infant_L	infant_M	infant_N	infant_O
0	0	0	0	NA	NA	0	0	NA	0	0	0	0	0	NA	NA
1	0	0	0	NA	NA	0	0	NA	0	0	0	0	0	NA	NA
2	0	0	0	NA	NA	0	0	NA	0	0	0	0	0	NA	NA
3	0	0	0	NA	NA	0	0	NA	0	0	0	0	0	NA	NA
4	0	0	0	NA	NA	0	1	NA	0	0	1	1	0	NA	NA
5	1	1	1	NA	NA	1	0	NA	1	1	1	0	1	NA	NA
6	0	0	0	NA	NA	0	0	NA	0	0	0	0	0	NA	NA
7	0	0	0	NA	NA	0	0	NA	NA	0	0	1	0	0	NA
8	1	1	1	NA	NA	1	1	NA	NA	1	1	0	1	1	NA
9	1	0	0	NA	NA	1	1	NA	NA	1	1	0	1	1	NA
10	0	0	0	NA	NA	0	0	NA	NA	0	0	0	0	0	NA
11	0	0	0	NA	NA	0	1	NA	NA	0	0	1	0	0	NA
12	0	1	1	NA	NA	1	1	NA	NA	1	1	0	1	1	NA
13	0	1	0	NA	NA	0	0	0	0	0	0	0	0	0	NA
14	0	0	0	NA	NA	0	1	1	0	0	0	0	0	0	NA
15	1	0	0	NA	NA	1	1	1	0	1	0	0	1	1	NA
16	1	1	1	NA	NA	1	1	1	1	1	0	0	1	1	NA
17	1	1	0	NA	NA	1	1	1	1	1	1	1	1	1	NA
18	1	1	0	NA	NA	1	1	1	1	1	1	0	1	1	NA
19	1	1	0	NA	NA	0	0	1	1	1	1	0	1	1	NA
20	1	0	0	NA	NA	0	0	0	1	0	0	0	0	0	NA
21	0	0	0	NA	NA	0	0	0	0	0	0	0	0	0	NA
22	0	0	0	NA	NA	1	0	0	0	0	0	0	0	0	NA
23	1	0	0	NA	NA	1	1	1	1	1	0	0	0	1	NA
24	1	0	0	NA	NA	1	1	1	1	1	1	0	0	1	NA
25	1	0	0	NA	NA	1	1	1	1	1	1	0	0	1	NA
26	0	1	1	NA	NA	1	1	1	1	1	1	1	1	1	NA
27	0	0	0	NA	NA	0	0	0	1	1	1	0	1	0	NA
28	0	0	0	0	NA	0	0	0	0	0	0	0	0	0	NA
29	0	0	0	0	NA	0	0	0	0	0	0	0	0	0	NA
30	0	0	0	0	NA	0	0	0	0	0	0	0	0	0	NA
31	0	0	0	0	NA	0	0	0	0	0	0	0	0	0	NA
32	1	1	0	0	NA	0	0	0	0	0	0	0	0	0	NA
33	1	1	1	0	1	0	1	0	0	0	0	0	0	0	NA
34	1	1	1	1	1	1	1	1	1	0	0	0	0	0	NA
35	1	1	1	1	1	1	1	1	1	0	1	0	0	0	NA
36	1	1	1	1	1	1	1	1	1	1	1	0	0	0	NA
37	1	0	0	0	0	1	0	1	1	1	1	1	1	1	NA
38	0	0	0	0	0	1	0	1	0	1	0	1	1	1	NA
39	0	0	0	0	0	1	0	0	0	1	0	1	1	1	NA
40	1	1	1	1	0	0	0	0	0	0	0	1	1	1	NA
41	1	1	1	1	1	1	0	0	0	0	NA	0	0	0	NA
42	1	1	1	1	1	1	1	0	0	1	NA	0	0	0	NA
43	1	1	1	1	1	1	1	1	1	1	NA	1	0	0	NA
44	1	1	1	0	1	1	1	1	1	1	NA	1	1	1	NA
45	0	1	0	0	1	1	1	1	1	1	NA	1	1	1	NA
46	0	1	0	0	0	1	1	0	1	0	NA	1	1	1	NA
47	0	0	0	0	0	0	1	0	0	0	NA	1	1	1	NA
48	0	0	0	0	0	0	1	0	0	0	NA	0	0	1	NA
49	0	0	1	0	0	0	0	0	0	0	NA	0	0	0	NA
50	0	0	1	1	1	1	0	0	0	1	NA	0	1	0	NA
51	1	1	1	1	1	1	0	1	1	1	NA	1	1	0	NA
52	1	1	1	1	1	1	0	1	1	1	NA	1	1	0	NA
53	1	1	0	1	1	1	1	1	1	1	NA	1	1	1	NA
54	1	1	NA	0	0	1	1	1	1	0	NA	1	0	1	NA
55	1	0	NA	NA	0	0	1	1	1	0	NA	0	0	1	NA
56	0	0	NA	NA	0	0	1	0	0	0	NA	0	0	1	NA
57	0	0	NA	NA	0	0	1	NA	0	0	NA	NA	0	0	NA
58	NA	NA	NA	NA	0	0	0	NA	0	0	NA	NA	0	0	NA
59	NA	NA	NA	NA	0	0	0	NA	0	0	NA	NA	0	0	NA
60	NA	NA	NA	NA	0	1	1	NA	1	1	NA	NA	0	0	NA
61	NA	NA	NA	NA	1	1	1	NA	1	1	NA	NA	1	1	NA
62	NA	NA	NA	NA	1	1	1	NA	1	1	NA	NA	1	1	NA
63	NA	NA	NA	NA	1	1	0	NA	1	0	NA	NA	1	1	NA
64	NA	NA	NA	NA	0	1	0	NA	1	0	NA	NA	1	1	NA
65	NA	NA	NA	NA	0	1	0	NA	0	0	NA	NA	0	0	NA
66	NA	NA	NA	NA	0	0	0	NA	0	0	NA	NA	0	0	NA
67	NA	NA	NA	NA	0	0	0	NA	0	0	NA	NA	0	0	NA
68	NA	NA	NA	NA	0	0	0	NA	0	0	NA	NA	0	0	NA
69	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
70	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
71	NA	NA	NA	NA	1	NA	1	NA	0	1	NA	NA	0	0	1
72	NA	NA	NA	NA	1	NA	1	NA	1	1	NA	NA	1	1	1
73	NA	NA	NA	NA	1	NA	1	NA	1	1	NA	NA	1	1	1
74	NA	NA	NA	NA	0	NA	1	NA	1	1	NA	NA	1	1	1
75	NA	NA	NA	NA	0	NA	1	NA	1	1	NA	NA	1	1	0
76	NA	NA	NA	NA	0	NA	1	NA	0	0	NA	NA	1	1	0
77	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	1	1	0
78	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	1	0
79	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
80	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
81	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
82	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
83	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
84	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
85	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0
86	NA	NA	NA	NA	0	NA	0	NA	0	0	NA	NA	0	0	0"
dutch_reg_data = read.table( text=dutch_reg_text, header=TRUE, sep="\t" )
dutch_reg_data.no_na = data.frame( apply(dutch_reg_data, 2, function(x) {ifelse( is.na(x), 0, x )} ) )


pdf(file = "~/git/misc-analyses/baby_development/images/plooij1992_figure1_remake.pdf", width=8, height=5, title="Data from Plooij 1992")
png(file = "~/git/misc-analyses/baby_development/images/plooij1992_figure1_remake.png", width=800, height=500, res=100 , bg="#eeeeee" )
par(mar=c(4.5,5,2,1))
plot(dutch_reg_data.no_na$week, rowSums(dutch_reg_data.no_na[,-1]), type='n', 
     xlab="Weeks of development", ylab="Baby code", 
     ylim=c(0,16), axes=FALSE )
segments(seq(0,85,5),rep(0,18),seq(0,85,5),rep(16,18), lwd=0.5, col="#00000033" )
axis(2, at=c(16, 14:0), labels=c("Aggregate", gsub("infant_","",names(dutch_reg_data.no_na)[-1])) , tick = FALSE, las=2, cex.axis=0.7 )
for (i in 2:ncol(dutch_reg_data.no_na) ){
  seg_x_start = which(diff(dutch_reg_data.no_na[,i])==1)
  seg_x_ends = which(diff(dutch_reg_data.no_na[,i])==-1)
  y_bounds = rep( 16, length(seg_x_start) )
  segments( seg_x_start-0.5, y_bounds, seg_x_ends-0.5 , y_bounds , 
            lwd=10, col="#00126722" )
}
for (i in 2:ncol(dutch_reg_data.no_na) ){
  seg_x_start = which(diff(dutch_reg_data.no_na[,i])==1)
  seg_x_ends = which(diff(dutch_reg_data.no_na[,i])==-1)
  y_bounds = rep( 16-i, length(seg_x_start) )
  segments( seg_x_start-0.5, y_bounds, seg_x_ends-0.5 , y_bounds , 
            lwd=6, col="#006797aa" )
  if (any(is.na(dutch_reg_data[,i]))){
    na_blocks = which(as.integer(is.na(dutch_reg_data[,i]))==1)
    na_block_breaks <- c(0, which(diff(na_blocks) != 1), length(na_blocks))
    na_block_starts <- na_blocks[na_block_breaks[-length(na_block_breaks)] + 1] -1
    na_block_ends   <- na_blocks[na_block_breaks[-1]] - 1
    rect(na_block_starts, rep(16-i-0.5,length(na_block_starts)), na_block_ends, rep(16-i+0.5,length(na_block_starts)), 
         col="#00000044", border = NA)
  }
}
axis(1, at=c(0:85), labels = FALSE, lwd.ticks = 0.5 )
axis(1, at=seq(0,85,5) )
dev.off()
#points( dutch_reg_data[["week"]][which(dutch_reg_data[,2]==1)], rep(1,length(which(dutch_reg_data[,2]==1))) )

plot(dutch_reg_data.no_na$week, rowSums(dutch_reg_data.no_na[,-1]), type='l', ylim=c(0,16), 
     col="#00126788", lwd=10, axes=FALSE )
lines(catalan_reg_data$weeks, catalan_reg_data$counts * 2, lwd=10, col="#12672388" )
axis(1, at=c(0:85), labels = FALSE, lwd.ticks = 0.5 )
axis(1, at=seq(0,85,5) )


# Sadurni 2010 The Temporal Relation between Regression and Transition Periods in Early Infancy
# https://pubmed.ncbi.nlm.nih.gov/20480682/

catalan_reg_text = "weeks	counts	n_dyads	n_missing
3	0	5	0
4	3	5	0
5	4	5	0
6	0	5	0
7	0	5	0
8	5	5	0
9	2	5	0
10	0	5	0
11	0	5	0
12	2	5	0
13	2	5	0
14	1	5	0
15	0	5	0
16	1	9	0
17	3	9	0
18	5	9	0
19	4	9	0
20	1	9	0
21	0	9	2
22	0	9	2
23	0	5	0
24	1	5	0
25	2	5	0
26	6	5	0
27	6	5	0
28	0	5	0
29	0	5	0
30	0	5	0
31	0	5	0
32	2	9	0
33	2	9	0
34	1	9	0
35	5	9	1
36	3	5	0
37	1	5	0
38	0	5	0
39	0	5	0
40	0	5	0
41	0	10	2
42	4	10	1
43	5	10	0
44	3	10	0
45	3	10	1
46	2	10	1
47	0	10	2
48	1	10	2
49	1	10	2
50	1	10	4
51	1	10	4
52	3	5	0
53	1	5	0
54	0	5	0
55	0	5	0
56	0	5	0
57	0	5	0
58	0	5	0
59	0	5	0
60	0	5	1"
catalan_reg_data = read.table( text=catalan_reg_text , header=TRUE, sep="\t" )


plot(catalan_reg_data$weeks, catalan_reg_data$counts / (catalan_reg_data$n_dyads - catalan_reg_data$n_missing), 
     type='h', xlim=c(2,70), lwd=4, col="#7698baaa", ylim=c(0,10),
     xlab="Weeks", ylab="Number of children", main="Regression behaviors in 18 Catalan babies" )
# peaks from Plooij 1992
points(  c(5, 8, 12, 17, 26, 36, 44, 53, 61, 72), rep(0,10) , cex=2, pch=18, col="#001267cc" )










#