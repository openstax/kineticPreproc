% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_survey_questions.R
\name{get_survey_questions}
\alias{get_survey_questions}
\title{get_survey_questions}
\usage{
get_survey_questions(qualtrics_df, survey_id, file_location = "./")
}
\arguments{
\item{qualtrics_df}{A Qualtrics dataframe}

\item{survey_id}{Alphanumeric string which is the ID for the survey derived from Qualtrics.
The Demographic survey ID is \code{SV_6xGQzj4OBJnxGuy}}

\item{file_location}{Folder location where the survey questions should be saved.}
}
\value{
dataframe with questions and metadata
}
\description{
get_survey_questions
}
\examples{
get_survey_questions(qualtrics_df, survey_id = "SV_0k6tEFgW2o4rmIu", file_location = "./")

}
