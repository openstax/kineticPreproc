#' connect_to_qualtrics
#'
#' @param qualtrics_credential
#' Add path to qualtrics credential file
#' @param base_url
#' YOUR-QUALTRICS_BASE_URL - yourorganizationid.yourdatacenterid.qualtrics.com
#' @param install
#'
#' @return access to qualtrics API
#' @export
#'
#' @examples connect_to_qualtrics(qualtrics_credential = "../qualtrics_cred.txt",
#'                                 base_url = "riceuniversity.iad1.qualtrics.com",
#'                                 install = FALSE)
connect_to_qualtrics <- function(qualtrics_credential,
                                 base_url = "riceuniversity.iad1.qualtrics.com",
                                 install = FALSE){
    require("qualtRics")
    qualtrics_cred <- read_qualtrics_cred(path_to_cred = qualtrics_credential)
    qualtrics_api_credentials(api_key = qualtrics_cred,
                              base_url = base_url, #<YOUR-QUALTRICS_BASE_URL>; yourorganizationid.yourdatacenterid.qualtrics.com
                              install = install)

}
