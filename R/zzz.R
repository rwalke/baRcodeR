.onAttach <- function(libname, pkgname){
  options(baRcodeR.connection = stdin())
}


numeric_input <- function(prompt_string, attempts_allowed = 3, integer = TRUE){
  attempt <- 1
  repeat {
    cat(prompt_string)
    startNum <- suppressWarnings(abs(as.numeric(readLines(con = getOption("baRcodeR.connection"), n = 1))))
    if(integer){
      startNum <- as.integer(startNum)
    }
    attempt <- attempt + 1
    # exit if input is number
    if (!is.na(startNum)) {
      break
    }
    # exit if too many attempts
    if(attempt > attempts_allowed){
      stop("Invalid input. Please try again.")
    } else {
      cat("Invalid input. Please enter an integer.")
    }
  }
  ifelse(!is.na(startNum), return(startNum))
  
}


string_input <- function(prompt_string){
  cat(prompt_string)
  return(readLines(con = getOption("baRcodeR.connection"), n = 1))
}
