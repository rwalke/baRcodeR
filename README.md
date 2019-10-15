
<!-- README.md is generated from README.Rmd. Please edit that file -->

# baRcodeR

<!-- badges: start -->

[![Status](https://www.r-pkg.org/badges/version/baRcodeR)](https://cran.r-project.org/web/packages/baRcodeR/index.html)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/baRcodeR)](https://cran.r-project.org/web/packages/baRcodeR/index.html)
[![Travis build
status](https://travis-ci.org/yihanwu/baRcodeR.svg?branch=master)](https://travis-ci.org/yihanwu/baRcodeR)
[![Codecov test
coverage](https://codecov.io/gh/yihanwu/baRcodeR/branch/master/graph/badge.svg)](https://codecov.io/gh/yihanwu/baRcodeR?branch=master)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

baRcodeR generates labels for more repeatable workflows with biological
samples

## Installation

You can install the released version of baRcodeR from
[CRAN](https://CRAN.R-project.org) with:

    install.packages("baRcodeR")

And the development version from [GitHub](https://github.com/) with:

    # install.packages("devtools")
    devtools::install_github("yihanwu/baRcodeR", build_vignettes = T)

## Quick Start

Text identifiers can be created in a sequential or hierarchical pattern.

``` r
library(baRcodeR)
```

    ## Loading required package: qrcode

    ## Registered S3 method overwritten by 'R.oo':
    ##   method        from       
    ##   throw.default R.methodsS3

``` r
example_labels <- uniqID_maker(user = F, string = "Example", level = 1:40)
head(example_labels)
```

    ##        label ind_string ind_number
    ## 1 Example001    Example        001
    ## 2 Example002    Example        002
    ## 3 Example003    Example        003
    ## 4 Example004    Example        004
    ## 5 Example005    Example        005
    ## 6 Example006    Example        006

Then the text identifiers can be printed out with a laser printer on
sticker sheets.

``` r
pdf_file_name <- tempfile()
create_PDF(Labels = example_labels, name = pdf_file_name)
```

![](man/figures/example.png)<!-- -->

### Cheat Sheet

A 2-page, quick-reference guide is available via
[Figshare](https://dx.doi.org/10.6084/m9.figshare.7043309)

## Overview

![Flowchart of major functions](man/figures/Flowchart.png)

## Introduction

`baRcodeR` is a R package for generating unique identifier strings and
printable 2D (QR) barcodes, with the aim of improving repeatability of
labelling, tracking and curating data from biological samples.
Specifically, users can:

  - generate simple ID codes (Ex001, Ex002, Ex003 …),
  - generate hierarchical (i.e. nested) ID codes (A01-B01, A01-B02,
    A02-B01, A02-B02, A03-B01 …),
  - generate printable PDF files of paired ID codes and QR barcodes with
    default spacing for ULINE 1.75" \* 0.5" WEATHER RESISTANT LABEL for
    laser printer; item \# S-19297 (uline.ca)
  - customize the PDF layout for any type of printable format (e.g,
    vinyl stickers, waterproof paper)
  - generate reproducible code for archival purposes (e.g. in
    publications or online repositories)
  - create CSV files to link unique IDs and sampling hierarchy with
    downstream data collection workflows. For example, the PyTrackDat
    pipeline can be used to set up a web-based data collection platform:
    <https://github.com/pytrackdat/pytrackdat>

## Using the RStudio addin

The main baRcodeR functions for unique identifiers and QR code
generation can be performed interactive via the RStudio addin found on
the toolbar.

![Screenshot of RStudio Addins
toolbar](man/figures/add-in-screenshot.png)

Click on the add-in, and a popup window will appear. NOTE the 3 tabs
along the bottom, corresponding to the three main baRcodeR commands:
`uniqID_maker`, `uniqID_hier_maker` and `create_PDF`.

![Screenshot of the simple ID Code
tab](man/figures/tab-1-screenshot.png)

The first tab generates basic ID codes:

![Active simple ID code tab](man/figures/tab-1-screenshot-2.png)

As you fill in the fields, a preview of the ID codes will appear on the
right-hand side along with reproducible code, which can be copied for
archival purposes. Clicking ‘Create Label.csv’ will create a CSV file
called ‘Label\_YYYY-MM-DD.csv’, which contains a data frame with the
full unique ID strings as the first column, the user-defined prefix
string in the second column, and the unique ID number in the third
column. This file is useful for archiving ID codes and as a starting
point for data entry. For example, it can be opened in a spreadsheet
program to add data measurement columns. It is also the input for
creating printable, QR-coded labels with `create_PDF`.

![Screenshot of the hierarchical ID code
tab](man/figures/tab-2-screenshot.png)

You can switch from the simple ID code generation tab to the
hierarchical ID code generation or QR code creation tabs at the bottom.

Hierarchical ID codes have a nested structure (e.g. X subsamples from Y
individuals at Z time points), the information for each level is saved
under the “Hierarchy” section. The “Add level” button is used to add
more levels to the hierarchy, and the “Remove level” button will remove
the most recently added level. The data frame output will contain ID
codes in the first column, and a separate column for each level of the
hierarchy, with the user-defined string as the header; as shown under
‘Preview’. As with the simple ID code tab, the output of Hierarchical
ID codes is a CSV file “Labels\_YYYY-MM-DD.csv”, saved in the working
directory. This file is useful for archiving ID codes and as a starting
point for data entry. For example, it can be opened in a spreadsheet
program to add data measurement columns. It is also the input for
creating printable, QR-coded labels with `create_PDF`.

![Screenshot of PDF creation tab](man/figures/tab-3-screenshot.png)

The Barcode Creation tab contains all the advanced options for page
layout. The default options fit a specific format: ULINE 1.75" \* 0.5"
WEATHER RESISTANT LABEL for laser printer; item \# S-19297 (uline.ca). A
text file containing ID codes is imported by clicking the “Browse”
button and selecting the CSV text file in the file browser. The file is
be previewed by clicking “Import File”.

![Screenshot of Column Selection](man/figures/tab-3-screenshot-2.png)

After importing a CSV file, the preview shows part of the expected
output PDF file based on font size and other layout options. The first
column is highlighted by default and defines the column to use for the
labels. Clicking on a different column will set it as the ID code
column, as shown in the preview.

Clicking “Make PDF” will generate a printable PDF of all barcodes
provided. This can take several minutes for \>100 barcodes, depending on
computer speed. The text “Done” will appear upon completion of the PDF
file.

> NOTE: When printing from pdf, ensure that ‘anti-aliasing’ or
> ‘smoothing’ options are turned OFF, and that you are not using ‘fit
> to page’ or similar options that will re-scale the output.

## Usage from the console

Please load the vignette “Using-baRcodeR” for console use.

``` r
library(baRcodeR)
```

    vignette("Using-baRcodeR")

# Contribution

Please note that the ‘baRcodeR’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.

Please document issues with a description, a minimal reproducible
example, and the `sessionInfo()`.

``` r
sessionInfo()
```

    ## R version 3.6.1 (2019-07-05)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 17763)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252   
    ## [3] LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                   
    ## [5] LC_TIME=English_Canada.1252    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] baRcodeR_0.1.4 qrcode_0.1.1  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.2        png_0.1-7         digest_0.6.20    
    ##  [4] R.methodsS3_1.7.1 magrittr_1.5      evaluate_0.14    
    ##  [7] stringi_1.4.3     rstudioapi_0.10   R.oo_1.22.0      
    ## [10] R.utils_2.9.0     rmarkdown_1.14    tools_3.6.1      
    ## [13] stringr_1.4.0     xfun_0.8          yaml_2.2.0       
    ## [16] compiler_3.6.1    htmltools_0.3.6   knitr_1.24

# See also:

  - [zintr](https://github.com/carlganz/zintr), an R interface to the C
    zint library
