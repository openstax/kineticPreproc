#' get_survey_data
#'
#' @param selected_kinetic_survey_kwd
#'
#' @return
#' Dataframe with metadata for all Kinetic Qualtrics surveys passed to the global environment as `kinetic_surveys`
#' Returns primarily dataframe for the desired survey from the Qualtrics API.
#' @export
#'
#' @examples
#' get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Demographic")
get_survey_data <- function(selected_kinetic_survey_kwd = "Kinetic-Demographic"){
    # Get all surveys
    surveys <- all_surveys()

    # Get Kinetic surveys
    kinetic_surveys <<- surveys %>%
        filter(grepl("Kinetic", name))

    # Select a survey
    survey_id <- kinetic_surveys %>%
        filter(grepl(selected_kinetic_survey_kwd, name)) %>%
        select(id) %>%
        unlist(use.names = FALSE)

    print(paste("The survey ID for", selected_kinetic_survey_kwd, "is", survey_id,
                ". Please save this as a variable."))

    # Get survey data
    survey_data <- fetch_survey(surveyID = survey_id, verbose = FALSE) %>%
        mutate(survey_id = survey_id)

    # setClass("Qualtrics_info",
    #          representation = (surveys = "dataframe", survey_id = "character", survey_data = "dataframe"))
    return(survey_data)
}
