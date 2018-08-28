# intron evolution #
A model of intron evolution, as a follow up to Francis and Wörheide (2017) [Similar ratios of introns to intergenic sequence across animal genomes.](https://doi.org/10.1093/gbe/evx103)

The total amount of intronic bases and intergenic bases are linearly related to the total size of the genome. The similar ratio of introns and intergenic sequences suggests that, on average, the forces that shape the amount of intron and amount of intergenic sequence are the same, and operate in a random manner. In such case, this has certain predictions as to the distribution of the sizes of individual introns. The theory is that each intron is subject to random expansion, i.e. by insertions, transposition, or replication errors. Here I implement a Python model to randomly expand introns in a hypothetical genome. This will start with a number N of introns of length 1l, running for i iterations. With each iteration, a random intron is elongated by 1l. Deletions are not considered, and all intron expansions are the same size (i.e. no difference between LINEs and SINEs).

![intron_expansion_model_v1.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/intron_expansion_model_v1.png)

An example is used starting with 100k equally-sized introns (of size 1l), for 1 million iterations, replicated 10 times. This mode (the default) gives an equal chance of expansion to all introns, regardless of size. To my knowledge, there is no evidence that this happens, or any proposed mechanism, but potentially this would be the expected pattern if the expansion were somehow restricted to something like the exon-intron junction, since every intron has exactly two exon-intron boundaries. This is run as follows, and produces a tab-delimited output file where each column is a replicate:

`./random_intron_expansion.py -i 1000000 -n 100000 -r 10 > random_1M_on_100k.10rep.tab`

However, in the alternative model shown in the figure above, an intron of length 2l should be twice as likely of having a *de novo* insertion or replication error. Overall, this expects that larger introns should become larger still, while a number of introns stay short. In the command line, this is done using option `-e`, which allows for a changing probability with each iteration whereby the chance of elongation for an intron of length 2l should be double that of 1l.

`./random_intron_expansion.py -i 1000000 -n 100000 -r 10 -e > random_1M_on_100k_w_ex.10rep.tab`

Histograms of the final lengths are shown below. Under equal probability (orange), the distribution is normal, centered around 11l. This is created by 1M iterations over 100k introns, whereby the average expansion is 10l. However, under the "runaway expansion" version, almost 10% of the introns are the initial length, while many are dramatically longer than the mean. It should be noted that the mean length is the same, still 11l, as the other model.

![random_intron_length_plot.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/random_intron_length_plot.png)

For real genomes, 1l would be some reasonable value like 300bp, which is a convenient value for the length of an exon or of some repetitive elements (such as Alu). This would give the average initial intron size of 300bp, and final size of 3300bp, seen for genomes of around 1.5Gb.

For a larger genome, like human, the total size is 3.2Gb, which predicts an average intron length around 6500bp. Precise intron information can be extracted directly from the [human genome GFF annotation file](https://www.ncbi.nlm.nih.gov/genome/51?genome_assembly_id=368248) using the [Python script](https://bitbucket.org/wrf/sequences/src) `gtfstats.py`.

`gtfstats.py -i ~/genomes/human/GCF_000001405.37_GRCh38.p11_genomic.gff.gz --print-introns > human_introns.tab`

The intron size distribution clearly resembles the length-dependent model, indicating the main determinants of intron size are random indels, subject to runaway expansion, and ultimately consistent with the model of insertions and deletions proposed by [Petrov 2002](https://doi.org/10.1006/tpbi.2002.1605).

![human_GRCh38_intron_hist.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/human_GRCh38_intron_hist.png)

For an even larger genome, like the 32Gb genome of the axolotl [*Ambystoma mexicanum*](https://www.axolotl-omics.org/), the measured average intron size is 42kb. A sixth of the introns are 1kb or shorter (47k out of 283k in the GFF file). It is again evident that the average size is driven by a small number of extremely long introns.

![Am_34_intron_hist.png](https://github.com/wrf/misc-analyses/blob/master/intron_evolution/Am_34_intron_hist.png)
