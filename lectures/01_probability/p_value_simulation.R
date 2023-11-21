pacman::p_load(
  here,         
  tidyverse,     
  lmtest,
  sandwich,
  paralllel
)

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

set.seed(123)
p.val_sim <- function(index, H0=0, theta = .25, sd_theta = 1, n=50){
  x <- rnorm(n, mean = theta, sd = sd_theta)
  z <- (mean(x) - H0)/(sd(x) / sqrt(length(x)))
  p.val <- 2*pnorm(-abs(z))
  
  return(p.val)
}

res0 <- mclapply(1:5e6, 
                 function(x) p.val_sim(index = x, 
                                       H0 = 0, 
                                       theta = .2, 
                                       sd_theta = 1, 
                                       n = 50),
                 mc.cores = detectCores() - 2)

res <- data.frame(p_values = do.call(rbind, res0))

head(res)

ggplot(res) + 
  geom_histogram(aes(x = p_values, 
                     y = after_stat(density)), 
                 bins = 60) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0)) +
  geom_density(aes(x = p_values), 
               kernel = "gaussian", 
               color = "red", 
               linewidth = 1) 
  geom_vline(xintercept = c(mean(res$p_values), 
                            median(res$p_values)), 
             color = c("blue", "cyan"))