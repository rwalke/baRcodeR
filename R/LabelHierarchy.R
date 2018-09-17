#' Make hierarchical ID codes
#'
#' Generate hierarchical ID codes for barcode labels. Use \code{\link{uniqID_maker}} 
#' for sequential single-level labels. Can be run interactively 
#' prompting user for input. The data.frame output can be used as input 
#' for \code{\link{create_PDF}} to create printable barcode labels.
#'
#' @param user logical. Run function using interactive mode (prompts user for 
#' parameter values). Default is \code{FALSE}
#' @param hierarchy list. A list with each element consisting of three members
#'  a vector of three elements (string, beginning value, end value). See examples.
#'  Used only when \code{user=F})
#' @param end character. A string to be appended to end of each label.
#' @param digits numerical. Default is \code{2}. Number of digits to be printed, 
#' adding leading 0s as needed. This will apply to all levels when \code{user=F}. 
#' When the numeric value of the label has a greater number of digits than 
#' \code{digits}, \code{digits} is automatically increased for the entire level. 
#' @export
#' @return data.frame of text labels in the first column, with additional columns 
#' for each level defined by the user.
#' 
#' @seealso \code{\link{uniqID_maker}}
#' @examples
#' \dontrun{
#' ## for interactive mode
#' uniqID_hier_maker(user = T)
#' }
#'
#' ## how to make hierarchy list
#'
#' ## create vectors for each level in the order string_prefix, beginning_value,
#' ## end_value and combine in list
#'
#' a <- c("a", 3, 6)
#' b <- c("b", 1, 3)
#' c <- list(a, b)
#' Labels <- uniqID_hier_maker(hierarchy = c)
#' Labels
#'
#' ## add string at end of each label
#' Labels <- uniqID_hier_maker(hierarchy = c, end = "end")
#' Labels
#'


uniqID_hier_maker <- function(user = F, hierarchy, end = NULL, digits = 2){
  # user interaction code
  if(user == T){
    hlevels <- readline("What is the # of levels in hierarchy: ")
    hlevels <- as.numeric(hlevels)
    # possible inputs
    strEndCheck <- c("Y", "y", "N", "n")
    strEnd <- readline("String at end of label? (y/n) ")
    # check input
    while((strEnd %in% strEndCheck) == FALSE){
      print("Invalid input, please only enter what is specified.")
      strEnd <- readline("String at end? (y/n) ")
    }
    if (paste(strEnd) == "y"){
      end <- readline("Please enter ending string: ")
    } else {
      end <- ""
    }
    digits <- as.numeric(readline(paste0("Number of digits to print: ")))
    while(is.na(as.numeric(digits)) == T){
      print("Invalid input. Please only enter an integer.")
      digits <- as.numeric(readline(paste0("Number of digits to print: ")))
    }
    hierarchy <- vector("list", hlevels)
    for(i in 1:hlevels){
      str <- readline(paste0("Please enter string for level ",i,": "))
      # startNum must be smaller than endNum
      startNum <- as.numeric(readline(paste0("Enter the starting number for level ",i,": ")))
      while(is.na(startNum) == T) {
        print("Invalid input. Please enter an integer.")
        startNum <- as.numeric(readline(paste0("Enter the starting number for level ",i,": ")))
      }
      endNum <- as.numeric(readline(paste0("Enter the ending number for level ",i,": ")))
      while(is.na(endNum) == T){
        print("Invalid input. Please enter an integer.")
        endNum <- as.numeric(readline(paste0("Enter the ending number for level ",i,": ")))
      }
      maxNum <- max(startNum,endNum)
      hierarchy[[i]]<-c(str, startNum, endNum)
    }
  } # end user input
  # hierarchy format check
  if (is.list(hierarchy) == F) stop("hierarchy is not in list format. See ?uniqID_hier_maker")
  if (length(unique(sapply(hierarchy, length))) != 1) stop("hierarchy entries are not of equal length. Each element should have a string, a beginning value and an end value.")
  # loop through hierarchy to generate text
  for(i in 1:length(hierarchy)){
    str <- hierarchy[[i]][1]
    startNum <- as.numeric(hierarchy[[i]][2])
    endNum <- as.numeric(hierarchy[[i]][3])
    if (is.na(startNum) == T ){
      stop(paste0("Invalid starting number on level", i, ". Please doublecheck your input"))
    }
    if (is.na(endNum) == T ){
      stop(paste0("Invalid ending number on level", i, ". Please doublecheck your input"))
    }
    maxNum <- max(startNum, endNum)
    digitsMax <- max(digits, nchar(paste(maxNum)))
    if (digitsMax > digits){
      warning("Digits specified less than max level number. Increasing number of digits for level")
      digits <- digitsMax
    }
    lvlRange <- c(startNum:endNum)
    line <- paste0(str, "%0", digits, "d")
    Labels <- sprintf(line, rep(lvlRange))
    if (i > 1) {
      ## replicate previous labels by number of elements in present level
      temp_barcode <- rep(barcodes, each = length(startNum:endNum))
      ## rep present level elements so the length matches that of temp_barcode
      temp_label <- rep(Labels, length.out = length(temp_barcode))
      ## paste everything together
      Labels <- paste(temp_barcode, temp_label, sep = "-")

    }
    barcodes <- Labels
  } # end hierarchy making loop
  # makes columns out of hierarchy levels
  label_df <- cbind(barcodes, data.frame(t(sapply(strsplit(barcodes, "-"),c))))
  df_names <- sapply(hierarchy, function(x) x[1])
  # different ways to name the data frame columns depending on presence of level strings.
  if (any(nchar(df_names) == 0)){
    warning("Empty string in level. Using default column naming.")
    names(label_df) <- c("label", paste0("level", 1:length(hierarchy)))
  } else {
    names(label_df) <- c("label", df_names)
  }
  # dont forget to add the string at the end
  label_df$label <- paste0(label_df$label, end)
  return(label_df)
}

