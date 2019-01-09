## Test environments
* local Windows 10 install, R 3.5.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORS or WARNINGS

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

### Jan 9, 2019

Added the ability to create linear (1D) barcodes using the type='linear' parameter in create_pdf() 
