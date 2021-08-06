# map of language difficulty for native english speakers
# data taken from US Foreign Service Institute
# https://www.state.gov/foreign-language-training/

# Category I Languages: 24-30 weeks (600-750 class hours)
# Languages more similar to English.
# Danish (24 weeks) 	Dutch (24 weeks) 	French (30 weeks)
# Italian (24 weeks) 	Norwegian (24 weeks) 	Portuguese (24 weeks)
# Romanian (24 weeks) 	Spanish (24 weeks) 	Swedish (24 weeks)

# Category II Languages: Approximately 36 weeks (900 class hours)
# German 	Haitian Creole 	Indonesian
# Malay 	Swahili 	

# Category III Languages: Approximately 44 weeks (1100 class hours)
# Hard languages – Languages with significant linguistic and/or cultural differences from English. This list is not exhaustive.
# Albanian 	Amharic 	Armenian	Azerbaijani 	Bengali 	Bulgarian
# Burmese 	Czech 	Dari	Estonian 	Farsi 	Finnish
# Georgian 	Greek 	Hebrew	Hindi 	Hungarian 	Icelandic
# Kazakh 	Khmer 	Kurdish	Kyrgyz 	Lao 	Latvian
# Lithuanian 	Macedonian 	Mongolian	Nepali 	Polish 	Russian
# Serbo-Croatian 	Sinhala 	Slovak	Slovenian 	Somali 	Tagalog
# Tajiki 	Tamil 	Telugu	Thai 	Tibetan 	Turkish
# Turkmen 	Ukrainian 	Urdu	Uzbek 	Vietnamese 	

# Category IV Languages: 88 weeks (2200 class hours)
# Super-hard languages – Languages which are exceptionally difficult for native English speakers.
# Arabic 	Chinese – Cantonese 	Chinese – Mandarin	Japanese 	Korean

# using old maps version
library(maps)



type24 = c("Denmark", "Netherlands", "Italy", "Norway", "Portugal", "Romania", "Spain", "Sweden")
type30 = c("France")
type36 = c("Germany", "Haiti", "Indonesia", "Malaysia", "Kenya", "Tanzania", "Rwanda", "Uganda", "Burundi")
type44 = c("Albania", "Ethiopia", "Armenia", "Azerbaijan", "Bangladesh", "Bulgaria", "Myanmar", "Czech Republic", "Afghanistan", "Estonia", "Iran", "Finland",
        "Georgia", "Greece", "Israel", "India", "Hungary", "Iceland", "Kazakhstan", "Cambodia", "Iraq", "Kyrgyzstan", "Laos", "Latvia", 
        "Lithuania", "Macedonia", "Mongolia", "Nepal", "Poland", "Russia", "Serbia", "Croatia", "Sri Lanka", "Slovakia", "Slovenia", "Somalia", "Philippines", 
        "Tajikistan", "Singapore", "India", "Thailand", "Tibet", "Turkey", "Turkmenistan", "Ukraine", "Pakistan", "Uzbekistan", "Vietnam" )
type88 = c( "Saudi Arabia", "Morocco", "Algeria", "Tunisia", "Libya", "Egypt", "Malta", "Syria", "Jordan", "Oman", "Yemen", "Kuwait", "Qatar", 
        "China", "Hong Kong", "Japan", "South Korea", "North Korea")


langcountries = c(type24, type30, type36, type44, type88)

colorindex = rep(1:5, lapply( list(type24, type30, type36, type44, type88), length))
colorset = c( "#f8e9b1", "#c7e9b4", "#7fcdbb", "#1d91c0", "#0c2c84")

latrange = c(-30,68)
lonrange = c(-25,150)
worldmap = map('world', ylim=latrange, xlim=lonrange)

countrylist = worldmap$names

vecbycountry = rep("#dddddd", length(worldmap$names) )
for (ctry in langcountries){
	vecbycountry[grep(ctry,countrylist)] = colorset[ colorindex[grep(ctry,langcountries)]]
}

pdf(file="~/git/misc-analyses/language_difficulty/images/language_learning_difficulty_v1.pdf", width=13, height=8)
worldmap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, col=vecbycountry, mar=c(1,1,1,1))
legend(53, 6, legend=c(20,30,36,44,88), pch=22, pt.bg=colorset, bty='n', cex=2.3)
text(73, -20, "Weeks to fluency\nfor native English\nspeakers", cex=2.5, pos=4)
dev.off()










#
