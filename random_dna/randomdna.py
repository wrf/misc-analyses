#!/usr/bin/env python
#
# v1 basic random dna functions

'''
    generates random DNA sequences in fasta format
randomdna.py -l 1000 -n 100 > random_seqs.fasta

    selection is unweighted, to make appx 40 percent GC
randomdna.py -l 1000 -a AAATTTGGCC -n 100 > random_seq.fasta
'''

import sys
import argparse
import time
import random

def make_random_string(n, alphabet):
	rs = ""
	for i in range(n):
		rs += random.choice(alphabet)
	return rs

def wrap_sequence(sequence, wrap=60):
	# space out the string with line breaks every n characters, each '\n' counts as one character
	spacedseq = "".join(sequence[i:i+wrap] + "\n" for i in xrange(0,len(sequence), wrap))
	return spacedseq

def main(argv, wayout):
	if not len(argv):
		argv.append("-h")
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-a','--alphabet', help="letters to use [ATGC]", default="ATGC")
	parser.add_argument('-l','--length', type=int, metavar="N", help="random sequence length", default=10)
	parser.add_argument('-n','--number', type=int, metavar="N", help="number of sequences to generate", default=1)
	parser.add_argument('-t','--tag', help="sequence header tag [random]", default="random")
	args = parser.parse_args(argv)

	for i in range(args.number):
		print >> sys.stdout, ">{}_{}".format(args.tag, i)
		randomseq = make_random_string(args.length, args.alphabet)
		sys.stdout.write( wrap_sequence(randomseq) )

if __name__ == "__main__":
	main(sys.argv[1:],sys.stdout)
