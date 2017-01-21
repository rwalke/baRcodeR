#########################################
## Script to make QR code labels      ###
## Output to pdf to print on stickers ###
#########################################
## Basic instructions:
# Runs in R
# Max 25 characters (longer labels truncated to 27 characters)
# Set up for ULINE 1.75X1/2 WEATHER RESISTANT LABEL for laser printer; Item # S-19297 (uline.ca)
# Output is a pdf of labels 
# When printing: Use 'original size' (i.e. not 'fit' or 'shrink') and no margins in the print setup.

##########################
###### USER SETTINGS #####
##########################
## Install these packages if not installed already:
##install.packages(c("ggplot2","grid","gridExtra","RCurl","png","ggplot2","qrcode"))
## File of labels for QR code
## NOTE: Labels must be in UTF-8 format!
## Should be a csv file with single column; each row = new label
#Labels<-read.csv("Labels.csv",header=F,as.is=T) # Simple csv file with a separate label in each row
#Make your own in LabelHierarchy.R!

##########################
###### END SETTINGS ######
##########################

## Libraries
library(ggplot2)
library(grid)
library(gridExtra)
library(png)
library(qrcode)
source("theme_empty.R")

# file name
oname <- readline("Enter the name of the output pdf file: ")
oname<-paste0(oname,".pdf")
while (oname==""){
  oname <- readline("Enter the name of the output pdf file: ")
}


# [Function] create_PDF prompts for pdf settings if "ask" is set to T, otherwise creates with default values
## Parameters: 
## Labels: a vector of barcodes
## ErrCorr: error correction, Levels of damage from low to high: L, M, Q, H
## Across: set to TRUE to print labels across rows instead of down columns
## Fsz: set font size
## trunc: split text into rows (prevents text cutoff when label has >8 characters without \\n in labels)
## ERows/ECols: number of rows/columns to skip, default is 0
## ask: user prompt, default is false
create_PDF<-function(Labels = NA, ErrCorr="H",Across=T,Fsz=2.5,trunc=F,ERows=0,ECols=0,ask=F){
  
  if(length(Labels) == 0){
    print("Please pass in barcode labels")
  } else{
  
    # if user prompt has been set to true
    if (ask==T){
      labelLength<-nchar(paste(Labels[1,1]))
      ## Set font size
      Fsz <- as.numeric(readline("Please enter a font size (2.2-4.7): "))
      while (Fsz<2.2 || Fsz >4.7){
        print ("Invalid input, please specify a font size within the range 2.2-4.7")
        Fsz <-as.numeric(readline("Please enter a font size (2.2-4.7): "))
      }
      
      while (Fsz>=2.2 && Fsz<=2.5 && labelLength >= 27){
        print("ERROR: not enought space to print full label, please decrease font size")
        Fsz <-as.numeric(readline("Please enter a font size (2.2-4.7): "))
      }
      while (Fsz>=2.6 && Fsz <=4.0 && labelLength >=18){
        print("ERROR: not enought space to print full label, please decrease font size")
        Fsz <-as.numeric(readline("Please enter a font size (2.2-4.7): "))
      }
      while(Fsz>=4.1 && Fsz<=4.7 && labelLength>=9){
        print("ERROR: not enought space to print full label, please decrease font size")
        Fsz <-as.numeric(readline("Please enter a font size (2.2-4.7): "))
      }

      
      ## Error correction
      ErrCorr <- toupper(readline("Specify an error correction - L, M, Q, H: "))
      errCheck<-c("L","l","M","m","Q","q","H","h")
      # check errCorr input
      while((ErrCorr %in% errCheck)==FALSE){
        print ("Invalid input, please only enter what is specified")
        ErrCorr <- toupper(readline("Specify an error correction - L, M, Q, H: "))
      }
        
      # possible inputs
      inputCheck<-c("T","t","F","f")
        
      ## Set to TRUE to print labels across rows instead of down columns
      Across<- toupper(readline("Please enter T or F to print across: "))
        
      while((Across %in% inputCheck)==FALSE){
        print("Invalid input")
        Across <- toupper(readline("Please enter T or F to print across: "))
      }
      # Split text into rows (prevents text cutoff when label has >8 characters without \\n in labels)
      trunc<-toupper(readline("Do you want to split text into rows? (T/F): "))
      while((trunc %in% inputCheck)==FALSE){
        print("Invalid input")
        trunc<-toupper(readline("Do you want to split text into rows? (T/F): "))
      }
        
      ERows <- as.numeric(readline("Number of rows to skip? (enter 0 for default): "))
      ECols <- as.numeric(readline("Number of cols to skip? (enter 0 for default): "))
        
    } # end ask == T
    
# Dummy data.frame for plotting
dmy<-data.frame(x=c(0,457),y=c(0,212))
### Page Setup
pdf(oname,width=8.5,height=11,onefile=T,family="Courier") # Standard North American 8.5 x 11
grid.newpage() # Open a new page on grid device 
pushViewport(viewport(width=unit(8,"in"),height=unit(10,"in"),just=c("centre","centre"),layout = grid.layout(nrow=20, ncol=4))) # Margins: left/right:10mm x top/bottom:22mm
row<-ERows
col<-ECols+1
for (i in 1:nrow(Labels)){
  # Create text label
  Xtxt<-paste(gsub("\\\\n","\\\n",Labels[i,]),collapse="")
  # Split label to count characters
  Xsplt<-strsplit(Xtxt,"")[[1]]
  
  if(trunc==T){  # Truncate string across lines if trunc==T
    if(length(Xsplt)>27){Xsplt<-Xsplt[1:27]}
    # If remaining string is > 8 characters, split into separate lines
    if(length(Xsplt)>8){
      Xnew<-{}
      count<-0
      for(j in 1:length(Xsplt)){
        count<-count+1
        Xnew<-c(Xnew,Xsplt[j])
        if(count>8){
          count<-0
          Xnew<-c(Xnew,"\n")        
        }
      }
      Xtxt<-paste(Xnew,collapse="")
    }
  }
  # Create qrcode
  Xpng<-rasterGrob(abs(qrcode_gen(paste0(Labels[i,]),ErrorCorrectionLevel=ErrCorr,dataOutput=T,plotQRcode=F,mask=3)-1),interpolate=F)
  # Create tag (QR code + text label)
  Xplt<-
    ggplot(data=dmy,aes(x=0,y=0))+annotation_custom(Xpng,xmin=30,xmax=210,ymin=60,ymax=210)+coord_cartesian(xlim=c(0,457),ylim=c(0,212))+theme_empty()+
    geom_text(aes(x=215,y=182,label=Xtxt,hjust=0,vjust=1),size=Fsz) # +geom_point(aes(x=x,y=y)) # useful points for fitting margins
  
  # Output to tag position
  row<-row+1
  if(Across==T){
    if(row>4){
      row<-1
      col<-col+1
      if(col>20){
        col<-1
        grid.newpage() # Open a new page on grid device 
        pushViewport(viewport(width=unit(8,"in"),height=unit(10,"in"),just=c("centre","centre"),layout = grid.layout(nrow=20, ncol=4))) # Margins: left/right:10mm x top/bottom:22mm
      }
    }
    print(Xplt, vp = viewport(layout.pos.row=col,layout.pos.col=row,x=unit(0,"mm"),y=unit(0,"mm"),clip=F))
    Xplt<-Xpng<-Xtxt<-Xsplt<-QRLink<-NA # Reset object to avoid mislabelling
  } else {if(row>20){
    row<-1
    col<-col+1
    if(col>4){
      col<-1
      grid.newpage() # Open a new page on grid device 
      pushViewport(viewport(width=unit(8,"in"),height=unit(10,"in"),just=c("centre","centre"),layout = grid.layout(nrow=20, ncol=4))) # Margins: left/right:10mm x top/bottom:22mm
    }
  }
    print(Xplt, vp = viewport(layout.pos.row=row,layout.pos.col=col,x=unit(0,"mm"),y=unit(0,"mm"),clip=F))
    Xplt<-Xpng<-Xtxt<-Xsplt<-QRLink<-NA # Reset object to avoid mislabelling
  }
}
dev.off()
} #end if
} #end create_PDF()

# Pass in Labels from global environment (Please make sure that Labels is existing)
create_PDF(Labels)
