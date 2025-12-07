# model of bootstrapping #
As it is suggested that most sites in an alignment do not contribute phylogenetic information to all nodes, [some nodes are only resolved by a few sites](https://github.com/wrf/pdbcolor#raxml-site-wise-likelihood). This can be modeled as a dataset of appx. 20000 sites, where 200 favor one tree, and 150 favor the other. The magnitude of the favoring is ignored, thus is thought of as binary for this example (even though that varies by an order of magnitude).

Given this ratio of sites favoring the two trees (4 to 3), out of 1000 draws with replacement (as is normally done during bootstrapping), over 99% of bootstrap replicates will favor the first tree, giving the illusion that this tree is "robustly supported". This is precisely what was observed for [many controversial phylogenies](https://doi.org/10.1038/s41559-017-0126), though those authors had interpreted the 51-57% support for some nodes as being "robust", when this is obviously "marginal" or "tenuous" support.

![bootstrap_marble_example_v1_w_results.png](https://github.com/wrf/misc-analyses/blob/master/random_bootstrap/images/bootstrap_marble_example_v1_w_results.png)

![sample_twoway_1000x.png](https://github.com/wrf/misc-analyses/blob/master/random_bootstrap/images/sample_twoway_1000x.png)

In an actual resampling 1000 times of a [sitewise likelihood dataset](https://bitbucket.org/wrf/sitelogl/src/master/) (alignment from [Simion 2017](http://www.sciencedirect.com/science/article/pii/S0960982217301999)), the collective difference in likelihood is around 7000-8000. The total difference in sitewise likelihood is 44591. This is still a fraction of the total likelihood, which is -20099128 and -20106727, for ctenophore and porifera, respectively.

![sample_sLL_simion2017_1000x.png](https://github.com/wrf/misc-analyses/blob/master/random_bootstrap/images/sample_sLL_simion2017_1000x.png)

When summed across genes, there is a clear dominance of one hypothesis.

![simion2017_para-animals_v_porisis_genewise_sorted.png](https://github.com/wrf/misc-analyses/blob/master/random_bootstrap/images/simion2017_para-animals_v_porisis_genewise_sorted.png)

## python version ##
The original version of this was a Python model where sample results were generated simply by running it:

`python random_bootstrap.py`

This is now done in the Rscript `random_bootstrap_hist.R`.


