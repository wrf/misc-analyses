# Global fish imports and exports #
See [here](https://wrfbiolum.shinyapps.io/foodbalance/) for a live version of the current app, or here for the [updated code](https://github.com/wrf/foodbalance) of the second version.

This page discusses the initial version, which was only related to fish and seafood products.

The data were downloaded in 2020 from the [UN FAO Food Balance Sheets](http://www.fao.org/faostat/en/#data/FBS), which included years 2014-2017. Currently the same website appears have included year 2018 data.

The original `.csv` file from the UN is large (45Mb, 315k lines), containing all food items (over 100), not just seafood. It includes other things like: Alcohol, Animal fats, Aquatic Plants, Bananas, Barley and products, Beans, Beer, Butter, Cereals - Excluding Beer, Citrus, Coconut Oil, Dates, Eggs, Fruits - Excluding Wine, Grapefruit and products, Honey, Lemons, Olive Oil, Onions, Pigmean, Plantains, Sesameseed Oil, Soybeans, Sweet potatoes, Vegetables, Wine, and many more. Some categories appear redundant (like Citrus), as they are just sums of other ones (Grapefruit, Lemons, Oranges), probably for convenience.

This is reduced to only seafood with a Python script, leaving `Pelagic fish`, `Demersal fish`, `Other marine fish`, `Freshwater fish`, `Crustaceans`, `Cephalopods` and `Molluscs (excl. cephalopods)`.

`./simplify_foodbalance_table.py -i data/FoodBalanceSheets_E_All_Data.csv > data/FoodBalanceSheets_E_reformat_all_fish.tab`

This is then used for making choropleth maps, like this one, showing imports of all seafood categories. China is the largest importer, producer, and exporter of basically all categories.

![global_fish_imports_only_2017.png](https://github.com/wrf/misc-analyses/blob/master/fisheries/images/global_fish_imports_only_2017.png)

Units are in 1000 tonnes, or M kg, or properly in gigagrams - Gg. 1 tonne of water, 1000kg, would be a 1m cube. A shipping container (40x8x10 ft) would be 86 cubic meters, a bit less than 100 tonnes. So 1 Gg would be about 10-12 shipping containers. Switzerland imports 146 Gg per year (eating 144 Gg), so roughly 5 shipping containers per day, for a population of about 8.5M. If a portion of fish is 150g with the same density of water (assuming no bones or shells), that would be about 2.5 million portions per day. Thus, one third of the country would be having seafood for either lunch or dinner each day.

## shinyapp v1 ##
Here, another [shinyapp](https://shiny.rstudio.com/) can redraw the choropleth map based on imports, exports, and production of various seafood products around the world. The top 20 items are also displayed in a barplot below the map. It should run on another system with only the data file in the `/data` folder. The drop down menu will change whatever is displayed. All will have the same color scheme except the `imports vs production`, since it is a ratio. Lat-lon can be changed, but the rendering is likely to distort. 

The `Print PDF` button will print a file `plot.pdf` of whatever fish category is displayed on the screen. The plot titles should adapt automatically.

![fisheries_shinyapp_screenshot.png](https://github.com/wrf/misc-analyses/blob/master/fisheries/images/fisheries_shinyapp_screenshot.png)

## notes ##

[Oceana 2013 report on mislabeling of seafood](https://oceana.org/wp-content/uploads/sites/18/National_Seafood_Fraud_Testing_Results_FINAL.pdf), noting the largest problem was in sushi restaurants, not grocery stores



