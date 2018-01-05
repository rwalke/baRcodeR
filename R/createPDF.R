#' Make qr codes and print to stickers
#'
#' This function will take in a data frame of labels and produce a pdf of QR codes which can then be printed. This is a wrapper function for \code{/link{.create_PDF}}
#'
#' @return pdf file that is saved to the working directory containing QR codes.
#' @export
#' The pdf setup is for the ULINE 1.75X1/2 WEATHER RESISTANT LABEL for laser printer; Item # S-19297 (uline.ca). The page format can be modified using the \code{...} options.
#'
#' @param user logical. Whether to run function as interactive. Default is false
#' @param Labels data frame. One column data frame containing the text for each barcode as a row.
#' @param name character. Name of pdf output file. Default is "LabelsOut"
#' @param ErrCorr the error correction value. Level of damage from low to high: L, M, Q, H. Default is "H"
#' @param Fsz numerical. Set font size. A number between 2.2 and 4.7. Depending on the length of the label, there may not be enough space to print the entire label using bigger font sizes. Default font size is 2.5
#' @param ... more advanced arguments to modify layout of pdf output. Can be accessed interactively when \code{user = F}.
#'
#' @param Across logical. When true, print labels in rows. When false, print labels in columns. Default is T.
#' @param ERows number of rows to skip. Default is 0.
#' @param ECols number of columns to skip. Default is 0.
#' @param trunc logical. Text is split into rows to prevent cutoff when labels are long. Default is T.
#' @param numrow numerical. Number of rows per page. Default is 20 rows per page.
#' @param numcol numerical. Number of columns per page. Default is 4 columns per page.
#' @param height_margin numerical. The height margin of the page (in inches). Default is 0.5 inches.
#' @param width_margin numerical. The width margin of the page (in inches). Default is 0.25 inches.
#' @param cust_spacing logical. Default is F. If spacing between qrcode and label should be changed.
#' @param x_space numerical. An integer between 190-250. This sets the distance between the qrcode and the label. Default is 215. This parameter is only used when \code{cust_spacing = T}.
#'
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
#' @seealso \code{link{.create_PDF}}


create_PDF<-function(user=F, Labels = NA, name="LabelsOut", ErrCorr="H", Fsz=2.5, ...) {
  .create_PDF(user, Labels, name, ErrCorr, Fsz...)
}




