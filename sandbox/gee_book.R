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


## import some datasets

bmi_cluster <- read_csv(here("data", "cluster_trial_data_bmi.csv"))

lead_data <- read_csv(here("data", "longitudinal_lead_data.csv"))

ships_data <- read_csv(here("data", "longitudinal_ships.csv"))

wheeze_data <- read_csv(here("data", "longitudinal_wheeze.csv"))


set.seed(123)
n = 50
x <- rbinom(n, size = 1, prob = .5)
y <- rpois(n, lambda = exp(2 + log(1.5)*x))

sim_data <- data.frame(y,x)

head(sim_data)

hist(y)

## FIML for Poisson Regression: Page 23 Hardin and Hilbe GEE book

mle_poisson <- function(){
  
}
