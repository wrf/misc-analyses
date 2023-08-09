# plot uni rankings for top 100

rankdat_file = "~/git/misc-analyses/education/us_news_2022_top100_global_universities.tab"
rankdat = read.table(rankdat_file,header = TRUE, sep = "\t", quote = "")

names(table(rankdat$Country))

is_european = rankdat$Country %in% c("Belgium", "Denmark", "Finland", "France", "Germany", "Netherlands", "Norway", "Spain", "Sweden", "Switzerland", "United Kingdom")
table(is_european)
is_from_dk = rankdat$Country=="Denmark"

points_below_harvard = -1* (100-rankdat$Score)

bar_color = ifelse(is_from_dk, "red", "#d0d9d2ff")
bar_color[rankdat$Country=="United States"] = "#2337d5ff"
bar_color[rankdat$Country=="United Kingdom"] = "#494949ff"
bar_color[rankdat$Country=="Netherlands"] = "#faa605ff"



barplot(points_below_harvard[1:100],
        col = bar_color,
        ylab = "Points behind Harvard")
text(49,-26,"KU", col="red")

barplot(points_below_harvard[is_european],
        col = bar_color[is_european],
        ylab = "Points behind Harvard")
