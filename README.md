# kineticPreproc

TLDR; Qualtrics data preprocessor for Kinetic

This package helps pull data from Kinetic by connecting to the Qualtrics API, and preprocesses the data to remove test data, incompletes, minor respondents, etc.
It includes the following functions visible to the end user that supports all the required processes:

## Install Packages

`make_packages_available(packages_needed = c("qualtRics", "tidyverse", "devtools))`

## To install kineticPreproc Package

`install_github(openstax/kineticPreproc)`

## Connecting to Qualtrics
`qualtrics_cred_file <- "~/Documents/GitHub/research-kinetic-pipeline/qualtrics_cred.txt"`

`connect_to_qualtrics(qualtrics_credential = qualtrics_cred_file)`


## Getting data
`demographics <- get_survey_data(selected_kinetic_survey_kwd = "Kinetic-Demographic")`

## Preprocessing data
`demographics_clean <- preprocess_demographics_df(demographics)`
