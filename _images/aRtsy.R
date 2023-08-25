
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


mandelbrot_art <- canvas_mandelbrot(colors = c("#111111","#fafafa","#0011ff"),
                                    set = "mandelbrot",
                                    zoom = 3.25, 
                                    resolution = 500, 
                                    top = 2, 
                                    bottom = -2,
                                    left = -3.16,
                                    right = 0.16)
mandelbrot_art

saveCanvas(mandelbrot_art, filename = "/Users/ain/Library/CloudStorage/Dropbox/Teaching/EPI560/_images/mandelbrot.png")