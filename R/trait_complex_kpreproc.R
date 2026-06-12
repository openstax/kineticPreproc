
library(devtools)
pak::pak("openstax/kineticPreproc")

library(kineticPreproc)

make_packages_available(packages_needed = c("qualtRics", "tidyverse", "excluder", "kableExtra", "janitor"))

qualtrics_cred_file <- "~/Documents/GitHub/research-kinetic-pipeline/qualtrics_cred.txt"

connect_to_qualtrics(qualtrics_credential = qualtrics_cred_file)


# Look at a single survey -------------------------------------------------

sci_knowledge <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Science Knowledge Survey")

# Create a metadata for the file
generate_survey_metadata_readme(sci_knowledge)

# The preprocess script has bugs and I will fix later
# For now, do your own preproc and share with me and I can integrate that into
# a generalizable workflow
# sci_k_clean <- sci_knowledge |>
#     preprocess_qualtrics_df()


goal_orientation <-  get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Goal Orientation (Survey)")


# Look at the full dataset
trait_complex_surveys$`Kinetic-Goal Orientation (Survey` |> glimpse()

# demographics
demographics <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Demographic")

# Loop through all the trait complex relevant surveys ---------------------


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

# Loop through the different surveys
trait_complex_surveys <- lapply(kinetic_study_names, function(study){
    get_survey_data(selected_kinetic_survey_kwd = study)
})
# Add the names of each survey based on the list of relevant surveys
names(trait_complex_surveys) <- kinetic_study_names


trait_surveys_cleaned <- lapply(trait_complex_surveys, function(survey){
    preprocess_qualtrics_df(survey)
})







