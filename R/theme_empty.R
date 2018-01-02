#' Internal formatting of barcode
#'
#' This is just a piece of code to use in ggplot called when making qrcodes that all lines are suppressed
#'
#' This function is not exported and will be called internally
#'

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
