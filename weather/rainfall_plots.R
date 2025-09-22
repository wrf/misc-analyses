#


# https://www.dmi.dk/vejrarkiv/
dmi_rain_text.lyngby="month	2024	2023	2022	2021	2020	2019	2018	2017	2016	2015	2014	2013	2012	2011
1	65	113	50	69	70	56	59	19	29	90	62	46	91	50
2	92	50	104	26	97	38	14	51	49	28	53	24	28	32
3	22	82	0	43	22	113	57	46	46	56	26	9	12	31
4	66	29	38	21	21	11	27	65	45	31	29	20	51	24
5	32	6	57	81	34	46	16	24	20	69	88	70	20	72
6	74	21	41	18	61	53	17	94	74	49	31	63	108	71
7	90	113	27	73	57	83	8	102	99	88	44	19	44	195
8	35	154	47	120	42	88	94	76	49	51	135	48	37	129
9	130	10	102	67	55	110	24	124	33	94	39	50	71	63
10	51	115	39	81	72	100	51	100	76	23	133	73	75	45
11	43	118	13	42	25	56	25	74	54	151	45	57	55	8
12	54	88	52	82	65	50	63	60	34	100	99	65	63	59"

dmi_rain_text.vejle="month	2024	2023	2022	2021	2020	2019	2018	2017	2016	2015	2014	2013	2012	2011
1	115.2	151.3	75.2	74.8	103.5	62	101.8	51.2	76.3	114.8	101.5	64.4	109.0	54.4
2	137.4	48.8	168.9	26.5	193.3	61.6	41.5	80.8	68.5	35.1	67	23.0	35.6	47.9
3	44.7	95.4	4.7	70.3	52.4	139.9	31.6	65.6	41.4	84.8	29.1	10.5	28.5	33.7
4	145.6	64.7	39.4	31.8	27	15.3	54.6	46.4	94.6	34.7	41.4	30.5	64.5	17.9
5	73.7	13.3	47.4	128.2	44.1	55.5	7.2	27.5	39.5	110.8	86.7	65.6	31.5	56.9
6	138.8	50.1	76.4	45.9	98.1	49	34.3	110.8	88.7	63.5	68.8	77.0	118.9	72.6
7	138.2	183.6	52.1	81.8	99.1	71.1	22.3	83.4	105.8	77.2	81.9	21.0	103.4	111.8
8	120.7	106.2	30.8	94.2	93.7	88.4	101.1	101.9	57.9	63.1	137.2	55.2	98.3	161.1
9	105.2	67.2	91.9	71.6	34.2	169.6	110	124.7	38.8	128.8	42	96.5	118.5	113.2
10	39.5	191.4	78.5	117.6	96.4	165.4	41.6	127.1	81.3	39.8	107.9	108.7	114.0	70.6
11	68.0	116.2	68.4	54.7	61.5	87.4	35.8	86.2	97.6	156.9	50.2	63.0	82.8	24.4
12	91.8	131.6	90.4	75.5	88.7	86.5	87.2	86.8	52.9	153.6	146.5	129.7	85.0	122.3"

dmi_rain_data = read.table(text=dmi_rain_text.lyngby, header=TRUE, sep="\t")[,-1]

#rain_pca = pca(dmi_rain_data)
#plot(rain_pca)

rainfall_averages = data.frame( mins = apply(dmi_rain_data, 1, min) , 
                                means = apply(dmi_rain_data, 1, mean) ,
                                maxs = apply(dmi_rain_data, 1, max) )
month_abbvs = c("J","F","M","A","M","J","J","A","S","O","N","D")
colorRampPalette(c("#eedd99", "#6677bb", "#123499"))(25)
overall_mean = mean(unlist(dmi_rain_data))
yearly_average = mean(colSums(dmi_rain_data))

pdf(file = "~/git/misc-analyses/weather/images/rainfall_ltk_2011-2024.pdf", width=7, height=7, title = "Rainfall in Lyngby-Tarbaek 2011-2024" )
#png(file = "~/git/misc-analyses/weather/images/rainfall_ltk_2011-2024.png", width=700, height=700, res=100, bg="#eeeeee" )
#pdf(file = "~/git/misc-analyses/weather/images/rainfall_vejle_2011-2024.pdf", width=7, height=7, title = "Rainfall in Vejle 2011-2024" )
#png(file = "~/git/misc-analyses/weather/images/rainfall_vejle_2011-2024.png", width=700, height=700, res=100, bg="#eeeeee" )
layout(matrix(c(1,2,3,4),ncol=2), widths = c(3,1), heights = c(1.2,3))
par(mar=c(0,3,1,0))
#barplot( rowSums(dmi_rain_data)/ncol(dmi_rain_data), col="#6677bb", las=1 , names.arg = NA )
b = barplot( rbind(rainfall_averages$mins,
               rainfall_averages$means-rainfall_averages$mins,
               rainfall_averages$maxs-rainfall_averages$means) ,
         col=c("#ddddee", "#6677bb", "#123499") , names.arg = month_abbvs )
segments(0,overall_mean,14.6, overall_mean, col="#12993466", lwd=3)
par(mar=c(4,4,1,1))
image(as.matrix(dmi_rain_data[,c(14:1)]) , col = colorRampPalette(c("#eeddaa", "#6677bb", "#123499"))(25) , axes=FALSE )
axis(1,at=c(0,(1:11)/11 ), labels=month_abbvs, tick = FALSE )
axis(2,at=c(0,(1:13)/13 ), labels=c(2011:2024), tick=FALSE , las=2)
text( rep(c(0,(1:11)/11),14), rep(c(0,(1:13)/13),each=12 ), unlist(dmi_rain_data[,c(14:1)]) )
par(mar=c(1,1,1,1))
plot(0,0,type='n', xlab=NA, ylab=NA, axes=FALSE)
legend("left", legend=c("Max", "Average", "Min"), title = "Monthly", col=rev(c("#ddddee", "#6677bb", "#123499")), pch=15, pt.cex = 2 )
par(mar=c(3.2,0,0.2,1))
b = barplot( rev(colSums(dmi_rain_data)), col="#1266aa", las=2, horiz=TRUE, xlim=c(0,1000),
         names.arg = NA)
segments(yearly_average,0,yearly_average, max(b), col="#12993466", lwd=3)
text(rev(colSums(dmi_rain_data)),b,rev(colSums(dmi_rain_data)), pos=2, col="#ddddee")
dev.off()







