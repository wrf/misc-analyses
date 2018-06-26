#!/usr/bin/env python
#
# a brief model of bootstrapping as a random draw with replacement

import random
from collections import Counter,defaultdict

# most sites U are uninformative
# other sites favor topology P or C
l = ["U"]*20000 + ["P"]*150 + ["C"]*200
hc = defaultdict(int)

# with 1000 boostraps, sampling with replacement
for i in range(1000):
	newlist = []
	for j in range(len(l)):
		newlist.append( random.choice(l) )
	c = Counter(newlist)
	print c, c["C"]-c["P"]
	hc[c["C"]-c["P"]] += 1

# print histogram
for k in sorted(hc.keys()):
	print k, hc[k]

