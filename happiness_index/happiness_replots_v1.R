# plots related to happiness and well being
# created 2024-08-07

library(ggplot2)
library(maps)
library(dplyr)
library(gridExtra)

# gallup's What Is the World's Emotional Temperature?
# https://news.gallup.com/interactives/248240/global-emotions.aspx

emo_data_file = "~/git/misc-analyses/happiness_index/data/gallup_2022_global_emotion_survey.tab"
emo_data = read.table(emo_data_file, header=TRUE, sep="\t", quote="")
#head(emo_data)
#unique(emo_data$country_short)
#unique(emo_data$emotion)
emotions_list = c("feel anger", "feel sadness", "feel stress", "feel worried", "feel pain", 
                  "feel enjoyment", "feel rested", "learn something", "smile", "feel respected" )
emotions_list.short = c("anger", "sadness", "stress", "worried", "pain", 
                        "enjoyment", "rested", "learn", "smile", "respected" )

hot_emotion_colors.p = colorRampPalette(c("#f0e78fff", "#fd8a13ff", "#d52121ff", "#962249ff"))
cool_emotion_colors.p = colorRampPalette(c("#bede18ff", "#68ba12ff", "#004d53ff"))

column_index = seq(6,24,2)
region_colors = c("#045aad88", "#81048d88", "#ad040488", "#8d890488", "#04ad1d88")
region_matches = match( emo_data$area, unique(emo_data$area) )
unique(emo_data$area)
country_codes.2022 = emo_data$country_code

# emo_data.all_yes = data.frame(region=emo_data$country_short[1:142],
#                               net_yes=net_emo_sums,
#                               was_angry=filter(emo_data, emotion=="anger")$answer_yes,
#                               was_sad=filter(emo_data, emotion=="sadness")$answer_yes,
#                               was_stressed=filter(emo_data, emotion=="stress")$answer_yes,
#                               was_worried=filter(emo_data, emotion=="worried")$answer_yes,
#                               had_pain=filter(emo_data, emotion=="pain")$answer_yes,
#                               did_enjoy = filter(emo_data, emotion=="enjoyment")$answer_yes,
#                               was_rested = filter(emo_data, emotion=="rested")$answer_yes,
#                               did_learn = filter(emo_data, emotion=="learned")$answer_yes,
#                               did_smile=filter(emo_data, emotion=="smiled")$answer_yes,
#                               was_respected=filter(emo_data, emotion=="respected")$answer_yes )

# make world map and merge dataset with emotional index
worldpolygons = map_data("world")
#unique(worldpolygons$region)
worldpolygons_w_emo = left_join(worldpolygons, rename(emo_data, region=country_short), by="region")

# generate plot
gg_anger = ggplot(worldpolygons_w_emo, aes(x = long, y = lat, group = group)) +
  coord_map(xlim=c(-180,180), ylim=c(-54, 68) ) +
  theme(plot.title = element_text(size=20),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position=c(0,0.5),
        legend.justification = "left") +
  scale_fill_gradientn(colours = hot_emotion_colors.p(8), na.value="gray70" ) +
  labs(x=NULL, y=NULL, fill='% "yes"',
       title=bquote("Did you experience" ~ bold('anger') ~ "during a lot of the day yesterday?"),
       caption=paste("What Is the World's Emotional Temperature?", emo_data$year[1] , "\n https://news.gallup.com/interactives/248240/global-emotions.aspx") ) +
  geom_polygon( aes(fill=anger_yes), colour = "#000000" )
gg_anger
ggsave("~/git/misc-analyses/happiness_index/images/gallup_2022_global_emotion_survey.anger_map.pdf",
       plot=gg_anger, device = "pdf", width=8, height=6, title="2022 Global Emotion Survey - Anger")

emo_data.respect = filter(emo_data, emotion=="respected") %>%
  rename(region=country_short)
worldpolygons_w_emo = left_join(worldpolygons, emo_data.respect, by="region")

# generate plot
gg_resp = ggplot(worldpolygons_w_emo, aes(x = long, y = lat, group = group)) +
  coord_map(xlim=c(-180,180), ylim=c(-54, 68) ) +
  theme(plot.title = element_text(size=20),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position=c(0,0.5),
        legend.justification = "left") +
  scale_fill_gradientn(colours = cool_emotion_colors.p(8), na.value="gray70" ) +
  labs(x=NULL, y=NULL, fill='% "yes"',
       title=bquote("Did you feel" ~ bold('respected') ~ "during a lot of the day yesterday?"),
       caption=paste("What Is the World's Emotional Temperature?", emo_data$year[1] , "\n https://news.gallup.com/interactives/248240/global-emotions.aspx") ) +
  geom_polygon( aes(fill=answer_yes), colour = "#000000" )
gg_resp
ggsave("~/git/misc-analyses/happiness_index/images/gallup_2022_global_emotion_survey.respected_map.pdf",
       plot=gg_resp, device = "pdf", width=8, height=6, title="2022 Global Emotion Survey - Respected")

# make all maps
for (i in 1:10){
  color_fun = ifelse(i<6, hot_emotion_colors.p, cool_emotion_colors.p)
  gg = ggplot(worldpolygons_w_emo, aes(x = long, y = lat, group = group)) +
    coord_map(xlim=c(-180,180), ylim=c(-54, 68) ) +
    theme(plot.title = element_text(size=20),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position=c(0,0.5),
          legend.justification = "left") +
    scale_fill_gradientn(colours = color_fun(8), na.value="gray70" ) +
    labs(x=NULL, y=NULL, fill='% "yes"',
         title= paste0("Did you **", emotions_list[i], "** during a lot of the day yesterday?"),
         caption=paste("What Is the World's Emotional Temperature?", emo_data$year[1] , "\n https://news.gallup.com/interactives/248240/global-emotions.aspx") ) +
    geom_polygon( aes(fill=worldpolygons_w_emo[,column_index[i]+5]), colour = "#000000" )
  gg
  pdf_auto_file_name = paste("~/git/misc-analyses/happiness_index/images/gallup", emo_data$year[1], "global_emotion_survey", emotions_list.short[i], "map.pdf", sep="_")
  pdf_auto_file_name
  ggsave(pdf_auto_file_name, plot=gg, device = "pdf", 
         width=8, height=6, title=paste("2022 Global Emotion Survey -",emotions_list.short[i]) )
  
}


# negative_emo_sums = filter(emo_data, emotion=="anger")$answer_yes +
#   filter(emo_data, emotion=="sadness")$answer_yes +
#   filter(emo_data, emotion=="stress")$answer_yes +
#   filter(emo_data, emotion=="worried")$answer_yes +
#   filter(emo_data, emotion=="pain")$answer_yes
# positive_emo_sums = filter(emo_data, emotion=="enjoyment")$answer_yes +
#   filter(emo_data, emotion=="rested")$answer_yes +
#   filter(emo_data, emotion=="learned")$answer_yes +
#   filter(emo_data, emotion=="smiled")$answer_yes +
#   filter(emo_data, emotion=="respected")$answer_yes
negative_emo_sums = emo_data$anger_yes + emo_data$sad_yes + emo_data$stressed_yes +
  emo_data$worried_yes + emo_data$pain_yes
positive_emo_sums = emo_data$enjoyment_yes + emo_data$rested_yes + emo_data$learned_yes +
  emo_data$smiled_yes + emo_data$respected_yes
net_emo_sums.2022 = positive_emo_sums - negative_emo_sums
net_emo_sums.2022
net_emo.2022.

#################
# using 2023 data
emo_data_file = "~/git/misc-analyses/happiness_index/data/gallup_2023_global_emotion_survey.tab"
emo_data = read.table(emo_data_file, header=TRUE, sep="\t", quote="")

# combine all emotions
negative_emo_sums = emo_data$anger_yes + emo_data$sad_yes + emo_data$stressed_yes +
  emo_data$worried_yes + emo_data$pain_yes
positive_emo_sums = emo_data$enjoyment_yes + emo_data$rested_yes + emo_data$learned_yes +
  emo_data$smiled_yes + emo_data$respected_yes
net_emo_sums.2023 = positive_emo_sums - negative_emo_sums
hist(net_emo_sums, breaks=25)


plot(net_emo_sums.2023[match(country_codes.2022, emo_data$country_code)], net_emo_sums.2022,
     pch=16, cex=2, col=region_colors[region_matches[match(country_codes.2022, emo_data$country_code)]]
     )
net_emo_sums.2022
abline(a=0,b=1)

# make all maps and sum plots
# pdf(file="~/git/misc-analyses/happiness_index/images/gallup_2023_global_emotion_survey.sums.pdf", width=8, height=11, paper="a4", title="2023 Global Emotion Survey")
# par(mar=c(4, 4.5, 4, 1), mfrow=c(2,1))
# for (i in 1:10){
#   color_fun = ifelse(i<6, hot_emotion_colors.p, cool_emotion_colors.p)
#   plot( emo_data[,column_index[i]], net_emo_sums , cex.lab=1.3, cex.axis=1.3,
#         ylab="Overall emotional score",
#         xlab=paste('Percent responses "yes" to "Did you', emotions_list[i], 'yesterday?"'),
#         pch=16, col=region_colors[region_matches], cex=2 )
#   text( emo_data[,column_index[i]], net_emo_sums , emo_data$country_code , cex=0.5)
#   mtext( emotions_list[i], side=3, at=min(emo_data[,column_index[i]]), cex=2, line=1, adj=0 )
# }
# dev.off()

sum_colors = region_colors[region_matches]
emo_data.w_sums = cbind(emo_data,net_emo_sums,sum_colors)

pdf(file="~/git/misc-analyses/happiness_index/images/gallup_2023_global_emotion_survey.maps_and_sums.pdf", width=8, height=11, paper="a4", title="2023 Global Emotion Survey", onefile = TRUE)
for (i in 1:10){
  color_fun = ifelse(i<6, hot_emotion_colors.p, cool_emotion_colors.p)
  
  ggp = ggplot( emo_data.w_sums , aes(x=emo_data.w_sums[,column_index[i]], y=net_emo_sums ) ) +
    theme(plot.title = element_text(size=20),
          legend.position=c(0,0.5),
          legend.justification = "left") +
    labs(y="Overall emotional score",
         x=paste('Percent responses "yes" to "Did you', emotions_list[i], 'yesterday?"'),
         title=emotions_list.short[i],
         caption=paste("What Is the World's Emotional Temperature?", emo_data$year[1] , "\n https://news.gallup.com/interactives/248240/global-emotions.aspx") ) +
    geom_point(size=4, colour=sum_colors) + 
    annotate("text", x=emo_data[,column_index[i]], y=net_emo_sums, label=emo_data.w_sums$country_code, size=1.5)
  ggm = ggplot(worldpolygons_w_emo, aes(x = long, y = lat, group = group)) +
    coord_map(xlim=c(-180,180), ylim=c(-54, 68) ) +
    theme(plot.title = element_text(size=20),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position=c(0,0.5),
          legend.justification = "left") +
    scale_fill_gradientn(colours = color_fun(8), na.value="gray70" ) +
    labs(x=NULL, y=NULL, fill='% "yes"',
         title= paste0("Did you **", emotions_list[i], "** during a lot of the day yesterday?"),
         caption=paste("What Is the World's Emotional Temperature?", emo_data$year[1] , "\n https://news.gallup.com/interactives/248240/global-emotions.aspx") ) +
    geom_polygon( aes(fill=worldpolygons_w_emo[,column_index[i]+5]), colour = "#000000" )
  grid.arrange(ggp, ggm)
}
dev.off()


# combined histograms in one page
pdf(file="~/git/misc-analyses/happiness_index/images/gallup_2023_global_emotion_survey.hist.pdf", width=8, height=11, paper="a4", title="2023 Global Emotion Survey")
par(mar=c(4, 4, 4, 1.5), mfrow=c(5,2))
for (i in 1:10){
  emo_values = emo_data[,column_index[i]]
  color_fun = ifelse(i<6, hot_emotion_colors.p, cool_emotion_colors.p)
  n_color = ifelse(i<10,33,22)
  xlow = ifelse(i<6, 0, min(emo_values) )
  xhigh = ifelse(i<6, max(emo_values), 100 )
  h = hist(emo_values, breaks=25, col=color_fun(n_color),
           xlim=c(xlow, xhigh),
           cex.lab=1.1, cex.axis=1.3,
           ylab="Frequency (n countries)", main=emotions_list[i],
           xlab=paste('Percent responses "yes" to "Did you', emotions_list[i], 'yesterday?"'),
           )
}
dev.off()

#emo_data.all_yes = data.frame(region=emo_data$country_short[1:142], net_yes=net_emo_sums)
worldpolygons_w_emo = left_join(worldpolygons, emo_data.all_yes, by="region")

ggplot(worldpolygons_w_emo, aes(x = long, y = lat, group = group)) +
  coord_map(xlim=c(-180,180), ylim=c(-54, 68) ) +
  theme(plot.title = element_text(size=20),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position=c(0,0.5),
        legend.justification = "left") +
  scale_fill_gradientn(colours = c(rev(hot_emotion_colors), cool_emotion_colors), na.value="gray70" ) +
  labs(x=NULL, y=NULL, fill="Score",
       title=bquote("All emotions combined from yesterday"),
       caption=paste("What Is the World's Emotional Temperature?", emo_data$year[1] , "\n https://news.gallup.com/interactives/248240/global-emotions.aspx") ) +
  geom_polygon( aes(fill=net_yes), colour = "#000000" )


################################################################################
################################################################################


#