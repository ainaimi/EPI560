---
layout: page
title: Syllabus Updated %%current_date_yyyymm%%
permalink: /syllabus/
header-includes:
  - \usepackage{hyperref}
  - \hypersetup{colorlinks=true,urlcolor=blue}
output:
  pdf_document
---

[Download a pdf copy of syllabus](../syllabus.pdf)

## Basic information

__DEPARTMENT:__ Epidemiology

__COURSE NUMBER:__ EPI 560                                          

__COURSE TITLE__: Epidemiologic Methods IV

__CREDIT HOURS__: 4

__SEMESTER__: Spring %%current_date_yyyy%%

__CLASS HOURS AND LOCATION__: TBD

__INSTRUCTOR NAME:__ Ashley I. Naimi

__INSTRUCTOR CONTACT INFORMATION__
* __EMAIL__: ashley.naimi@emory.edu 
* __SCHOOL ADDRESS OR MAILBOX LOCATION__: CNR 4013
* __OFFICE HOURS__: By Appointment

__TEACHING ASSISTANT INFORMATION__: 
* __NAME__: Erin Rogers
* __EMAIL__: erin.rogers@emory.edu
* __OFFICE HOURS__: TBD (location: TBD)
 

## COURSE DESCRIPTION

This course covers epidemiologic concepts in further depth than previous methods courses in the program, and provides an overview of advanced topic in the analysis of epidemiologic data. The course builds on the concepts and tools introduced in other Epi methods courses early in the series. This is a required course for students in the PhD and MSPH Epidemiology program. 

### Concepts Covered

The course includes two weekly lectures and one lab, and will be divided into five sections: Frequentist versus Bayesian Statistics and related concepts (p values, s values, Bayes factors, confidence intervals, credible intervals, NHST) (section 1), basic study design and trial emulation topics (section 2), regression modeling strategies for continuous, binary and categorical outcomes (section 3), missing data and multiple imputation (section 4), and variance estimation and interpretation (section 5). 

The lecture material will be reinforced by lab sessions in which students will be able to implement lecture concepts and observe them in practice. The labs will focus on actual analyses using the R programming language. 

## PRE-REQUISITES

This course will build on basic and intermediate analytic methods covered in [EPI 538](https://sph.emory.edu/academics/courses/epi-courses/index.html), [EPI 545](https://sph.emory.edu/academics/courses/epi-courses/index.html), and [EPI 550](https://sph.emory.edu/academics/courses/epi-courses/index.html).

Prerequesite skills and concept include: basic epidemiological measures, confounding, misclassification, selection bias, types of study designs, estimation of epidemiological parameters, issues related to causality, interaction, effect modification and mediation, as well as concepts, methods, and application of key mathematical modeling approaches used to evaluate multivariable data from epidemiologic studies such as logistic and Cox regression.

## DIVERSITY, EQUITY, AND INCLUSION CONSIDERATIONS

This course will focus on the theory and application of quantitative and statistical methods to epidemiologic data. Epidemiology is a complex field of study that combines biomedical, physiological, mathematical, social, political, and economic dimensions into a single domain. As a result of this complexity, it is important to understand how epidemiologic knowledge is shaped by and is used to shape social and cultural perspectives on health, well-being, and the optimal organization of human societies.

It is impossible to understand these perspectives without acknowledging the role that early 20th century views on race, ethnicity, sex, gender, and other related socio-political constructs played in shaping quantitative methods that we still use today. For example, the "founding fathers" of statistics (Francis Galton, Karl Pearson, and Ronald Fisher) were also founders of 20th century Eugenics, and they used the new math they derived to characterize many of the egregious and scientifically unjustifiable eugenic acts (forced sterilization, marriage prohibitions, or the supposed moral superiority of "Nordics" or "Aryans") with the patina of "objectivity."

The literature on this topic is expansive, complex, and rapidly growing, and we will not be able to cover many of the problems with how statistical and quantitative methods were and are used inappropriately for iniquitous ends. However, the [reading list](https://ainaimi.github.io/EPI560/readings/) for the course contains references to key books and papers on this topic which are (some highly) recommended. Additionally, a deep understanding of the connection between data, statistics, and substantive theory can go a long way in both dismantling unsubstantiated claims (both eugenic, and more generally), as well as design studies that can generate a more nuanced understanding of the complexity of health. My hope is that EPI 560 will serve this end. 

## COURSE LEARNING OBJECTIVES

* 	Integrate fundamental epidemiologic concepts related to disease occurrence and associations.
* 	Articulate fundamental concepts in the potential outcomes frameworks.
* 	Understand the relation between exchangeability and bias.
* 	Understand and articulate the differences between truncation and censoring.
* 	Understand and recognize when and how to use regression models in various epidemiologic settings.
* 	Recognize the presence, impact, and ways to analyse competing risk data.
* 	Understand bootstrap and its potential applications to the analysis of epidemiologic data.
* 	Correctly interpret p values and confidence intervals.

 
## ATTENDANCE POLICY

In person attendance in this course is expected.

## EVALUATION

### Assignments

There will be one final project to be completed at home. Each section will also carry a section assignment to be completed at home. All assignments are "open-book". Use of internet search engines is encouraged. Use of ChatGPT or other large language model based chat-bots is not prohibited. However, dihonest or misleading use of these (or any) techniques will be considered as Academic dishonesty, which will incur associated penalties (see below).

### Grade scale

Students can choose to be graded as using letter scores (see table), or as Satisfactory (S)/Unsatisfactory (U) if approved by the instructor.

The basis for the final grade will be determined as follows:

|---|---|
| Section Assignments | 60% |
| Final Analysis Project | 40% |

<br/><br/>

Final grade point cutoffs (rounded to the nearest whole number) will be:

|---|---|
| A | 95-100 |
| A- | 90-94 |
| B+ | 85-89 |
| B | 80-84 |
| B- | 75-79 |
| C | 70-74 |
| F | <70 |

## COURSE LOGISTICS

### Course Website

All materials for the class will be hosted on the course website: [https://ainaimi.github.io/EPI560/](https://ainaimi.github.io/EPI560/). This includes the syllabus, lecture notes, lab notes/slides,  datasets, homework assignments, and readings. 

### Slack

We will use Slack as a primary means of communication in this course. This is the best way to reach out to classmates, teaching assistants, and the instructor. To join the Slack team for EPI 560, please use this link: [https://epi560.slack.com/signup#/domain-signup](https://epi560.slack.com/signup#/domain-signup)

We will use the `#general` channel for most class discussions. We will also create a channel for each assignment, which can be used to answer questions specific to the homeworks. Each lab section will also have its own channel. If you would like to ask a question anonymously in any of these channels, please use the `/anonymous` argument before typing your question.

### CANVAS

You will be asked to use CANVAS to submit homework assignments by the assigned due date.

### R and Posit

Students will be expected to have [R](https://cran.r-project.org/) and [Posit](https://posit.co/) [(formerly RStudio)](https://posit.co/blog/rstudio-is-becoming-posit/) installed and working on their computers. In addition, the following packages should be installed and in working order:

```
"tidyverse", "here", "sandwich", "lmtest", "boot", "ggplot2", "broom", "rio"
```

Other packages may have to be installed during the course of the semester. 

Depending on the analytic scenario, you may have to install a development package from, e.g., GitHub. The best way to do this is to use the `install_github()` function in the `remotes` package. However, you will have to address the potential GitHub API limits, which can lead to installation errors. To deal with this problem, you will need your own GitHub account. 

The easiest way to address this issue is to use a Github personal access token (PAT). There are a number of ways to do this, and it's important to [read the basic information on PATs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). Within R and RStudio, one straightforward way to manage PATs is to install and use the `usethis` package, which has a suite of functions available for creating and integrating PATs. Once you've installed `usethis`, you can:

- Use `usethis::browse_github_pat()` to create a GitHub token

- Use `usethis::edit_r_environ()` and add the environment variable by adding the following line to the R environment file: `GITHUB_PAT = 'your_github_token'`.

- Restart R (so that the GITHUB_PAT is read) and try to reinstall the packages that were resulting in the API limit error.

Be aware: **your Github PAT is a password, and should be treated as such.**

### Health considerations

At the very first sign of not feeling well, please stay at home. You will not be penalized for not showing up to class because you are feeling ill. 

## RSPH POLICIES

__Accessibility and Accommodations__ 

Accessibility Services works with students who have disabilities to provide reasonable accommodations. In order to receive consideration for reasonable accommodations, you must contact the Office of Accessibility Services (OAS). It is the responsibility of the student to register with OAS. Please note that accommodations are not retroactive and that disability accommodations are not provided until an accommodation letter has been processed.

Students who registered with OAS and have a letter outlining their academic accommodations are strongly encouraged to coordinate a meeting time with me to discuss a protocol to implement the accommodations as needed throughout the semester. This meeting should occur as early in the semester as possible.

Contact Accessibility Services for more information at (404) 727-9877 or accessibility@emory.edu. Additional information is available at the OAS website at http://equityandinclusion.emory.edu/access/students/index.html

## Honor Code

You are bound by Emory University’s Student Honor and Conduct Code. RSPH requires that all material submitted by a student fulfilling his or her academic course of study **must be the original work of the student.**  Violations of academic honor include any action by a student indicating dishonesty or a lack of integrity in academic ethics. Academic dishonesty refers to cheating, plagiarizing, assisting other students without authorization, lying, tampering, or stealing in performing any academic work, and will not be tolerated under any circumstances.

The [RSPH Honor Code](http://www.sph.emory.edu/cms/current_students/enrollment_services/honor_code.html) states: "*Plagiarism is the act of presenting as one's own work the expression, words, or ideas of another person whether published or unpublished (including the work of another student). A writer’s work should be regarded as his/her own property.*" 

## Laney Academic Integrity Statement 

You are expected to uphold and cooperate in maintaining academic integrity as a member of the Laney Graduate School. By taking this course, you affirm your commitment to the Laney Graduate School Honor Code, which you can find in the Laney Graduate School Handbook. You should ensure that you are familiar with the rights and responsibilities of members of our academic community and with policies that apply to students as members of our academic community. Any individual, when they suspect that an offense of academic misconduct has occurred, shall report this suspected breach to the appropriate Director of Graduate Studies, Program Director, or Dean of the Laney Graduate School. If an allegation is reported to a Director of Graduate Studies or a Program Director, they are in turn required to report the allegation to the Dean of Laney Graduate School. 

## COURSE CALENDAR AND OUTLINE



| Section 1 | Probability and Statistical Inference, Frequentist and Bayesian; P-values, Neyman-Pearson Testing, and the P-Value Fallacy; S Values, Bayes Factors, Confidence Intervals, Credible Intervals, Consequences of Heavy Tails |

| Section 2 | Design and Regression Modeling: Randomized Trials, Observational Studies, and Target Trial Emulation, Dynamic, Static, and Stochastic Interventions; A Suite of Causal Estimands; Causal Inference; Identification Bias versus Estimation Bias |

| Section 3 | Regression modeling for continuous, binary and categorical outcomes; Generalized Linear Models, distributions and link functions; Splines and Generalized Additive Models; Ridge Regression, LASSO, and Penalization; Quantile Regression |

| Section 4 | Missing Data; Relation to Exchangeability and Causal Inference Assumptions; Missing Completely at Random, Missing Not at Random, and Missing At Random; monotone versus nonmonotone missingness; imputation versus weighting; multiple imputation via chained equations |

| Section 5 | Variance Estimation; Model Based Standard Error, Robust Variance Standard Error; Bootstrapping (normal interval, percentile, bias-corrected and accelerated) |