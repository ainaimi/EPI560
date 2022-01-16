remotes::install_github("rstudio/fontawesome")
library(fontawesome)

## not working...

png("./figures/fa-lightbulb.png")
fa(name="lightbulb", fill="black")
dev.off()