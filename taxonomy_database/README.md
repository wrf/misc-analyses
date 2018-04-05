# taxonomy database #
The master list of the transcriptome shotgun archive can be found here:

`ftp://ftp.ddbj.nig.ac.jp/ddbj_database/tsa/TSA_ORGANISM_LIST.html`

This currently contains:

![sra_trace_species_list_2018-04-05.png](https://github.com/wrf/misc-analyses/blob/master/taxonomy_database/sra_trace_species_list_2018-04-05.png)

## adding kingdom etc ##
To add kingdom, phylum and class ranks to this table, so it can be more easily searched. Copy the `organism` column to a text file (here this is named as `sra_trace_species_list_2018-04-05.txt`). Then run:

`parse_ncbi_taxonomy.py -n names.dmp -o nodes.dmp -i sra_trace_species_list_2018-04-05.txt > sra_trace_species_w_phyla_2018-04-05.txt`

NCBI Taxonomy files can be downloaded at from the `taxdump.tar.gz` file at:

`ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/`

