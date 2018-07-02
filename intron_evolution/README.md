# intron evolution #
A model of intron evolution, as a follow up to [Similar ratios of introns to intergenic sequence across animal genomes.](https://doi.org/10.1093/gbe/evx103)

The total amount of intronic bases and intergenic bases are linearly related to the total size of the genome. The similar ratio of introns and intergenic sequences suggests that, on average, the forces that shape the amount of intron and amount of intergenic sequence are the same, and operate in a random manner. In such case, this has certain predictions as to the distribution of the sizes of individual introns. The theory is that each intron is subject to random expansion, i.e. by insertions, transposition, replication errors.

![intron_expansion_model_v1.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/intron_expansion_model_v1.png)

In the Python implementation of the model, starting with 100k equally-sized introns, for 1 million iterations, replicated 10 times, it is run as follows. This mode (the default) gives an equal chance of expansion to all introns, regardless of size.

`./random_intron_expansion.py -i 1000000 -n 100000 -r 10 > random_1M_on_100k.10rep.tab`

As an intron of length 2l should be twice as likely of having a *de novo* insertion or replication error, using option `-e` allows for a changing probability, whereby the chance of elongation for an intron of length 2l should be double that of 1l.

`./random_intron_expansion.py -i 1000000 -n 100000 -r 10 -e > random_1M_on_100k_w_ex.10rep.tab`

Histograms of the final lengths are shown below. Under equal probability (orange), the distribution is normal, centered around 11l. This is created by 1M iterations over 100k introns, whereby the average expansion is 10l. However, under the "runaway expansion" version, almost 10% of the introns are the initial length, while many are dramatically longer. It should be noted that the mean length is the same, still 11l.

![random_intron_length_plot.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/random_intron_length_plot.png)

For real genomes, l would be some reasonable value, say 300bp, which is a convenient value for the length of an exon or of some repetitive elements (such as Alu). This would give the average initial intron size of 300bp, and final size of 3300bp, seen for genomes of around 1.5Gb.
