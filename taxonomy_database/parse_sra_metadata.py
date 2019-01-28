#!/usr/bin/env python
#
# parse_sra_metadata.py v1 created by WRF 2018-04-24

'''parse_sra_metadata.py v1.0 last modified 2019-01-28

parse_sra_metadata.py NCBI_SRA_Metadata_Full_20181203.tar.gz > NCBI_SRA_Metadata_Full_20181203.samples.tab

    NOTE: parsing metadata can be slow due to the tar.gz size
      above run took appx 6 days

    download SRA metadata from:
ftp://ftp.ncbi.nlm.nih.gov/sra/reports/Metadata/
'''

import sys
import time
import tarfile
import unicodedata
import xml.etree.ElementTree as ET

if len(sys.argv) < 2:
	print >> sys.stderr, __doc__
else:
	starttime = time.time()
	print >> sys.stderr, "# parsing metadata from {}".format(sys.argv[1]), time.asctime()
	metadata = tarfile.open(name=sys.argv[1], mode="r:gz")

	samplecounter = 0
	foldercounter = 0
	warningcounter = 0
	WARNMAX = 100
	for member in metadata.getmembers():
		if member.isdir():
			foldercounter += 1
			samplename = "{0}/{0}.sample.xml".format(member.name)
			if not foldercounter % 100000:
				print >> sys.stderr, "# {} folders".format(foldercounter), time.asctime()
			try:
				fex = metadata.extractfile(samplename)
			except KeyError:
				warningcounter += 1
				if warningcounter < WARNMAX:
					print >> sys.stderr, "WARNING: CANNOT FIND ITEM {}, {}, SKIPPING".format(foldercounter, samplename), time.asctime()
				elif warningcounter == WARNMAX:
					print >> sys.stderr, "# {} WARNINGS, WILL NOT DISPLAY MORE".format(WARNMAX), time.asctime()
				continue
			#print >> sys.stderr, "# reading sample info from {}".format(samplename)
			xmltree = ET.fromstring(fex.read())
			xl = xmltree.getchildren() # should be SAMPLE_SET of 1 or more SAMPLE
			#print >> sys.stderr, samplename
			for sample in xl:
				samplecounter += 1
				sl = sample.getchildren()
				# should be [<Element 'IDENTIFIERS' at 0x7fe2b5879dd0>, <Element 'TITLE' at 0x7fe2b5879e90>, <Element 'SAMPLE_NAME' at 0x7fe2b5879ed0>, <Element 'DESCRIPTION' at 0x7fe2b5879fd0>, <Element 'SAMPLE_LINKS' at 0x7fe2b5885050>, <Element 'SAMPLE_ATTRIBUTES' at 0x7fe2b58851d0>]
				# >>> sample.attrib
				# {'alias': 'SAMD00028700', 'accession': 'DRS023861'}
				namedict = {}
				for sinfo in sl:
					if sinfo.tag=="SAMPLE_NAME":
						for subinfo in sinfo.getchildren():
							namedict[subinfo.tag] = subinfo.text
# extract individual folders to check
# tar -zxf NCBI_SRA_Metadata_Full_20181203.tar.gz SRA070055
						try:
							rawsamplealias = sample.attrib.get("alias",None)
							if rawsamplealias is not None:
								samplealias = unicodedata.normalize('NFKD', unicode(rawsamplealias)).encode("ascii",errors="replace")
						# ERROR WITH ERA542436/ERA542436.sample.xml, {'center_name': 'ANIMAL HEALTH TRUST', 'alias': u'\xd3sk E', 'accession': 'ERS1013701'}
						except UnicodeEncodeError:
						# caused UnicodeEncodeError due to '\xa0' in some strings
						# '\xa0' apparently is a non-standard space
							samplealias = "ERROR"
						# accession should be the SRA number, like SRA070055
						accession = sample.attrib.get("accession",None)

						# if somehow neither exists, skip
						if accession is None and samplealias is None:
							continue
						# print line
						try:
							outline = u"{}\t{}\t{}\t{}".format( samplealias, accession, namedict.get('TAXON_ID',None), namedict.get('SCIENTIFIC_NAME',None) )
							norm_outline = unicodedata.normalize('NFKD', outline).encode("ascii",errors="replace")
							print >> sys.stdout, norm_outline
						except UnicodeEncodeError:
							print >> sys.stderr, "WARNING: COULD NOT PROCESS UNICODE FOR {} ENTRY {}".format(accession, foldercounter)

	# report stats of total run
	if warningcounter > WARNMAX:
		print >> sys.stderr, "# Last folder was {}, {}".format(foldercounter, samplename), time.asctime()
	print >> sys.stderr, "# Process completed in {:.1f} minutes".format( (time.time()-starttime)/60 )
	print >> sys.stderr, "# Found {} folders, and {} samples".format( foldercounter , samplecounter )
	if warningcounter:
		print >> sys.stderr, "# Could not find samples for {} folders".format( warningcounter )
	metadata.close()

