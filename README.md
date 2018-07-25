# baRcodeR

Yihan Wu, Emily Bao and Robert I. Colautti

## Quick Start:

```
devtools::install_github("yihanwu/baRcodeR")
library(baRcodeR)
```

## Introduction

`baRcodeR` is a R package for generating sample labels and 2D barcodes for labelling and tracking biological samples. Users can: 

* generate simple labels (Ex-001, Ex-002, Ex-003 ...),
* generate hierarchical labels (A-01-B-01, A-01-B-02, A-02-B-01, A-02-B-02, A-03-B01 ...),
* produce PDF files with custom layouts for all types of sticker labels.

## Usage the RStudio addin 

The main baRcodeR functions, label creation and barcode generation, can be performed interactive via the RStudio addin found on the toolbar. 

![Screenshot of add-in toolbar](man/figures/add-in-screenshot.png)

Click on the add-in, and a popup window will appear.

![Screenshot of the simple labels tab](man/figures/tab-1-screenshot.png)

As you fill in the fields, a preview of the labels will appear on the side along with reproducible code which can be copied. 

![Active simple labels tab](man/figures/tab-1-screenshot-2.png)

You can switch from the simple label generation tab to the hierarchical label generation or barcode creation tabs at the bottom.

![Screenshot of the hierarchical labels tab](man/figures/tab-2-screenshot.png)

For hierarchical labels, the information for each level is saved under the "Levels" section and you can remove the most recently added level using the "Remove Level" button.

Labels are saved with the file name "Labels_YYYY-MM-DD.csv" in the working directory.

The Barcode Creation tab contains all the advanced options for page layout. 

![Screenshot of PDF creation tab](man/figures/tab-3-screenshot.png)

Text files can be previewed before generating barcodes.










