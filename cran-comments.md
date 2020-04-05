## baRcodeR 0.1.5 R CMD check results

This is a minor update to make sure tests pass on r-devel and fix a broken link. 


## Test environments

* local Windows 10 install, R 3.6.1, r-devel
* win-builder (devel and release)
* Ubuntu 16.04 (on travis-ci), R-oldrel, R-release, R-devel
* R-hub 
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 16.04 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran


## Amendment to previous rejected submission

We have removed the license file from the description file and the package file itself as suggested by Uwe Ligges.


  
## baRcodeR 0.1.4 R CMD check results

There were no ERRORS or WARNINGS. 1 NOTE regarding change of package maintainer from Robert Colautti to Yihan Wu. 

This is our third submission. From our last submission, we made

1. changes to clarify documentation 

2. modify command line prompts with menu-like choices

3. added a vignette tutorial to show how to use the package with the RStudio addin and removed similar content from the package README

4. corrected error in current CRAN version of package relating to R-devel changes

### April 26, 2019

This is our second submission. From first submission on September 10, 2018, we made three changes:

1. We have changed the example for create_PDF() to write to tempdir() as suggested by Uwe Liggs.

2. We renamed functions containing label_ to uniqID_ to clarify that the functions generate unique identifiers, in contrast to create_PDF, which generates labels for printing. We found this was already a source of confusions among early testers.

3. We fixed a minor bug in the preview of one of the Addins tabs and we clarified explanations in the vignette and documentation.

### Oct 4, 2018 

additional changes advised by Swetlana Herbrandt

1. Removed 'Open-Source R Tools for' in the title
2. Replaced T and F with TRUE and FALSE throughout
3. Repaced \dontrun{} with if(interactive()){} or \donttest{}

### Oct 12, 2018

A few changes from Oct 4 were not included in the last upload.
Additionally, fixed a minor text errors:
1. 'collection' occurred twice in DESCRIPTION
2. 'unique' was mis-spelled in documentation of uniqID_maker

### Nov 29, 2018

Bug fixes and minor features added, as outlined in NEWS.md

### Jan 10, 2019

- Added the ability to create linear (1D) barcodes using the type='linear' parameter in create_pdf()
- fixed a few minor spelling/grammar changes

### April 26, 2019

Bug fix for linear barcodes and minor changes outlined in NEWS.md (ver. 0.1.3)

### April 4, 2020

At the request of a COVID-2019 research group, we have added an option to allow non-encoded text to appear with linear & 2D barcodes.  
