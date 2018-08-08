#!/usr/bin/env python
#
# sort_mmetsp_data.py

'''sort_mmetsp_data.py  last modified 2018-08-08
    process and rename samples from iMicrobe project 104, 
    script will process metadata, then rename headers in fasta files for all files

    Marine Microbial Eukaryote Transcriptome Sequencing Project: project 104
    https://www.imicrobe.us/#/projects/104

    script is run with this exact command:
sort_mmetsp_data.py sample-attr.tab *pep.fa.gz > sample_to_species.tab

    before beginning, download the sample metadata sheet from:
ftp://ftp.imicrobe.us/projects/104/

    fasta files of proteins can be downloaded in a single command:
for I in {1662..2522} ; do wget ftp://ftp.imicrobe.us/projects/104/samples/$I\/*.pep.fa.gz ; done

    some species were sequenced multiple times as different samples,
    making ~200 species for ~650 samples

    files are renamed as Genus_species_samplenum.prot.fasta
    if genus is not available, then family is used, order, class, phylum
    if species is not available, strain is used, then SRA number
'''

# ~/est/mmetsp_prots$ cat *.prot.fasta | sizecutter.py -n -q -
# Parsing sequences on <stdin>: Tue Aug  7 13:50:41 2018
# Counted 16784529 sequences:  Tue Aug  7 13:52:21 2018
# Total input letters is: 5505865486
# Average length is: 328.03
# Median length is: 241
# Shortest sequence is: 30
# Longest sequence is: 19885

import sys
import gzip
import time
from collections import defaultdict
from Bio import SeqIO

class Sample:
	def __init__(self, sample_name):
		self.name = sample_name
		self.attributes = {}
	def add_attr(self, feature, value):
		self.attributes[feature] = value

def process_samples(sample_data, name_counter):
	# either count, 
	if name_counter is None:
		only_count = True
		used_species = defaultdict(int) # key is name, value is number of usages
	else:
		only_count = False
		used_species = {} # key is sample name/number, value is species name

	# iterate through Sample objects
	for sample_name in sample_data:
		# reset flags
		get_family = False
		get_order = False

		# build up name depending on what is there
		genus = sample_data[sample_name].attributes.get("genus",None)
		if (genus is None) or (genus=="Genus nov.") or (genus=="non described") or (genus=="Unknown") or (genus=="Unidentified") or (genus=="unid.") or (genus=="unid") or (genus=="None"):
			family = sample_data[sample_name].attributes.get("family",None)
			genus = family
			if (family is None) or (family=="Unknown"):
				order = sample_data[sample_name].attributes.get("order",None)
				genus = order
				if (order is None) or (order=="Unknown"):
					class_sp = sample_data[sample_name].attributes.get("class",None)
					genus = class_sp
					if ( class_sp is None) or (class_sp=="Unknown"):
						phylum = sample_data[sample_name].attributes.get("phylum",None)
						genus = phylum
						if ( phylum is None) or (phylum=="Unknown"):
							genus = "Unknown_eukaryote"

		# use species name, or strain
		species = sample_data[sample_name].attributes.get("species",None)
		if (species is None) or (species=="species nov.") or (species=="sp.") or (species=="sp") or (species=="Sp") or (species=="cf sp") or (species=="Undescribed") or (species=="non described") or (species=="complex sp."):
			species = sample_data[sample_name].attributes.get("strain",None)
			if (species is None):
				species = sample_data[sample_name].attributes.get("NCBI SRA", "MISSING")
		
			# add specific corrections for weird names
			if species=="m":
				species = "strain-m"
		species = species.replace(" cf","").replace(" var. ","_").replace(" ","_").replace("/","-").replace(".","") # remove spaces in "ATCC 50986" type names, etc
		# either count the name, or assign it
		if only_count:
			finalname = "{}_{}".format( genus, species )
			used_species[finalname] += 1
		else: # reassign names including SRA if occurs more than once
			finalname = "{}_{}".format( genus, species )
			if name_counter.get(finalname) > 1: # meaning non-unique name
				sranum = sample_data[sample_name].attributes.get("NCBI SRA",None)
				finalname = "{}_{}_{}".format( genus, species, sranum)
			used_species[sample_name] = finalname
	return used_species

def read_samples(samplefile):
	sample_data = {}
	linecounter = 0
	print >> sys.stderr, "# parsing sample information from {}".format( samplefile )
	for line in open(samplefile,'r'):
		line = line.strip()
		if line:
			lsplits = line.split("\t")
			if lsplits[0]=="sample_id":
				continue
			linecounter += 1
			sample_name = lsplits[1]
			if sample_name in sample_data:
				pass
			else: # create new object
				sample_data[sample_name] = Sample(sample_name)
			attr_type = lsplits[2]
			attr_value = lsplits[3]
			sample_data[sample_name].add_attr( attr_type, attr_value )
	print >> sys.stderr, "# counted {} lines for {} samples".format( linecounter, len(sample_data) )
	return sample_data

if len(sys.argv) < 2:
	print >> sys.stderr, __doc__
else:
	# first parse species information
	sample_data = read_samples(sys.argv[1])

	# generate dictionary for renaming
	name_counts = process_samples( sample_data, None )
	sample_to_species = process_samples( sample_data, name_counts ) # key is sample ID, value is full species name

	# print sample to species id table
	for sample, species_id in sample_to_species.iteritems():
		print >> sys.stdout, "{}\t{}".format(sample, species_id)

	# rename fasta files
	for fastafile in sys.argv[2:]:
		sample_id = fastafile.split(".")[0]
		species_name = sample_to_species.get(sample_id)
		new_name = "{}_{}.prot.fasta".format(species_name, sample_id)
		print >> sys.stderr, "# reading prots from {}, renaming as {}".format( fastafile , new_name ), time.asctime()
		with gzip.open(fastafile,'r') as ff, open(new_name,'w') as nf:
			for line in ff:
				line = line.strip()
				if line[0]==">":
					seqid = line[1:].split(" ")[0]
					newid = ">{}_{}".format(species_name, seqid)
					print >> nf, newid
				else:
					print >> nf, line

samples = """
sample_id	sample_name	attr_type	attr_value
2468	MMETSP1325	GenBank BioSample	2740228
2468	MMETSP1325	NCBI SRA	SRS616875
2468	MMETSP1325	project_id	104
2468	MMETSP1325	source_mat_id	(MMETSP1325) Florenciella sp. - seawater
2468	MMETSP1325	sample_name	MMETSP1325
2468	MMETSP1325	latitude	-8.333333333
2468	MMETSP1325	longitude	-141.25
2468	MMETSP1325	habitat_name	marine habitat
2468	MMETSP1325	taxon_id	236786
2468	MMETSP1325	strain	RCC1007
2468	MMETSP1325	genus	Florenciella
2468	MMETSP1325	species	sp.
2468	MMETSP1325	family	Florenciellales
2468	MMETSP1325	depth	10
2468	MMETSP1325	sample_collection_site	Pacific Ocean
2468	MMETSP1325	class	Dictyochophyceae
2468	MMETSP1325	phylum	Ochrophyta
2468	MMETSP1325	assembly_accession_number	CAM_ASM_000708
2468	MMETSP1325	collection_date	29-OCT-04
2468	MMETSP1325	date_of_experiment	15-JAN-12
2468	MMETSP1325	day_portion_of_day_night_cycle_in_hours	12
2468	MMETSP1325	envo_term_for_habitat_primary_term	Aquatic: marine
2468	MMETSP1325	growth_medium	K
2468	MMETSP1325	investigation_type	EU
2468	MMETSP1325	light	80
2468	MMETSP1325	other_collection_site_info	Marquises islands
2468	MMETSP1325	sample_material	seawater
2468	MMETSP1325	experimental_salinity	35
2468	MMETSP1325	experimental_temperature	20
2468	MMETSP1325	fastq_file	/iplant/home/shared/imicrobe/projects/104/transcriptomes/MMETSP132/MMETSP1325.
fastq.tar
2468	MMETSP1325	night_portion_of_day_night_cycle_in_hours	12
2468	MMETSP1325	primary_citation	Le Gall, F., Rigaut-Jalabert, F., Marie, D., Garczareck, L., Viprey, M
., Godet, A. and Vaulot, D. (2008) Picoplankton diversity in the South-East Pacific Ocean from cultures. Biogeoscience
s 5: 203-214
2468	MMETSP1325	longhurst_province	SPSG
"""
