pacman::p_load(
  rio,          
  here,         
  skimr,        
  tidyverse,     
  lmtest,
  sandwich,
  broom
)

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

file_loc <- url("https://bit.ly/47ECRcs")
nhefs <- read_csv(file_loc) %>%
  dplyr::select(qsmk,wt82_71,sex,age) %>% 
  mutate(wt_delta = as.numeric(wt82_71 > median(wt82_71, na.rm = T))) %>% 
  dplyr::select(-wt82_71) %>% 
  na.omit(.)

nhefs

expit <- function(x){1/(1+exp(-x))}
logit <- function(x){log(x/(1 - x))}
dlogit <- function(x){1/(x*(1 - x))}
var_func <- function(p){p*(1-p)}


def WLS(X, W, z):
  
  # Normal equations of weighted least squares
  XtWX = X.T @ W @ X
XtWz = X.T @ W @ z
b = np.linalg.inv(XtWX) @ XtWz

return b

def Likelihood(p, y):
  
  # Log-likelihood of logistic regression
  L = y * np.log(p) + (1 - y) * np.log(1 - p)
return sum(L)

