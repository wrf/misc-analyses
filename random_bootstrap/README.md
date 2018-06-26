# model of bootstrapping #
As it is suggested that most sites in an alignment do not contribute phylogenetic information to all nodes, [some nodes are only resolved by a few sites](https://github.com/wrf/pdbcolor#raxml-site-wise-likelihood). This can be modeled as a dataset of appx. 20000 sites, where 200 favor one tree, and 150 favor the other. The magnitude of the favoring is ignored, thus is thought of as binary for this example.

Given this ratio of sites favoring the two trees (4 to 3), out of 1000 draws with replacement (as is normally done during bootstrapping), over 99% of bootstrap replicates will favor the first tree, giving the illusion that this tree is "robustly supported". This is precisely what was observed for [many controversial phylogenies](https://doi.org/10.1038/s41559-017-0126), though those authors had interpreted the 51-57% support for some nodes as being "robust", when this is obviously "marginal" or "tenuous" support.

![bootstrap_marble_example_v1_w_results.png](https://github.com/wrf/misc-analyses/blob/master/random_bootstrap/bootstrap_marble_example_v1_w_results.png)

Sample results were generated with the Python script:

`python random_bootstrap.py`

