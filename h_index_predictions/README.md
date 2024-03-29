# Prediction of future H-index #
This is based on the editorial [Predicting scientific success](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3770471/) discussing the ability to predict the [H-index](https://en.wikipedia.org/wiki/H-index) of a researcher in 10 years, using multiple factors. Naturally, the 10 year predictions were not very accurate. The predictions for 1, 5 and 10 years were generated by:

```
#Predicting next year (R2=0.92): 
h1  = 0.76 + 0.37*sqrt(n) + 0.97*h - 0.07*y + 0.02*j + 0.03*q

#Predicting 5 years into the future (R2=0.67):
h5  = 4.00 + 1.58*sqrt(n) + 0.86*h - 0.35*y + 0.06*j + 0.2*q

#Predicting 10 years into the future (R2=0.48):
h10 = 8.73 + 1.33*sqrt(n) + 0.48*h - 0.41*y + 0.52*j + 0.82*q
```

For 1 year, it is essentially the current H index plus one (`+0.76`). In the long term, the formula indicates a greater importance of publishing in different journals (`+0.52*j`), but also having a Science/Nature/PNAS paper (`+0.82*q`).

Many researchers can get a high H-index from other reasons, such as running a shared facility or having a machine used by other labs. In my experience, I have worked with such groups several times. It is all too common that they do not write a single word of the paper, but nonetheless gain authorship. It is not even clear if they read the paper at all, particularly if it is outside of their discipline. Of course, such facilities need *some* way of getting credit for their work (for reports to funding agencies, etc), but it is not clear to me that authorship is the best way of doing this. To me, [authorship implies writing something](http://www.icmje.org/recommendations/browse/roles-and-responsibilities/defining-the-role-of-authors-and-contributors.html). Proposed solutions involve categories of authors (e.g writing, experimental, funding), or simply crediting the people in the acknowledgements without authorship.

![2020_barplot.png](https://github.com/wrf/misc-analyses/blob/master/h_index_predictions/2020_barplot.png)

Because the H-index [requires high citations](https://science.sciencemag.org/content/286/5437/53), but also a [high number of papers](https://science.sciencemag.org/content/337/6098/1019.summary), the [strategy of gaming](https://doi.org/10.1080/13504851.2016.1164812) the stat is obvious: [get on as many papers as possible](https://royalsocietypublishing.org/doi/10.1098/rspb.2019.2047#d1e649) and [demand authorship for minor things](https://doi.org/10.1371/journal.pone.0187394). This is [commonly reported](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0187394) and nearly everyone I know does this to some extent.

![h_index_gaming_strategy_v2.png](https://github.com/wrf/misc-analyses/blob/master/h_index_predictions/h_index_gaming_strategy_v2.png)

Journals like [peerJ](https://peerj.com/about/author-instructions/#basic-manuscript-organization) try to apply strict criteria for authorship, but this also fails in the online implementation. It requires a minimum number of author tasks to be added for each author, but users can just keep adding contributions for all authors during the submission step until the "Continue to Next Step" button allows them to continue, even if they didn't actually do anything. Hence, the failure is that users or submitting authors are not honest about the contributions of other authors.

# An equally lazy, but better solution #
One [preprint by Lariviere 2016](https://www.biorxiv.org/content/10.1101/062109v2) argues in favor of presenting the distributions of citations within a journal. To me, it makes more sense to draw them as ordinal ranking, rather than a histogram. As they all have exponential distributions, using the [arithmetic mean, which is done for the 2-year impact factor, would be meaningless](https://www.bmj.com/content/314/7079/497.1). The underhanded staff at Nature suggest that "[a broader range of metrics](https://www.nature.com/news/beat-it-impact-factor-publishing-elite-turns-against-controversial-metric-1.20224)" could fix this, trying to hide the fact that journal-based metrics, rather than paper-based, are precisely the problem.

I suspect this problem will not change for a while, since there is substantial mental inertia. This is reflected in the number of professors today that refer to "good journals". Even though it is not explicitly the impact factor, the concept is the same, that there could be a single metric that captures what is good or bad in a journal, rather than the individual research items.

Table 2 from [Lariviere 2016](https://www.biorxiv.org/content/10.1101/062109v2)

| journal     | JIF  |  % items below JIF |
| --- | ---: | ---: |
| Nature      | 38.1 | 74.8 |
| Science     | 34.7 | 75.5 |
| Nature Comm | 11.3 | 74.1 |
| EMBO J      | 9.6 | 66.9 |
| PLOS Biol   | 8.7 | 66.8 |
| eLife       | 8.3 | 71.2 |
| PLOS Genet  | 6.7 | 65.3 |
| Nature Sci Rep | 5.2 | 73.2 |
| Proc R Soc B | 4.8 | 65.7 |
| PLOS ONE    | 3.1 | 72.2 |
| J Informetrics | 2.4 | 68.4 |

Because the differences between journals in their citation distributions are small, a better idea would be to report the percentile of your paper *within* the journal. Again, a consequence of the distribution of scores is that most papers fall below the impact factor of that journal, meaning that a few highly-cited papers are dragging up the impact factor, while about 70% are lower for all journals. The top 1% of *ALL* journals still have more citations than the impact factor for Nature. **Thus, the most impactful work is the top 1% of papers for each journal, regardless of which journal**. It is also clear that 2 years is insufficient to measure this, but that is a separate issue.

![citation_distributions_2014_v1.png](https://github.com/wrf/misc-analyses/blob/master/h_index_predictions/citation_distributions_2014_v1.png)

