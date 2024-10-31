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

set.seed(123)

expit <- function(x){1/(1+exp(-x))}

## IMPORT DATA
a <- read_delim(here("data","asthma.txt"), ' ') %>% 
  mutate(educ = as.numeric(educ>4)) %>% sample_n(size = 634, replace = T)

table(a$educ)

table(a$aqoc)
mean(a$pg)

mod_ps <- glm(pg ~ sex + educ + age, data = a, family = binomial("logit"))

ps_coefs <- summary(mod_ps)$coefficients[,1]

b <- a %>% select(sex, educ, age)

b$treatment <- rbinom(n = nrow(b), size = 1, 
                      p = expit(cbind(1, as.matrix(b))%*%ps_coefs))

b <- b %>% select(treatment, sex, educ, age)

mod_mu <- glm(aqoc ~ pg + sex + educ + age, 
              data = a, 
              family = binomial("logit"))

mu_coefs <- summary(mod_mu)$coefficients[,1]

names(mu_coefs)[2] <- "exposure"

mu_coefs[1:2] <- c(-1.2, log(.5))

b$outcome <- rbinom(n = nrow(b), size = 1, 
                    p = expit(cbind(1, as.matrix(b))%*%mu_coefs))

table(b$outcome)
mean(b$outcome)

b$id <- 1:nrow(b)

b <- b %>% select(id, outcome, treatment, sex, educ, age)

b 

write.csv(b, here("QE_data.csv"))