
library(ggplot2)

# plotting global fertilizer production
#
# data from
# Smil V (1991) Population Growth and Nitrogen: An Exploration of a Critical Existential Link
# http://www.jstor.org/stable/1973598
# Table 2: Production of nitrogen fertilizers (million tons of nitrogen content): Selected series, 1920-88



fertilizer_data_file = "~/git/misc-analyses/land_usage/data/smil_1991_table2_nitrogen_fertilizer.txt"
fertilizer_data = read.table(fertilizer_data_file, header=TRUE, sep="\t")
fertilizer_data$world_total_Mtons_N

gp = ggplot(data=fertilizer_data, aes(x = year, y = world_total_Mtons_N) ) +
  theme(axis.text=element_text(size=16),
        axis.title = element_text(size=18),
        plot.title = element_text(size=25)) +
  scale_x_continuous() +
  labs(x=NULL, y="Million tons Nitrogen",
       title="Global fertilizer production",
       subtitle="Data from Smil (1991) Population and Development Review") +
  geom_line(linewidth = 3, color="black" ) + 
  geom_line(aes(x = year, y = USA_Mtons_N), linewidth = 3, color="#123489" ) + 
  geom_line(aes(x = year, y = China_Mtons_N), linewidth = 3, color="#cc1212" ) + 
  annotate( geom="text", x=1975, y=80, label="Global total", color="black", size=6) +
  annotate( geom="text", x=1985, y=4, label="USA", color="#123489", size=6) +
  annotate( geom="text", x=1985, y=23, label="China", color="#cc1212", size=6)
ggsave("~/git/misc-analyses/land_usage/image/global_fertilizer_production_smil_1991.pdf", gp, device="pdf", height=5, width=7, title="Global fertilizer production")


# per hectare yields of different protein sources
# plotting data on protein yield from
# Shurtleff 1975 The Book of Tofu
# apparently from
# USDA and WHO 1971


prot_sources = c("Soybean", "Rice", "Corn", "Other legumes",
                 "Wheat", "Milk", "Eggs", "Meat (all)", "Beef")
yields_lbs_per_acre = c(356, 265, 211, 192, 138, 82, 78, 45, 20)
lbs_to_kg = 1/2.204
hectare_to_acre = 1/0.4047
yields_kg_per_hectare = yields_lbs_per_acre * lbs_to_kg * hectare_to_acre

ps_data = data.frame(prot_sources,yields_lbs_per_acre,yields_kg_per_hectare)

gp = ggplot(data=ps_data, aes(x=reorder(prot_sources, yields_kg_per_hectare), y=yields_kg_per_hectare) ) +
    coord_flip() +
    theme(axis.text.y=element_text(size=16),
          axis.text.x=element_text(size=13),
          axis.title.x=element_text(size=18),
          plot.title = element_text(size=25)) +
    scale_fill_gradient(low="#fe9929", high="#78c679") +
    geom_col(aes(fill=yields_kg_per_hectare), show.legend = FALSE) +
    labs(x=NULL, y="kg protein per hectare",
         title="Per-hectare yields of protein sources",
         subtitle="Data from USDA 1971") +
    annotate(geom="text", y=yields_kg_per_hectare+15, x=rev(seq(1,9,1)), label=round(yields_kg_per_hectare) )
ggsave("~/git/misc-analyses/land_usage/image/per_hectare_protein_USDA_1971.pdf", gp, device="pdf", height=5, width=8)

#
# also using data from 
# Poore 2018 Reducing food’s environmental impacts through producers and consumers. Science
# doi.org/10.1126/science.aaq0216
#
food_items = c("Wheat & Rye (Bread)", "Maize (Meal)", "Barley (Beer)", "Oatmeal", 
               "Rice", "Potatoes", "Cassava", "Cane Sugar", "Beet Sugar", 
               "Other Pulses", "Peas", "Nuts", "Groundnuts", "Soymilk", "Tofu", 
               "Soybean Oil", "Palm Oil", "Sunflower Oil", "Rapeseed Oil", 
               "Olive Oil", "Tomatoes", "Onions & Leeks", "Root Vegetables", 
               "Brassicas", "Other Vegetables", "Citrus Fruit", "Bananas", 
               "Apples", "Berries & Grapes", "Wine", "Other Fruit", "Coffee", 
               "Dark Chocolate", "Bovine Meat (beef herd)", "Bovine Meat (dairy herd)", 
               "Lamb & Mutton", "Pig Meat", "Poultry Meat", 
               "Milk", "Cheese", "Eggs", 
               "Fish (farmed)", "Crustaceans (farmed)")
# subset 100g protein items
is_100g_protein = c(34, 36, 35, 43, 40, 37, 38, 41, 15, 13, 10, 11, 12 )
# processed data from Poore2018, as m2 land per 100g protein
food_median_land_use_m2_unit = c(2.7, 1.8, 0.9, 7.7, 2.2, 0.8, 1.3, 1.8, 1.5, 12.2, 6.7, 8.7, 7.9, 0.6, 3.4, 9.6, 2.4, 16.3, 9.4, 17.3, 0.2, 0.3, 0.3, 0.3, 0.2, 0.7, 1.4, 0.5, 2.6, 1.6, 0.9, 11.9, 53.8, 170.4, 25.9, 127.4, 13.4, 11.0, 2.1, 20.2, 5.7, 5.6, 0.8)
food_mean_land_use_m2_unit = c(3.9, 2.9, 1.1, 7.6, 2.8, 0.9, 1.8, 2.0, 1.8, 15.6, 7.5, 13.0, 9.1, 0.7, 3.5, 10.5, 2.4, 17.7, 10.6, 26.3, 0.8, 0.4, 0.3, 0.6, 0.4, 0.9, 1.9, 0.6, 2.4, 1.8, 0.9, 21.6, 69.0, 326.2, 43.2, 369.8, 17.4, 12.2, 9.0, 87.8, 6.3, 8.4, 3.0)
# 10000 m2 per kilogram, simplifies to 1000/x
food_median_land_use_kg_hec = 1000 / food_median_land_use_m2_unit
food_mean_land_use_kg_hec = 1000 / food_mean_land_use_m2_unit

food_table = droplevels(data.frame( food_items, food_median_land_use_kg_hec, food_mean_land_use_kg_hec ))
ft_protein_only = food_table[rev(is_100g_protein),]
ft_protein_only$food_items = factor(ft_protein_only$food_items, levels = ft_protein_only$food_items)

gp = ggplot(data=ft_protein_only, aes(x=food_items, y=food_mean_land_use_kg_hec) ) +
    coord_flip() +
    theme(axis.text.y=element_text(size=16),
          axis.text.x=element_text(size=13),
          axis.title.x=element_text(size=18),
          plot.title = element_text(size=25)) +
    scale_fill_gradient(low="#fe9929", high="#78c679") +
    geom_col(aes(fill=food_mean_land_use_kg_hec), show.legend = FALSE) + 
    labs(x=NULL, y="kg protein per hectare",
         title="Per-hectare yields of protein sources",
         subtitle="Data from Poore 2018 Science") +
    annotate(geom="text", y=food_mean_land_use_kg_hec[is_100g_protein]+15, x=rev(seq(1,13,1)), label=round( food_mean_land_use_kg_hec[is_100g_protein] ) )
gp

ggsave("~/git/misc-analyses/land_usage/image/per_hectare_protein_Poore2018.pdf", gp, device="pdf", height=6, width=9)


#