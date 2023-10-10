#' preprocess_demographics
#'
#' @description Read in desired Qualtrics dataframe from the environment and preprocess data
#' to remove minors, non-consents, identifying information, previews, test accounts,
#' incomplete responses, and uninformative columns.
#'
#' @param demographics_df substitute this with the qualtrics dataframe name that you want to analyze
#'
#' @return Opens the dataframe viewer and returns a clean dataframe without the above fields and cases.
#' @export
#'
#' @examples preprocess_demographics("./Kinetic_data.csv")
preprocess_demographics <- function(demographics_df){
    require(excluder)
    qualtrics_demographics_clean <- demographics_df %>%
        mutate(date_recorded = as.Date(RecordedDate),
               age = 2022 - as.numeric(year),
               age = ifelse(between(age, 10, 80), age, NA)) %>%
        exclude_progress() %>%
        exclude_preview() %>%
        exclude_duplicates(id_col = "research_id", dupl_location = FALSE) %>%
        deidentify() %>%
        select(-matches('Name|DistributionChannel|Email|ExternalReference')) %>%
        filter(is_testing == FALSE) %>%
        filter(age > 17)

    glimpse(qualtrics_demographics_clean)

    return(qualtrics_demographics_clean)
}
