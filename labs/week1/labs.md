EPI 560 Lab Topics

Week 1:

- Using the language of "censoring" and/or "truncation" (left, right, and/or interval), explain why a prospective cohort study is often seen as higher quality than a retrospective cohort study.

- Ashley will provide another dataset with non-fixed time-scale. Task: ask the students to pick a study start and create a new cohort with this new T0, where new cohort is subject to left truncation. who is truncated?

- Please do a very basic exploratory analysis of the "example_dat1.csv" dataset. No more than 1/2 page. Provide results for the exposure, the confounder, and the outcome.

- Describe, in words, the interpretation of the CDF, F(t) AND the survival function S(t). I.e., "The probability that ..."

- fit the `survfit()` function to the "example_dat1.csv" data. Examine the R object that you get from this fit. ANSWER: use the `str()` to explore the content of hte object created.

- 5a) Using "example_dat1.csv", plot the cumulative distribution function using the KM estimator. Interpret the curve. (right censoring)

- 5b) Using "example_dat1.csv", plot the cumulative distribution function using the KM estimator. Interpret the curve. (left truncation)
