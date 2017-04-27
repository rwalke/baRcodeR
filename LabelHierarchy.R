##################################################
##       Script to make barcode labels         ###
##    Outputs a list in environment and csv    ###
##  barcode with multiple levels of hierarchy  ###
##################################################

# Set the working directory
mainDir <- "~/Documents/courses/barcodeProject/"
subDir <- "output_csv"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))

# [Function] assignVar prompts and obtains the inputted hierarchy information 
assignVar <- function(){
  
  # output csv file name
  name <<- noquote(readline("Enter the name of the output csv file: "))
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

  # loops through user indicated levels
for(i in 1:hlevels){
  curr <- as.numeric(i) # records current level
  # startNum must be smaller than endNum
  startNum <- as.numeric(readline(paste0("Enter the starting number for level ",i,": ")))
  endNum <- as.numeric(readline(paste0("Enter the ending number for level ",i,": ")))
  maxNum <- max(startNum,endNum)
  str <- readline(paste0("Please enter string for level ",i,": "))
  digitsMax <- nchar(paste(maxNum))
  digits <- as.numeric(readline(paste0("Number of digits to print for level ",i,": ")))
  # check input
  while (digits<digitsMax){
    print(paste0("Please enter a number larger or equal to ", nchar(paste(maxNum))))
    digits <- as.numeric(readline(paste0("Number of digits to print for level",i,": ")))
  }
  # calls LabelMakerHierarchy function and passes in needed values
  LabelMakerHierarchy(startNum,endNum,digits,str,end,curr,hlevels,name)
}
}

# [Function] LabelMakerHierarchy takes in parameters of each level  
# and blends it with the previous level
# it outputs a list called final which contains the barcode
LabelMakerHierarchy <- function(startNum,endNum, digits,str,end, curr,hlevels,name){
  barcode <-{} # barcode of each level
  temp_1 <-{} # barcode of first level
  Labels<- {} # final barcode
  temp_2<-{}

  lvlRange <-c(startNum:endNum)
  line<-paste0(str,"%0",digits,"d")
  barcode<-sprintf(line,rep(lvlRange))
  
print(barcode)
  if (curr==1){
    temp_1<-rep(barcode)
    setInitial(temp_1)
  } 
  if (curr!=1){
    setFollowing(barcode)
    temp_1 <- getInitial()
    
    # copy each label next level number of times
    temp_2 <- sort(rep(temp_1,length(barcode)))

    # replicate current level to same length of label (modified)
    barcode<-rep(barcode,length(temp_1))
    
    # append levels together
    Labels <- paste0(temp_2,barcode)
    temp_1<-Labels
    setInitial(temp_1)
    if(curr==hlevels){
      # add ending string
      Labels<<-data.frame(paste0(Labels,end))
      saveToCSV(name)
      setwd(file.path(mainDir))
    }
  }
}

saveToCSV<-function(name){
  name<-paste0(name,".csv")
  write.table(Labels, sep=",",file=name,row.names=FALSE,col.names=FALSE)
}
# [Function] Sets barcode as global
setFollowing<-function(barcode){
  assign("barcode",barcode,env=e1)
}

getFollowing<- function(){
  return(get("barcode",e1))
}

# [Function] Sets temp_1 as global
setInitial<-function(temp_1){
  assign("initial",temp_1,env=e1)
}

getInitial<- function(){
  return(get("initial",e1))
}

e1 <- new.env()
assignVar()
print(Labels)



