#' Make qr codes and print to stickers
#'
#' This function will take in a data frame of labels and produce a pdf of QR
#' codes which can then be printed. This is a wrapper function for \code{\link{custom_create_PDF}}
#'
#' @return pdf file that is saved to the working directory containing QR codes.
#'
#' The pdf setup is for the ULINE 1.75X1/2 WEATHER RESISTANT LABEL for laser
#' printer; Item # S-19297 (uline.ca). The page format can be modified using
#' the \code{...} options.
#'
#' @inheritParams custom_create_PDF
#' @param ... more advanced arguments to modify layout of pdf output. See
#'  \code{\link{custom_create_PDF}} for arguments. The advanced options can be
#'   accessed interactively when \code{user = T} by entering T when prompted to
#'    modify advanced options.
#' @export
#' @examples
#' ## data frame
#' example<- as.data.frame(c("ao1", "a02", "a03"))
#'
#' \dontrun{
#' ## run with default options, pdf file will be "example.pdf"
#' create_PDF(Labels=example, name="example")
#' ## run interactively. Overrides default pdf options
#' create_PDF(user=T, Labels=example)
#' }
#' @seealso \code{\link{custom_create_PDF}}


create_PDF<-function(user=F,
                     Labels = NULL,
                     name="LabelsOut",
                     ErrCorr="H",
                     Fsz=2.5, ...) {
  custom_create_PDF(user, Labels, name, ErrCorr, Fsz, ...)
}




