
remotes::install_github("koenderks/aRtsy")
library(aRtsy)
library(ggplot2)

set.seed(4)
artwork <- canvas_lissajous(colors = colorPalette("jfa"),
                 background = "white",
                 iterations = 2,
                 neighbors = 75,
                 noise = T)


saveCanvas(artwork, filename = "/Users/ain/Library/CloudStorage/Dropbox/Teaching/MCS/_images/lissajous.png")