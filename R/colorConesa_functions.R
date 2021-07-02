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
#'
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

#' Return conesa palette
#'
#' Return a list of the different palettes with their colors.
#'
#' @export
getConesaPalettes <- function(){
  return(conesa_palettes)
}


#' Return conesa main colors
#'
#'Return a list of the different colors the RColorConesa packages uses.
#'
#' @export
getConesaColors <- function(){
  return(conesa_colors)
}

#' Return function to interpolate a conesa color palette
#'
#' @param palette Character name of palette in conesa_palettes: c("main", "nature", "sunshine", "hot", "warm", "cold", "complete") are avairable.
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
conesa_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- conesa_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}

#' colorConesa
#'
#' Returns as many colours as you need from ConesaLab's color palettes.
#'
#' @param n Number of colors you need
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param palette Character name of palette in conesa_palettes: c("main", "nature", "sunshine", "hot", "warm", "cold", "complete") are avairable.
#'
#' @examples
#' colorSpecies <- colorConesa(3, palette = "main")
#' plot(x = iris$Sepal.Length, y = iris$Sepal.Width, col = colorSpecies[iris$Species], pch = 16)
#'
#' @export
colorConesa <- function(n, reverse = F, palette = "complete"){
  if(!palette %in% names(conesa_palettes)){
    message("Palette musst be some of the following palettes: ", paste(names(conesa_palettes),sep=" ", collapse=", "))
  }

  pal <- conesa_pal(palette = palette, reverse = reverse)
  return(pal(n))
}

#' Color scale constructor for conesa colors
#'
#' @param palette Character name of palette in conesa_palettes: c("main", "nature", "sunshine", "hot", "warm", "cold", "complete") are avairable.
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @examples
#' library(ggplot2)
#' g <- ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species))
#' g <- g + geom_point(size = 4)
#' g <- g + scale_color_conesa(palette = "main")
#'
#' @export
scale_color_conesa <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  if(!palette %in% names(conesa_palettes)){
    message("Palette musst be some of the following palettes: ", paste(names(conesa_palettes),sep=" ", collapse=", "))
    stop()
  }

  pal <- conesa_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("conesa_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for conesa colors
#'
#' @param palette Character name of palette in conesa_palettes c("main", "nature", "sunshine", "hot", "warm", "cold", "complete") are avairable.
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @examples
#' library(ggplot2)
#' g <- ggplot(mpg, aes(manufacturer, fill = manufacturer))
#' g <- g + geom_bar()
#' g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
#' g <- g + scale_fill_conesa(palette = "complete")
#'
#' @export
scale_fill_conesa <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  if(!palette %in% names(conesa_palettes)){
    message("Palette musst be some of the following palettes: ", paste(names(conesa_palettes),sep=" ", collapse=", "))
    stop()
  }

  pal <- conesa_pal(palette = palette, reverse = reverse)

  if(discrete){
    ggplot2::discrete_scale("fill", paste0("conesa_", palette), palette = pal, ...)
  }else{
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }

}
