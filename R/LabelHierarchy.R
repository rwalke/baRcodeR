label_hier_maker<-function(user=F, hierarchy, end=NULL, digits=2) {
  if(user==T) {
    hlevels <- readline("What is the # of levels in hierarchy: ")
    hlevels<-as.numeric(hlevels)
    # possible inputs
    strEndCheck<-c("Y","y","N","n")
    strEnd <- readline("String at end of barcode? (y/n) ")

    # check input
    while((strEnd %in% strEndCheck)==FALSE){
      print ("Invalid input, please only enter what is specified.")
      strEnd <- readline("String at end? (y/n) ")
    }
    if (paste(strEnd)=="y"){
      end <- readline("Please enter ending string: ")
    } else {
      end <- ""
    }
    barcodes<-NULL
    for(i in 1:hlevels){
      str <- readline(paste0("Please enter string for level ",i,": "))
      # startNum must be smaller than endNum
      startNum <- as.numeric(readline(paste0("Enter the starting number for level ",i,": ")))
      endNum <- as.numeric(readline(paste0("Enter the ending number for level ",i,": ")))
      maxNum <- max(startNum,endNum)
      digitsMax <- nchar(paste(maxNum))
      digits <- as.numeric(readline(paste0("Number of digits to print for level ",i,": ")))
      # check input
      while (digits<digitsMax){
        print(paste0("Please enter a number larger or equal to ", nchar(paste(maxNum))))
        digits <- as.numeric(readline(paste0("Number of digits to print for level",i,": ")))
      }
      lvlRange <-c(startNum:endNum)
      line<-paste0(str,"%0",digits,"d")
      Labels<-sprintf(line,rep(lvlRange))
      ## loop for levels
      if (i > 1) {
        ## replicate previous labels by number of elements in present level
        temp_barcode<-rep(barcodes, each=length(startNum:endNum))
        ## rep present level elements so the length matches that of temp_barcode
        temp_label<-rep(Labels, length.out=length(temp_barcode))
        ## paste everything together
        Labels<-paste(temp_barcode, temp_label, sep="-")
      }
      ## paste ending string onto labels and call it barcodes
      barcodes<-paste0(Labels,end)
      return(barcodes)
  }

  } else {
    if (is.list(hierarchy)==F) stop("hierarchy is not in list format. See ?label_hier_maker")
    if (length(unique(sapply(hierarchy, length))) != 1) stop("hierarchy entries are not of equal length. Each element should have a string, a beginning value and an end value.")
    barcodes<-NULL
    for (i in 1:length(hierarchy)) {
      str<-hierarchy[[i]][1]
      startNum<-as.numeric(hierarchy[[i]][2])
      endNum<-as.numeric(hierarchy[[i]][3])
      maxNum <- max(startNum,endNum)
      lvlRange <-c(startNum:endNum)
      line<-paste0(str,"%0",digits,"d")
      Labels<-sprintf(line,rep(lvlRange))
      ## loop for levels
      if (i > 1) {
        ## replicate previous labels by number of elements in present level
        temp_barcode<-rep(barcodes, each=length(startNum:endNum))
        ## rep present level elements so the length matches that of temp_barcode
        temp_label<-rep(Labels, length.out=length(temp_barcode))
        ## paste everything together
        Labels<-paste(temp_barcode, temp_label, sep="-")
      }
      barcodes<-paste0(Labels,end)
    }
    return(barcodes)
  }

}




a<-c("a",3,6)
b<-c("b",1,3)
c<-list(a,b)

label_hier_maker(hierarchy=c, end="end")
