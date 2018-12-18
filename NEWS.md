# baRcodeR 0.1.2

New Feature:

- As requested, there is now an option to print linear (code 128 set B) barcodes. 


# baRcodeR 0.1.1

Bugs and Improvements: 

- will replace all underscores in text with dashes. Underscores are not specified in the encoding dictionary of `qcrode` and will throw errors.
- x_space and y_space, parameters used to position text on label, is now limited between 0 and 1 for easier use.
- limits on font size taken off, font size now measured as points

New Features:

- Specify the width and height of the label to account for gaps between physical labels both horizontally and vertically.



# baRcodeR 0.1.0

This is the first official release of the package.