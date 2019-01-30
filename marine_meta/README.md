# marine microbes #
Downloading and processing of the transcriptomes of the [Marine Microbial Eukaryote Transcriptome Sequencing Project](https://www.imicrobe.us/#/projects/104) ( paper by [Keeling et al 2014](https://doi.org/10.1371/journal.pbio.1001889) ). This consists of 678 samples, with 16 million peptides summing to 5.5 billion amino acids. See `ftp://ftp.imicrobe.us/projects/104/` for individual samples.

![sample-attr_oceanography.png](https://github.com/wrf/misc-analyses/blob/master/marine_meta/sample-attr_oceanography.png)

![sample-attr_world_map.png](https://github.com/wrf/misc-analyses/blob/master/marine_meta/sample-attr_world_map.png)

All of the peptides for each sample can be downloaded using a for-loop-in-the-shell:

`for I in {1662..2522} ; do wget ftp://ftp.imicrobe.us/projects/104/samples/$I\/*.pep.fa.gz ; done`

After downloading the sample metadata sheet, run the script:

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

