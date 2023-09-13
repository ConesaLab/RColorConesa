#' @import ggplot2

conesa_colors <- c(`green` = "#15918A",
                   `orange` = "#F58A53",
                   `yellow` = "#FDC659",
                   `blue` = "#74CDF0",
                   `purple` = "#9F7BB8",
                   `pink` = "#FDA3D1",
                   `magenta` = "#EE446F")

#' Function to extract conesa colors as hex codes
#'
#' @param ... Character names of conesa_colors

conesa_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols))
    return (conesa_colors)

  conesa_colors[cols]
}

#' Conesa color palette
conesa_palettes <- list(
  `main`  = conesa_cols("green", "orange", "yellow"),
  `nature`= conesa_cols("green", "yellow"),
  `sunshine`= conesa_cols("yellow", "orange"),

  `hot`   = conesa_cols("orange", "magenta"),
  `warm`  = conesa_cols("blue", "magenta"),
  `cold`  = conesa_cols("blue", "purple"),

  `complete` = conesa_cols("green", "orange", "yellow", "blue", "pink", "purple", "magenta")
)

#' Return Conesa Color Palettes
#'
#' @description
#' The `getConesaPalettes` function retrieves a collection of color palettes, specifically designed for scientific visualizations. These palettes are part of the Conesa collection.
#'
#' @details
#' By using the `getConesaPalettes` function, users can access these palettes and incorporate them into their visualizations, ensuring that their plots and graphs are both informative and visually appealing.
#'
#' @return
#' A list containing the various color palettes from the Conesa collection. Each palette in the list is represented as a vector of color values.
#'
#' @author
#' Pedro Salguero Garcia. Maintainer: pedsalga@upv.edu.es
#'
#' @export
#'
#' @examples
#' getConesaPalettes()
#'
getConesaPalettes <- function(){
  return(conesa_palettes)
}


#' Retrieve Conesa's Main Color Set
#'
#' @description
#' The `getConesaColors` function provides access to a curated set of colors that are part of the RColorConesa package. These colors have been specifically chosen for their utility in scientific visualizations.
#'
#' @details
#' When using the `getConesaColors` function, users can seamlessly integrate these colors into their R visualizations, benefiting from the expertise embedded in the Conesa color selection.
#'
#' @return
#' A list containing the primary colors from the Conesa collection. Each color in the list is represented as a hexadecimal color value.
#'
#' @author
#' Pedro Salguero Garcia. Maintainer: pedsalga@upv.edu.es
#'
#' @export
#'
#' @examples
#' getConesaColors()
#'
getConesaColors <- function(){
  return(conesa_colors)
}

#' Interpolate a Conesa Color Palette
#'
#' @description
#' The `conesa_pal` function offers a flexible way to interpolate colors from the Conesa color palettes. This function provides an interface to generate a range of colors based on the selected Conesa palette, allowing for enhanced customization in scientific visualizations.
#'
#' @details
#' The Conesa color palettes, available in the RColorConesa package, have been specifically curated for scientific visualizations. The `conesa_pal` function leverages the `colorRampPalette` function from the `grDevices` package to interpolate between the colors of the chosen Conesa palette. This interpolation capability ensures that users can generate a continuous range of colors, suitable for representing a wide variety of data types and scales. Whether visualizing continuous data gradients or categorical distinctions, the interpolated Conesa palettes can provide clarity and aesthetic appeal to the visual representation.
#'
#' @param palette
#' A character string specifying the name of the desired palette from the `conesa_palettes`. Available options include: "main", "nature", "sunshine", "hot", "warm", "cold", and "complete".
#' @param reverse
#' A logical value indicating whether the colors in the selected palette should be reversed. Default is `FALSE`.
#' @param ...
#' Additional arguments to be passed to the `colorRampPalette` function from the `grDevices` package.
#'
#' @author
#' Pedro Salguero Garcia. Maintainer: pedsalga@upv.edu.es
conesa_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- conesa_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}

#' Retrieve Colors from ConesaLab's Palettes
#'
#' @description
#' The `colorConesa` function facilitates the extraction of a specified number of colors from the ConesaLab's curated color palettes. This function is designed to obtain a set of colors for their scientific visualizations.
#'
#' @details
#' ConesaLab's color palettes, available within the package, are tailored for scientific data visualization. The `colorConesa` function is built upon these palettes, offering flexibility in color selection based on the user's requirements. It integrates with the `palette` argument to choose the color thematic.
#'
#' It's essential to note that if the requested number of colors (`n`) is less than or equal to the size of the chosen palette, the function will directly extract the colors without interpolation. However, if `n` surpasses the palette size, interpolation is employed to generate the required colors.
#'
#' @param n
#' An integer specifying the number of colors to be extracted from the chosen palette.
#' @param reverse
#' A logical value indicating whether the colors in the selected palette should be reversed (Default: `FALSE`).
#' @param palette
#' A character string specifying the name of the desired palette from the `conesa_palettes`. Available options include: "main", "nature", "sunshine", "hot", "warm", "cold", and "complete" (Default: "complete").
#'
#' @return
#' A character vector of colors corresponding to the specified number and palette.
#'
#' @author
#' Pedro Salguero Garcia. Maintainer: pedsalga@upv.edu.es
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#' data("iris")
#' colorSpecies <- colorConesa(3, palette = "cold")
#' plot(x = iris$Sepal.Length, y = iris$Sepal.Width, col = colorSpecies[iris$Species], pch = 16)
#'
colorConesa <- function(n, reverse = FALSE, palette = "complete"){
  if(!palette %in% names(conesa_palettes)){
    message("Palette musst be some of the following palettes: ", paste(names(conesa_palettes),sep= " ", collapse= ", "))
  }

  pal <- conesa_pal(palette = palette, reverse = reverse)

  if(n<=length(getConesaPalettes()[[palette]])){
    colors <- getConesaPalettes()[[palette]][1:n]
    names(colors) <- NULL
    return(colors)
  }

  return(pal(n))
}

#' Color scale constructor for conesa colors
#' @description
#' The `scale_color_conesa` function provides a mechanism to integrate ConesaLab's curated color palettes into `ggplot2` visualizations.
#'
#' @details
#' The `scale_color_conesa` function acts as a bridge between these palettes and the `ggplot2` package, allowing users to apply the palettes to their plots Depending on the nature of the data (continuous or discrete), the function intelligently selects the appropriate scale from `ggplot2` to render the colors.
#'
#' When the `continuous` parameter is set to `TRUE`, the function employs the `scale_color_gradientn` function from `ggplot2` to generate a continuous color scale. Conversely, for discrete data, the `discrete_scale` function is utilized. This ensures that the chosen palette is optimally represented in the plot, irrespective of the data type.
#'
#' @param palette
#' A character string specifying the name of the desired palette from the `conesa_palettes`. Available options include: "main", "nature", "sunshine", "hot", "warm", "cold", and "complete" (Default: "main").
#' @param continuous
#' A logical value indicating whether the color aesthetic represents continuous data (Default: `FALSE`).
#' @param reverse
#' A logical value indicating whether the colors in the selected palette should be reversed (Default: `FALSE`).
#' @param ...
#' Additional arguments passed either to `discrete_scale` or `scale_color_gradientn` from the `ggplot2` package, depending on the value of the `continuous` parameter.
#' @return
#' A `ggplot2` scale function suitable for adding to a `ggplot2` object.
#'
#' @author
#' Pedro Salguero Garcia. Maintainer: pedsalga@upv.edu.es
#'
#' @examples
#' library(ggplot2)
#' data("iris")
#' g <- ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species))
#' g <- g + geom_point(size = 4)
#' g <- g + scale_color_conesa(palette = "main")
#'
#' @export
scale_color_conesa <- function(palette = "main", continuous = FALSE, reverse = FALSE, ...) {
  if(!palette %in% names(conesa_palettes)){
    message("Palette must be some of the following palettes: ", paste(names(conesa_palettes),sep=" ", collapse=", "))
    stop()
  }

  pal <- conesa_pal(palette = palette, reverse = reverse)

  if (!continuous) {
    ggplot2::discrete_scale("colour", paste0("conesa_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for conesa colors
#' @description
#' The `scale_fill_conesa` function provides a mechanism to integrate ConesaLab's curated color palettes into `ggplot2` visualizations.
#'
#' @details
#' The `scale_fill_conesa` function acts as a bridge between these palettes and the `ggplot2` package, allowing users to apply the palettes to their plots Depending on the nature of the data (continuous or discrete), the function intelligently selects the appropriate scale from `ggplot2` to render the colors.
#'
#' When the `continuous` parameter is set to `TRUE`, the function employs the `scale_fill_gradientn` function from `ggplot2` to generate a continuous color scale. Conversely, for discrete data, the `discrete_scale` function is utilized. This ensures that the chosen palette is optimally represented in the plot, irrespective of the data type.
#'
#' @param palette
#' A character string specifying the name of the desired palette from the `conesa_palettes`. Available options include: "main", "nature", "sunshine", "hot", "warm", "cold", and "complete" (Default: "main").
#' @param continuous
#' A logical value indicating whether the color aesthetic represents continuous data (Default: `FALSE`).
#' @param reverse
#' A logical value indicating whether the colors in the selected palette should be reversed (Default: `FALSE`).
#' @param ...
#' Additional arguments passed either to `discrete_scale` or `scale_fill_gradientn` from the `ggplot2` package, depending on the value of the `continuous` parameter.
#'
#' @return
#' A `ggplot2` scale function suitable for adding to a `ggplot2` object.
#'
#' @author
#' Pedro Salguero Garcia. Maintainer: pedsalga@upv.edu.es
#'
#' @examples
#' library(ggplot2)
#' data("iris")
#' g <- ggplot(iris, aes(x = Sepal.Width, fill = Species))
#' g <- g + geom_histogram(binwidth = 0.2, alpha = 0.8)
#' g <- g + labs(title = "Histogram of Sepal Width", x = "Sepal Width", y = "Frequency")
#' g <- g + scale_fill_conesa(palette = "main")
#'
#' @export
scale_fill_conesa <- function(palette = "main", continuous = FALSE, reverse = FALSE, ...) {
  if(!palette %in% names(conesa_palettes)){
    message("Palette must be some of the following palettes: ", paste(names(conesa_palettes),sep=" ", collapse=", "))
    stop()
  }

  pal <- conesa_pal(palette = palette, reverse = reverse)

  if(!continuous){
    ggplot2::discrete_scale("fill", paste0("conesa_", palette), palette = pal, ...)
  }else{
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }

}
