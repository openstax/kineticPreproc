
library(devtools)
pak::pak("openstax/kineticPreproc")

library(kineticPreproc)

make_packages_available(packages_needed = c("qualtRics", "tidyverse", "excluder"))

qualtrics_cred_file <- "~/Documents/GitHub/research-kinetic-pipeline/qualtrics_cred.txt"

kinetic_study_names <- c(
    "Kinetic-Goal Orientation (Survey)",
    "Kinetic-Mini Big 5 Personality (Survey)",
    "Kinetic-Academic Procrastination",
    "Kinetic-Self-efficacy for self-regulation",
    "Kinetic-Self-Efficacy (Survey)",
    "Kinetic-Mindset",
    "Kinetic-Optimism",
    "Kinetic-Anxiety (Survey)",
    "Kinetic-Belongingness",
    "Kinetic-Reading Span (Working Memory)",
    "Kinetic-Matrices (Ability Test)",
    "Kinetic-STEM Interest",
    "Kinetic-STEM Biodata",
    "Kinetic-Science Knowledge Survey"
)

connect_to_qualtrics(qualtrics_credential = qualtrics_cred_file)

demographics <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Demographic")
# gather all the active highlighting data
active_highlighting_bio_t1 <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Active highlighting - Biology")

generate_survey_metadata_readme()




# demographics_clean <- preprocess_demographics(demographics)
demographics_clean <- preprocess_qualtrics_df(demographics)

IDT <- get_survey_data(selected_kinetic_survey_kwd = "IDT")
IDT_clean <- preprocess_qualtrics_df(IDT)

# For all surveys
all_surveys <- lapply(71:nrow(kinetic_surveys), function(idx){
    survey_id <- kinetic_surveys$id[idx]

    print(paste("The survey ID for", kinetic_surveys$name[idx], "is", survey_id,
                ". Please save this as a variable."))
    survey_data <-  tryCatch({
        fetch_survey(surveyID = survey_id, verbose = FALSE) %>%
            mutate(survey_id = survey_id)

    }, error = function(err){
        message(paste("Survey does not seem to exist:", survey_id))
        message("Here's the original error message:")
        message(conditionMessage(err))
        # Choose a return value in case of error
        NULL
        })
    if(!is.null(survey_data)){
        survey_data <- survey_data %>%
            janitor::clean_names(case = "snake")
        # Extract questions
        # questions <- extract_colmap(survey_data)
        #
        # print(paste(c("This is row", idx)))
        # question_csv_fname <- paste0("~/Box Sync/Kinetic/survey_questions/", survey_id,
        #                              "_questions_", Sys.Date(), ".csv")

        # Export questions as a csv
        # questions %>%
        #     write_csv(question_csv_fname)

        survey_clean <- tryCatch({
            preprocess_qualtrics_df(survey_data)
        }, error = function(err_preproc){
            message(paste("Preproc failed:", survey_id, kinetic_surveys$name[idx]))
            message("Here's the original error message:")
            message(conditionMessage(err_preproc))
            # Choose a return value in case of error
            NULL
        })

    }

    return(survey_clean)
})


# User Persona ------------------------------------------------------------
persona <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-User Persona")

persona_clean <- preprocess_demographics(persona)



# devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
# devtools::test()
# devtools::check()
