library(lattice)
data(iris)
X11()

super.sym <- trellis.par.get("superpose.symbol")
super.sym$pch <- c(20, 20, 20)
super.sym$col <- c("darkgreen", "darkorchid", "darkorange")

splom(~iris[1:4], groups = Species, data = iris,
      panel = panel.superpose,
      pch = super.sym$pch[1:3],
      col = super.sym$col[1:3],
      pscales = c(),
      key = list(title = "Scatter Plot Matrix of Iris Data",
                 columns = 3,
                 points = list(pch = super.sym$pch[1:3],
                 col = super.sym$col[1:3]),
                 text = list(c("Setosa", "Versicolor", "Virginica"))))

message("Press enter to exit...")
invisible(readLines("stdin", n=1))

# execute this in R
# Rscript 3d_scatter.r

# http://stuff.mit.edu/afs/sipb/project/r-project/arch/i386_rhel3/lib/R/library/lattice/html/splom.html
