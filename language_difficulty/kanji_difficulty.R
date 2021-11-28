# plot number of strokes per character vs year of learning the kanji
# from list on wikipedia
# https://en.wikipedia.org/wiki/Ky%C5%8Diku_kanji

library(ggplot2)

kanjidata_file = "~/git/misc-analyses/language_difficulty/data/kanji_by_school_year_1-6.txt"

kanjidata = read.table(kanjidata_file, header=TRUE, sep="\t", encoding="UTF-8", stringsAsFactors=FALSE)

strokejitter=jitter(kanjidata$Strokes, factor=0.5)
gradejitter=jitter(kanjidata$grade)

replace_numbers = c(116, 120, 237, 
                    436, 241, 
                    582, 608, 613, 629, 635, 636, 640, 
                    769, 774, 792, 793, 824, 
                    946, 963, 964, 989, 1003 )
replace_xjitters = c(1.9, 2.1, 2.0,
                     3.0, 3.0,
                     3.9, 3.8, 4.1, 3.9, 4.1, 4.0, 4.2,
                     4.8, 5.0, 5.0, 5.0, 5.2,
                     5.8, 5.9, 6.0, 6.1, 6.2 )
gradejitter_fixed = replace(gradejitter, replace_numbers, replace_xjitters)

has_many_strokes = kanjidata$Strokes >= 18

kanjidata[has_many_strokes,2]

p = ggplot(data=kanjidata , aes(x = grade, y = Strokes, group=grade) ) +
  theme(text = element_text(family="Japan1"),
        axis.text.y=element_text(size=16),
        axis.text.x=element_text(size=13),
        axis.title=element_text(size=18)) +
  labs(x="Grade", y="Strokes",
       title="Number of strokes per character for Kyouiku Kanji",
       subtitle="for primary school") +
  scale_x_continuous(breaks=1:6) +
  geom_boxplot( outlier.size = 5, outlier.shape = NA) + 
  #geom_jitter( width=0.25, height=0.2, color="#086a33", size=5, alpha=0.5)
  geom_point(data=kanjidata, aes(x = gradejitter_fixed, y=strokejitter), size=5, alpha=0.5, color="#fe9929") +
  geom_text(data=kanjidata, aes( x = gradejitter_fixed, y=strokejitter, label=ifelse(Strokes >= 18 , as.character(Kanji), '' ) ) , vjust=0.5, size=5  )
p


pdf("~/git/misc-analyses/language_difficulty/images/kanji_by_school_year_w_outliers.pdf", height=7, width=8, family="Japan1" )
print(p)
dev.off()

#ggsave("~/git/misc-analyses/language_difficulty/images/kanji_by_school_year_w_outliers.pdf", p, device="pdf", encoding="default", height=7, width=8, fonts="Japan1")

#
