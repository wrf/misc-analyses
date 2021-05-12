#!/usr/bin/env python
#

'''simplify_foodbalance_table.py  last modified 2021-05-03

    to take all seafood categories:
./simplify_foodbalance_table.py -i FoodBalanceSheets_E_All_Data.csv > FoodBalanceSheets_E_reformat_all_fish.tab

    to take only the totals, use -s :
./simplify_foodbalance_table.py -i FoodBalanceSheets_E_All_Data.csv -s > FoodBalanceSheets_E_fish_summary_only.tab

    data from UN FAO, for 2014 to 2017
  www.fao.org/fishery/statistics/global-consumption/en
  http://www.fao.org/faostat/en/#data/FBS
    
'''

import sys
import argparse
import csv
from collections import defaultdict

def parse_balancetable_csv(csvfile, do_summary):
	''''''
	if do_summary:
		fishery_allowed_items = ["Fish, Seafood"]
	else:
		fishery_allowed_items = ["Fish, Seafood", "Freshwater Fish", "Demersal Fish", "Pelagic Fish", "Marine Fish, Other", "Crustaceans", "Cephalopods", "Molluscs, Other"]
	related_items = ["Aquatic Products, Other", "Aquatic Animals, Others", "Aquatic Plants"]

	element_variation_terms = ["Production", "Import Quantity", "Stock Variation", "Export Quantity", "Domestic supply quantity", "Other uses (non-food)", "Food"]

	country_name_swaps =   {"Iran (Islamic Republic of)":"Iran",
							"United Republic of Tanzania":"Tanzania",
							"Bolivia (Plurinational State of)":"Bolivia",
							"Republic of Moldova":"Moldova",
							"China, Hong Kong SAR":"Hong Kong",
							"Lao People's Democratic Republic":"Laos",
							"China, Macao SAR":"Macao",
							"Venezuela (Bolivarian Republic of)":"Venezuela",
							"China, Taiwan Province of":"Taiwan",
							"Democratic People's Republic of Korea":"North Korea",
							"Republic of Korea":"South Korea",
							"C\xf4te d'Ivoire":"Ivory Coast",
							"United Kingdom":"UK",
							"United States of America":"USA",
							"Viet Nam":"Vietnam",
							"Russian Federation":"Russia"
                         }

	# 0          1     2          3     4             5        6     7      8       9      10      11     12      13     14
	# Area Code  Area  Item Code  Item  Element Code  Element  Unit  Y2014  Y2014F  Y2015  Y2015F  Y2016  Y2016F  Y2017  Y2017F

	production_counts = defaultdict( lambda: defaultdict(int) ) # key is country, key is category of fish, value is 2017 counts
	import_counts = defaultdict( lambda: defaultdict(int) )
	export_counts = defaultdict( lambda: defaultdict(int) )
	feed_counts = defaultdict( lambda: defaultdict(int) )

	sys.stderr.write("# Reading {}\n".format(csvfile) )
	balance_csv = csv.reader(open(csvfile,'rU') )
	for row in balance_csv:
		country = row[1]
		if country in country_name_swaps:
			country = country_name_swaps.get(country)
		item = row[3]
		element = row[5]
		y2017 = row[13]
		# all values are rounded to nearest integer in the original data csv
		if item in fishery_allowed_items:
			if element   == "Production":
				production_counts[country][item] = int(y2017)
			elif element == "Import Quantity":
				import_counts[country][item] = int(y2017)
			elif element == "Export Quantity":
				export_counts[country][item] = int(y2017)
			elif element == "Feed":
				feed_counts[country][item] = int(y2017)

	# make header line
	header_line = "region\titem\tproduction_2017_Gg\timports_2017_Gg\texports_2017_Gg\tfeed_2017_Gg\n"
	sys.stdout.write(header_line)

	# iterate through 
	for country in import_counts.keys():
		for fish_item in import_counts.get(country).keys():
			prod_quant   = production_counts.get(country,{}).get(fish_item,0)
			import_quant = import_counts.get(country,{}).get(fish_item,0)
			export_quant = export_counts.get(country,{}).get(fish_item,0)
			feed_quant = feed_counts.get(country,{}).get(fish_item,0)
			outline = "{}\t{}\t{}\t{}\t{}\t{}\n".format(country, fish_item, prod_quant, import_quant, export_quant, feed_quant)
			sys.stdout.write(outline)

def main(argv, wayout):
	if not len(argv):
		argv.append("-h")
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=__doc__)
	parser.add_argument('-i','--input', help="FoodBalanceSheets csv file", required=True)
	parser.add_argument('-s','--summary', action="store_true", help="extract only summary info")
	args = parser.parse_args(argv)

	parse_balancetable_csv(args.input, args.summary)

if __name__ == "__main__":
	main(sys.argv[1:],sys.stdout)
