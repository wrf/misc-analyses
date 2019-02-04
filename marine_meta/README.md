# marine microbes #
Downloading and processing of the transcriptomes of the [Marine Microbial Eukaryote Transcriptome Sequencing Project](https://www.imicrobe.us/#/projects/104) ( paper by [Keeling et al 2014](https://doi.org/10.1371/journal.pbio.1001889) ). This consists of 678 samples, with 16 million peptides summing to 5.5 billion amino acids. See `ftp://ftp.imicrobe.us/projects/104/` for individual samples.

![sample-attr_oceanography.png](https://github.com/wrf/misc-analyses/blob/master/marine_meta/sample-attr_oceanography.png)

![sample-attr_world_map.png](https://github.com/wrf/misc-analyses/blob/master/marine_meta/sample-attr_world_map.png)

All of the peptides for each sample can be downloaded using a for-loop-in-the-shell:

`for I in {1662..2522} ; do wget ftp://ftp.imicrobe.us/projects/104/samples/$I\/*.pep.fa.gz ; done`

After downloading the sample metadata sheet (at `ftp://ftp.imicrobe.us/projects/104/sample-attr.tab.gz`), run the script:

`sort_mmetsp_data.py sample-attr.tab *pep.fa.gz > sample_to_species.tab`

This will rename all `pep.fa.gz` files, to a fasta file for each species, where fasta headers are also changed for each species.

For example, headers in `MMETSP1451.pep.fa.gz` look like:

```
>CAMPEP_0198395734 /NCGR_PEP_ID=MMETSP1451-20131203|47560_1 /TAXON_ID=1169540 /ORGANISM="Vitrella brassicaformis, Strain CCMP3346" /LENGTH=155 /DNA_ID=CAMNT_0044112673 /DNA_START=1 /DNA_END=463 /DNA_ORIENTATION=+
>CAMPEP_0198395736 /NCGR_PEP_ID=MMETSP1451-20131203|47563_1 /TAXON_ID=1169540 /ORGANISM="Vitrella brassicaformis, Strain CCMP3346" /LENGTH=235 /DNA_ID=CAMNT_0044112675 /DNA_START=21 /DNA_END=728 /DNA_ORIENTATION=-
>CAMPEP_0198395738 /NCGR_PEP_ID=MMETSP1451-20131203|47566_1 /TAXON_ID=1169540 /ORGANISM="Vitrella brassicaformis, Strain CCMP3346" /LENGTH=71 /DNA_ID=CAMNT_0044112677 /DNA_START=1 /DNA_END=213 /DNA_ORIENTATION=-
>CAMPEP_0198395740 /NCGR_PEP_ID=MMETSP1451-20131203|47571_1 /TAXON_ID=1169540 /ORGANISM="Vitrella brassicaformis, Strain CCMP3346" /LENGTH=93 /DNA_ID=CAMNT_0044112679 /DNA_START=1 /DNA_END=278 /DNA_ORIENTATION=-
>CAMPEP_0198395742 /NCGR_PEP_ID=MMETSP1451-20131203|47572_1 /TAXON_ID=1169540 /ORGANISM="Vitrella brassicaformis, Strain CCMP3346" /LENGTH=104 /DNA_ID=CAMNT_0044112681 /DNA_START=1 /DNA_END=310 /DNA_ORIENTATION=+
```

The file `Vitrella_brassicaformis_MMETSP1451.prot.fasta` will be automatically produced, and the headers will be renamed to include the species name (if given) and the original peptide ID:

```
>Vitrella_brassicaformis_CAMPEP_0198395734
>Vitrella_brassicaformis_CAMPEP_0198395736
>Vitrella_brassicaformis_CAMPEP_0198395738
>Vitrella_brassicaformis_CAMPEP_0198395740
>Vitrella_brassicaformis_CAMPEP_0198395742
```

Other people have made code to download the raw data and re-assemble everything: by [jlcohen](https://github.com/ljcohen/MMETSP) and [dib-lab](https://github.com/dib-lab/dib-MMETSP). This might not be necessary.

## best hits against swissprot
Here I use a subset of [SwissProt](https://www.uniprot.org/downloads), containing *E. coli*, *Arabidopsis*, *Saccharomyces* and human proteins. These are generally better annotated than other species, and it is better to have some weak annotation than a strong match to a closer but unannotated spcies.

The search program [diamond](https://github.com/bbuchfink/diamond) is used, as it is faster, but gives mostly the same matches as blast in the same 12-column format.

`~/diamond-linux64/diamond makedb --in model_organism_uniprot.fasta -d model_organism_uniprot.fasta`

A for-loop-in-the-shell is used to match each file against the model database, taking about 10 seconds per sample when using 8 CPUs (default is all).

`for FILE in *.prot.fasta ; do BASE="${FILE%.prot.fasta}" ; ~/diamond-linux64/diamond blastp -d ~/db/model_organism_uniprot.fasta -q $FILE -o $BASE.dmnd_v_swiss.tab ; done`

Another loop is then used to filter the diamond results and generate a conversion vector file - a tab-delimited text file of the old name and the new name. This requires the script [annotatefromblast.py](https://bitbucket.org/wrf/sequences/src/master/annotatefromblast.py). The filtering thresholds (`-l`, `-b` and `-B`) are lowered from defaults, as the database contains only model organisms, none of which are closely related to the query sequences. The option `--mmetsp` is used to give a special output format for the conversion vector.

`for FILE in *.prot.fasta ; do BASE="${FILE%.prot.fasta}" ; annotatefromblast.py -i $BASE.dmnd_v_swiss.tab -q $FILE -d ~/db/model_organism_uniprot.fasta -l 0.5 -b 50 -B 500 --mmetsp > $BASE.prot.annotation.tab ; done`

The conversion vectors are used to rename the original proteins, using the [rename_select_fasta.py](https://bitbucket.org/wrf/sequences/src/master/rename_select_fasta.py) script.

`for FILE in *.prot.fasta ; do BASE="${FILE%.prot.fasta}" ; rename_select_fasta.py $BASE.prot.annotation.tab $FILE  > $BASE.prot.w_annotation.fasta ; done`

## notes
* `Unknown_eukaryote_CCMP2111_MMETSP1446` now appears to be named as a species of *Chloropicon sp*, as per [Lopes-dos Santos 2017](https://doi.org/10.1038/s41598-017-12412-5)
* `Unknown_eukaryote_CCMP2175_MMETSP1470` is now a strain of *Chloropicon laureae*, as per [Lopes-dos Santos 2017](https://doi.org/10.1038/s41598-017-12412-5)
