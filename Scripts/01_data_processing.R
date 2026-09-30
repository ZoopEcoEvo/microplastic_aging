# Data processing ---------------------------------------------------------
# Reads raw data from Raw_data/, cleans it, and writes processed files to
# Output/Output_data/. Load every package this script needs here; it runs in
# its own environment when called from 00_controller.R.

library(here)
library(tidyverse)
library(readxl)

# Read in raw data --------------------------------------------------------
# raw_data <- read_excel(here("Raw_data", "data.xlsx"))

# Clean and process -------------------------------------------------------

# Write processed data ----------------------------------------------------
# write_csv(processed_data, here("Output", "Output_data", "processed_data.csv"))
