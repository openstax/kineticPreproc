# kineticPreproc

TLDR; Qualtrics data preprocessor for Kinetic

This package helps pull data from Kinetic by connecting to the Qualtrics API, and preprocesses the data to remove test data, incompletes, minor respondents, etc.
It includes the following functions visible to the end user that supports all the required processes:

`make_packages_available(packages_needed = c("qualtRics", "tidyverse"))`

`qualtrics_cred_file <- "~/Documents/GitHub/research-kinetic-pipeline/qualtrics_cred.txt"`

`connect_to_qualtrics(qualtrics_credential = qualtrics_cred_file)`

`demographics <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Demographic")`

`demographics_clean <- preprocess_demographics_df(demographics)`
