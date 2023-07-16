### For this analysis, here are some packages required
#' make_packages_available
#'
#' @description
#' Enter a vector of packages to first check whether they are already installed.
#' If installed, then make them available by a library call.
#' If not installed, install each one and then make them available.
#' Uses the `get_package` function to install each package.
#'
#' @param packages_needed
#' A character vector of package names
#'
#' @return
#' packages
#'
#' @export
#'
#' @examples
#' packages_needed <- c("tidyverse", "lubridate")
#' make_packages_available(packages_needed)
#'
make_packages_available <- function(packages_needed = c("tidyverse", "qualtRics",
                                                        "jsonlite","kableExtra","lubridate",
                                                        "patchwork", "janitor", "roxygen2")){
    invisible(sapply(packages_needed, get_package))
}

