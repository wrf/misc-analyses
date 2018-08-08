# marine microbes #
Downloading and processing of the transcriptomes of the [Marine Microbial Eukaryote Transcriptome Sequencing Project](https://doi.org/10.1371/journal.pbio.1001889). This consists of 678 samples, with 16 million peptides summing to 5.5 billion amino acids.

All of the peptides for each sample can be downloaded using a for-loop-in-the-shell:

`for I in {1662..2522} ; do wget ftp://ftp.imicrobe.us/projects/104/samples/$I\/*.pep.fa.gz ; done`

After downloading the sample metadata sheet, run the script:

`sort_mmetsp_data.py sample-attr.tab *pep.fa.gz > sample_to_species.tab`

This will rename all `pep.fa.gz` files, to a fasta file for each species, where fasta headers are also changed for each species.

Other people have made code to download the raw data and re-assemble everything: by [jlcohen](https://github.com/ljcohen/MMETSP) and [dib-lab](https://github.com/dib-lab/dib-MMETSP). This might not be necessary.
