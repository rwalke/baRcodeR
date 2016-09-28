#########################################
## Script to make QR code labels      ###
## Output to pdf to print on stickers ###
#########################################
## Basic instructions:
# Runs in R
# Max 25 characters (longer labels truncated to 25 characters)
# Set up for ULINE 1.75X1/2 WEATHER RESISTANT LABEL for laser printer; Item # S-19297 (uline.ca)
# Output is a pdf of labels 
# When printing: Use 'original size' (i.e. not 'fit' or 'shrink') and no margins in the print setup.

##########################
###### USER SETTINGS #####
##########################
## Install these packages if not installed already:
#install.packages(c("ggplot2","grid","gridExtra","RCurl","png","ggplot2","qrcode"))
## File of labels for QR code
## NOTE: Labels must be in UTF-8 format!
## Should be a csv file with single column; each row = new label
#Labels<-read.csv("Labels.csv",header=F,as.is=T) # Simple csv file with a separate label in each row

## Or make your own! (Text = any generic text; %04d = 4 digits preceded by zero as necessary)
#Labels<-data.frame(sprintf("@ColauttiLab\n2016-%04d",c(321:800)))

## With hierarchichal numbering (e.g. individuals within populations #11-20, sorted by population)
Pop<-c(11:20)
Ind<-c(1:80)
Labels<-data.frame(sprintf("rc91@queensu.ca\nPOP-%02d-%03d",sort(rep(Pop,length(Ind))),c(1:80)))

## Error correction: allows for some damage to barcode without affecting ability to scan.
#Level "L" - up to 7% damage -- ideal for very small labels (large pixels)
#Level "M" - up to 15% damage
#Level "Q" - up to 25% damage
#Level "H" - up to 30% damage -- good for bigger levels (small pixels)
ErrCorr="H"


## Set to TRUE to print labels across rows instead of down columns
Across<-T

# Set font size
Fsz<-2.5
# Split text into rows (prevents text cutoff when label has >8 characters without \\n in labels)
trunc<-F

## Number of rows/columns to skip --> Useful for printing on used sheets
ERows<-0
ECols<-0


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

# Dummy data.frame for plotting
dmy<-data.frame(x=c(0,457),y=c(0,212))
### Page Setup
pdf("LabelsOut.pdf",width=8.5,height=11,onefile=T,family="Courier") # Standard North American 8.5 x 11
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
    if(length(Xsplt)>25){Xsplt<-Xsplt[1:25]}
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
            
            





