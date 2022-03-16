packages <- c("data.table","tidyverse","skimr","here","survival","splines")

for (package in packages) {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package, repos='http://lib.stat.cmu.edu/R/CRAN')
  }
}

for (package in packages) {
  library(package, character.only=T)
}

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

# lab exercise: go through code, understand; run code under different time_divisor scenarios; generate time-specific risk differences; bootstrap.

time_divisor <- 8

a <- read_csv(here("data","2022_03_09-section1_cohort.csv")) %>% 
  mutate(stop_rounded = ceiling(stop)*time_divisor,
         cs_outcome=as.numeric(outcome==1))

a

# one to many transform:
b <- a %>% 
  uncount(stop_rounded) %>% 
  group_by(ID) %>% 
  mutate(counter = 1,
         time_var = cumsum(counter)/time_divisor,
         last_id = !duplicated(ID, fromLast = T),
         cs_outcome = cs_outcome*last_id) %>% 
  ungroup(ID) %>% 
  select(ID,time_var,stop,exposure,confounder,outcome,cs_outcome)

b %>% print(n=60)

max(b$time_var)

# run the pooled logistic model
plr_model <- glm(cs_outcome ~ bs(time_var, df = 4) + exposure + confounder, data=b, family=binomial(link = "logit"))
summary(plr_model)

# predict the time-specific probabilities
mu <- tibble(b,mu=predict(plr_model,newdata=b,type="response"))
mu1 <- tibble(b,mu1=predict(plr_model,newdata=transform(b,exposure=1),type="response"))
mu0 <- tibble(b,mu0=predict(plr_model,newdata=transform(b,exposure=0),type="response"))

# average time-specific probabilities over all individuals in the sample
# this step is the "standardization" step, but to which population?
mu <- mu %>% group_by(time_var) %>% summarize(mean_mu=mean(mu))
mu1 <- mu1 %>% group_by(time_var) %>% summarize(mean_mu1=mean(mu1))
mu0 <- mu0 %>% group_by(time_var) %>% summarize(mean_mu0=mean(mu0))

# obtain cumulative risks over time
mu <- mu %>% mutate(cum_risk = cumsum(mean_mu))
mu1 <- mu1 %>% mutate(cum_risk1 = cumsum(mean_mu1))
mu0 <- mu0 %>% mutate(cum_risk0 = cumsum(mean_mu0))

mu
mu1
mu0

# plot the risks and risk differences
mu_dat <- left_join(mu1,mu0,by="time_var") %>% mutate(risk_difference = cum_risk1 - cum_risk0)

mu_dat$risk_difference

## bootstrap: note the complication, we have to resample ppl not time
boot_num <- 100
mu_boot <- NULL
mu1_boot <- NULL
mu0_boot <- NULL

for(i in 1:boot_num){
  
  set.seed(i)
  index <- sample(1:nrow(a), nrow(a), replace = T)
  boot_dat <- a[index,] %>% mutate(stop_rounded = ceiling(stop)*time_divisor,
                                   cs_outcome=as.numeric(outcome==1))
  
  # one to many transform:
  b_ <- boot_dat %>% 
    mutate(counter_col = 1:n(),
           newID = paste0(ID,counter_col)) %>% ## note the need for newID!
    uncount(stop_rounded) %>% 
    group_by(newID) %>% 
    mutate(counter = 1,
           time_var = cumsum(counter)/time_divisor,
           last_id = !duplicated(ID, fromLast = T),
           cs_outcome = cs_outcome*last_id) %>% 
    ungroup(newID) %>% 
    select(newID,time_var,stop,exposure,confounder,outcome,cs_outcome)
  
  # run the pooled logistic model
  plr_model <- glm(cs_outcome ~ bs(time_var, df = 4) + exposure + confounder, data=b_, family=binomial(link = "logit"))
  
  # predict the time-specific probabilities
  mu_ <- tibble(b,mu=predict(plr_model,newdata=b,type="response"))
  mu1_ <- tibble(b,mu1=predict(plr_model,newdata=transform(b,exposure=1),type="response"))
  mu0_ <- tibble(b,mu0=predict(plr_model,newdata=transform(b,exposure=0),type="response"))
  
  # average time-specific probabilities over all individuals in the sample
  # this step is the "standardization" step, but to which population?
  mu_ <- mu_ %>% group_by(time_var) %>% summarize(mean_mu=mean(mu))
  mu1_ <- mu1_ %>% group_by(time_var) %>% summarize(mean_mu1=mean(mu1))
  mu0_ <- mu0_ %>% group_by(time_var) %>% summarize(mean_mu0=mean(mu0))
  
  # obtain cumulative risks over time
  mu_ <- mu_ %>% mutate(cum_risk = cumsum(mean_mu), boot_repl=i)
  mu1_ <- mu1_ %>% mutate(cum_risk1 = cumsum(mean_mu1), boot_repl=i)
  mu0_ <- mu0_ %>% mutate(cum_risk0 = cumsum(mean_mu0), boot_repl=i)

  mu_boot <- rbind(mu_boot,mu_)
  mu1_boot <- rbind(mu1_boot,mu1_)
  mu0_boot <- rbind(mu0_boot,mu0_)
  
  mu_dat_boot <- left_join(mu1_boot,mu0_boot,by=c("time_var","boot_repl")) %>% mutate(risk_difference = cum_risk1 - cum_risk0)
  
}

## plot stuff
# note the need for layering! bootstrap comes before empirical estimate
ggplot() + 
  geom_step(data=mu,aes(x = time_var, y = cum_risk), linetype=2) +
  geom_step(data=mu0_boot,aes(x = time_var, y = cum_risk0, group=boot_repl), color="lightblue", alpha=.2) + 
  geom_step(data=mu0,aes(x = time_var, y = cum_risk0), color="blue") +
  geom_step(data=mu1_boot,aes(x = time_var, y = cum_risk1, group=boot_repl), color="pink", alpha=.2) +
  geom_step(data=mu1,aes(x = time_var, y = cum_risk1), color="red") +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0), limits = c(0,1)) +
  ylab("Cumulative Risk") + xlab("Time")

# note the need for layering! bootstrap comes before empirical estimate
ggplot(mu_dat) + 
  geom_line(data=mu_dat_boot,aes(x = time_var, y = risk_difference, group=boot_repl), color="gray", alpha=.2) +
  geom_line(aes(x = time_var, y = risk_difference)) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0), limits = c(0,1)) +
  ylab("Cumulative Risk Difference") + xlab("Time")


## standard KM curve
surv_model <- survfit(Surv(time = stop, event = cs_outcome) ~ 1, data = a)

plot_dat <- tibble(time = surv_model$time, risk = 1 - surv_model$surv)

max(plot_dat$risk)

plot1 <- ggplot(plot_dat) + 
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  scale_x_continuous(expand = c(0,0)) + 
  ylab("Cumulative Risk") + 
  xlab("Time on Study") + 
  geom_step(aes(x = time, y = risk))

plot1 + geom_hline(yintercept = max(plot_dat$risk), color="red")

