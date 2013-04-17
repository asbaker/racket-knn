library(scatterplot3d)
attach(iris)
X11()


makeColor <- function(class) {
  if(class == "setosa") {
    return("darkgreen")
  }
  else if(class == "versicolor") {
    return("darkorchid")
  }
  else if(class == "virginica") {
    return("darkorange")
  }
}

iris$color <- sapply(iris$Species, makeColor)

scatterplot3d(Sepal.Length,Petal.Length,Petal.Width,
  pch=20,
  color=iris$color,
  main="3-D Scatterplot of Iris Data",
  xlab="Sepal Length",
  ylab="Petal Length",
  zlab="Petal Width"
  )

legend("topleft",
  inset=.05,
  bty="n",
  cex=.75,
  title="Species",
  c("Setosa", "Versicolor", "Virginica"),
  fill=c("darkgreen", "darkorchid", "darkorange"))

message("Press enter to exit...")
invisible(readLines("stdin", n=1))

# Rscript 3d_scatter.r
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
# http://statmethods.wordpress.com/2012/01/30/getting-fancy-with-3-d-scatterplots/
# http://www.statmethods.net/graphs/scatterplot.html
