pacman::p_load(
  rio,          
  here,         
  skimr,        
  tidyverse,     
  lmtest,
  sandwich,
  broom,
  gt,
  BSDA
)

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

## run David's code, focusing just on OR

set.seed(123)

res <- data.frame(iteration = rep(0, 1000),
                  meanY = rep(0,1000),
                  meanA = rep(0,1000),
                  ATE1_OR_hat = rep(0, 1000),
                  ATT1_OR_hat = rep(0, 1000),
                  ATE2_OR_hat = rep(0, 1000),
                  ATT2_OR_hat = rep(0, 1000),
                  log_diff1 = rep(0, 1000),
                  log_diff2 = rep(0, 1000))

for(i in 1:10000){
  
  print(i)
  
  res[i,]$iteration <- i
  
  # simulate data from linear/logistic models
  n <- 1000
  W <- runif(n)
  A <- rbinom(n, 1, plogis(W))
  binary_Y <- rbinom(n, 1, plogis(A + 1.5*W + 1.5*A*W))
  data <- data.frame(W, A, binary_Y)
  
  res[i,]$meanY <- mean(binary_Y)
  res[i,]$meanA <- mean(A)
  
  # these are used throughout to compute g-comp
  data_Ais1 <- data; data_Ais1$A <- 1
  data_Ais0 <- data; data_Ais0$A <- 0
  
  ## focus on logistic regression
  # case 1, single logistic regression, no interactions
  outcome_model <- glm(
    binary_Y ~ A + W, 
    data = data,
    family = binomial()
  )
  
  pred_Ais1 <- predict(
    outcome_model, newdata = data_Ais1, type = "response"
  )
  pred_Ais0 <- predict(
    outcome_model, newdata = data_Ais0, type = "response"
  )
  
  # E[Y(1)] estimate (for ATE)
  EY1_hat <- mean(pred_Ais1)
  # E[Y(0)] estimate (for ATT)
  EY0_hat <- mean(pred_Ais0)
  # E[Y(1) | A = 1] estimate (for ATT)
  EY1_Ais1_hat <- mean(pred_Ais1[A == 1])
  # E[Y(0) | A = 1] estimate (for ATT)
  EY0_Ais1_hat <- mean(pred_Ais0[A == 1])
  
  # What happens on the OR scale?
  res[i,]$ATE1_OR_hat <- (EY1_hat/(1 - EY1_hat))/(EY0_hat/(1 - EY0_hat))
  res[i,]$ATT1_OR_hat <- (EY1_Ais1_hat/(1 - EY1_Ais1_hat))/(EY0_Ais1_hat/(1 - EY0_Ais1_hat))
  
  ## ain:
  ## for completeness, repeat for logistic regression
  # case 2, single logistic regression, WITH interactions
  outcome_model <- glm(
    binary_Y ~ A*W, 
    data = data,
    family = binomial()
  )
  
  pred_Ais1 <- predict(
    outcome_model, newdata = data_Ais1, type = "response"
  )
  pred_Ais0 <- predict(
    outcome_model, newdata = data_Ais0, type = "response"
  )
  
  # E[Y(1)] estimate (for ATE)
  EY1_hat <- mean(pred_Ais1)
  # E[Y(0)] estimate (for ATT)
  EY0_hat <- mean(pred_Ais0)
  # E[Y(1) | A = 1] estimate (for ATT)
  EY1_Ais1_hat <- mean(pred_Ais1[A == 1])
  # E[Y(0) | A = 1] estimate (for ATT)
  EY0_Ais1_hat <- mean(pred_Ais0[A == 1])
  
  # What happens on the OR scale?
  res[i,]$ATE2_OR_hat <- (EY1_hat/(1 - EY1_hat))/(EY0_hat/(1 - EY0_hat))
  res[i,]$ATT2_OR_hat <- (EY1_Ais1_hat/(1 - EY1_Ais1_hat))/(EY0_Ais1_hat/(1 - EY0_Ais1_hat))
  
  res[i,]$log_diff1 <- log(res[i,]$ATE1_OR_hat) - log(res[i,]$ATT1_OR_hat)
  res[i,]$log_diff2 <- log(res[i,]$ATE2_OR_hat) - log(res[i,]$ATT2_OR_hat)
}

head(res)
tail(res)

t.test(log(res$ATE1_OR_hat), log(res$ATT1_OR_hat), paired = TRUE)
t.test(log(res$ATE2_OR_hat), log(res$ATT2_OR_hat), paired = TRUE)

hist(res$meanA)

# ggplot() +
#   geom_histogram(data = res, 
#                  aes(log_diff1), fill = "gray") + 
#   scale_x_continuous(expand = c(0,0)) +
#   scale_y_continuous(expand = c(0,0)) +
#   geom_vline(xintercept = 0, color = "red")
# 
# ggplot() +
#   geom_histogram(data = res, 
#                  aes(log_diff2), fill = "gray") + 
#   scale_x_continuous(expand = c(0,0)) +
#   scale_y_continuous(expand = c(0,0)) +
#   geom_vline(xintercept = 0, color = "red")
# 
# summary(lm(meanY ~ log_diff1, data = res))
# ggplot() +
#   geom_point(data = res, 
#              aes(x=log_diff1, y = meanY), color = "gray") + 
#   scale_x_continuous(expand = c(0,0)) +
#   scale_y_continuous(expand = c(0,0))


p1 <- ggplot() +
  geom_histogram(data = res, 
                 aes(log(ATE1_OR_hat)), fill = "black") +
  geom_histogram(data = res, 
                 aes(log(ATT1_OR_hat)), fill = "green", alpha = .25) +
  xlab("Estimated log Odds Ratio") +
  ggtitle("logORs: ATT (green) and ATE (black) from a Logit Model with No Interaction") +
  scale_x_continuous(expand = c(0,0)) + scale_y_continuous(expand = c(0,0))

p2 <- ggplot() +
  geom_histogram(data = res, 
                 aes(log(ATE2_OR_hat)), fill = "black") +
  geom_histogram(data = res, 
                 aes(log(ATT2_OR_hat)), fill = "green", alpha = .25) +
  xlab("Estimated log Odds Ratio") +
  ggtitle("logORs: ATT (green) and ATE (black) from a Logit Model with Interaction")  +
  scale_x_continuous(expand = c(0,0)) + scale_y_continuous(expand = c(0,0))

gridExtra::grid.arrange(p1,p2, ncol = 2)

res_tab <- data.frame(
  the_contrast = c("log Odds Ratio"),
  ATE1 = c(mean(log(res$ATE1_OR_hat))),
  ATT1 = c(mean(log(res$ATT1_OR_hat))),
  diff1 = mean(res$log_diff1),
  ATE2 = c(mean(log(res$ATE2_OR_hat))),
  ATT2 = c(mean(log(res$ATT2_OR_hat))),
  diff2 = mean(res$log_diff2)
)

res_tab

res_tab |>
  gt(rowname_col = "the_contrast") |>
  fmt_number(decimals = 3) |>
  tab_spanner(
    label = "No Interaction",
    columns = c(ATE1, ATT1, diff1)
  ) |>
  tab_spanner(
    label = "Interaction",
    columns = c(ATE2, ATT2, diff2)
  ) |>
  cols_label(
    ATE1 = "ATE",
    ATT1 = "ATT",
    diff1 = "Difference",
    ATE2 = "ATE",
    ATT2 = "ATT",
    diff2 = "Difference"
  )