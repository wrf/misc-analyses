#!/usr/bin/env python

import sys

test_dict = {}
for line in open(sys.argv[1]):
	test_dict[line] = 0
for line in open(sys.argv[2]):
	if line in test_dict:
		test_dict[line] = test_dict.get(line) + 1
	else:
		sys.stdout.write( "> " + line )
for k,v in test_dict.items():
	if v==0:
		sys.stdout.write( "< " + k )
