# .onAttach <- function(libname, pkgname){
#   options(baRcodeR.connection = stdin())
# }


numeric_input <- function(prompt_string, attempts_allowed = 3, integer = T){
  attempt <- 1
  repeat {
    
    startNum <- suppressWarnings(abs(as.numeric(readline(prompt_string))))
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

