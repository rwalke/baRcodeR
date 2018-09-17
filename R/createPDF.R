#' Make QR codes and print to stickers
#'
#' Input vector or data.frame of labels and produce a pdf of QR codes which can 
#' then be printed. This is a wrapper function for \code{\link{custom_create_PDF}}
#'
#' @return pdf file that is saved to the working directory containing QR codes.
#'
#' The pdf setup is for the ULINE 1.75X1/2 WEATHER RESISTANT LABEL for laser
#' printer; Item # S-19297 (uline.ca). The page format can be modified using
#' the \code{...} advanced options for other label types.
#'
#' @inheritParams custom_create_PDF
#' @param ... advanced arguments to modify pdf layout. See
#'  \code{\link{custom_create_PDF}} for arguments. The advanced options can be
#'   accessed interactively with \code{user = T} and then entering T when prompted to
#'    modify advanced options.
#' @export
#' @examples
#' ## data frame
#' example_vector <- as.data.frame(c("ao1", "a02", "a03"))
#'
#' \dontrun{
#' ## run with default options
#' ## pdf file will be "example.pdf" saved into a temp directory
#' 
#' create_PDF(Labels = example_vector, name = file.path(tempdir(), "example"))
#' 
#' ## view example output from temp folder
#' system(paste0('open "', file.path(tempdir(), "example"), ".pdf"))
#' 
#' ## run interactively. Overrides default pdf options
#' create_PDF(user = T, Labels = example_vector)
#' 
#' ## run using a data frame, automatically choosing the "label" column
#' example_df <- data.frame("level1" = c("a1", "a2"), "label" = c("a1-b1",
#' "a1-b2"), "level2" = c("b1", "b1"))
#' create_PDF(user = F, Labels = example_df, name = file.path(tempdir(), "example_2"))
#' 
#' ## run using an unnamed data frame
#' example_df <- data.frame(c("a1", "a2"), c("a1-b1", "a1-b2"), c("b1", "b1"))
#' 
#' ## specify column from data frame
#' create_PDF(user = F, Labels = example_df[,2], name = file.path(tempdir(), "example_3"))
#' }
#' @seealso \code{\link{custom_create_PDF}}


create_PDF <- function(user = F,
                     Labels = NULL,
                     name ="LabelsOut",
                     ErrCorr = "H",
                     Fsz = 2.5, ...) {
  custom_create_PDF(user, Labels, name, ErrCorr, Fsz, ...)
}




