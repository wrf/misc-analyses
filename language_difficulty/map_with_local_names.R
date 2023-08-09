# map of places where names are written in local language

library(maps)

latrange = c(20,65)
lonrange = c(-25,100)
#euromap = map('world', ylim=latrange, xlim=lonrange)


wc = world.cities

wcaps = wc[wc$capital==1,]
# Montenegro not included, because data are from 2006
# get data manually
mnc = c("Podgorica","Montenegro",1, 42.441286, 19.262892,1)

wcaps

countrylist = wcaps[["country.etc"]]

citiesonly = wc[1:(dim(wc)[1]),1]
#citiesonly

countrycolors = rainbow(length(countrylist),v=0.9,s=0.35)

# extract capitals for relevant countries
#capsonly = wcaps[match(c(countries_noNA), wcaps[1:(dim(wcaps)[1]),2],nomatch=FALSE),]
#capsonly

euromap = map('world', ylim=latrange, xlim=lonrange)

vecbycountry = rep("#dddddd", length(euromap$names) )
for (ctry in countrylist){
	vecbycountry[grep(ctry,euromap$names)] = countrycolors[ grep(ctry,countrylist)]
}
vecbycountry

fontsize = 1

library("Unicode")




cairo_pdf(file="~/git/map_code_in_R/map_with_local_names.pdf", width=18, height=10, )

euromap = map('world', ylim=latrange, xlim=lonrange, fill=TRUE, border="#999999", col=vecbycountry, mar=c(1,0.6,1,0.6))
text( -0.10-1.2,  51.52+1, "United\nKingdom", cex=fontsize)
text( -6.25-1,  53.33, "Éire\n(Ireland)", cex=fontsize)
text(   2.3,  48.86-1, "France\n(France)", cex=fontsize)
text( -3.71,  40.42, "España\n(Spain)", cex=fontsize)
text( -2.92,  43.25, "Euskal Herria\n(Basque)", cex=fontsize)
text( 12.50+3,  41.89-1, "Italia\n(Italy)", cex=fontsize)
text( -9.14,  38.72, "Portugal\n(Portugal)", cex=fontsize)
text(  7.44,  46.95, "Schweiz\nSuisse\nSvizzera\n(Switzerland)", cex=fontsize)
text(  4.33,  50.83, "Belgique\nBelgië\n(Belgium)", cex=fontsize)
text(  4.89,  52.37+1.5, "Nederland\n(Netherlands)", cex=fontsize)
text( 13.38-2,  52.52-0.5, "Deutschland\n(Germany)", cex=fontsize)
text( 16.37-2,  48.22-0.5, "Österreich\n(Austria)", cex=fontsize)
text( 21.02-2,  52.26, "Polska\n(Poland)", cex=fontsize)
text( 14.43,  50.08, "Česká republika\n(Czech Republic)", cex=fontsize)
text( 17.13,  48.16, "Slovensko\n(Slovakia)", cex=fontsize)
text( 14.51,  46.06, "Slovenija\n(Slovenia)", cex=fontsize)
text( 19.08+1,  47.51-0.5, "Magyarország\n(Hungary)", cex=fontsize)
text( 12.57-2,  55.68, "Danmark\n(Denmark)", cex=fontsize)
text( 18.07-3,  59.33+1, "Sverige\n(Sweden)", cex=fontsize)
text( 10.75-1,  59.91+1, "Norge\n(Norway)", cex=fontsize)
text( 24.94,  60.17+2, "Suomi\n(Finland)", cex=fontsize)
text(-21.92,  64.14, "Ísland\n(Iceland)", cex=fontsize)
text( 25.27-2,  54.70+0.5, "Lietuva\n(Lithuania)", cex=fontsize)
text( 24.13,  56.97, "Latvija (Latvia)", cex=fontsize)
text( 24.74,  59.44-1, "Eesti (Estonia)", cex=fontsize)

text( 23.32,  42.69, "България\n(Bulgaria = Balgariya)", cex=fontsize)
text( 26.10-1,  44.44+1, "România\n(Romania)", cex=fontsize)
text( 28.83,  47.03, "Moldova\n(Moldova)", cex=fontsize)
text( 30.52,  50.43-0.8, "Україна\n(Ukraine = Ukrayina)", cex=fontsize)
text( 37.62,  55.75, "Росси́я\n(Russia = Rossiya)", cex=fontsize)
text( 27.55,  53.91-1, "Беларусь\n(Belarus = Belarusa)", cex=fontsize)
text( 15.97,  45.80-2, "Hrvatska\n(Croatia)", cex=fontsize)
text( 23.73,  37.98, "Ελλάδα\n(Greece = Ellátha)", cex=fontsize)
text( 33.38-3,  35.16, "Κύπρος\n(Cyprus = Kypros)", cex=fontsize)



text( 32.85,  39.93, "Türkiye\n(Turkey)", cex=fontsize)
text( 44.79-1.5,  41.72+1, "საქართველო\n(Georgia = Sakartvelo)", cex=fontsize)
text( 44.52,  40.17, "Հայաստան\n(Armenia = Hayastan)", cex=fontsize)
text( 49.86+2,  40.39, "Azərbaycan\n(Azerbaijan)", cex=fontsize)



text( -6.84,  34.02, "المغرب‎\n(Morocco = al-maġhrib)", cex=fontsize)
text(  3.04-1,  36.77-8, "الجزائر‎\n(Algeria = al-Jazāʾir)", cex=fontsize)
text( 10.22,  36.84, "تونیس\n(Tunisia = Tūnis)", cex=fontsize)
text( 13.18+3,  32.87-5, "ليبيا‎\n(Libya = Lībiyā)", cex=fontsize)
text( 31.25-1,  30.06-4, "مِصر‎\n(Egypt = Miṣr)", cex=fontsize)
text( 35.93+2,  31.95-2, "الْأُرْدُنّ‎\n(Jordan = Al-ʾUrdunn)", cex=fontsize)
text( 35.50,  33.88, "لبنان‎\n(Lebanon = Lubnān)", cex=fontsize)
text( 35.22,  31.78, "יִשְׂרָאֵל\n(Israel)", cex=fontsize)

text( 36.32+3,  33.50+3, "سوريا‎\n(Syria = Sūriyā)", cex=fontsize)

text( 46.77,  24.65, "السعودية\n(Saudi Arabia = as-Saʿūdīyah)", cex=fontsize)
text( 44.44,  33.33, "العراق‎\n(Iraq = al-'Irāq)", cex=fontsize)
text( 51.43+3,  35.67-3, "ايران\n(Iran = Irân)", cex=fontsize)
text( 69.17-2,  34.53, "افغانستان\n(Afghanistan = Afġānistān)", cex=fontsize)
text( 73.06-3,  33.72-4, "پاکستان\n(Pakistan = Pākistān)", cex=fontsize)
text( 58.38,  37.95, "Türkmenistan\n(Turkmenistan)", cex=fontsize)
text( 71.47,  51.17, "Қазақстан\n(Kazakhstan = Qazaqstan)", cex=fontsize)
text( 74.57,  42.87, "Кыргызстан\n(Kyrgyzstan = Kırğızstan)", cex=fontsize)
text( 68.78,  38.57, "Тоҷикистон\n(Tajikistan = Tojikiston)", cex=fontsize)
text( 69.30-8,  41.31+2, "Oʻzbekiston\n(Uzbekistan)", cex=fontsize)
text( 77.22+3,  28.60-6, "भारत\n(India = Bhārat)", cex=fontsize)
text( 89.70,  27.48, "འབྲུག་ཡུལ་\n(Bhutan = Druk Yul)", cex=fontsize)



text( 116.40,  39.93, "中国\n(China = Zhōngguó)", cex=fontsize)
#text(126.99, 37.56, "한국\n(South Korea = Hanguk)", cex=fontsize=0.5)
#text(139.77, 35.67, "日本\n(Japan = Nihon)", cex=fontsize=0.5)

dev.off()


#text("Việt Nam", cex=fontsize)






























#