#!/usr/bin/env python
#
# download_ncbi_tsa.py  created 2018-05-04

'''download_ncbi_tsa.py  last modified 2018-09-03
  download NCBI transcriptome assemblies and rename fasta sequences

download_ncbi_tsa.py -i arachnida_codes

    codes file contains 1 code per line, as:
GANL.gz
GANP
GFVZ.gz
# comments are allowed
...

    check that all automatically assigned names are correct:
head -n 1 *renamed.fasta

    translate all sequences in a single command using:
for FILE in *.renamed.fasta ; do BASE="${FILE%.renamed.fasta}"; prottrans.py -a 50 $FILE | commonseq.py -1 - -e > $BASE.prot.fasta ; done
'''

import sys
import subprocess
import time
import os
import argparse
import gzip

def make_wget_command(ncbicode):
	'''make command for wget'''
	# ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GF/GY/GFGY01/GFGY01.1.fsa_nt.gz
	codesplits = [ncbicode[0:2], ncbicode[2:4], ncbicode[0:4], ncbicode[0:4]]
	wgetstring = "ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/{}/{}/{}01/{}01.1.fsa_nt.gz".format(*codesplits)
	return wgetstring

def run_wget(wgetstring):
	'''run wget as subprocess'''
	wget_args = ["wget", wgetstring]
	print >> sys.stderr, "Making system call:\n{}".format( " ".join(wget_args) )
	subprocess.call(wget_args)
	# no return

def main(argv, wayout):
	if not len(argv):
		argv.append('-h')
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-i','--input', help="text file of species codes, one per line (e.g. GGLO)")
	args = parser.parse_args(argv)

	species_collected = {}
	errorcount = 0
	filecollector = []
	print >> sys.stderr, "# reading species IDs from {}".format(args.input), time.asctime()
	for line in open(args.input,'r'):
		line = line.strip()
		if line and line[0]!="#": # ignore empty and comment lines
			speciescode = line[0:4] # chop any endings like .gz or 01
			if speciescode in species_collected:
				print >> sys.stderr, "# SKIPPING CODE {}, ALREADY DOWNLOADED".format(speciescode)
				continue
			dlfile = "{}01.1.fsa_nt.gz".format(speciescode)
			wgetstring = make_wget_command(line[0:4])
			#print >> sys.stdout, wgetstring
			run_wget(wgetstring)
			if os.path.exists(dlfile) and os.path.isfile(dlfile):
				species_collected[speciescode] = True
				print >> sys.stderr, "# downloaded {}, renaming sequences".format(dlfile), time.asctime()
				with gzip.open(dlfile,'r') as gf:
					firstline = gf.next()
				firstheader = firstline.split()
				speciesname = "{}_{}".format(*firstheader[2:4]).replace(".","") # replace . for cases of sp.
				renamedfile = "{}_{}01.renamed.fasta".format(speciesname, speciescode)
				with open(renamedfile,'w') as rf:
					for gfline in gzip.open(dlfile,'r'):
						gfline = gfline.strip()
						if gfline[0]==">":
							headersplits = gfline.split()
						#	genus, species, comp = headersplits[2:5]
							newheader = ">{}_{}_{}".format( *headersplits[2:5] )
							newheader = newheader.replace("TRINITY_","")
							newheader = newheader.replace("Locus_","l")
							newheader = newheader.replace("Transcript_","t")
							newheader = newheader.replace(":","_")
							newheader = newheader.replace(".","_")
							newheader = newheader.replace("/","_")
							print >> rf, newheader
						else:
							print >> rf, gfline
					filecollector.append(renamedfile)
			else:
				errorcount += 1
	print >> sys.stderr, "# found data for {} codes, could not find for {}".format( len(species_collected), errorcount), time.asctime()
	print >> sys.stderr, "# renamed sequences for:\n{}".format( "\n".join(filecollector) )

if __name__ == "__main__":
	main(sys.argv[1:], sys.stdout)
