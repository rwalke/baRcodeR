## Test environments
* local Windows 10 install, R 3.5.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORS or WARNINGS

This is our second submission. From first submission on September 10, 2018, we made three changes:

1. We have changed the example for create_PDF() to write to tempdir() as suggested by Uwe Liggs.

2. We renamed functions containing label_ to uniqID_ to clarify that the functions generate unique identifiers, in contrast to create_PDF, which generates labels for printing. We found this was already a source of confusions among early testers.

3. We fixed a minor bug in the preview of one of the Addins tabs and we clarified explanations in the vignette and documentation.

