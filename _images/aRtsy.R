
remotes::install_github("koenderks/aRtsy")
library(aRtsy)
library(ggplot2)

set.seed(4)
lissajous_art <- canvas_lissajous(colors = colorPalette("jfa"),
                 background = "white",
                 iterations = 2,
                 neighbors = 75,
                 noise = T)


saveCanvas(lissajous_art, filename = "/Users/ain/Library/CloudStorage/Dropbox/Teaching/MCS/_images/lissajous.png")


set.seed(4)
mandelbrot_art <- canvas_mandelbrot(colors = colorPalette("viridis"))
mandelbrot_art

saveCanvas(lissajous_art, filename = "/Users/ain/Library/CloudStorage/Dropbox/Teaching/MCS/_images/mandelbrot.png")