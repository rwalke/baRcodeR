#' Internal functions
#'
#' Function theme_empty is a code snippet to use in \code{\link{custom_create_PDF}} to remove all lines from plots when creating the barcode PDF file. This function is not exported.
#'
#' @param base_size numerical. Value to be passed onto base_size in ggplot theme_classic.
#' @param base_family character. Value to be passed onto base_family in ggplot theme_classic.
#' @noRd
# Custom theme to remove all lines from plots
theme_empty<-function(base_size = 12, base_family = "") {
  theme_classic(base_size = base_size, base_family = base_family) %+replace%
    theme(
      plot.margin = unit(c(2,4,-2,-2),"mm"),
      axis.text = element_blank(),
      axis.title.x = element_blank(),
      axis.text.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      plot.title=element_blank(),
      legend.background = element_blank(),
      legend.text = element_blank(),
      legend.title = element_blank()
    )
}
