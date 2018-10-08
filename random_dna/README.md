# random DNA and proteins #

One million random DNA sequences of 1000bp each can be generated with `randomdna.py`, where options `-l` is the length (here 1000bp) and `-n` is the number of sequences. Option `-a` specifies the drawing set, where `ATGC` is four letters of equal probability, meaning 50% GC content on average. The file produced by this operation is around 1Gb.

```
randomdna.py -a ATGC -l 1000 -n 1000000 -t random_50gc > random_50gc_nucl.fasta

randomdna.py -a AAATTTGGCC -l 1000 -n 1000000 -t random_40gc > random_40gc_nucl.fasta

randomdna.py -a AATTGGGCCC -l 1000 -n 1000000 -t random_60gc > random_60gc_nucl.fasta
```

The random DNA sets [can be translated](https://bitbucket.org/wrf/sequences/src), in this case only taking the longest protein across all 6 frames. Peptides without a starting **ATG**/**M** are ignored. Thus, the longest peptide means the longest predicted peptide from M to the next stop codon in any frame. Ties occur around 2-3% of the time, and both are kept.

```
prottrans.py random_40gc_nucl.fasta > random_40gc_prot.fasta

prottrans.py random_50gc_nucl.fasta > random_50gc_prot.fasta

prottrans.py random_60gc_nucl.fasta > random_60gc_prot.fasta
```

The [lengths of the predicted peptides](https://bitbucket.org/wrf/sequences/src) are calculated and used to generate a histogram for each set of peptides. A maximum length is defined with `-M`, where 350 is used for convenience (no protein from 1000bp could be longer than 332 AAs).

```
sizecutter.py -H -M 350 -q random_40gc_prot.fasta > random_40gc_prot.hist

sizecutter.py -H -M 350 -q random_50gc_prot.fasta > random_50gc_prot.hist

sizecutter.py -H -M 350 -q random_60gc_prot.fasta > random_60gc_prot.hist
```

A histogram of lengths is then plotted. It is clear that AT-rich genomes would have shorter random peptides on average when compared to GC-rich, likely due to increased chance of getting the stop codon **TAA**.

![random_hist_comparison.png](https://github.com/wrf/misc-analyses/blob/master/random_dna/random_hist_comparison.png)
