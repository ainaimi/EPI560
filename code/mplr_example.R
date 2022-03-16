packages <- c("data.table","tidyverse","skimr",
              "here","survival","splines","VGAM")

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

a <- read_csv(here("data","2022_03_09-section1_cohort.csv")) %>% mutate(stop_rounded = ceiling(stop)*time_divisor,
                                                                        cs_outcome=as.numeric(outcome==1))

a

# one to many transform:
b <- a %>% 
  uncount(stop_rounded) %>% 
  group_by(ID) %>% 
  mutate(counter = 1,
         time_var = cumsum(counter)/time_divisor,
         last_id = !duplicated(ID, fromLast = T),
         cs_outcome = cs_outcome*last_id,
         outcome = outcome*last_id) %>% 
  ungroup(ID) %>% 
  select(ID,time_var,stop,exposure,confounder,outcome,cs_outcome)

b %>% print(n=10)

# run the multinomial pooled logistic model
pmr1 <- vglm(outcome ~ time_var + exposure + 
               confounder, data=b, 
             family=multinomial(refLevel = 1))

# create three datasets, one that predicts under natural conditions
# and two that predict under exposure = [0, 1]
## FOR OUTCOME = 1
mu_1 <- tibble(b,mu_1=predict(pmr1,newdata=b,type="response")[,2])
mu_11 <- tibble(b,mu_11=predict(pmr1,newdata=transform(b,exposure=1),type="response")[,2])
mu_10 <- tibble(b,mu_10=predict(pmr1,newdata=transform(b,exposure=0),type="response")[,2])
## FOR OUTCOME = 2
mu_2 <- tibble(b,mu_2=predict(pmr1,newdata=b,type="response")[,3])
mu_21 <- tibble(b,mu_21=predict(pmr1,newdata=transform(b,exposure=1),type="response")[,3])
mu_20 <- tibble(b,mu_20=predict(pmr1,newdata=transform(b,exposure=0),type="response")[,3])

# average the predictions for each individual stratified by time
## FOR OUTCOME = 1
mu_1 <- mu_1 %>% group_by(time_var) %>% summarize(mean_mu_1=mean(mu_1))
mu_11 <- mu_11 %>% group_by(time_var) %>% summarize(mean_mu_11=mean(mu_11))
mu_10 <- mu_10 %>% group_by(time_var) %>% summarize(mean_mu_10=mean(mu_10))
## FOR OUTCOME = 2
mu_2 <- mu_2 %>% group_by(time_var) %>% summarize(mean_mu_2=mean(mu_2))
mu_21 <- mu_21 %>% group_by(time_var) %>% summarize(mean_mu_21=mean(mu_21))
mu_20 <- mu_20 %>% group_by(time_var) %>% summarize(mean_mu_20=mean(mu_20))

# cumulatively sum the predictions over time to estimate cumulative risk
## FOR OUTCOME = 1
mu_1 <- mu_1 %>% mutate(cum_risk_1 = cumsum(mean_mu_1))
mu_11 <- mu_11 %>% mutate(cum_risk_11 = cumsum(mean_mu_11))
mu_10 <- mu_10 %>% mutate(cum_risk_10 = cumsum(mean_mu_10))
## FOR OUTCOME = 2
mu_2 <- mu_2 %>% mutate(cum_risk_2 = cumsum(mean_mu_2))
mu_21 <- mu_21 %>% mutate(cum_risk_21 = cumsum(mean_mu_21))
mu_20 <- mu_20 %>% mutate(cum_risk_20 = cumsum(mean_mu_20))

# plot the risks and risk differences
mu_dat_1 <- left_join(mu_11,mu_10,by="time_var") %>% 
  mutate(risk_difference_1 = cum_risk_11 - cum_risk_10)

mu_dat_2 <- left_join(mu_21,mu_20,by="time_var") %>% 
  mutate(risk_difference_2 = cum_risk_21 - cum_risk_20)

mu_dat_1$risk_difference_1
mu_dat_2$risk_difference_2

## bootstrap: note the complication, we have to resample ppl not time
boot_num <- 100
mu_1boot  <- mu_2boot <- NULL
mu_11boot <- mu_21boot <- NULL
mu_10boot <- mu_20boot <- NULL

for(i in 1:boot_num){
  
  set.seed(i)
  index <- sample(1:nrow(a), nrow(a), replace = T)
  boot_dat <- a[index,] %>% mutate(stop_rounded = ceiling(stop)*time_divisor,
                                   cs_outcome=as.numeric(outcome==1))
  
  # one to many transform:
  b_ <- boot_dat %>% 
    mutate(counter_col = 1:n(),
           newID = paste0(ID,counter_col/1000)) %>% ## note the need for newID!
    uncount(stop_rounded) %>% 
    group_by(newID) %>% 
    mutate(counter = 1,
           last_id = !duplicated(newID, fromLast = T),
           time_var = cumsum(counter)/time_divisor,
           cs_outcome = cs_outcome*last_id,
           outcome = outcome*last_id) %>% 
    ungroup(newID) %>% 
    mutate(row_num = 1:n()) %>% 
    select(newID,time_var,stop,exposure,confounder,outcome,cs_outcome)
  
  cat(paste(i, max(b_$time_var), "\n"))
  
  # run the multinomial pooled logistic model
  pmr1 <- vglm(outcome ~ time_var + exposure + 
                 confounder, data=b_, 
               family=multinomial(refLevel = 1))
  
  # create three datasets, one that predicts under natural conditions
  # and two that predict under exposure = [0, 1]
  ## FOR OUTCOME = 1
  mu_1 <- tibble(b_,mu_1=predict(pmr1,newdata=b_,type="response")[,2])
  mu_11 <- tibble(b_,mu_11=predict(pmr1,newdata=transform(b_,exposure=1),type="response")[,2])
  mu_10 <- tibble(b_,mu_10=predict(pmr1,newdata=transform(b_,exposure=0),type="response")[,2])
  ## FOR OUTCOME = 2
  mu_2 <- tibble(b_,mu_2=predict(pmr1,newdata=b_,type="response")[,3])
  mu_21 <- tibble(b_,mu_21=predict(pmr1,newdata=transform(b_,exposure=1),type="response")[,3])
  mu_20 <- tibble(b_,mu_20=predict(pmr1,newdata=transform(b_,exposure=0),type="response")[,3])
  
  # average the predictions for each individual stratified by time
  ## FOR OUTCOME = 1
  mu_1 <- mu_1 %>% group_by(time_var) %>% summarize(mean_mu_1=mean(mu_1))
  mu_11 <- mu_11 %>% group_by(time_var) %>% summarize(mean_mu_11=mean(mu_11))
  mu_10 <- mu_10 %>% group_by(time_var) %>% summarize(mean_mu_10=mean(mu_10))
  ## FOR OUTCOME = 2
  mu_2 <- mu_2 %>% group_by(time_var) %>% summarize(mean_mu_2=mean(mu_2))
  mu_21 <- mu_21 %>% group_by(time_var) %>% summarize(mean_mu_21=mean(mu_21))
  mu_20 <- mu_20 %>% group_by(time_var) %>% summarize(mean_mu_20=mean(mu_20))
  
  # cumulatively sum the predictions over time to estimate cumulative risk
  ## FOR OUTCOME = 1
  mu_1 <- mu_1   %>% mutate(boot_repl=i, cum_risk_1 = cumsum(mean_mu_1))
  mu_11 <- mu_11 %>% mutate(boot_repl=i, cum_risk_11 = cumsum(mean_mu_11))
  mu_10 <- mu_10 %>% mutate(boot_repl=i, cum_risk_10 = cumsum(mean_mu_10))
  ## FOR OUTCOME = 2
  mu_2 <- mu_2   %>% mutate(boot_repl=i, cum_risk_2 = cumsum(mean_mu_2))
  mu_21 <- mu_21 %>% mutate(boot_repl=i, cum_risk_21 = cumsum(mean_mu_21))
  mu_20 <- mu_20 %>% mutate(boot_repl=i, cum_risk_20 = cumsum(mean_mu_20))
  
  
  mu_1boot <- rbind(mu_1boot,mu_1)
  mu_2boot <- rbind(mu_2boot,mu_2)
  
  mu_11boot <- rbind(mu_11boot,mu_11)
  mu_21boot <- rbind(mu_21boot,mu_21)
  
  mu_10boot <- rbind(mu_10boot,mu_10)
  mu_20boot <- rbind(mu_20boot,mu_20)
  
}

# plot the risks and risk differences
mu_dat_1boot <- left_join(mu_11boot,mu_10boot,by=c("time_var","boot_repl")) %>% 
  mutate(risk_difference_1 = cum_risk_11 - cum_risk_10)

mu_dat_2boot <- left_join(mu_21boot,mu_20boot,by=c("time_var","boot_repl")) %>% 
  mutate(risk_difference_2 = cum_risk_21 - cum_risk_20)

## plot stuff
# note the need for layering! bootstrap comes before empirical estimate
ggplot() + 
  geom_step(data=mu_1boot,aes(x = time_var, y = cum_risk_1, group=boot_repl), color="lightblue", alpha=.2) + 
  geom_step(data=mu_1,aes(x = time_var, y = cum_risk_1), color="blue") +
  geom_step(data=mu_2boot,aes(x = time_var, y = cum_risk_2, group=boot_repl), color="pink", alpha=.2) +
  geom_step(data=mu_2,aes(x = time_var, y = cum_risk_2), color="red") +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0), limits = c(0,1)) +
  ylab("Cumulative Risk") + xlab("Time")

# note the need for layering! bootstrap comes before empirical estimate

ggplot() + 
  geom_line(data=mu_dat_1boot,aes(x = time_var, y = risk_difference_1, group=boot_repl), color="lightblue", alpha=.2) +
  geom_line(data=mu_dat_1,aes(x = time_var, y = risk_difference_1), color="blue") +
  geom_line(data=mu_dat_2boot,aes(x = time_var, y = risk_difference_2, group=boot_repl), color="pink", alpha=.2) +
  geom_line(data=mu_dat_2,aes(x = time_var, y = risk_difference_2), color="red") +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0), limits = c(-1,1)) +
  ylab("Risk Difference") + xlab("Time")





