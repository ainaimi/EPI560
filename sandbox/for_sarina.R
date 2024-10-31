# simulate data from linear/logistic models
n <- 1000
W <- runif(n)
A <- rbinom(n, 1, plogis(W))
binary_Y <- rbinom(n, 1, plogis(A + W + A*W))
continuous_Y <- A + W + A*W +rnorm(n)
data <- data.frame(W, A, binary_Y, continuous_Y)

# these are used throughout to compute g-comp
data_Ais1 <- data; data_Ais1$A <- 1
data_Ais0 <- data; data_Ais0$A <- 0


# case 1, single linear regression, no interactions
outcome_model <- glm(
	continuous_Y ~ A + W, 
	data = data,
	family = gaussian()
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

ATE_hat <- EY1_hat - EY0_hat
ATT_hat <- EY1_Ais1_hat - EY0_Ais1_hat

# equivalent up to rounding error
ATE_hat - ATT_hat



# case 2, single linear regression, interactions
outcome_model <- glm(
	continuous_Y ~ A*W, 
	data = data,
	family = gaussian()
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
# note that this is EXACTLY THE SAME (up to rounding error) 
# as the mean of Y in the treated (because outcome_model above 
# contains an intercept)
EY1_Ais1_hat - mean(continuous_Y[A == 1])

# E[Y(0) | A = 1] estimate (for ATT)
EY0_Ais1_hat <- mean(pred_Ais0[A == 1])

ATE_hat <- EY1_hat - EY0_hat
ATT_hat <- EY1_Ais1_hat - EY0_Ais1_hat

# not equivalent
ATE_hat - ATT_hat


# case 3, linear regression for each treatment arm
# the same as a model where every term is interacted with treatment
# i.e., EXACTLY the same as case 2 above
outcome_model_Ais1 <- glm(
	continuous_Y ~ W, 
	data = data[data$A == 1,],
	family = gaussian()
)

pred_Ais1 <- predict(
	outcome_model_Ais1, newdata = data, type = "response"
)

outcome_model_Ais0 <- glm(
	continuous_Y ~ W, 
	data = data[data$A == 0,],
	family = gaussian()
)

pred_Ais0 <- predict(
	outcome_model_Ais0, newdata = data, type = "response"
)

# E[Y(1)] estimate (for ATE)
EY1_hat_two_models <- mean(pred_Ais1)
# E[Y(0)] estimate (for ATT)
EY0_hat_two_models <- mean(pred_Ais0)
# E[Y(1) | A = 1] estimate (for ATT)
EY1_Ais1_hat_two_models <- mean(pred_Ais1[A == 1])
# E[Y(0) | A = 1] estimate (for ATT)
EY0_Ais1_hat_two_models <- mean(pred_Ais0[A == 1])

ATE_hat_two_models <- EY1_hat_two_models - EY0_hat_two_models
ATT_hat_two_models <- EY1_Ais1_hat_two_models - EY0_Ais1_hat_two_models

# not equivalent
ATE_hat_two_models - ATT_hat_two_models

# but exactly the same (up to rounding error) as single model with trt * covariate interactions
ATE_hat_two_models - ATE_hat
ATT_hat_two_models - ATT_hat


## now repeat for logistic regression
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

ATE_hat <- EY1_hat - EY0_hat
ATT_hat <- EY1_Ais1_hat - EY0_Ais1_hat

# NOT equivalent due to non-collapsibility
ATE_hat - ATT_hat

