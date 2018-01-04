# II-I-II-baRcodes-I-II-III
The purpose of this project is to build a set of tools in R for labelling and tracking biological samples

## Description:


## In Progress: 
GOAL: reorganize code so that it is following guidelines to submit to CRAN
Adding Roxygen documentation to create man pages
Adding ability to run from console in addition to user prompts by adding input variables to function for those needed
Writing vignette/methods on how to use package


~~LabelMaker.R~~  
~~LabelHierarchy.R~~
~~createPDF.R~~
customSizePDF.R


## To Do:
Make tests using testthat package




## Variables:
Variables to track for function:
digits -> # digits to print (e.g. for leading zeros, 001, 000001, etc.)
hlevels ->  # levels in hiearchy (e.g. Individual nested in Population = 2 levels)
oname -> File name of pdf output
iname -> FIle name of csv input
errcorr -> Error correction; must be in c("L","M","Q","H")

Examples of label inputs:
#### A csv file with single column; each row = new label
Labels<-read.csv("Labels.csv",header=F,as.is=T) 

#### Any generic text; %04d = 4 digits preceded by zero as necessary
Labels<-data.frame(sprintf("@ColauttiLab\n2016-%04d",c(321:800)))

#### Text with hierarchichal numbering (e.g. individuals within populations #11-20, sorted by population)
Pop<-c(1:20)
Ind<-c(1:80)
Labels<-data.frame(sprintf("rc91@queensu.ca\nPOP-%02d-%03d",sort(rep(Pop,length(Ind))),c(1:80)))



### ULINE_QRGenerato.R
Contains sample code for producing 2D barcode labels that can be printed on a standard laser printer
Formatted for ULINE Premium Laser Printer Labels
Catalogue #S-19297 (80 labels per sheet, 1.75" x 0.5")

Requires:**theme_empty.R**
