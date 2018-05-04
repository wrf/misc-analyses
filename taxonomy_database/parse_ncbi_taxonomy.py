#!/usr/bin/env python
#
# parse_ncbi_taxonomy.py  created by WRF 2018-04-05

'''parse_ncbi_taxonomy.py  last modified 2018-05-04

parse_ncbi_taxonomy.py -n names.dmp -o nodes.dmp -i species_list.txt

    NCBI Taxonomy files can be downloaded at the FTP:
    ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/
'''

import sys
import time
import argparse

#nodes.dmp
#---------
#This file represents taxonomy nodes. The description for each node includes 
#the following fields:
#	tax_id					-- node id in GenBank taxonomy database
# 	parent tax_id				-- parent node id in GenBank taxonomy database
# 	rank					-- rank of this node (superkingdom, kingdom, ...) 
# 	embl code				-- locus-name prefix; not unique
# 	division id				-- see division.dmp file
# 	inherited div flag  (1 or 0)		-- 1 if node inherits division from parent
# 	genetic code id				-- see gencode.dmp file
# 	inherited GC  flag  (1 or 0)		-- 1 if node inherits genetic code from parent
# 	mitochondrial genetic code id		-- see gencode.dmp file
# 	inherited MGC flag  (1 or 0)		-- 1 if node inherits mitochondrial gencode from parent
# 	GenBank hidden flag (1 or 0)            -- 1 if name is suppressed in GenBank entry lineage
# 	hidden subtree root flag (1 or 0)       -- 1 if this subtree has no sequence data yet
# 	comments				-- free-text comments and citations

#names.dmp
#---------
#Taxonomy names file has these fields:
#	tax_id					-- the id of node associated with this name
#	name_txt				-- name itself
#	unique name				-- the unique variant of this name if name not unique
#	name class				-- (synonym, common name, ...)

def names_to_nodes(namesfile):
	'''read names.dmp and return a dict where name is key and value is the node number'''
	name_to_node = {}
	node_to_name = {}
	print >> sys.stderr, "# reading species names from {}".format(namesfile), time.asctime()
	for line in open(namesfile,'r'):
		line = line.strip()
		if line:
			lsplits = [s.strip() for s in line.split("|")]
			nameclass = lsplits[3]
			if nameclass=="scientific name":
				node = lsplits[0]
				species = lsplits[1]
				name_to_node[species] = node
				node_to_name[node] = species
	print >> sys.stderr, "# counted {} scientific names from {}".format( len(name_to_node), namesfile), time.asctime()
	return name_to_node, node_to_name

def nodes_to_parents(nodesfilelist):
	'''read nodes.dmp and return two dicts where keys are node numbers'''
	node_to_rank = {}
	node_to_parent = {}
	for nodesfile in nodesfilelist:
		print >> sys.stderr, "# reading nodes from {}".format(nodesfile), time.asctime()
		for line in open(nodesfile,'r'):
			line = line.strip()
			if line:
				lsplits = [s.strip() for s in line.split("|")]
				node = lsplits[0]
				parent = lsplits[1]
				rank = lsplits[2]
				node_to_rank[node] = rank
				node_to_parent[node] = parent
	print >> sys.stderr, "# counted {} nodes from {}".format( len(node_to_rank), nodesfile), time.asctime()
	return node_to_rank, node_to_parent

def get_parent_tree(nodenumber, noderanks, nodeparents):
	'''given the node number, and the two dictionaries, traverse the tree until you end with kingdom and return a list of the numbers of the kingdom, phylum and class'''
	parent = "0"
	kingdom = None
	phylum = None
	pclass = None
	while nodenumber != "1":
		#print >> sys.stderr, parent, kingdom, phylum, pclass, nodenumber
		try:
			if noderanks[nodenumber] =="kingdom":
				kingdom = nodenumber
			elif noderanks[nodenumber] =="phylum":
				phylum = nodenumber
			elif noderanks[nodenumber] =="class":
				pclass = nodenumber
			if nodenumber=="2" or nodenumber=="2157": # for bacteria and archaea
				kingdom = nodenumber
		except KeyError:
			print >> sys.stderr, "WARNING: NODE {} MISSING, CHECK delnodes.dmp".format(nodenumber)
			return ["Deleted","Deleted","Deleted"]
		parent = nodeparents[nodenumber]
		nodenumber = parent
	return [kingdom, phylum, pclass]

def clean_name(seqname, symbollist="#[]()+=&'"):
	for s in symbollist:
		seqname = seqname.replace(s,"")
	return seqname

def main(argv, wayout):
	if not len(argv):
		argv.append('-h')
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-i','--input', help="text file of species names")
	parser.add_argument('-n','--names', help="NCBI taxonomy names.dmp")
	parser.add_argument('-o','--nodes', nargs="*", help="NCBI taxonomy nodes.dmp, and possibly merged.dmp")
	parser.add_argument('--header', action="store_true", help="write header line for output")
	parser.add_argument('--numbers', action="store_true", help="input lines are NCBI ID numbers, not names")
	parser.add_argument('--unique', action="store_true", help="only count first occurrence of a speices")
	args = parser.parse_args(argv)

	name_to_node, node_to_name = names_to_nodes(args.names)
	node_to_rank, node_to_parent = nodes_to_parents(args.nodes)

	if args.header:
		print >> sys.stdout, "species\tkingdom\tphylum\tclass"

	node_tracker = {}

	nullentries = 0
	foundentries = 0
	print >> sys.stderr, "# reading species IDs from {}".format(args.input), time.asctime()
	for line in open(args.input,'r'):
		line = line.strip()
		if line:
			if args.numbers: # input lines are NCBI numbers, meaning get species name from that
				speciesname = node_to_name.get(line,None)
				node_id = line
			else: # meaning input lines are species names, like Danio rerio
				speciesname = line
				node_id = name_to_node.get(speciesname,None)
			if speciesname is not None: # remove any # that would disrupt downstream analyses
				speciesname = clean_name(speciesname)

			node_tracker[node_id] = node_tracker.get(node_id, 0) + 1
			if args.unique and node_tracker.get(node_id,0) > 1:
				continue

			if node_id is not None:
				foundentries += 1
				finalnodes = get_parent_tree(node_id, node_to_rank, node_to_parent)
				outputstring = "{}\t{}\t{}\t{}".format( speciesname, node_to_name.get(finalnodes[0],"None"), node_to_name.get(finalnodes[1],"None"), node_to_name.get(finalnodes[2],"None") )

				# check for deleted nodes, add to null entries
				if finalnodes[0]=="Deleted":
					nullentries += 1
			else:
				nullentries += 1
				outputstring = "{}\tNone\tNone\tNone".format( speciesname )
			print >> sys.stdout, outputstring
	print >> sys.stderr, "# found tree for {} nodes, could not find for {}".format( foundentries, nullentries), time.asctime()

if __name__ == "__main__":
	main(sys.argv[1:], sys.stdout)
