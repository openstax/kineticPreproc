#' generate_survey_metadata_readme
#'
#' Extracts questions and metadata tags from Qualtrics survey and creates a scrollable table
#' for friendly viewing for embedding in the survey README files.
#'
#' @param qualtrics_df
#' A Qualtrics dataframe
#'
#' @param width
#' Width of the scrollable box, can be in px unit
#'
#' @param height
#' Height of the scrollable box, can be in px unit
#'
#' @param remove_cols_str
#' String pattern of column names to remove
#'
#' @return
#' html for scrollable table
#' @export
#'
#' @examples generate_survey_metadata_readme
generate_survey_metadata_readme <- function(qualtrics_df, width = "720px", height = "480px",
                                            remove_cols_str = "Name|DistributionChannel|Email|ExternalReference|IPAddress"){
    # Extract questions
    questions <- extract_colmap(qualtrics_df)
    # Add data type for each column
    data_type <- qualtrics_df %>%
        summarise(across(.cols = everything(), .fns = class))

    data_type_transposed <- as_tibble(cbind(qname = names(data_type), t(data_type)))

    questions_with_dtype <- questions %>%
        left_join(data_type_transposed, by = "qname")

    questions_with_dtype %>%
        filter(!grepl(remove_cols_str, qname)) %>%
        knitr::kable() %>%
        kable_styling() %>%
        scroll_box(width = width, height = height, fixed_thead = TRUE)

}
