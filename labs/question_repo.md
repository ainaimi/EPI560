{\bf Instructions} (read carefully): 
\begin{itemize}
\item Each group must submit {\bf one} assignment as a .pdf file. 
\item Each member of the same group will receive the same grade. 
\item Please put the name of each group member on the first page. 
\item Use one inch margins and double spaced text. 
\item For each assignment, one group will be chosen in advance to present/discuss the results in class.
\item All of the R code for all applied questions must be provided at the end of the file.
\item This assignment is due {\bf electronically} to Gabriel Conzuelo {\bf Tuesday Sept 11} at the beginning of class.
\end{itemize}

\vskip .5cm 

\noindent { \bf Question 1}: Consider Bertrand Russell's quote:

\begin{quote}
If p then q; now q is true, therefore p is true. E.g., If pigs have wings, then some winged animals are good to eat; now some winged animals are good to eat; therefore pigs have wings. This form of inference is called the 'scientific method.'
\end{quote}

Why would he say this? What feature of the scientific/empirical process warrants such a statement? Please discuss from the perspective of an epidemiologic study investigating the effect of an exposure on an outcome. Give a practical (possibly hypothetical) example of such a study, and use this example to explain how it relates to the above quote. Please write no more than 1/2 a page.

\vskip .5cm 

\noindent{ \bf Question 2}: Which of the following are directed acyclic graphs? Why / why not?

\begin{figure}[H]
	\centering
	\includegraphics[scale=.65]{F5.pdf}
\end{figure}	

\vskip .5cm 

\noindent{ \bf Question 3}: In the following DAG, suppose you are interested in estimating the effect of $X$ on $Y$. Find the minimally sufficient adjustment set.

\begin{figure}[H]
	\centering
	\includegraphics[scale=.25]{ShrierDAG.png}
\end{figure}	

\vskip .5cm 

\noindent{ \bf Question 4}: In September 2006, NYT columnist Nicholas Bakalar wrote regarding a study on the effect of brisk walking after a fatty meal: ``She and her fellow authors acknowledge that the study sample was limited to eight healthy young adults. But the effect was statistically highly significant, suggesting a meaningful treatment effect.'' Discuss the logic of this passage.

\vskip .5cm 

\noindent{ \bf Question 5}: In 1/2 a page or less, please discuss the distinction between confidence intervals and identification bounds.

\vskip .5cm 

\noindent{ \bf Question 6}: Import the NHEFS data into R. How many rows/columns are there in the data? How many people quit smoking between the first questionnaire and 1982? Create a data frame named ``\texttt{nhefs\_data}'' as an object in the R environment with the following variables: seqn, qsmk, smkintensity82\_71, smokeintensity, active, exercise, wt82\_71, sbp, dbp, hbp, ht, hbpmed, sex, age, hf, race, income, marital, school, asthma, bronch, diabetes.

 Use the \texttt{aggr} function in the VIM package to generate a missing data plot for the \texttt{nhefs\_data} object.

\vskip .5cm 

\noindent{ \bf Question 7}: Delete all rows with any missing data from the \texttt{nhefs\_data} object. How many observations remain? Create a propensity score overlap plot for the \texttt{qsmk} variable conditional on the following covariates: hbpmed, sex, age, race, asthma, bronch, diabetes. Include variables in the model as linear terms only (i.e., ignore potential dose-response and categorical). Does this figure suggest good or problematic propensity score overlap? Explain.

\vskip .5cm 

\noindent{ \bf Question 8}: Consider the following 10 hypothetical individuals in the NEHFS data. Assume that we are interested in the effect of quitting smoking (\texttt{qsmk}) on asthma ($Y$). Assume further that counterfactual consistency holds. Please complete the table by writing out possible values for the potential outcomes.

\begin{table}[H]
\centering
\begin{tabular}{rrrrrr}
  \hline
ID & qsmk &  $Y$ & $Y^0$ & $Y^1$ \\ 
  \hline
1 &   0 & 0 & & \\ 
  2 &   0 & 0 & &  \\ 
  3 &   0 & 0 & &  \\ 
  4 &   0 & 1 & &  \\ 
  5 &   1 & 0 & &  \\ 
  6 &   0 & 0 & &  \\ 
  7 &   1 & 1 & &  \\ 
  8 &   1 & 0 & &  \\ 
  9 &   0 & 1 & &  \\ 
  10 &   0 & 0 & &  \\ 
   \hline
\end{tabular}
\end{table}


\noindent { \bf Question 1}: When conducting a statistical test, if the $p$-value is greater than the pre-specified $alpha$ level, proper interpretation requires stating that we fail to reject the null hypothesis, and not that we accept the null hypothesis. Why?

\vskip .5cm 

\textcolor{red}{ The logic of null hypothesis significance testing is based on the following premises: if the null hypothesis is true ($P$), then the $p$-value will not be small ($Q$). Upon seeing a $p$-value that is not small ($Q$), we cannot conclude that the null hypothesis is true ($P$) because this would be affirming the consequent (a formal logical fallacy).}

\vskip .5cm 

\noindent{ \bf Question 2}: The ``g'' in g computation stands for ``generalized.'' Discuss why this method is generalized in less than half a page.

\textcolor{red}{ When the exposure and confounders are measured repeatedly over time, time-varying confounding is highly likely. This occurs when past exposure measurements affect prior confounders, which subsequently affect future exposures. Under such scenarios, standard methods such as regression fail to provide an unbiased estimate of the effect of the exposure on the outcome. }

\textcolor{red}{ G methods, on the other hand, are valid when faced with such time varying confounding. They are also valid when faced with data that are not subject to time-varying confounding. For this reason, they are more general than standard methods.}

\vskip .5cm 

\noindent{ \bf Question 3}: With the NHEFS data, use g computation to estimate the average treatment effect and the effect of treatment on the treated for the relation between quitting smoking (\texttt{qsmk}) and weight gain (\texttt{wt82\_71}). Present estimates for these effects on the mean difference scale. Adjust for the following variables: \texttt{smkintensity82\_71, exercise, sbp, dbp, sex, age, race, income, marital, school, asthma}. Use the same strategy to obtain complete cases that was illustrated in Application 1.

In presenting your results, please provide the point estimates (on the mean difference scale) for these two effects, as well as a clear and concise interpretation of the effect. When interpreting, please consider threats to each identifiability assumption. Follow the steps outlined in the lecture notes (setup, implementation, validation, interpretation) and present your findings in no more than 1.5 pages. 

Additional points will be given for concision and clarity. Please present your findings as though you were submitting them for publication. Estimates for the ATE and ETT should be neatly arranged in a table that includes a legend/title.

Bonus points will be allotted if correct confidence intervals are also provided. If attempted, please use 123 as the seed.

\textcolor{red}{ See attached R program for code}

\textcolor{red}{We sought to estimate the effect of quitting smoking on increases in weight between 1971 and 1982 in the NEHFS data using g computation. Results are provided in Table 1:}

\begin{table}[H]
\caption{Point estimates and 95\% confidence intervals quantifying the average treatment effect and the effect of treatment on the treated for the relation between quitting smoking and weight gain in the National Health and Nutrition Examination Survey, Epidemiologic Follow-Up Study, 1971-1982}
\centering
\begin{tabular}{rrrr}
  \hline
 &  & \multicolumn{2}{c}{95\% Confidence Limits} \\ 
 & Estimate & Lower & Upper \\ 
  \hline
Average Treatment Effect & 2.51 & 1.50 & 3.52 \\ 
Effect of Treatment on the Treated & 2.45 & 1.63 & 3.27 \\ 
   \hline
\end{tabular}
\end{table}

\textcolor{red} {To interpret these effects causally, several identifiability assumptions are required. Counterfactual consistency states that the observed outcome is the potential outcome under the observed exposure, and requires that the exposure assignment mechanism is well-defined. We examined the effect of quitting smoking. While it is possible to clearly define interventions that will lead to the cessation of smoking, there are a small number of possible mechanisms by which individuals in the NEHFS cohort may have quit. For instance, quitting due to the adoption of a healthy lifestyle, versus quitting as the result of some underlying health condition. These may lead to different magnitudes of weight change, and thus our results should be interpreted with caution. }

\textcolor{red} {No interference requires that the exposure status of a given individual does not affect the outcome status of another individual. In this cohort, we assume that all individuals were sufficiently separated in time and space so as to render the no interference assumption true. }

\textcolor{red} {Exchangeability requires that the potential outcomes are independent of the observed exposures, which will be met if there is no confounding bias, no selection bias, and no information bias. In our case, we adjusted for 11 confounding variables. However, as we entered all variables (including categorical and continuous) as linear terms, there is likely some degree of residual confounding. }

\textcolor{red} {There are several possible reasons that selection bias may be present. First, we assume all confounders adjusted for in the analysis were pre-exposure. If this is true, adjusting for these variables will not induce collider stratification bias (a form of selection bias), since colliders must be ancestors of the exposure. The primary reason that selection bias may arise in these data is that we conducted a complete case analysis. For g computation, these analyses assume that, conditional on all variables in the outcome model, there is no association between the potential outcomes and any missingness indicators. This assumption cannot be verified.}

\textcolor{red} {Finally, no information bias requires all variables are perfectly measured. In our case, because all variables were measured via self- or other-reported survey questionnaires, there is no reason to believe in the absence of information bias. Furthermore, as there are no ``gold-standard'' measurements for any of the variables in our analysis, there is no way to correct for threats due to information bias.}

\vskip .5cm 

\noindent{ \bf Question 4}: What is the smallest Monte Carlo sample you can use without the point estimate changing so as to influence the interpretation?

\textcolor{red}{ See attached R program.}

\textcolor{red}{ This figure suggests that for both the ATE, there is no MC sample size too small to yield the point estimate:}

\begin{figure*}[h]
\centering
  \includegraphics[]{../week4/MC_sample_results.pdf}
\end{figure*}

\textcolor{red}{ The reason is as follows. In the g computation algorithm, our outcome for \texttt{wt\_82\_71} modeled using a linear model with no interactions between the exposure \texttt{qsmk} and any of the covariates. This model stipulates that the effect of \texttt{qsmk} is constant across all levels of the covariates included in the model. Thus, whether the point estimate for the ATE was generated from a Monte Carlo sample with one individual, or a Monte Carlo sample with 10 million individuals, nothing would change. }

\textcolor{red}{ On the other hand, the ETT displays some degree of dependence on the Monte Carlo sample size. This is because for the ETT, the average outcome that would be observed if everybody quit smoking [$E(Y^{a=1})$] is estimated as the average outcome in the sample among those who quit smoking. With a Monte Carlo sample size of about 10,000 (red line), ETT estimates begin to stabilize.}

\vskip .5cm 

\noindent{ \bf Question 5}: The outcome model in question three contains the exposure and 11 confounders, for a total of 12 variables. What is the total number of possible interactions in this model? What are the total number of 2-way interactions? Show your reasoning.

\textcolor{red}{ This is simply an application of the relevant combinatorial equations. For the total number of possible interactions, which includes 2-way, 3-way, all the way up to 12-way, we use the multiplication rule:}

\begin{equation*}
{\color{red}   2^{12} - 12 - 1 = 4,083}
\end{equation*}

\textcolor{red}{There are a total of 4,083 interactions possible with 12 variables.}

\textcolor{red}{For the total number of 2-way interactions, this is an application of choosing 2 out of 12:}

\begin{equation*}
{\color{red} {12 \choose 2} = \frac{12!}{2!(12 - 2)!} = 66}
\end{equation*}

\textcolor{red}{There are a total of 66 two way interactions.}

\vskip .5cm

\noindent{ \bf Question 6}: What happens to the results of the analysis if an interaction between race and sex is included in the outcome model?

\textcolor{red}{ See attached R program.}

\begin{table}[H]
\caption{Point estimates and 95\% confidence intervals quantifying the average treatment effect and the effect of treatment on the treated from models including and excluding race$\times$sex interaction.}
\centering
\begin{tabular}{rrrr}
  \hline
 &  & \multicolumn{2}{c}{95\% Confidence Limits} \\ 
 & Estimate & Lower & Upper \\ 
  \hline
ATE (without interaction) & 2.51 & 1.50 & 3.52 \\ 
ATE (with interaction) & 2.51 & 1.51 & 3.52 \\ 

ETT (without interaction) & 2.45 & 1.63 & 3.27 \\ 
ETT (with interaction) & 2.55 & 1.73 & 3.37 \\ 
   \hline
\end{tabular}
\end{table}

\textcolor{red}{Including an interaction between race and sex in the model does not meaningfully change point estimates.}

\noindent{ \bf Question 1}: Please define (mathematically) unstabilized and stabilized inverse probability weights for a binary exposure. Use mathematical arguments to describe why a very high/low propensity score can create problems with an inverse probability weighted estimator.

\vskip .5cm 

\noindent { \bf Question 2}: Consider the example data presented on page 4 of the IPW course notes:

\begin{table}[h]
\begin{center}
\begin{tabular}{llllll}
&&&&&\\
\hline
$C$ & $A$ & $Y$ & $N$  & $w$ & $sw$ \\
\hline \hline
0 & 0  & 94.3 & 344,052 & & \\
0 & 1  & 119.2 & 154,568 & &  \\
1 & 0  & 130.6 & 154,560 & & \\
1 & 1  & 155.7 & 346,820 & & \\
\hline
\end{tabular}
\end{center}
\end{table}

Please fill the last two columns by computing the unstabilized and stabilized inverse probability weights for each row.

\vskip .5cm 

\noindent{ \bf Question 3}: With the NHEFS data, use IPW to estimate the average treatment effect and the effect of treatment on the treated for the relation between quitting smoking (\texttt{qsmk}) and weight gain (\texttt{wt82\_71}). Present estimates for these effects on the mean difference scale. Adjust for the following variables: \texttt{smkintensity82\_71, exercise, sbp, dbp, sex, age, race, income, marital, school, asthma}. Use the same strategy to obtain complete cases that was illustrated in Application 1.

Please provide robust and bootstrapped (use 123 as the seed) 95\% confidence intervals with all point estimates.

In presenting your results, please provide the point estimates (on the mean difference scale) for these two effects, as well as a clear and concise interpretation of the effect. When interpreting, please consider threats to each identifiability assumption.

Additional points will be given for concision and clarity. Please present your findings as though you were submitting them for publication. Estimates for the ATE and ETT should be neatly arranged in a table that includes a legend/title.

\noindent{ \bf Question 4}: Consider a scenario with {\bf four} binary exposure measurements: $\{ a_1,a_2,a_3,a_4 \}$. Please interpret $\boldsymbol{\psi}_1$ in models 1, 2, and 3:
\begin{align}
  E(Y^{a_1,a_2,a_3,a_4}) & = \psi_0 + \psi_1 a_1 + \psi_2 a_2 + \psi_3 a_3 + \psi_4 a_4 \\
  E(Y^{a_1,a_2,a_3,a_4}) & = \psi_0 + \psi_1 f(a) \\ \notag
  & \hskip 1cm f(a) = (a_1+a_2+a_3+a_4)/4 \\ \notag
    E(Y^{a_1,a_2,a_3,a_4}) & = \psi_0 + \psi_1 g(a) \\ 
  & \hskip 1cm g(a) = (a_1+a_2+a_3+a_4)/2 \\ \notag
\end{align}



\noindent{ \bf Question 5}: Consider the following DAG:

\begin{figure}[H]
  \includegraphics{F4a}
\end{figure}

Discuss the identification problems for the following average causal effect contrasts:

A) If everyone were exposed at time 1 versus if no one were exposed at time 1.
B) If everyone were exposed at time 0 versus if no one were exposed at time 0.
C) If everyone were exposed at both time points versus if no one were exposed at both time points. 

\noindent{ \bf Question 6}: In class, we estimated the average treatment effect risk difference, risk ratio, and odds ratio for the relation between quitting smoking and high blood pressure of -0.129, 0.53, and 0.45, respectively. Suppose that the identification assumptions required for interpreting these associations as causal effects holds. Please interpret these effect measures.


\noindent{ \bf Question 7}: For the example of the relation between quitting smoking and high blood pressure, do you think the average treatment effect or the effect of treatment on the treated is more relevant? Explain why or why not.



