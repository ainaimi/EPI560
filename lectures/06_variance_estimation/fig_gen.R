packages <- c("data.table","tidyverse","skimr","here")

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

res <- list()
for(i in 1:200000){
  
  set.seed(i)
  n = 1e3
  p = 10
  
  ## CONFOUNDERS
  sigma <- matrix(0,nrow=p,ncol=p); diag(sigma) <- 1
  c     <- rmvnorm(n, mean=rep(0,p), sigma=sigma)
  
  ## EXPSOURE
  pi_x <- expit(-2 + log(2)*c[,1] + log(2)*c[,2])
  x <- rbinom(n, 1, pi_x)
  
  ## OUTCOME
  pi_m <- expit(-2 + log(2)*x + log(2)*c[,1] + log(2)*c[,2])
  y <- rbinom(n, 1, pi_m)
  
  a <- data.frame(y,x,c)
  
  names(a) <- c("y", "x", paste0("c", 1:10))
  
  model_mu <- glm(y ~ x + c1 + c2, data = a, family = binomial("logit"))
  
  estimate <- summary(model_mu)$coefficients[2,1]
  
  std.err <- summary(model_mu)$coefficients[2,2]
  
  res[[i]] <- c(estimate, std.err)
  
}

res <- do.call(rbind, res)
res <- data.frame(res)
names(res) <- c("estimate", "std.err")

dim(res)

round(sd(res$estimate), 3)
round(mean(res$std.err), 3)

seq_list <- seq(1, 200000, by=1000)

res_i <- NULL
for(i in seq_list){
  res_i <- rbind(res_i, 
                 c(i, sd(res[1:i,]$estimate), mean(res[1:i,]$std.err)))
}

a <- data.frame(res_i)
names(a) <- c("N", "sd(estimate)", "mean(se)")

a <- a %>% 
  filter(N>1) %>% 
  mutate(N = N - 1)

ggplot(a) +
  geom_line(aes(x = N, y = `sd(estimate)`), linetype = "dashed") +
  geom_line(aes(x = N, y = `mean(se)`), color = "blue") +
  ylim(.21,.23)