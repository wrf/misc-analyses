# the butter line #
Many plants will have geographically restricted cultivation. An obvious case is olive and grape production around the Mediterranean sea, and similar latitudes globally. This contrasts with northern Europe, which often have food and drink based on wheat, barley, and milk products. Above a line that is roughly following the Alps, butter is the historical fat of choice (i.e. availability), below this line, it is olive oil.

This is, of course, a simplification, as cultural factors and movement of people are also at play. Of particular interest is France, which spans the Mediterranean climate and temperate north. This has some interesting cultural differences from those two greater regions, with wine production throughout (not beer), accompanied with bread and butter/cheese (not olives). There is, of course, olive production in France, but this is limited to a small region near the Mediterranean, and is small-scale compared to other countries in southern Europe.

Production of most of these foods can be observed at a global scale. Based on my [earlier version of fisheries only](https://github.com/wrf/misc-analyses/tree/master/fisheries), I made another [shinyapp](https://shiny.rstudio.com/) that can redraw the choropleth map based on imports, exports, and production of various food products around the world. The top 20 items are also displayed in a barplot below the map. It should run on another system by [downloading the original .csv file from the UN](http://www.fao.org/faostat/en/#data/FBS), placing it into the `/data` folder.

The app [is currently live here](https://wrfbiolum.shinyapps.io/butterline/).

The drop down menu will change whatever is displayed. There is a table at the bottom, and display options can be controlled as well. Lat-lon can be changed for the map view, but the rendering is likely to distort the map unless it is roughly 2:1 aspect ratio. The `Print PDF` button will print a map file `plot.pdf` of whatever food category is displayed on the screen. The plot titles should adapt automatically.

![food_balance_app_v2_screenshot.png](https://github.com/wrf/misc-analyses/blob/master/olive_v_butter/images/food_balance_app_v2_screenshot.png)

The data were downloaded in 2021 from the [UN FAO Food Balance Sheets](http://www.fao.org/faostat/en/#data/FBS), which included years 2014-2018.

Units are in 1000 tonnes, or M kg, or properly in gigagrams - Gg. One tonne of water, 1000kg, would be a 1m cube. A shipping container (40x8x10 ft) would be 86 cubic meters, a bit less than 100 tonnes. So 1 Gg would be about 10-12 shipping containers.

For example, Switzerland imports 180 Gg of wine per year (plus producing 111Gg and exporting 1Gg). For ease of math, suppose that each 1kg is 1 bottle of 750mL of wine, whereby 1Gg would be 1M bottles (this actually would probably be about 1.25kg per bottle). Thus, the imports sum to roughly 5 shipping containers per day, for a population of about 8.5M. The final consumption is 290Gg/year, coming out to 794k bottles per day. On average, 1 in 10 people have wine for dinner. This makes more sense to imagine that 2/10 have wine with dinner, and that any given couple would be finishing a bottle once or twice a week.

