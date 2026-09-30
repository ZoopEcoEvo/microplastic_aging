# Project controller ------------------------------------------------------
# Run the whole workflow from here. Each step runs in its own clean
# environment, so every script and document must load its own packages and
# read its own input files. That keeps each piece reproducible on its own.
#
# Paths are built with here::here(), which finds the project root from the
# .Rproj file (or the .git folder), so this works regardless of the current
# working directory.

library(here)
library(rmarkdown)

# Choose which steps to run -----------------------------------------------
process_data    <- FALSE # Raw_data/ -> Output/Output_data/
make_report     <- FALSE # Output/Reports/report.Rmd -> figures + report
knit_manuscript <- FALSE # Manuscript/manuscript_name.Rmd -> Output/Drafts/

# Step 1: Process the raw data ---------------------------------------------
if (process_data) {
  source(here("Scripts", "01_data_processing.R"), local = new.env())
}

# Step 2: Render the project report ----------------------------------------
if (make_report) {
  render(input = here("Output", "Reports", "report.Rmd"),
         output_format = "all",
         envir = new.env())
}

# Step 3: Render the manuscript --------------------------------------------
if (knit_manuscript) {
  render(input = here("Manuscript", "manuscript_name.Rmd"),
         # Drafts are named by date. Files starting with "dev_" are ignored by
         # git; remove the prefix if you want a draft committed to the repo.
         output_file = paste0("dev_draft_", Sys.Date()),
         output_dir = here("Output", "Drafts"),
         output_format = "all",
         envir = new.env(),
         clean = TRUE)
}

# Record the software environment ------------------------------------------
# Written on every run so the README never needs a hand-copied sessionInfo().
# If the project uses renv, renv.lock is the authoritative record instead.
writeLines(capture.output(sessionInfo()),
           here("Output", "session_info.txt"))
