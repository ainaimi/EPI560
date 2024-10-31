pacman::p_load(
  rio,          
  here,         
  skimr,        
  tidyverse,     
  lmtest,
  sandwich,
  broom,
  VGAM
)

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

n = 1000

x <- runif(n)

x <- cut(x, breaks = c(0, .33, .66, 1))

table(x)

c1 <- rbinom(n,1,.5)
c2 <- rbinom(n,1,.5)
c3 <- rbinom(n,1,.5)
c4 <- rbinom(n,1,.5)

ps_model <- vglm(x ~ c1 + c2 + c3 + c4, family = "multinomial")

summary(ps_model)

ps_matrix <- cbind(predict(ps_model, type = "response"), x)

ps_matrix

ps_matrix <- data.frame(ps_matrix)

pscore <- NULL
for(i in 1:n){
  pscore <- rbind(pscore, 
                  ps_matrix[i, ps_matrix[i,]$x]
                  )
}

## obtain numerator
ps_model <- vglm(x ~ 1, family = "multinomial")
summary(ps_model)
ps_matrix <- cbind(predict(ps_model, type = "response"), x)

ps_matrix

ps_matrix <- data.frame(ps_matrix)

pscore_num <- NULL
for(i in 1:n){
  pscore_num <- rbind(pscore_num, 
                      ps_matrix[i, ps_matrix[i,]$x]
  )
}


sw <- pscore_num/pscore

sw

quantile(sw, .99)

## how do you trim?

sw <- if_else(sw>quantile(sw, .99), 
              quantile(sw, .99),
              sw)