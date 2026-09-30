# Starting a new project from this template

Delete this file once the project is set up.

1. On GitHub, create the project's repository from this template ("Use this template").
2. In RStudio, choose File > New Project > Version Control > Git and paste the new repository's URL. RStudio clones the repo and creates the project's `.Rproj` file. Commit the `.Rproj` file so everyone who clones the project shares the same settings.
3. Run `renv::init()` to start tracking package versions. Commit the resulting `renv.lock`, `renv/activate.R`, and `.Rprofile`. After installing new packages later, run `renv::snapshot()`.
4. Fill in the analysis plan in `Background/analysis_plan.qmd` before collecting data.
5. Rename `Manuscript/manuscript_name.Rmd` if you like, and update its path in `Scripts/00_controller.R`.
6. Update the README: title, authors, description, badges, data description, and funding.

Packages the template uses: here, rmarkdown, tidyverse, readxl, ggpubr, monochromeR, and a LaTeX installation for the PDF manuscript (e.g. `tinytex::install_tinytex()`).
