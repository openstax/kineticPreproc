#' preprocess_qualtrics_df
#'
#' @description Read in desired Qualtrics dataframe from the environment and preprocess data
#' to remove minors, non-consents, identifying information, previews, test accounts,
#' incomplete responses, and uninformative columns.
#'
#' @param qualtrics_df_name substitute this with the qualtrics dataframe name that you want to analyze
#'
#' @return Opens the dataframe viewer and returns a clean dataframe without the above fields and cases.
#' @export
#'
#' @examples preprocess_qualtrics_df("./Kinetic_data.csv")
preprocess_qualtrics_df <- function(qualtrics_df){
    qualtrics_df_clean <- qualtrics_df %>%
        mutate(date_recorded = as.Date(RecordedDate)) %>%
        exclude_progress() %>%
        exclude_preview() %>%
        exclude_duplicates(id_col = "research_id", dupl_location = FALSE) %>%
        deidentify() %>%
        select(-matches('Name|DistributionChannel|Email|ExternalReference')) %>%
        filter(is_testing == FALSE) %>%
        filter(consent == TRUE)
    # To deal with different kinds of age responses
   if(sum(grepl("18 or Older", qualtrics_df_clean$age)) > 0){
       qualtrics_df_clean <- qualtrics_df_clean  %>%
           filter(age == "18 or Older")
       print(unique(qualtrics_df_clean$age))
   } else {
       qualtrics_df_clean <- qualtrics_df_clean %>%
           mutate(age = 2022 - as.numeric(year),
                  age = ifelse(between(age, 10, 80), age, NA)) %>%
           filter(age > 17)
       print(unique(qualtrics_df_clean$age))
   }

    # glimpse(qualtrics_df_clean)

    return(qualtrics_df_clean)
}
