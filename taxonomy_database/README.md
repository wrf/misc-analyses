# taxonomy database #
The master list of the transcriptome shotgun archive can be found below, though the embedded links only download a GenBank format file:

`ftp://ftp.ddbj.nig.ac.jp/ddbj_database/tsa/TSA_ORGANISM_LIST.html`

Gzipped FASTA-format files can also be downloaded at the [NCBI Trace archive](https://www.ncbi.nlm.nih.gov/Traces/wgs/), by species name (e.g. *Hormiphora californensis*) or the 4-letter accessions (like GGLO01).

This currently contains transcriptomes of:

![sra_trace_species_list_2018-04-05.png](https://github.com/wrf/misc-analyses/blob/master/taxonomy_database/sra_trace_species_list_2018-04-05.png)

## adding kingdom etc ##
To add kingdom, phylum and class ranks to this table, so it can be more easily searched. Copy the `organism` column to a text file (here this is named as `sra_trace_species_list_2018-04-05.txt`). Then run:

`parse_ncbi_taxonomy.py -n names.dmp -o nodes.dmp -i sra_trace_species_list_2018-04-05.txt > sra_trace_species_w_phyla_2018-04-05.txt`

NCBI Taxonomy files can be downloaded at from the `taxdump.tar.gz` file at:

`ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/`

## using CSV from NCBI WGS ##
On the [trace archive](https://www.ncbi.nlm.nih.gov/Traces/wgs/?page=1&view=tsa), select only the `TSA` projects, and download the file `wgs_selector.csv` (renaming as desired).

Extract the names with `cut`, using `grep` to remove the header line `organism_an`:

`cut -f 5 -d , wgs_selector_tsa_only_2018-08-23.csv | grep -v organism_an > wgs_selector_tsa_only_2018-08-23.names_only`

Then use the names and the taxonomy files to regenerate the table including kingdom:

`parse_ncbi_taxonomy.py -i wgs_selector_tsa_only_2018-08-23.names_only -n ~/db/taxonomy/names.dmp -o ~/db/taxonomy/nodes.dmp --header > wgs_selector_tsa_only_2018-08-23.w_kingdom.tab`

Then generate the summary barplot:

`Rscript taxon_barplot.R wgs_selector_tsa_only_2018-08-23.w_kingdom.tab`

## rapid downloading and renaming ##
Assemblies can be downloaded directly from the NCBI FTP using `wget`, which can be called through the script `download_ncbi_tsa.py`. The only input requirement (`-i`) is a file of the accession numbers.

`download_ncbi_tsa.py -i download_codes.txt`

The download codes are the 4-letter accessions, with one accession per line. Only the first 4 characters are used, so the names can be directly copied out of the table, and pasted into a text file like:

```
GAUS.gz
GAUU.gz
GAVC.gz
```

With each download, the FASTA headers are changed and written into a new file, in the format of `Genus_species_XXXX01.renamed.fasta`, where `XXXX` is the accession number. For example, from `GFGY01.1.fsa_nt.gz`, a new file would be made named `Paramacrobiotus_richtersi_GFGY01.renamed.fasta`, and the FASTA header of first sequence:

```
$ gzip -dc GFGY01.1.fsa_nt.gz | head
>GFGY01000001.1 TSA: Paramacrobiotus richtersi comp116965_c2 transcribed RNA sequence
```

would be changed to:

```
$ head Paramacrobiotus_richtersi_GFGY01.renamed.fasta
>Paramacrobiotus_richtersi_comp116965_c2
```

to preserve the information from Trinity components and allow better downstream identification of splice variants (perhaps from BLAST hits). This works for the vast majority of transcriptomes, which are assembled with Trinity, though it may be necessary to confirm for each sample.

## for all of NCBI SRA ##
At the time of writing (May 2018) [NCBI SRA](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi) contains over 3.5M entries, accounting for 6 petabases. Chordates (so probably human samples, or mouse) account for over 1.3 million of those, and "uncategorized" samples (probably environmental metagenomic samples) account for almost 1 million.

![NCBI_SRA_Metadata_Full_20180402.ncbi_ids_w_kingdom.png](https://github.com/wrf/misc-analyses/blob/master/taxonomy_database/NCBI_SRA_Metadata_Full_20180402.ncbi_ids_w_kingdom.png)

The entire [metadata library of SRA can be downloaded](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=mirroring), and then parsed directly from the `.tar.gz` file (which is 1.8Gb). Reading from the archive took a long time (rather slowly over several days with 1 CPU). This generates a 4-column table containing: sample name, the SRA number, the NCBI Taxonomy number, the scientific name (species or environment).

`parse_sra_metadata.py NCBI_SRA_Metadata_Full_20180402.tar.gz > NCBI_SRA_Metadata_Full_20180402.samples.tab`

This would look like:

```
PNUSAE012016	SRS3075518	562	Escherichia coli
2672F-sc-2013-07-18T13:25:16Z-1668979	ERS327577	1773	Mycobacterium tuberculosis
PRJEB19319	ERS1543308	182710	Oceanobacillus iheyensis
```

Because the NCBI taxonomy numbers are also given, rather than just samples, those can be used instead to index the nodes in the taxonomy tree. The NCBI IDs (numbers) are extracted with the shell command `cut`, taking the third column:

`cut -f 3 NCBI_SRA_Metadata_Full_20180402.samples.tab > NCBI_SRA_Metadata_Full_20180402.ncbi_ids.txt`

This is then processed as above from the taxonomy database to make a 4-column table, of species name, kingdom, phylum and class. This can be added to any existing spreadsheet or processed into the barplot. Here, the numbers are used as input by adding the option `--numbers` to `parse_ncbi_taxonomy.py`.

`parse_ncbi_taxonomy.py -i NCBI_SRA_Metadata_Full_20180402.ncbi_ids.txt -n ~/db/taxonomy/names.dmp -o ~/db/taxonomy/nodes.dmp ~/db/taxonomy/merged.dmp --numbers --header > NCBI_SRA_Metadata_Full_20180402.ncbi_ids_w_kingdom.tab`

As the above command had counted each sample separately, species can instead be combined to give a sense of the species diversity. This is done by adding the `--unique` option to the `parse_ncbi_taxonomy.py` script.

`parse_ncbi_taxonomy.py -i NCBI_SRA_Metadata_Full_20180402.ncbi_ids.txt -n ~/db/taxonomy/names.dmp -o ~/db/taxonomy/nodes.dmp ~/db/taxonomy/merged.dmp --numbers --header --unique > NCBI_SRA_Metadata_Full_20180402.unique_ncbi_ids_w_king.tab`

The Rscript then creates the graph, displaying a similar pattern to the number of samples.

`Rscript taxon_barplot.R NCBI_SRA_Metadata_Full_20180402.unique_ncbi_ids_w_king.tab`

![NCBI_SRA_Metadata_Full_20180402.unique_ncbi_ids_w_king.png](https://github.com/wrf/misc-analyses/blob/master/taxonomy_database/NCBI_SRA_Metadata_Full_20180402.unique_ncbi_ids_w_king.png)
