# Are some countries overwhelmed by tourists? #

Plotted below are the ratios of international tourist arrivals to the local population. Data for the majority of countries count only overnight visitors (category TF), that is, excludes day-trips/excursions (category VF). Gray countries indicate that no data are available (e.g. Libya, Pakistan).

Arrival numbers are annual totals, though in the context of a tourism season, many tourists may come at the same time and stay for weeks. If for instance, all of the tourism to Greece (30M visitors, pop. appx. 10M) were confined to the summer, and each person stayed for one month, then the population of Greece would effectively double for the summer. Each visitor of course needs access to food, basic facilities, etc. This would mean that the infrastructure is either at double capacity for the summer (hence would be insufficient), or is at half capacity for the rest of the year (sufficient but underused most of the time).

Tourism arrivals data from [UN World Tourism Organization 2019 Tourism Highlights](https://www.e-unwto.org/doi/book/10.18111/9789284421152) containing counts for 2018, population data are from [World Population Clock](https://www.worldometers.info/world-population/population-by-country/).

![2018_annual_tourism_by_countries.png](https://github.com/wrf/misc-analyses/blob/master/tourism/2018_annual_tourism_by_countries.png)

Much of the pattern is the same as the previous year. Several travel trends are nonetheless evident. European countries receive the most international visitors by far (710M, vs Asia with 347M). Most European countries are almost 1:1 of arrivals to locals (colored red). Some exceptions are:

* France and Spain receive the most visitors worldwide (89M and 82M, respectively), then Italy (62M visitors, 5th global, 3rd in Europe)
* Iceland is a small country (338k) but has 2.3 million tourists, giving it a very high tourist to local ratio
* Austria and Greece both get 30 million visitors, for countries of only 8.9M and 10.4M people. Both likely have strong seasonality to the tourism (mountains/skiing, and beaches). Vienna counts for [6M](https://en.wikipedia.org/wiki/List_of_cities_by_international_visitors) people in 2017
* Denmark has the most tourists (10M) among the nordic countries (maybe mostly Copenhagen (3M) and [Legoland](https://en.wikipedia.org/wiki/Legoland_Billund_Resort) (2M), and some beach tourism along Jutland)
* Croatia has 16M tourists, for only 4.1M people (possibly mix of beach tourism and [Game of Thrones fans](https://gameofthrones.fandom.com/wiki/Filming_locations))
* Saudi Arabia gets 15M people per year, half of this is for visits to the [city of Mecca](https://en.wikipedia.org/wiki/Mecca), reporting [almost 8M people for 2018](https://en.wikipedia.org/wiki/Hajj)

The UK and Germany by comparison receive relatively few tourists. The UK received 37M visitors, though almost 20M is to London (again [based on 2017](https://en.wikipedia.org/wiki/List_of_cities_by_international_visitors) counts). Germany had 38M visitors, against almost 6 million to Berlin in 2017. Oktoberfest claims over 6M people, though not all of these are international.

A few places stand out with relatively high tourism for their region (colored red while most neighbors are green), compared to their local poulations. These include Georgia (4.7M/3.9M), Kyrgyzstan (4.5M/6.4M), Malaysia (25.8M/31.9M), Namibia (1.4M/2.4M), and Uruguay (3.4M/3.4M). Much of this effect appears to come from the relatively small populations of these countries. 

By comparison, several very large countries appear to have a low rate of tourism due to the very large local populations, such as China (62.9M visitors, 4th globally, against 1.43G locals), India (17.4M/1.36G), Indonesia (13.3M/270M), Brazil (6.6M/211M), Nigeria (1.9M/200M) and Russia (24.5M/145M).

### Notes ###
Two countries changed names in the past year, Swaziland to Eswatini, and the Former Yugoslavian Republic of Macedonia to North Macedonia. Both of these use the old names in the datasets to enable consistent matching in the code.
