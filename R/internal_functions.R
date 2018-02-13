#' Internal functions
#'
#' Function theme_empty is a code snippet to use in \code{\link{custom_create_PDF}} to remove all lines from plots when creating the barcode PDF file. This function is not exported.
#'
#' @param base_size numerical. Value to be passed onto base_size in ggplot theme_classic.
#' @param base_family character. Value to be passed onto base_family in ggplot theme_classic.
#'
# Custom theme to remove all lines from plots
theme_empty<-function(base_size = 12, base_family = "") {
  ggplot2::theme_classic(base_size = base_size, base_family = base_family) + ggplot2::theme_replace(
    plot.margin = grid::unit(c(2,4,-2,-2),"mm"),
    axis.text = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank(),
    axis.title.y = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    plot.title = ggplot2::element_blank(),
    legend.background = ggplot2::element_blank(),
    legend.text = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank()
  )

}
