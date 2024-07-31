# misc-analyses #
other analyses of diverse topics, all work and opinions are my own

## [language difficulty](https://github.com/wrf/misc-analyses/tree/master/language_difficulty) ##
Not all children learn their native language at the same rate.

![bleses_2008_fig3_data.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/bleses_2008_fig3_data.png)

## [land usage](https://github.com/wrf/misc-analyses/tree/master/land_usage) ##
Some replots of data regarding efficiency of land usage, carbon emissions, and crop yields

![per_hectare_protein_Poore2018.png](https://github.com/wrf/misc-analyses/blob/master/land_usage/image/per_hectare_protein_Poore2018.png)

## [global consumption of seafood](https://github.com/wrf/misc-analyses/tree/master/fisheries) ##
Many countries with long coastlines still import a lot of their fish. This is viewable on my [interactive online RShinyApp](https://wrfbiolum.shinyapps.io/foodbalance/), which apparently works on mobile phones too. Data are from [UN FAO](http://www.fao.org/faostat/en/#data/FBS).

![global_fish_imports_only_2017.png](https://github.com/wrf/misc-analyses/blob/master/fisheries/images/global_fish_imports_only_2017.png)

## [seasonality of human births](https://github.com/wrf/misc-analyses/tree/master/birth_rate_by_month) ##
Month of birth has real effects, like astrology, something known by all of humanity for thousands of years. Data from the [UN data portal](https://data.un.org/Data.aspx?d=POP&f=tableCode:55).

![UNdata_Export_20210419_scand_by_year.png](https://github.com/wrf/misc-analyses/blob/master/birth_rate_by_month/images/UNdata_Export_20210419_scand_by_year.png)

## [food cravings during pregnancy](https://github.com/wrf/misc-analyses/tree/master/nausea_pregnancy) ##
Replots of food aversions and cravings during pregnancy, [NVP](https://en.wikipedia.org/wiki/Morning_sickness), and related things

![food_cravings_flaxman_2000_fig7.png](https://github.com/wrf/misc-analyses/blob/master/nausea_pregnancy/images/food_cravings_flaxman_2000_fig7.png)

## [generic interactive plotter](https://github.com/wrf/misc-analyses/tree/master/shinyplot) ##
Generic interactive plotter using [Rshiny](https://shiny.rstudio.com/). The app can read in a file, and plot any X against any Y (as a scatterplot). The graph can be printed as a PDF for easy sharing.

![shinyplot_demo_screenshot.png](https://github.com/wrf/misc-analyses/blob/master/shinyplot/shinyplot_demo_screenshot.png)

## [ratio of annual tourists to population](https://github.com/wrf/misc-analyses/tree/master/tourism) ##
Some countries with a peak tourism season need to run at double capacity for 2-3 months, or are at half capacity for the rest of the year. Tourism arrivals data from [UN World Tourism Organization 2019 Tourism Highlights](https://www.e-unwto.org/doi/book/10.18111/9789284421152) containing counts for 2018, population data are from [World Population Clock](https://www.worldometers.info/world-population/population-by-country/).

![2018_annual_tourism_by_countries.png](https://github.com/wrf/misc-analyses/blob/master/tourism/2018_annual_tourism_by_countries.png)

## [quality of life index](https://github.com/wrf/misc-analyses/tree/master/quality_of_life) ##
Quality of life index vs tax revenue of each country. A lot of the world is not represented there.

![plot of quality of life against tax revenue](https://github.com/wrf/misc-analyses/blob/master/quality_of_life/images/qol_vs_tax_revenue_v1.png)

## [success in ERC grants - moved to own repo](https://github.com/wrf/erc-success) ##
Countries like France and Spain have the same number of applications, but France is twice as successful. Data from [ERC statistics tables](https://erc.europa.eu/projects-figures/statistics), and from [MSCA-IF 2018 table](http://ec.europa.eu/research/participants/portal/doc/call/h2020/msca-if-2018/1847614-if2018_percentiles_en.pdf)

![map of 2019 ERC StG success across all panels](https://github.com/wrf/erc-success/blob/main/images/erc_2019_StG_granted_projects_all_panels_ratio_w_counts.png)

## [prospective H-index](https://github.com/wrf/misc-analyses/tree/master/h_index_predictions) ##
Any formula can be used on any person, even if it should not, reminding us that "[when a measure becomes a target, it ceases to be a good measure](https://en.wikipedia.org/wiki/Goodhart%27s_law)"

![2020_barplot.png](https://github.com/wrf/misc-analyses/blob/master/h_index_predictions/2020_barplot.png)

## [high level ranks in sequence databases - moved to new repo](https://github.com/wrf/taxonomy_database) ##
Occurrence of samples from each kingdom, phylum and class in public databases. Data in the archives are dominated by model organism samples. This is also integrated into an [interactive ShinyApp map](https://rstudio.github.io/leaflet/).

![NCBI_SRA_Metadata_Full_20191130.ncbi_ids_w_kingdom.png](https://github.com/wrf/taxonomy_database/blob/master/images/NCBI_SRA_Metadata_Full_20191130.ncbi_ids_w_kingdom.png)

## [remaking overview figures for the MMETSP](https://github.com/wrf/misc-analyses/tree/master/marine_meta) ##
In addition to a [poor choice in color scheme](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001889#pbio-1001889-g001), the [original paper figures](https://doi.org/10.1371/journal.pbio.1001889) did not explain much about the diversity of samples. Additional processing of this dataset was used for [Orsi 2018](https://bitbucket.org/wrf/subsurface2017)

![sample-attr_oceanography.png](https://github.com/wrf/misc-analyses/blob/master/marine_meta/sample-attr_oceanography.png)

## [model of intron evolution](https://github.com/wrf/misc-analyses/tree/master/intron_evolution) ##
Introns become longer by a runaway expansion model, creating an exponential distribution of length. This was a follow up to Francis 2017 [Similar ratios of introns to intergenic sequence across animal genomes.](https://doi.org/10.1093/gbe/evx103)

![random_intron_length_plot.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/random_intron_length_plot.png)

## [similar ratio of introns to intergenic sequences - on bitbucket](https://bitbucket.org/wrf/genome-reannotations) ##
Data for the paper of [Francis 2017](https://doi.org/10.1093/gbe/evx103) showing the ratio of intronic bases to intergenic bases. Original version had 68 species, though many more have been added since.

![large_intron_intergenic_log_plot.png](https://raw.githubusercontent.com/wrf/misc-analyses/master/figures_for_repo/large_intron_intergenic_log_plot.png)

## [visualizing randomness](https://github.com/wrf/misc-analyses/tree/master/visualizing_randomness) ##
Some exploration of how randomness is viewed on plots

![4 plots of randomness levels](https://github.com/wrf/misc-analyses/blob/master/visualizing_randomness/block_test_various_percent.png)

## [model of phylogenetic bootstrap as a random draw of marbles](https://github.com/wrf/misc-analyses/tree/master/random_bootstrap) ##
A simple model about [bootstrapping in phylogenetics](https://en.wikipedia.org/wiki/Bootstrapping_%28statistics%29), showing that bootstrap replicates do not reflect the uncertainty in the data. This topic came up following the work of [Shen 2017](http://dx.doi.org/10.1038/s41559-017-0126).

![bootstrap_marble_example_v1_w_results.png](https://github.com/wrf/misc-analyses/blob/master/random_bootstrap/bootstrap_marble_example_v1_w_results.png)

## [oxygen usage in animals](https://github.com/wrf/misc-analyses/tree/master/animal_oxygen) ##
Data digitized from *Ecology and Evolution in Anoxic Worlds* by Fenchel and Finlay (1995).

![fenchel_finlay_1995_km_by_size.png](https://github.com/wrf/misc-analyses/blob/master/animal_oxygen/fenchel_finlay_1995_km_by_size.png)

## [bioluminescence spectra - on bitbucket](https://bitbucket.org/wrf/biolum-spectra) ##
Collection of bioluminescence spectra, some original, and some digitized from old papers

![cnidarian_spectra_v2.png](https://bitbucket.org/wrf/biolum-spectra/raw/81f1cc0661362493e195f7a94317b57548b36d84/cnidarian_spectra_v2.png)


