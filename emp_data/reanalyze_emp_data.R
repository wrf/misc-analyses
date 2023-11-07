# 
# data from
# Thompson 2017 A communal catalogue reveals Earth’s multiscale microbial diversity
# 10.1038/nature24621
# https://earthmicrobiome.org/data-and-code/
# https://zenodo.org/records/890000

library(dplyr)

metadata = read.delim("~/git/misc-analyses/emp_data/emp_qiime_mapping_release1_20170912.tsv", comment.char="")

colnames(metadata)
m = filter(metadata, study_id=="1098")
m
table(metadata$study_id)

studydata = read.csv("~/git/misc-analyses/emp_data/emp_studies.csv")
colnames(studydata)
sum(na.omit(studydata$num_samples))
# [1] 57973
studydata$study_id




#