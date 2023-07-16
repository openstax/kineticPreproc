#' get_survey_questions
#'
#' @param qualtrics_df
#' A Qualtrics dataframe
#'
#' @param survey_id
#' Alphanumeric string which is the ID for the survey derived from Qualtrics.
#' The Demographic survey ID is `SV_6xGQzj4OBJnxGuy`
#'
#' @param file_location
#' Folder location where the survey questions should be saved.
#'
#'
#' @return
#'
#' dataframe with questions and metadata
#'
#' @export `csv` file with question metadata
#'
#' @examples
#' get_survey_questions(qualtrics_df, survey_id = "SV_0k6tEFgW2o4rmIu", file_location = "./")
#'

get_survey_questions <- function(qualtrics_df, survey_id,
                                 file_location = "./"){
    # Extract questions
    questions <- extract_colmap(qualtrics_df)

    question_csv_fname <- paste0(file_location, survey_id,
                                "_questions_", Sys.Date(), ".csv")
    # Export questions as a csv
    questions %>%
        write_csv(question_csv_fname)
    return(questions)
}

