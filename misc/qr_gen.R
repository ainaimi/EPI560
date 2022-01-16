install.packages("qrcode")
library(qrcode)

png("qrplot.png")
qrcode_gen("https://datascienceplus.com/")
dev.off()