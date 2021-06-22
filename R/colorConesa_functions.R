#' @import ggplot2

lstGreen = c("#15918A", "#62DED8", "#1FDED4", "#48A49F", "#0D5E5A")
lstOrange = c("#F58A53", "#F7BB9E", "#C26D42", "#754228", "#75594B")
lstYellow = c("#FDC659", "#FDDFA4", "#C99E47", "#7D622C", "#7D6E51")
lstBlue = c("#74CDF0", "#BDE3F2", "#5BA1BD", "#366070", "#586970")
lstPurple = c("#9F7BB8", "#9048C3", "#725985", "#302638", "#291538")
lstPink = c("#FDA3D1", "#FD56AC", "#C981A6", "#7D2A55", "#7D5067")
lstMagenta = c("#EE446F", "#F08EA6", "#BA3657", "#6E2033", "#6E414C")

conesa_colors <- c(`green` = "#15918A",
                   `orange` = "#F58A53",
                   `yellow` = "#FDC659",
                   `blue` = "#74CDF0",
                   `purple` = "#9F7BB8",
                   `pink` = "#FDA3D1",
                   `magenta` = "#EE446F")

N <- length(lstOrange) + length(lstGreen) + length(lstYellow) + length(lstPink) + length(lstBlue) + length(lstMagenta) + length(lstPurple)

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

#' Return all conesa colors by number of colors you need
#'
#' @param n Number of colors you need
#' @param reverse Boolean indicating whether the palette should be reversed
#'
#' @export
colorConesa <- function(n, reverse = F){
  if(n>N){
    stop(paste0("colorConesa can manage at maximum of ", N," colors"))
  }

  res <- NULL
  for(i in 1:n){
    color <- i %% 7
    pos <-  Hmisc::ceil(i/7)
    if(color==1){
      res <- c(res, lstGreen[pos])
    }else if(color==2){
      res <- c(res, lstOrange[pos])
    }else if(color==3){
      res <- c(res, lstYellow[pos])
    }else if(color==4){
      res <- c(res, lstBlue[pos])
    }else if(color==5){
      res <- c(res, lstPurple[pos])
    }else if(color==6){
      res <- c(res, lstPink[pos])
    }else if(color==0){
      res <- c(res, lstMagenta[pos])
    }
  }

  if(reverse){
    return(rev(res))
  }else{
    return(res)
  }
}

#' Conesa color palette
#'
conesa_palettes <- list(
  `main`  = conesa_cols("green", "orange", "yellow"),
  `nature`= conesa_cols("green", "yellow"),
  `cool`  = conesa_cols("blue", "purple"),
  `hot`   = conesa_cols("orange", "magenta"),
  `warm`  = conesa_cols("magenta", "blue"),
  `mixed` = conesa_cols("green", "orange", "yellow", "blue", "pruple", "pink", "magenta")
)

#' Return function to interpolate a conesa color palette
#'
#' @param palette Character name of palette in conesa_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
conesa_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- conesa_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}

#' Color scale constructor for conesa colors
#'
#' @param palette Character name of palette in conesa_palettes c("main", "cool", "warm", "hot", "nature", "mixed") are avairable.
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @export
scale_color_conesa <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- conesa_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("conesa_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for conesa colors
#'
#' @param palette Character name of palette in conesa_palettes c("main", "cool", "warm", "hot", "nature", "mixed") are avairable.
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @export
scale_fill_conesa <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- conesa_pal(palette = palette, reverse = reverse)

  if(discrete){
    ggplot2::discrete_scale("fill", paste0("conesa_", palette), palette = pal, ...)
  }else{
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }

}
