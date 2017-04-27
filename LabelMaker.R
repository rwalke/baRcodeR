############################################
##    Script to make barcode labels      ###
## Outputs a list in environment and csv ###
##            one level only             ###
############################################

# Set the working directory
# setwd("C:/Users/Emily Bao/SkyDrive/Documents/R-Projects/II-I-II-baRcodes-I-II-III")
mainDir <- "~/Documents/courses/barcodeProject/"
subDir <- "output_csv"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))

# [Function] assignVar prompts and obtains the inputted hierarchy information 
assignVar <- function(){
  
  # output csv file name
  name <<- noquote(readline("Enter the name of the output csv file: "))
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
    startNum <- as.numeric(readline(paste0("Enter the starting number for level: ")))
    endNum <- as.numeric(readline(paste0("Enter the ending number for level: ")))
    maxNum <- max(startNum,endNum)
    str <- readline(paste0("Please enter string for level: "))
    digitsMax <- nchar(paste(maxNum))
    digits <- as.numeric(readline(paste0("Number of digits to print for level: ")))
    # check input
    while (digits<digitsMax){
      print(paste0("Please enter a number larger or equal to ", nchar(paste(maxNum))))
      digits <- as.numeric(readline(paste0("Number of digits to print for level: ")))
    }
    lvlRange <-c(startNum:endNum)
    line<-paste0(str,"%0",digits,"d")
    Labels<-sprintf(line,rep(lvlRange))
    name<-paste0(name,".csv")
    write.table(Labels, sep=",",file=name,row.names=FALSE,col.names=FALSE)
    print(Labels)
    setwd(file.path(mainDir))
}


e1 <- new.env()
assignVar()



