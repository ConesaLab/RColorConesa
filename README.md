
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RColorConesa

## Installation

You can install the released version of RColorConesa from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("ConesaLab/RColorConesa")
```

## Information

The package RColorConesa is a color packages with different palletes
inspired by the corporative image of the Conesa Lab.

![Logo ConesaLab](./images/logo_ConesaLab.png)

## Palettes

RColorConesa consists of seven main colours from which a number of
different colour palettes have been created.

## Palette - main

<img src="man/figures/README-palette1-1.png" width="100%" />

## Palette - nature

<img src="man/figures/README-palette2-1.png" width="100%" />

## Palette - sunshine

<img src="man/figures/README-palette3-1.png" width="100%" />

## Palette - hot

<img src="man/figures/README-palette4-1.png" width="100%" />

## Palette - warm

<img src="man/figures/README-palette5-1.png" width="100%" />

## Palette - cold

<img src="man/figures/README-palette6-1.png" width="100%" />

## Palette - complete

<img src="man/figures/README-palette7-1.png" width="100%" />

## Example - plot()

This is a basic example which shows you how to solve a common problem
using the databases “iris” and the basic ploting function in R. The
objetive is color by spsecie using the RcolorConesa packages.

To do this, we can use the funtion “colorConesa()” which returns a list
of as many colors of you needed.

``` r
library(RColorConesa)

n_species <- length(levels(iris$Species))
colorSpecies <- colorConesa(n_species, palette = "main")

plot(x = iris$Sepal.Length, y = iris$Sepal.Width, col = colorSpecies[iris$Species], pch = 16)
legend("bottomleft", legend=c(levels(iris$Species)), col=colorSpecies, lty=1)
```

<img src="man/figures/README-example plot-1.png" width="100%" />

## Example - ggplot()

In case of ggplot(), if we want to plot by color it is much more easier
to do with the functions “scale\_color\_conesa()” and
“scale\_fill\_conesa()”. We plot the same result we made before.

``` r
library(RColorConesa)
library(ggplot2)

ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(size = 4) +
  scale_color_conesa(palette = "main")
```

<img src="man/figures/README-example ggplot-1.png" width="100%" />

A good point for the packages is you can use more colors that it already
have. For example, we are going to color each Manufacturer from the
dataset “mpg” from the package “ggplot2”.

As you can see, the palette “complete” only have 7 colors, but it can
interpolate as much as need it to fill all the categories.

``` r
library(RColorConesa)
library(ggplot2)

mpg <- ggplot2::mpg

ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_conesa(palette = "complete")
```

<img src="man/figures/README-example ggplot - fill-1.png" width="100%" />

Finally, for continuos variables, you can change the parameter discrete
to False in the functions “scale\_fill\_conesa()” and
“scale\_fill\_conesa()”.

``` r
library(RColorConesa)
library(ggplot2)

df.heatmap <- expand.grid(Var1 = letters[1:15], Var2 = 1:15)
df.heatmap$score <- runif(nrow(df.heatmap), min = -5, max = 5)

ggplot(df.heatmap, aes(x = Var1, y = Var2, fill = score)) + 
  geom_tile() + 
  scale_fill_conesa(palette = "sunshine", discrete = F)
```

<img src="man/figures/README-example - continuous-1.png" width="100%" />

# Contact

Note that RColorConesa can be updated. If you encounter a problem,
please open an issue via GitHub or send an email to
<pedsalga@upv.edu.es>.

# Author

Pedro Salguero García - <pedsalga@upv.edu.es>
