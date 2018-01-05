#' Make qr codes and print to stickers
#'
#' This function will take in a data frame of labels and produce a pdf of QR codes which can then be printed. This is a wrapper function for \code{\link{.create_PDF}}
#'
#' @return pdf file that is saved to the working directory containing QR codes.
#'
#' The pdf setup is for the ULINE 1.75X1/2 WEATHER RESISTANT LABEL for laser printer; Item # S-19297 (uline.ca). The page format can be modified using the \code{...} options.
#'
#' @param user logical. Whether to run function as interactive. Default is false
#' @param Labels data frame. One column data frame containing the text for each barcode as a row.
#' @param name character. Name of pdf output file. Default is "LabelsOut"
#' @param ErrCorr the error correction value. Level of damage from low to high: L, M, Q, H. Default is "H"
#' @param Fsz numerical. Set font size. A number between 2.2 and 4.7. Depending on the length of the label, there may not be enough space to print the entire label using bigger font sizes. Default font size is 2.5
#' @param ... more advanced arguments to modify layout of pdf output. Can be accessed interactively when \code{user = F}.
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


create_PDF<-function(user=F, Labels = NA, name="LabelsOut", ErrCorr="H", Fsz=2.5, ...) {
  custom_create_PDF(user, Labels, name, ErrCorr, Fsz...)
}




