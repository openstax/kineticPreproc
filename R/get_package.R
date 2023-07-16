#' get_package
#'
#' @description This function checks whether a package is installed or not, if not installed, then installs the package and makes it available for the analysis. It will not install the package if it is already installed, then it will just make the package available readily.
#' @param package
#' A package name string
#'
#' @return access to package
#' @export
#'
#' @examples get_package(package_name)
#'
get_package<- function(package){
    if (!package %in% installed.packages()){
        install.packages(package, repos = "http://cran.rstudio.com/")
    }
    invisible(library(package, character.only = TRUE))
}
