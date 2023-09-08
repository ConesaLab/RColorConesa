
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
different colour palettes have been created. Each palette have the
continuous and the continuous form as you can see in next examples.

## Palette - main

    #> Warning: `qplot()` was deprecated in ggplot2 3.4.0.
    #> This warning is displayed once every 8 hours.
    #> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    #> generated.

<img src="images/palette1-1.png" width="100%" /><img src="images/palette1-2.png" width="100%" />

## Palette - nature

<img src="images/palette2-1.png" width="100%" /><img src="images/palette2-2.png" width="100%" />

## Palette - sunshine

<img src="images/palette3-1.png" width="100%" /><img src="images/palette3-2.png" width="100%" />

## Palette - hot

<img src="images/palette4-1.png" width="100%" /><img src="images/palette4-2.png" width="100%" />

## Palette - warm

<img src="images/palette5-1.png" width="100%" /><img src="images/palette5-2.png" width="100%" />

## Palette - cold

<img src="images/palette6-1.png" width="100%" /><img src="images/palette6-2.png" width="100%" />

## Palette - complete

<img src="images/palette7-1.png" width="100%" /><img src="images/palette7-2.png" width="100%" />

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

<img src="images/example plot-1.png" width="100%" />

## Example - ggplot()

In case of ggplot(), if we want to plot by color it is much more easier
to do with the functions “scale_color_conesa()” and
“scale_fill_conesa()”. We plot the same result we made before.

``` r
library(RColorConesa)
library(ggplot2)

ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(size = 4) +
  scale_color_conesa(palette = "main")
```

<img src="images/example ggplot-1.png" width="100%" />

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

<img src="images/example ggplot - fill-1.png" width="100%" />

Finally, for continuous variables, you can change the parameter
continuous to True in the functions “scale_fill_conesa()” and
“scale_fill_conesa()”.

``` r
library(RColorConesa)
library(ggplot2)

df.heatmap <- expand.grid(Var1 = letters[1:15], Var2 = 1:15)
df.heatmap$score <- runif(nrow(df.heatmap), min = -5, max = 5)

ggplot(df.heatmap, aes(x = Var1, y = Var2, fill = score)) + 
  geom_tile() + 
  scale_fill_conesa(palette = "sunshine", continuous = T)
```

<img src="images/example - continuous-1.png" width="100%" />

# Contact

Note that RColorConesa can be updated. If you encounter a problem,
please open an issue via GitHub or send an email to
<pedsalga@upv.edu.es>.

# Author

Pedro Salguero García - <pedsalga@upv.edu.es>
