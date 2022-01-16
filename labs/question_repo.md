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


\noindent{ \bf Question 1}: Please provide {\bf the complete} definition of a p-value.

{\color{red} The p-value is defined as the probability of observing a result as extreme or more extreme if the null hypotheses were true  and there were {\bf no selection, confounding, and information bias}. Note this latter condition (no bias) is what \emph{completes} the definition, and is not typically included in statistical treatments.}

\vskip .5cm 

\noindent { \bf Question 2}: In a recent article, a group of prominent scientists/statisticians argued for redefining ``statistical significance,'' from 0.05 to 0.005. In no more than 1/2 a page, please provide your views on whether this change is a useful suggestion or not. Be sure to provide insights on the potential benefits and drawbacks to making such a change.

{\color{red} Changing the value at which researchers deem results to be ``statistically significant'' from 0.05 to 0.005 will do little to nothing to improve the quality or calibre of scientific research. This is because random error represents only a minor portion of the challenges that a researcher faces in seeking to quantify effect estimates. More threatening are the challenges imposed by confounding, selection, or information bias. 

In fact, it is likely that such a proposal will do more harm than good. The magnitude of the p-value is affected by two phenomena: 1) bias; and 2) sample size. By lowering the significance threshold to a smaller value, there is an increased likelihood that ``significant'' results are those that are subject to more extreme bias. On the other hand, it is also possible that clinically insignificant results are deemed significant by virtue of the fact that ``big data'' were used to quantify the effect, thus rendering a low p-value.

All told, rather than focus on some arbitrary threshold of a single (and easily misunderstood) measure, scientists would be better off thinking critically about all of the potential threats to their inferences.}

\vskip .5cm 

\noindent{ \bf Question 3}: With the NHEFS data, please re-do the analysis using IPW to estimate the average treatment effect and the effect of treatment on the treated for the relation between quitting smoking (\texttt{qsmk}) and weight gain (\texttt{wt82\_71}). Present estimates for these effects on the mean difference scale. Adjust for the following variables: \texttt{smkintensity82\_71, exercise, sbp, dbp, sex, age, race, income, marital, school, asthma}. Use the same strategy to obtain complete cases that was illustrated in Application 1.

This time, please provide the point estimates for the ATE and ETT, as well as p-values based on the $Z$-test using the robust variance estimator, and $p$-values based on a permutation test. Please interpret the ATE and ETT as {\bf causal effects} assuming all relevant identifiability assumptions hold (no need to discuss these assumptions here). Additionally, please provide a complete interpretation of the estimated p-values.

The following code can be used to obtain estimates representing the distribution of the null for the ATE and ETT, provided the dataset is named ``\texttt{nhefs\_data}'':

\begin{verbatim}
  set.seed(123) 
  res <- NULL 
  permutations <- 2000 
  permuted <- nhefs_data
  for(i in 1:permutations){
    permuted$qsmk <- permuted$qsmk[sample(length(permuted$qsmk))]
    
    propensity <- glm(qsmk ~ smkintensity82_71 + exercise + sbp + dbp + sex + 
                      age + race + income + marital + school + asthma,
                    data=permuted,family=binomial("logit"))$fitted.values
                    
        sw <- (mean(permuted$qsmk)/propensity)*permuted$qsmk + 
          (mean(1-permuted$qsmk)/(1-propensity))*(1-permuted$qsmk)
  
    sw_ett <- mean(permuted$qsmk)*permuted$qsmk + 
          (mean(1-permuted$qsmk)*(propensity/(1-propensity)))*(1-permuted$qsmk)
    
      ATE_mod <- glm(wt82_71 ~ qsmk, data=permuted,
            weights=sw,family=gaussian("identity"))
      ATE_permuted <- coef(ATE_mod)[2]
  
      ETT_mod <- glm(wt82_71 ~ qsmk, data=permuted,
            weights=sw_ett,family=gaussian("identity"))
      ETT_permuted <- coef(ETT_mod)[2]
  
      res <- rbind(res,cbind(ATE_permuted,ETT_permuted))
}

res <- data.frame(res) 
names(res) <- c("ATE","ETT")
\end{verbatim}

To obtain the robust standard error, fit the IP-weighted model and use the \texttt{vcovHC} function from the \texttt{sandwich} package. For example, for the ATE:

\begin{verbatim}
ATE_model <- glm(wt82_71 ~ qsmk,data=nhefs_data,
        weights=sw,family=gaussian(link = "identity"))
ATE <- round(coef(ATE_model),2)[2]
z = (ATE - 0)/vcovHC(ATE_model, type = "HC1")[2,2]
p.value_ATE <- round(2*pnorm(-abs(z)),4)
\end{verbatim}

{\color{red} 

After implementing IP-weighting for estimating the ATE and the ETT, as well as robust and permutation based p-values for these associations, we obtain the following results.
% latex table generated in R 3.5.1 by xtable 1.8-3 package
% Thu Nov  1 21:24:32 2018
\begin{table}[ht]
\centering
\begin{tabular}{rrrrrr}
  \hline
&  & \multicolumn{2}{2}{Confidence Limits} & \multicolumn{2}{2}{P-Values} \\
& Estimate & Lower & Upper & Z-score & Permutation \\ 
  \hline
ATE & 2.00 & 0.44 & 3.57 & 0.00 & 0.00 \\ 
ETT & 3.77 & 1.32 & 6.22 & 0.02 & 0.00 \\ 
   \hline
\end{tabular}
\end{table}

These effects can be interpreted as follows: If all individuals in the population were to quit smoking, the mean weight loss in the population would be 2 kg higher than if no individuals were to quit smoking (ATE). On the other hand, among those who actually quit smoking, the effect of quitting led to a 3.8 kg increase in weight between 1972 and 1981.

The z-score based p-values suggest that the probability of observing an ATE and ETT as extreme or more than what was observed is less than 0.001 and equal to 0.02, respectively.

For the permutation p-values, the interpretation is identical, except the probabilities are less than 0.001 for both the ATE and the ETT.

}

\noindent{ \bf Question 4}: In a 2016 study of the relation between statins and the risk of glioma, Seliger et al. reported that ``this matched case-control study revealed a null association between statin use and risk of glioma.'' Furthermore, they stated that their findings ``do not support previous sparse evidence of a possible inverse association between statin use and glioma risk.'' 

The estimated odds ratio in the study by Seliger et al was 0.75, with 95\% CIs of 0.48, 1.17. The ``previous sparse evidence'' they referred to were studies that reported odds ratios of 0.72 (0.52-1.00) and 0.76 (0.59-0.98).

In 1/2 a page, please discuss whether you agree with the statement that the findings by Seliger et al ``do not support previous \ldots evidence.'' Explain why you agree/disagree with the statement.

{\color{red} The statement by Seliger et al is simply nonsense, and based on a dramatic oversimplification of the information contained in the confidence intervals. To see specifically why, it is possible to construct distributions of the estimates from each study, and visualize the extent to which the information in each overlaps. To do this, we assume that the log of the estimator is normally distributed. 

The log-OR estimated by Seliger was -0.29. We can use the upper and lower CI bounds by Seliger to obtain the standard error via the following equation:
$$ SE = \frac{\log(UCL) - \log(LCL)}{2\times 1.96} $$

Using the log-ORs and their respective standard errors, we can then derive the density functions representing the distribution of each estimator:
\begin{figure}[h]
  \centering
  \includegraphics[scale=.8]{overlap_plot.pdf}
\end{figure}  

In the above Figure, the black line is the distribution of the OR from the Seliger et al study. The blue and red lines are from the other studies. Clearly, the information contained in both estimators are very similar, and support the same inferences about the relation between statins and the risk of glioma.

}

%\noindent{ \bf Question 5}: Can you interpret the confidence intervals provided by Seliger et al? Why or why not?


\noindent{ \bf Question 5}: Suppose you conduct a study and estimate a mean difference with 95\% CIs of 1.71 and 3.23. Please indicate whether the following statements about these estimated CIs are true or false and why:
\begin{itemize}
  \item[1.] The probability that the true mean is greater than zero is 95\%.
  \item[2.] The probability that the true mean equals zero is $\leq 5\%$.
  \item[3.] There is a 95\% probability that the true mean lies between 1.71 and 3.23.
  \item[4.] We can be 95\% confident that the true mean lies between 1.71 and 3.23.
  \item[5.] If we were to repeat the experiment 100 times, the true mean would fall between 1.71 and 3.23 95\% of the time.
\end{itemize}

{\color{red} None of the above are correct. The key issue is that the specific values obtained for an upper and lower confidence bound do not possess any probabilistic interpretation: the truth is either contained in the bound, or it's not. Thus, for examples 1, 2, and 3, the fact that the probability of the truth is referred to at all is a giveaway that these interpretations are false. In example 4, the word ``confident'' is used instead of probability. Unless one clarifies some highly technical definition of the word confident that renders the statement tautologically true, this is simply a word game. Finally, for example 5, the truth will not fall in specific bounds at any percentage except 0\% or 100\%, making this last example false. }



