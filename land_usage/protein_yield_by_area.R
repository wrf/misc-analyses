# per hectare yields of different protein sources
# plotting data on protein yield from
# Shurtleff 1975 The Book of Tofu
# apparently from
# USDA and WHO 1971
#

library(ggplot2)


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
ggsave("~/git/misc-analyses/land_usage/per_hectare_protein_USDA_1971.pdf", gp, device="pdf", height=5, width=8)







