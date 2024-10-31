pacman::p_load(
  rio,          
  here,         
  skimr,        
  tidyverse,     
  lmtest,
  sandwich,
  broom,
  geepack
)

thm <- theme_classic() +
  theme(
    legend.position = "top",
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key = element_rect(fill = "transparent", colour = NA)
  )
theme_set(thm)

cluster_trial <- read_csv(here("data","cluster_trial_data_bmi.csv"))

cluster_trial %>% print(n=5)

seed <- 123
set.seed(seed)

boot_func <- function(boot_num){
  
  clusters <- as.numeric(names(table(cluster_trial$practice)))
  index <- sample(1:length(clusters), length(clusters), replace=TRUE)
  bb <- table(clusters[index])
  boot <- NULL
  
  for(zzz in 1:max(bb)){
    cc <- cluster_trial[cluster_trial$practice %in% names(bb[bb %in% c(zzz:max(bb))]),]
    cc$b_practice<-paste0(cc$practice,zzz)
    boot <- rbind(boot, cc)
  }
  
  mod1 <- glm(BMI ~ treatment, 
              data=boot,
              family=gaussian(link = "identity"))
  
  se1 <- coeftest(mod1, vcov=vcovCL(mod1,
                             type = "HC", 
                             cadjust = F,
                             cluster = boot$b_practice))[2,2]
  
  mod1_ind <- geeglm(BMI ~ treatment, 
                     family = gaussian(link = "identity"), 
                     id = factor(b_practice), 
                     data=boot, 
                     scale.fix = T,
                     corstr="independence")
  
  se2 <- summary(mod1_ind)$coefficients[2,2]
  
  res <- c(se1, se2)
  
  return(res)
}

boot_res <- lapply(1:500, function(x) boot_func(x))
boot_res <- do.call(rbind,boot_res)
boot_res

sum((boot_res[,1] - boot_res[,2])^2)

all.equal(boot_res[,1],boot_res[,2])