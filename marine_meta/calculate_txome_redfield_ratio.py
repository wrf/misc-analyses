#!/usr/bin/env python
#
# calculate_txome_redfield_ratio.py

'''calculate_txome_redfield_ratio.py  last modified 2020-05-04

    to parse peptides of Synechococcus elongatus
    https://www.ncbi.nlm.nih.gov/genome/430
./calculate_txome_redfield_ratio.py -p GCF_000010065.1_ASM1006v1_protein.faa.gz

    or using CDS transcripts predicted off the genome:
grep CDS GCF_000010065.1_ASM1006v1_genomic.gff > GCF_000010065.1_ASM1006v1_genomic.cds_only.gff

~/gffread-0.11.7.Linux_x86_64/gffread -g GCF_000010065.1_ASM1006v1_genomic.fna -x GCF_000010065.1_ASM1006v1_genomic.cds_only.fasta GCF_000010065.1_ASM1006v1_genomic.cds_only.gff

./calculate_txome_redfield_ratio.py -t GCF_000010065.1_ASM1006v1_genomic.cds_only.fasta
'''

import sys
import gzip
import argparse
import time
from collections import Counter
from Bio import SeqIO

#
#
amino_acid_C_counts = { "A":3, "C":3, "D":4, "E":5, "F":9, 
						"G":2, "H":6, "I":6, "K":7, "L":6, 
						"M":5, "N":4, "P":5, "Q":5, "R":6, 
						"S":3, "T":4, "V":5, "W":11, "Y":9, 
						"X":5 }
amino_acid_N_counts = { "A":1, "C":1, "D":1, "E":1, "F":1, 
						"G":1, "H":3, "I":1, "K":2, "L":1, 
						"M":1, "N":2, "P":1, "Q":2, "R":4, 
						"S":1, "T":1, "V":1, "W":2, "Y":1, 
						"X":1 }

# A C10H13N5O4
# T C10H14N2O5
# C C9H13N3O5
# G C10H13N5O5
# U C9H12N2O6
base_C_counts = {"A":10, "T":10, "C":9, "G":10, "U":9, 
				"S":9.5, "W":10, "R":10, "Y":9.5, "N":9.5, "X":9.5 }
base_N_counts = {"A":5, "T":2, "C":3, "G":5, "U":2, 
				"S":4, "W":3.5, "R":5, "Y":2.5, "N":3.5, "X":3.5 }
base_CN_ratio = {"A":2.0, "T":5.0, "C":3.0, "G":2.0, "U":4.5, 
				"S":2.375, "W":2.857, "R":2.0, "Y":3.8, "N":2.714, "X":2.714 }

def peptide_C_and_N(sequence):
	'''from an amino acid string, count and return integers of carbons and nitrogens'''
	carbon_count = 0
	nitrogen_count = 0
	aacounts = Counter(sequence)
	for AA in aacounts.keys():
		carbon_count += aacounts[AA] * amino_acid_C_counts.get(AA,0.0)
		nitrogen_count += aacounts[AA] * amino_acid_N_counts.get(AA,0.0)
	return carbon_count, nitrogen_count

def nucleotide_C_and_N(sequence):
	'''from an amino acid string, count and return integers of carbons and nitrogens'''
	carbon_count = 0
	nitrogen_count = 0
	basecounts = Counter(sequence)
	for base in basecounts.keys():
		carbon_count += basecounts[base] * base_C_counts.get(base,0.0)
		nitrogen_count += basecounts[base] * base_N_counts.get(base,0.0)
	return carbon_count, nitrogen_count

def parse_fasta_sequences(seqfile, lower_limit, upper_limit, is_peptides):
	# counters for proteins
	sequence_counter = 0
	min_cn_ratio = 100.0
	max_cn_ratio = 0.0
	# check for gzip
	if seqfile.rsplit('.',1)[-1]=="gz": # autodetect gzip format
		opentype = gzip.open
		sys.stderr.write("# Calculating C-to-N ratio of proteins from {} as gzipped\n".format(seqfile) )
	else: # otherwise assume normal open for fasta format
		opentype = open
		sys.stderr.write("# Calculating C-to-N ratio of proteins from {}\n".format(seqfile) )
	# begin parsing peptides
	for seqrec in SeqIO.parse(opentype(seqfile,'rt'),"fasta"):
		sequence_counter += 1
		seqlength = len(seqrec.seq)

		# get C N and P counts
		if is_peptides:
			C, N = peptide_C_and_N(seqrec.seq)
			P = 0
			c_to_n_ratio = 1.0 * C / N # convert to float
			c_to_p_ratio = 0
			n_to_p_ratio = 0
		else: # meaning is nucleotides
			C, N = nucleotide_C_and_N(seqrec.seq)
			P = seqlength
			c_to_n_ratio = 1.0 * C / N # convert to float
			c_to_p_ratio = 1.0 * C / P # convert to float
			n_to_p_ratio = 1.0 * N / P # convert to float

		# check for new min or max
		if c_to_n_ratio < min_cn_ratio:
			min_cn_ratio = c_to_n_ratio
		if c_to_n_ratio > max_cn_ratio:
			max_cn_ratio = c_to_n_ratio

		# filter low and high
		if lower_limit <= c_to_n_ratio <= upper_limit:
			outline = "{}\t{}\t{}\t{}\t{}\t{:.4f}\t{:.4f}\t{:.4f}\n".format(seqrec.id, seqlength, C, N, P, c_to_n_ratio, c_to_p_ratio, n_to_p_ratio)
			sys.stdout.write(outline)

	# report overall stats
	sys.stderr.write("# Counted {} sequences\n".format(sequence_counter) )
	sys.stderr.write("# C-to-N ratios varied from {:.4f} to {:.4f}\n".format(min_cn_ratio, max_cn_ratio) )
	# no return

def main(argv, wayout):
	if not len(argv):
		argv.append("-h")
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-p', '--proteins', metavar='FASTA', help="fasta file of peptides, names must match transcriptome and counts")
	parser.add_argument('-t', '--transcripts', metavar='FASTA', help="fasta file of transcripts, names must match proteins and counts")
	parser.add_argument('-a', '--above', type=float, metavar='N.N', default=0.0, help="only print sequences with C-N ratio greater than N [0.0]")
	parser.add_argument('-b', '--below', type=float, metavar='N.N', default=100.0, help="only print sequences with C-N ratio less than N [100.0]")
	args = parser.parse_args(argv)

	if args.proteins:
		parse_fasta_sequences(args.proteins, args.above, args.below, True)

	if args.transcripts:
		parse_fasta_sequences(args.transcripts, args.above, args.below, False)

if __name__ == "__main__":
	main(sys.argv[1:],sys.stdout)

