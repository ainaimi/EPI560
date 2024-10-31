packages <- c("data.table","tidyverse","skimr","here")

for (package in packages) {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package, repos='http://lib.stat.cmu.edu/R/CRAN')
  }
}

for (package in packages) {
  library(package, character.only=T)
}



data <- rbind(pattern1, pattern2, pattern3, pattern4)
mdpat <- cbind(expand.grid(rec = 8:1, pat = 1:4, var = 1:3), r = as.numeric(as.vector(is.na(data))))
mdpat <- mdpat[mdpat$pat %in% c(1,2,4),]

types <- c("Univariate", "Monotone", "Non-Monotone")
tp41 <- levelplot(r ~ var + rec | as.factor(pat),
                  data = mdpat,
                  as.table = TRUE, aspect = "iso",
                  shrink = c(0.9),
                  col.regions = mdc(1:2),
                  colorkey = FALSE,
                  scales = list(draw = FALSE),
                  xlab = "", ylab = "",
                  between = list(x = 1, y = 0),
                  strip = strip.custom(
                    bg = "grey95", style = 1,
                    factor.levels = types
                  )
)

png(filename = here("figures", "md_patterns.png"))
tp41
dev.off()