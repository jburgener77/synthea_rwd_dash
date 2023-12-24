# Setup -----------------------------------------------------------------------

# Set CWD
setwd("R")

# Libraries
library(tidyverse)

# Load CSVs
csv_dir <- "../csv/"

## Patient Data
patient_df <- read.csv(paste0(csv_dir, "patient_data.csv"))
head(patient_df)

## Conditions Data
conditions_df <- read.csv(paste0(csv_dir, "conditions_data.csv"))
head(conditions_df)

## Procedures Data
procedures_df <- read.csv(paste0(csv_dir, "procedures_data.csv"))
head(procedures_df)

## Medications Data
medications_df <- read.csv(paste0(csv_dir, "medications_data.csv"))
head(medications_df)

## Observations Data
observations_df <- read.csv(paste0(csv_dir, "observations_data.csv"))
head(observations_df)

## Claims Data
claims_df <- read.csv(paste0(csv_dir, "claims_data.csv"))
head(claims_df)

# EDA -------------------------------------------------------------------------
