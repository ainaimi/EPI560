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

here()

ID <- seq(1:6)
start_time <- rep(42,6)
stop_time <- c(48,50,56,52,54,56)
outcome <- c(1,1,1,1,1,1)

d <- tibble(ID,start_time,stop_time,outcome)

d %>% ggplot(.) +
  geom_linerange(aes(y=ID,xmin=start_time,xmax=stop_time)) +
  geom_point(aes(y=ID,x=stop_time),shape=4) +
  geom_vline(xintercept = c(46,56),color="red",linetype=2) +
  scale_y_continuous(expand=c(0.05,0.05),
                     limits=c(-1,6),
                     breaks=c(0:7)) +
  scale_x_continuous(expand=c(0,0),
                     limits=c(42,58)) +
  theme(axis.title.y = element_text(angle=0,vjust=.5)) +
  xlab("Age")

ggsave("./figures/2021_12_08-hw-fig.pdf",width=6,height=6,units="cm")