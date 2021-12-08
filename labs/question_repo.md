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




