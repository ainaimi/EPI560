pacman::p_load(
  rio,          
  here,         
  skimr,        
  tidyverse,     
  lmtest,
  sandwich,
  broom,
  geepack,
  simstudy
)

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

sim_func <- function(sample_size=20, cluster_number=4){
  
  def <- defData(varname = "x", 
                 dist = "binary", 
                 id = "cid",
                 formula = "0",
                 link = "logit")
  def <- defData(def, "nperiods", formula = 3, 
                 dist = "normal")
  def2 <- defDataAdd(varname = "y", 
                     formula = "3 + 2 * x", 
                     dist = "nonrandom", link = "identity")
  
  dt <- genData(50, def)
  
  dtLong <- addPeriods(dt, idvars = "cid", nPeriods = 3)
  a <- addColumns(def2, dtLong)
  
  a <- data.frame(a)
  
  print(mean(a$x))
  
  mod1_ind <- geeglm(y ~ x,
                     family = gaussian(link = "identity"),
                     id = cid,
                     data = a,
                     scale.fix=TRUE,
                     corstr="independence")

  se1 <- summary(mod1_ind)$coefficients[2,2]

  mod1_exch <- geeglm(y ~ x,
                      family = gaussian(link = "identity"),
                      id = cid,
                      data = a,
                      scale.fix=TRUE,
                      corstr="exchangeable")

  se2 <- summary(mod1_exch)$coefficients[2,2]

  res <- list(c(se1, se2), QIC(mod1_ind, mod1_exch))

  return(res)
}

sim_res <- lapply(1:100, function(x) sim_func(x))

sim_res_se <- lapply(1:100, function(x) sim_res[[x]][[1]])

sim_res_qic <- lapply(1:100, function(x) sim_res[[x]][[2]])

sim_res_se <- do.call(rbind, sim_res_se)
sim_res_qic <- do.call(rbind, sim_res_qic)

sim_res_se
sim_res_qic



sim_func <- function(sample_size=20, cluster_number=4){
  
  def <- defData(varname = "xbase", formula = 5, variance = .4, 
                 dist = "gamma", id = "cid")
  def <- defData(def, "nperiods", formula = 3, 
                 dist = "noZeroPoisson")
  
  def2 <- defDataAdd(varname = "lambda", 
                     formula = "0.5 + 0.5 * period + 0.1 * xbase", 
                     dist="nonrandom", link = "log")
  
  dt <- genData(1000, def)
  
  dtLong <- addPeriods(dt, idvars = "cid", nPeriods = 3)
  dtLong <- addColumns(def2, dtLong)
  
  dtX3 <- addCorGen(dtOld = dtLong, idvar = "cid", nvars = 3, 
                    rho = .6, corstr = "cs", dist = "poisson", 
                    param1 = "lambda", cnames = "NewPois")
  
  dtX3
  
  mod1_ind <- geeglm(NewPois ~ period + xbase, 
                     family = poisson(link = "log"),
                     id = cid,
                     data = dtX3,
                     scale.fix=F,
                     corstr="independence")
  
  se1 <- summary(mod1_ind)$coefficients[2,2]
  
  mod1_exch <- geeglm(NewPois ~ period + xbase, 
                      family = poisson(link = "log"),
                      id = cid,
                      data = dtX3,
                      scale.fix=F,
                      corstr="exchangeable")
  
  se2 <- summary(mod1_exch)$coefficients[2,2]
  
  res <- list(c(se1, se2), CIC(mod1_ind, mod1_exch))
  
  return(res)
}


sim_res <- lapply(1:100, function(x) sim_func(x))

sim_res_se <- lapply(1:100, function(x) sim_res[[x]][[1]])

sim_res_qic <- lapply(1:100, function(x) sim_res[[x]][[2]])

sim_res_se <- do.call(rbind, sim_res_se)
sim_res_qic <- do.call(rbind, sim_res_qic)

sim_res_se
sim_res_qic