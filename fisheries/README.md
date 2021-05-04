# Global fish imports and exports #
The data were downloaded in 2020 from the [UN FAO Food Balance Sheets](http://www.fao.org/faostat/en/#data/FBS), which included years 2014-2017. Currently the same website appears have included year 2018 data.

The original `.csv` file from the UN is large (45Mb, 315k lines), containing all food items (over 100), not just seafood. It includes other things like: Alcohol, Animal fats, Aquatic Plants, Bananas, Barley and products, Beans, Beer, Butter, Cereals - Excluding Beer, Citrus, Coconut Oil, Dates, Eggs, Fruits - Excluding Wine, Grapefruit and products, Honey, Lemons, Olive Oil, Onions, Pigmean, Plantains, Sesameseed Oil, Soybeans, Sweet potatoes, Vegetables, Wine, and many more. Some categories appear redundant (like Citrus), as they are just sums of other ones (Grapefruit, Lemons, Oranges), probably for convenience.

This is reduced to only seafood with a Python script, leaving `Pelagic fish`, `Demersal fish`, `Other marine fish`, `Freshwater fish`, `Crustaceans`, `Cephalopods` and `Molluscs (excl. cephalopods)`.

`./simplify_foodbalance_table.py -i data/FoodBalanceSheets_E_All_Data.csv > data/FoodBalanceSheets_E_reformat_all_fish.tab`

This is then used for making choropleth maps, like this one, showing imports of all seafood categories. China is the largest importer, producer, and exporter of basically all categories.

![global_fish_imports_only_2017.png](https://github.com/wrf/misc-analyses/blob/master/fisheries/images/global_fish_imports_only_2017.png)

## shinyapp ##
Here, another [shinyapp](https://shiny.rstudio.com/) can redraw the choropleth map based on imports, exports, and production of various seafood products around the world. It should run on another system with only the data file in the `/data` folder. The drop down menu will change whatever is displayed. All will have the same color scheme except the `imports vs production`, since it is a ratio. Lat-lon can be changed, but the rendering is likely to distort. 

The `Print PDF` button will print a file `plot.pdf` of whatever fish category is displayed on the screen. The plot titles should adapt automatically.

![fisheries_shinyapp_screenshot.png](https://github.com/wrf/misc-analyses/blob/master/fisheries/images/fisheries_shinyapp_screenshot.png)

This probably could be redone to include all the food items above, and may be implemented in the future.
