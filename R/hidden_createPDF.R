#' Make qr codes and print to stickers
#'
#' This function will take in a data frame of labels and produce a pdf of QR
#' codes which can then be printed. The pdf setup is for the ULINE 1.75X1/2
#' WEATHER RESISTANT LABEL for laser printer; Item # S-19297 (uline.ca)
#'
#' @return pdf file that is saved to the working directory containing QR codes.
#'
#' @param user logical. Whether to run function as interactive. Default is \code{FALSE}
#' @param Labels data frame. One column data frame containing the text for each
#' barcode as a row.
#' @param name character. Name of pdf output file. Default is "LabelsOut"
#' @param ErrCorr the error correction value. Level of damage from low to high:
#' L, M, Q, H. Default is \code{"H"}
#' @param Fsz numerical. Set font size. A number between 2.2 and 4.7. Depending
#' on the length of the label, there may not be enough space to print the entire
#'  label using bigger font sizes. Default font size is 2.5
#' @param Across logical. When true, print labels in rows. When false, print
#' labels in columns. Default is \code{TRUE}.
#' @param ERows number of rows to skip. Default is 0.
#' @param ECols number of columns to skip. Default is 0.
#' @param trunc logical. Text is split into rows to prevent cutoff when labels
#' are long. Default is \code{TRUE}.
#' @param numrow numerical. Number of rows per page. Default is 20 rows per page.
#' @param numcol numerical. Number of columns per page. Default is 4 columns
#' per page.
#' @param height_margin numerical. The height margin of the page (in inches).
#' Default is 0.5 inches.
#' @param width_margin numerical. The width margin of the page (in inches).
#' Default is 0.25 inches.
#' @param cust_spacing logical. Default is \code{FALSE}. If spacing between qrcode and
#' label should be changed.
#' @param x_space numerical. An integer between 190 - 250. This sets the distance
#' between the qrcode and the label. Default is 215. This parameter is only
#' used when \code{cust_spacing = T}.
#' @seealso \code{\link{create_PDF}}
#' @export

custom_create_PDF<-function(user=F,
                            Labels=NULL,
                            name="LabelsOut",
                            ErrCorr="H",
                            Fsz = 2.5,
                            Across=T,
                            ERows=0,
                            ECols=0,
                            trunc=T,
                            numrow=20,
                            numcol=4,
                            height_margin=0.5,
                            width_margin=0.25,
                            cust_spacing=F,
                            x_space=215){
  if (length(Labels)==0) stop("Labels do not exist. Please pass in Labels")
  labelLength<-nchar(paste(Labels[1,1]))
  # clean up any open graphical devices if function fails
  on.exit(dev.off())
  # if user prompt has been set to true
  if (user == T){
    # possible inputs
    inputCheck<-c("T", "t", "F", "f")
    yesNo<-c("Y", "N")
    ## ask for name
    name <- readline(paste0("Please enter name for PDF output file: "))
    ## Set font size
    Fsz <- noquote(as.numeric(readline("Please enter a font size (2.2-4.7): ")))
    while (Fsz < 2.2 || Fsz > 4.7){
      noquote(print("Invalid input, please specify a font size within the range 2.2-4.7"))
      Fsz <-noquote(as.numeric(readline("Please enter a font size (2.2-4.7): ")))
    }

    while (Fsz >= 2.2 && Fsz <= 2.5 && labelLength >= 27){
      noquote(print("ERROR: not enought space to print full label, please decrease font size"))
      Fsz <-noquote(as.numeric(readline("Please enter a font size (2.2-4.7): ")))
    }
    while (Fsz>= 2.6 && Fsz <= 4.0 && labelLength >= 18){
      noquote(print("ERROR: not enought space to print full label, please decrease font size"))
      Fsz <-noquote(as.numeric(readline("Please enter a font size (2.2-4.7): ")))
    }
    while(Fsz >= 4.1 && Fsz <= 4.7 && labelLength >= 9){
      noquote(print("ERROR: not enought space to print full label, please decrease font size"))
      Fsz <-noquote(as.numeric(readline("Please enter a font size (2.2-4.7): ")))
    }
    ## Error correction
    ErrCorr <- noquote(toupper(readline("Specify an error correction - L, M, Q, H: ")))
    errCheck<-c("L","l","M","m","Q","q","H","h")
    # check errCorr input
    while((ErrCorr %in% errCheck) == FALSE){
      noquote(print("Invalid input, please only enter what is specified"))
      ErrCorr <- noquote(toupper(readline("Specify an error correction - L, M, Q, H: ")))
    }
    Advanced<-noquote(toupper(readline("Edit advanced parameters? (Y/N): ")))
    while((Advanced %in% yesNo) == FALSE){
      noquote(print("Invalid input"))
      Advanced<-noquote(toupper(readline("Edit advanced parameters? (Y/N): ")))
    }
    if (Advanced =="Y") {
      ## Set to TRUE to print labels across rows instead of down columns
      Across<- noquote(toupper(readline("Please enter T or F to print across: ")))
      while((Across %in% inputCheck)==FALSE){
        noquote(print("Invalid input"))
        Across <- noquote(toupper(readline("Please enter T or F to print across: ")))
      }
      # Split text into rows (prevents text cutoff when label has >8 characters without \\n in labels)
      trunc<-noquote(toupper(readline("Do you want to split text into rows? (T/F): ")))
      while((trunc %in% inputCheck)==FALSE){
        noquote(print("Invalid input"))
        trunc<-noquote(toupper(readline("Do you want to split text into rows? (T/F): ")))
      }
      ERows <- noquote(as.numeric(readline("Number of rows to skip? (enter 0 for default): ")))
      ECols <- noquote(as.numeric(readline("Number of cols to skip? (enter 0 for default): ")))
      numrow<-as.numeric(readline("# of rows per page: "))
      while(is.numeric(numrow) == F) {
        noquote(print("Invalid input"))
        numrow<-as.numeric(readline("# of rows per page: "))
      }
      numcol<-as.numeric(readline("# of col per page: "))
      while(is.numeric(numcol) == F) {
        noquote(print("Invalid input"))
        numcol<-as.numeric(readline("# of col per page: "))
      }
      height_margin<-as.numeric(readline("Please enter the height margin of page (in inch): "))
      while(is.numeric(height_margin) == F){
        noquote(print("Invalid input"))
        height_margin<-as.numeric(readline("Please enter the height margin of page (in inch): "))
      }
      width_margin<-as.numeric(readline("Please enter the width margin of page (in inch): "))
      while(is.numeric(width_margin) == F){
        noquote(print("Invalid input"))
        width_margin<-as.numeric(readline("Please enter the width margin of page (in inch): "))
      }
      space<-toupper(readline("change distance between qrcode and label? (y/n): "))
      while((space %in% yesNo) == F){
        noquote(print("Invalid input"))
        space<-toupper(readline("change distance between qrcode and label? (y/n): "))
      }
      x_space <- 215
      if (space=="Y"){
        x_space <- as.numeric(readline("Please enter a distance between 190-250: "))
        while((x_space < 190 || x_space > 250)){
          noquote(print("Invalid input"))
          x_space <- as.numeric(readline("Please enter a distance between 190-250: "))
        }
      }
    } ## end of advanced options loop


  } # user ask == T
  # Dummy data.frame for plotting

  if (Fsz >= 2.2 && Fsz <= 2.5 && labelLength >= 27) stop("ERROR: not enought space to print full label, please decrease font size")
  width_margin <- 8.5-width_margin*2
  height_margin <- 11-height_margin*2
  dmy<-data.frame(x = c(0,457), y = c(0,212))
  if (cust_spacing == T) {
    y_space <- x_space-(as.integer(x_space * 0.5)) -15
  } else {
    y_space <- 182
  }
  ### Page Setup
  oname <- paste0(name, ".pdf")
  grDevices::pdf(oname, width = 8.5, height = 11, onefile = T, family = "Courier") # Standard North American 8.5 x 11
  grid::grid.newpage() # Open a new page on grid device
  grid::pushViewport(grid::viewport(width = grid::unit(width_margin, "in"), height = grid::unit(height_margin, "in"), just = c("centre", "centre"), layout = grid::grid.layout(numrow, numcol))) # Margins: left/right:10mm x top/bottom:22mm
  row<-ERows
  col<-ECols+1
  for (i in 1:nrow(Labels)){
    # Create text label
    Xtxt<-paste(gsub("\\\\n","\\\n",Labels[i,]),collapse="")
    # Split label to count characters
    Xsplt<-strsplit(Xtxt,"")[[1]]

    if(trunc==T){  # Truncate string across lines if trunc==T
      if(length(Xsplt) > 27){Xsplt <- Xsplt[1:27]}
      # If remaining string is > 8 characters, split into separate lines
      if(length(Xsplt) > 8){
        Xnew<-{}
        count<- 0
        for(j in 1:length(Xsplt)){
          count<-count + 1
          Xnew<-c(Xnew, Xsplt[j])
          if(count > 8){
            count<- 0
            Xnew<- c(Xnew,"\n")
          }
        }
        Xtxt<-paste(Xnew, collapse="")
      }
    }
    # Create qrcode
    Xpng<-grid::rasterGrob(abs(qrcode::qrcode_gen(paste0(Labels[i,]), ErrorCorrectionLevel=ErrCorr, dataOutput = T, plotQRcode = F, mask = 3) - 1), interpolate = F)
    # Create tag (QR code + text label)
    Xplt<-
      ggplot2::ggplot(data=dmy,ggplot2::aes(x=0,y=0))+ggplot2::annotation_custom(Xpng,xmin=30,xmax=180,ymin=60,ymax=180)+ggplot2::coord_cartesian(xlim=c(0,457),ylim=c(0,212))+theme_empty()+
      ggplot2::geom_text(ggplot2::aes(x=x_space,y=y_space,label=Xtxt,hjust=0,vjust=1),size=Fsz) # +geom_point(aes(x=x,y=y)) # useful points for fitting margins

    # Output to tag position
    row<-row+1
    if(Across=="T" || Across ==T){
      if(row > numcol){
        row<-1
        col<-col + 1
        if(col > numrow){
          col<-1
          grid::grid.newpage() # Open a new page on grid device
          grid::pushViewport(grid::viewport(width = grid::unit(width_margin, "in"), height = grid::unit(height_margin, "in"), just = c("centre","centre"), layout = grid::grid.layout(numrow, numcol))) # Margins: left/right:10mm x top/bottom:22mm
        }
      }
      print(Xplt, vp = grid::viewport(layout.pos.row = col, layout.pos.col = row, x = grid::unit(0,"mm"), y = grid::unit(0,"mm"), clip = F))
      Xplt<-Xpng<-Xtxt<-Xsplt<-QRLink<-NA # Reset object to avoid mislabelling
    } else {if(row > numrow){
      row <- 1
      col<-col+1
      if(col > numcol){
        col<- 1
        grid::grid.newpage() # Open a new page on grid device
        grid::pushViewport(grid::viewport(width = grid::unit(width_margin, "in"), height = grid::unit(height_margin, "in"), just = c("centre", "centre"), layout = grid::grid.layout(numrow, numcol))) # Margins: left/right:10mm x top/bottom:22mm
      }
    }
      print(Xplt, vp = grid::viewport(layout.pos.row = row, layout.pos.col = col, x= grid::unit(0, "mm"), y = grid::unit(0, "mm"), clip = F))
      Xplt<-Xpng<-Xtxt<-Xsplt<-QRLink<-NA # Reset object to avoid mislabelling
    }
  }
  grDevices::dev.off()

  #end if
} #end create_PDF()
