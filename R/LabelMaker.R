#' Makes list for barcode labels in environment
#'
#' Takes user prompts or variables to create  text labels consisting of a text
#' string and numbers (string001, string002 ... ...) . This function will only
#' create simple text labels compared to \code{\link{label_hier_maker}} that
#' creates a hierarchical list of labels. The created output will then be fed
#' into \code{\link{create_PDF}} to create 2-D labels in PDF.
#'
#' When the function is used with user prompts, the levels are the sequence
#' between the starting and ending number. When \code{user=F}, it is possible
#' to set custom sequences of numbers for the levels. See example.
#'
#' @return a string of characters
#' @param user logical. Default is FALSE. If the function is run with user
#' prompts or with variables already specified
#' @param string character. Text string for label. Default null.
#' @param level integer string. Defines the numerical values to be appended
#' to the character string. Can be any sequence of numbers, not just sequential
#' @param digits integer. The number of digits to print for the numbers
#' appended to the text string. Default is 3.
#'
#' @seealso \code{\link{label_hier_maker}}
#' @export
#' @examples
#'
#'
#' ## sequential string of numbers in label
#' Labels<-label_maker(string="string", level = c(1:5), digits=2)
#' Labels
#' ## can also use nonsequential strings in input for levels
#' level<-c(1:5, 8:10, 999:1000)
#' Labels<-label_maker(string="string", level = level, digits=4)
#' Labels
#'
#' \dontrun{
#' ## function using user prompt does not use any of the other parameters
#' Labels<-label_maker(user=T)
#' Labels
#' }



label_maker<-function(user=F, string=NULL, level, digits=3){
  if (user==T) {
    ## asks for string
    string <- readline(paste0("Please enter string for level: "))
    ## first value of level
    startNum <- as.numeric(readline(paste0("Enter the starting number for level: ")))
    while(is.na(startNum) == T) {
      print("Invalid input. Please enter an integer.")
      startNum <- as.numeric(readline(paste0("Enter the starting number for level: ")))
    }
    ## ending value of level
    endNum <- as.numeric(readline(paste0("Enter the ending number for level: ")))
    while(is.na(endNum) == T){
      print("Invalid input. Please enter an integer.")
      endNum <- as.numeric(readline(paste0("Enter the ending number for level: ")))
    }
    ## finds greatest value
    maxNum <- max(startNum,endNum)
    ## checks what is number of digits in max value
    digitsMax <- nchar(paste(maxNum))
    ## asks for how many digits to print
    digits <- as.numeric(readline(paste0("Number of digits to print for level: ")))
    # check input
    while(is.na(as.numeric(digits))==T){
      print("Invalid input. Please only enter an integer.")
      digits <- as.numeric(readline(paste0("Number of digits to print: ")))
    }
    ## if the number to digits to print is less than the digits in max value, try again
    while (digits<digitsMax){
      print(paste0("Please enter a number larger or equal to ", nchar(paste(maxNum))))
      digits <- as.numeric(readline(paste0("Number of digits to print for level: ")))
    }
    level <-c(startNum:endNum)
  }
  if (is.numeric(level)==F) stop("level is not a string of numbers")
  if (is.numeric(digits)==F) stop("Digits is not a numerical value")
  if (digitsMax > digits){
    warning("Digits specified less than max number. Increasing number of digits.")
  }
  digitsMax <- max(digits,nchar(paste(maxNum)))
  line<-paste0(string,"%0",digits,"d")
  Labels<-sprintf(line,rep(level))
  ind_string<-rep(string, length(rep(level)))
  numbers<-rep(level)
  return(data.frame(Labels, ind_string, level))

}



