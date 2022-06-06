# diversity dependence solely on species number #

[Shannon diversity](https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/shannon.htm) calculated as:

`H = -1 * sum(p * log(p))`

The index is not asymptotic, so it will increase infinitely as more species are added. About 20k-30k species are needed to get to an index of 10, which is impractical to count for anything other than microbes with amplicon sequencing. Additionally, it was argued from the [Earth Microbiome Project](https://en.wikipedia.org/wiki/Earth_Microbiome_Project) by [Thompson 2017](https://doi.org/10.1038/nature24621) that many habitats are nested in such a way that species-rich habitats include many of the species of species-poor habitats.

![shannon_diversity_model_v1.png](https://github.com/wrf/misc-analyses/blob/master/eco_diversity/images/shannon_diversity_model_v1.png)


