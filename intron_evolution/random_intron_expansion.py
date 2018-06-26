#!/usr/bin/env python
#
# random_intron_expansion.py v1 created 2018-06-25

'''random_intron_expansion.py v1 last modified 2018-06-25

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
	parser.add_argument('-e','--elongate', action="store_true", help="elongate introns with each iteration")
	args = parser.parse_args(argv)

	print >> sys.stderr, "# Starting random length increase, for {} iterations of {} initial introns".format(args.iterations, args.number)
	if args.elongate:
		print >> sys.stderr, "# extending introns with each iteration"

	# initialize lengths
	randomcounts = {}
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

	for length in xrange( max( lengthhist.keys() ) ):
		print >> wayout, "{}\t{}".format(length, lengthhist[length])

if __name__ == "__main__":
	main(sys.argv[1:], sys.stdout)
