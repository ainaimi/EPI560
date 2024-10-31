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

a <- read_csv(here("data","nhefs.csv")) %>% sample_frac(size = 10, replace = T)

a %>% print(n=5)

VIM::aggr(a)

seed <- 123
set.seed(seed)

boot_func <- function(boot_num){
  
  index <- sample(1:nrow(a), nrow(a), replace = T)
  boot <- a[index,]
  
  mod1 <- glm(wt82_71 ~ qsmk + sex, 
              data = boot,
              family = gaussian(link = "identity"))
  
  res <- c(coef(mod1))
  
  return(res)
}

boot_res <- lapply(1:1000, function(x) boot_func(x))
boot_res <- do.call(rbind,boot_res)
boot_res

cov(boot_res)/sqrt(nrow(a))

mod1 <- glm(wt82_71 ~ qsmk + sex, 
            data = a,
            family = gaussian(link = "identity"))

vcov(mod1)

sd(boot_res[,2]) - summary(mod1)$coefficients[2,2]