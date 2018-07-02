#!/usr/bin/env python
#
# random_intron_expansion.py v1 created 2018-06-25

'''random_intron_expansion.py v1 last modified 2018-07-02

    generate table of intron lengths, as multiples of an arbitrary length n
    for example
     one iteration on 10 introns would result in 9 introns of length n
     and one intron of length 2n

random_intron_expansion.py -i 1000000 > intron_n_length_histogram.tab

'''

import sys
import random
import argparse
from collections import Counter,defaultdict

def main(argv, wayout):
	if not len(argv):
		argv.append('-h')
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-i','--iterations', type=int,  help="number of iterations [1000000]", required=True)
	parser.add_argument('-n','--number', type=int, default=100000, help="starting number of introns [100000]")
	parser.add_argument('-r','--replicates', type=int,  default=1, help="number of replicates [1]")
	parser.add_argument('-e','--elongate', action="store_true", help="elongate introns with each iteration")
	args = parser.parse_args(argv)

	if args.replicates < 1:
		sys.exit("ERROR: must have more than 0 replicates, -r {} given".format(args.replicates) )

	replist = defaultdict(list) # key is length, value is list of integers
	repstrings = []
	maxlength = 0

	# repeat entire process as replicates
	for rep in range(args.replicates):
		print >> sys.stderr, "# Starting random length increase replicate {}, for {} iterations of {} initial introns".format( rep+1, args.iterations, args.number)
		repstrings.append( "rep{}".format(rep+1) )
		if args.elongate:
			print >> sys.stderr, "# extending introns with each iteration"

		# initialize lengths
		randomcounts = {} # key is identifier number of intron, value is accumulated length
		for i in xrange(args.number):
			randomcounts[i] = 1

		# build list of intron lengths, and iterate random selection
		intronindex = range(args.number)
		for i in xrange(args.iterations):
			randomindex = random.choice(intronindex)
			randomcounts[randomindex] = randomcounts.get(randomindex) + 1
			if args.elongate:
				intronindex.append(randomindex)
		print >> sys.stderr, "# {} total intron lengths counted".format(sum(randomcounts.values()))

		print >> sys.stderr, "# Counting most common lengths for {} introns".format( len(randomcounts) )
		if args.elongate:
			freqdict = Counter(intronindex)
		else:
			freqdict = randomcounts
		lengthhist = defaultdict(int)
		for k,v in freqdict.iteritems():
			lengthhist[v] += 1

		if max( lengthhist.keys() ) > maxlength:
			maxlength = max( lengthhist.keys() )

		# add values to replist for each replicate
		for length in xrange( maxlength ):
			if rep and length not in replist: # meaning value has not been encountered yet
				replist[length].extend( ["0"]*(rep) ) # extend by blank list
			replist[length].append( str(lengthhist[length]) )

	# print final table
	print >> wayout, "length\t{}".format( "\t".join(repstrings) )
	for rlength in xrange( maxlength ) ):
		print >> wayout, "{}\t{}".format(rlength, "\t".join(replist[rlength]) )

if __name__ == "__main__":
	main(sys.argv[1:], sys.stdout)
