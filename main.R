######################################################
##  Script to run LabelHierarchy.R and createPDF.R ###
##      Outputs pdf to specified location          ###
######################################################

# Please keep this script in the same folder as LabelHierarchy.R and createPDF.R

# Set the working directory (default will be the current directory)

setwd("/Users/emilybao/Documents/courses/barcodeProject")
##multi level label run:
#source("LabelHierarchy.R") 

##one level label run:
#source("LabelMaker.R") 
cust <- toupper(readline("Do you want to use the standard pdf layout? (y/n): "))
if (cust == "Y" || cust == "y"){
  source("createPDF.R")
} else {
  source("customSizePDF.R")
}





