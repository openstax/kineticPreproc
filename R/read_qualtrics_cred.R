#' read_qualtrics_cred
#' @description
#' This function reads in your qualtrics credential from the appropriate path.
#' The qualtrics credential is your Qualtrics API key that you can get from your Qualtrics account by generating key.
#' It is an alphanumeric string.
#' The credentials must be saved as a simple `.txt` files. Press enter at the end of the credential in the textfile to create a newline.
#'
#' @param path_to_cred
#' qualtrics credential file name with path
#'
#'
#' @return
#' Qualtrics credential
#'
#' @export
#'
#' @examples
#' read_qualtrics_cred(path_to_cred = "../Qualtrics/credentials/qualtrics_cred.txt")
#'
read_qualtrics_cred <- function(path_to_cred){
    qualtrics_cred <- readLines(path_to_cred)
    return(qualtrics_cred)
}
