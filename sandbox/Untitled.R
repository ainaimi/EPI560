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
x <- c(rep(1, 5e5),rep(0, 5e5))
res <- replicate(5e5, mean(sample(x, size = 50, replace = F)))

ggplot() + 
  geom_histogram(aes(x = res), bins = 30) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0))


a <- read_csv(here("data", "01_data", "nhefs_data.csv")) %>% 
  mutate(wt_delta = as.numeric(wt82_71>median(wt82_71)))

mod1 <- glm(wt_delta ~ qsmk + ht + age + sex + asthma, data = a, family = binomial("logit"))

test1 <- predict(mod1, type = "response")

test2 <- mod1$fitted.values

plot(test1,test2)


# Stabilized Weights for ATE, ETT, and ETU

propensity_score <- glm(qsmk ~ ht + age + sex + asthma, data = a, family = binomial("logit"))$fitted.values

sw_ate <- (mean(a$qsmk)/propensity_score)*a$qsmk + ((1 - mean(a$qsmk))/(1 - propensity_score))*(1 - a$qsmk)

sw_att <- a$qsmk + ((propensity_score)/(1 - propensity_score))*(1 - a$qsmk)

sw_atu <- ((1 - propensity_score)/propensity_score)*a$qsmk + (1 - a$qsmk)

rd_ate <- glm(wt_delta ~ qsmk, data = a, weights = sw_ate, family = quasibinomial("identity"))$coefficients[2]
rd_att <- glm(wt_delta ~ qsmk, data = a, weights = sw_att, family = quasibinomial("identity"))$coefficients[2]
rd_atu <- glm(wt_delta ~ qsmk, data = a, weights = sw_atu, family = quasibinomial("identity"))$coefficients[2]

rd_ate
rd_att
rd_atu
