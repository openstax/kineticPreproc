# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this package does

`kineticPreproc` is an R package that pulls OpenStax Kinetic study data from the Qualtrics API and preprocesses it: removing minor (<18) respondents, non-consenting respondents, identifying information (Name/Email/IPAddress/ExternalReference columns), spam, survey previews, test accounts, and incomplete responses. It is installed by researchers via `install_github("openstax/kineticPreproc")` and used inside the Kinetic Secure Enclaves.

## Development commands

Development happens in R (via RStudio, `kineticPreproc.Rproj`). The package uses **renv** — `.Rprofile` sources `renv/activate.R`, so run `renv::restore()` to set up dependencies.

```r
devtools::document()   # regenerate man/*.Rd and NAMESPACE from roxygen comments
devtools::test()       # run testthat tests (tests/testthat/)
devtools::check()      # full R CMD check
devtools::load_all()   # load package for interactive development
```

Run a single test file: `testthat::test_file("tests/testthat/test-hello.R")`.

From the shell: `Rscript -e 'devtools::test()'` etc.

Note: tests are currently a placeholder (`test-hello.R`); most functions hit the live Qualtrics API and have no offline tests.

## Architecture and data flow

The typical pipeline (see README.md and `R/trait_complex_kpreproc.R` for the canonical usage):

1. **Setup**: `make_packages_available()` (`R/make_packages_available.R`, uses `get_package.R`) installs/loads runtime deps: `qualtRics`, `tidyverse`, `excluder`, `janitor`, `kableExtra`.
2. **Auth**: `connect_to_qualtrics()` reads an API key from a local text file via `read_qualtrics_cred()` and registers it with `qualtRics::qualtrics_api_credentials()`. Default base URL is `riceuniversity.iad1.qualtrics.com`. The credential file lives outside the repo (e.g., `~/Documents/GitHub/research-kinetic-pipeline/qualtrics_cred.txt`) — never commit credentials.
3. **Fetch**: `get_survey_data(selected_kinetic_survey_kwd = "Kinetic-...")` lists all surveys, filters to names containing "Kinetic" (side effect: assigns `kinetic_surveys` to the global env with `<<-`), fetches the matching survey by exact name, and writes a `SV_*_questions_<date>.csv` question-map file to `file_location` (default `./` — this is why `SV_*.csv` files accumulate in the repo root; they are exports, not inputs).
4. **Preprocess**: `preprocess_qualtrics_df()` is the general cleaner (snake_cases columns via `janitor::clean_names()`, then filters). It handles two age formats: a categorical `age` column ("18 or Older") with a `consent` check, or a birth-`year` column converted to age (hardcoded against year 2022). `preprocess_demographics()` is an older variant that works on un-cleaned (PascalCase) column names.
5. **Metadata/docs**: `get_survey_questions()` and `generate_survey_metadata_readme()` extract the question column map (`qualtRics::extract_colmap()`) for survey README files; the latter renders a scrollable kableExtra HTML table.

`R/trait_complex_kpreproc.R` is not a package function — it's a working analysis script (top-level code, no function wrapper) that batch-fetches the trait-complex surveys (`kinetic_study_names` vector) and loops preprocessing over all Kinetic surveys. `devtools::check()` complaints about it are expected; don't convert it to roxygen-documented functions without asking.

## Conventions and gotchas

- Roxygen2 with markdown (`Roxygen: list(markdown = TRUE)`); `man/` is generated — edit roxygen comments in `R/`, not the `.Rd` files. NAMESPACE currently uses a blanket `exportPattern("^[[:alpha:]]+")` rather than roxygen-generated exports.
- Functions assume `tidyverse` is attached by the caller (`%>%`, `filter`, `mutate` are used without namespacing); runtime deps are loaded via `require()` inside functions rather than declared in DESCRIPTION `Imports`. Follow the existing style unless explicitly refactoring.
- Data privacy is the core concern: any change to the preprocessing functions must preserve removal of minors, non-consents, and PII columns (`Name|DistributionChannel|Email|ExternalReference|IPAddress`).
- The age-from-year calculation hardcodes `2022 - as.numeric(year)` in both preprocess functions — a known limitation to keep in mind when touching age logic.
