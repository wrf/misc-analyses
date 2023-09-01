# diversity dependence solely on species number #

### model ###
[Shannon diversity](https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/shannon.htm) `H` is calculated as:

`H = -1 * sum(p * log(p))`

where `p` is the proportion of each species in the sample.

The index is not asymptotic, so it will increase infinitely as more species are added. About 20k-30k species are needed to get to an index of 10, which is impractical to count for anything other than microbes with amplicon sequencing. There are about 10k species of birds globally, and about 35k species of fish globally. For comparison, there are currently (Jan-2023) 26k [prokaryotic 16S sequences on RefSeq](https://www.ncbi.nlm.nih.gov/nuccore?term=33175%5BBioProject%5D+OR+33317%5BBioProject%5D). This does not include uncharacterized species, which could be orders of mangitude more abundant.

It was argued from the [Earth Microbiome Project](https://en.wikipedia.org/wiki/Earth_Microbiome_Project) by [Thompson 2017](https://doi.org/10.1038/nature24621) that many habitats are nested in such a way that species-rich habitats include many of the species of species-poor habitats.

![shannon_diversity_model_v2.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/shannon_diversity_model_v2.png)

Evenness `J` is calculated then as:

`J = Hn / H1`

where `Hn` is measured diversity index, and `H1` is the diversity where all species are equal

![evenness_model_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/evenness_model_v1.png)

### real data ###
In a real world example from the sponge microbiome by [Schuster 2021](https://doi.org/10.1128/msphere.00991-20), an increase of 1 unit of Shannon diversity is associated about roughly a 2-fold increase in species number. In other examples, one unit of diversity index is closer to a 3-fold change.

![ireland_otus_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/ireland_otus_vs_diversity_index_v1.png) ![busch2022_species_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/busch2022_species_vs_diversity_index_v1.png) 
![aronson2016_otus_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/aronson2016_otus_vs_diversity_index_v1.png) ![junqueira2017_otus_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/junqueira2017_otus_vs_diversity_index_v1.png)
![blyton2019_otus_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/blyton2019_otus_vs_diversity_index_v1.png) ![albert2015_otus_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/albert2015_otus_vs_diversity_index_v1.png)

Point size was proporitional to the number of reads per sample. This is replotted another way below, showing that more reads does not strongly affect the diversity index, that is, more reads of a lower diversity sample is only resampling the species that have already been found. This is evident in other studies as well.

![ireland_sponge_reads_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/ireland_sponge_reads_vs_diversity_index_v1.png) ![busch2022_sample_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/busch2022_sample_diversity_index_v1.png) ![albert2015_reads_vs_diversity_index_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/albert2015_reads_vs_diversity_index_v1.png)



