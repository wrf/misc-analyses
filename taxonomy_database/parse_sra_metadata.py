#!/usr/bin/env python
#
# parse_sra_metadata.py v1 created by WRF 2018-04-24

'''parse_sra_metadata.py v1.0 last modified 2018-04-24

parse_sra_metadata.py NCBI_SRA_Metadata_Full_20180402.tar.gz > SRA_sample_list.tab

    download SRA metadata from:
ftp://ftp.ncbi.nlm.nih.gov/sra/reports/Metadata/
'''


import sys
import time
import tarfile
import xml.etree.ElementTree as ET

if len(sys.argv) < 2:
	sys.exit(__doc__)
else:
	print >> sys.stderr, "# parsing metadata from {}".format(sys.argv[1]), time.asctime()
	metadata = tarfile.open(name=sys.argv[1], mode="r:gz")

	samplecounter = 0
	foldercounter = 0
	for member in metadata.getmembers():
		if member.isdir():
			foldercounter += 1
			samplename = "{0}/{0}.sample.xml".format(member.name)
			try:
				fex = metadata.extractfile(samplename)
			except KeyError:
				print >> sys.stderr, "WARNING: CANNOT FIND ITEM {}, {}, SKIPPING".format(foldercounter, samplename), time.asctime()
				continue
			#print >> sys.stderr, "# reading sample info from {}".format(samplename)
			xmltree = ET.fromstring(fex.read())
			xl = xmltree.getchildren() # should be SAMPLE_SET of 1 or more SAMPLE
			for sample in xl:
				samplecounter += 1
				sl = sample.getchildren() # should be [<Element 'IDENTIFIERS' at 0x7fe2b5879dd0>, <Element 'TITLE' at 0x7fe2b5879e90>, <Element 'SAMPLE_NAME' at 0x7fe2b5879ed0>, <Element 'DESCRIPTION' at 0x7fe2b5879fd0>, <Element 'SAMPLE_LINKS' at 0x7fe2b5885050>, <Element 'SAMPLE_ATTRIBUTES' at 0x7fe2b58851d0>]
				# >>> sample.attrib
				# {'alias': 'SAMD00028700', 'accession': 'DRS023861'}
				namedict = {}
				for sinfo in sl:
					if sinfo.tag=="SAMPLE_NAME":
						for subinfo in sinfo.getchildren():
							namedict[subinfo.tag] = subinfo.text
						try:
							samplealias = sample.attrib.get("alias",None)
						# ERROR WITH ERA542436/ERA542436.sample.xml, {'center_name': 'ANIMAL HEALTH TRUST', 'alias': u'\xd3sk E', 'accession': 'ERS1013701'}
						except UnicodeEncodeError:
							samplealias = "ERROR"
						accession = sample.attrib.get("accession",None)
						if accession is None and samplealias is None:
							continue
						outline = u"{}\t{}\t{}\t{}".format( samplealias, , namedict.get('TAXON_ID',None), namedict.get('SCIENTIFIC_NAME',None) )
						print >> sys.stdout, outline

	print >> sys.stderr, "# Found {} folders, and {} samples".format( foldercounter , samplecounter )
	metadata.close()

#
