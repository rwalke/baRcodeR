######################################################
##  Script to run LabelHierarchy.R and createPDF.R ###
##      Outputs pdf to specified location          ###
######################################################

# Please keep this script in the same folder as LabelHierarchy.R and createPDF.R

# Set the working directory (default will be the current directory)

setwd("/Users/emilybao/Documents/courses/barcodeProject")

#source("LabelHierarchy.R") 
cust <- toupper(readline("Do you want customize your own values for pdf layout? (y/n): "))
if (cust == "Y" || cust == "y"){
  source("customSizePDF.R")
} else {
  source("createPDF.R")
}





