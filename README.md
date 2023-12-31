# Synthea Health Dataset Dashboard

## Overview
A simple project to mine data from simluated electronic health records and real-world data (RWD) using Synthea Health tools. Data will subsequently be used to generate Dashboards using RShiny and Plotly's Dash library.

More information on the Synthea Patient Generator tool can be found here: https://github.com/synthetichealth/synthea

## Data Generation
Simulated electronic health records were generated for individuals within California by:

```
sh synthea_setup.sh
```

Relevant information from simulated electronic health records were summarized based on patient, claims, medications, observations, conditions, and procedure information and saved as CSV files within the `csv` directory.

## Structure
```
-bin
  |-synthea-with-dependencies.jar
-output
  |-fhir
    |-simluated_fhir_record_1.json
    |-simulated_fhir_record_2.json
    |- ...
    |- ...
  |-csv
    |-claims.csv
    |-conditions.csv
    |- ...
    |- ...
-csv
  |-claims_data.csv
  |-conditions_data.csv
  |-medications_data.csv
  |-observations_data.csv
  |-patient_data.csv
  |-procedures_data.csv
-data_cleaned
  |-claims_cleaned.csv
  |- ...
  |- ...
-README.md
-synthea_setup.sh
-synthea_configuration.txt
-01_data_mining.ipynb
-02_data_cleaning.ipynb
```

## Current Work
- **Data Mining** [01_data_mining](01_data_mining.ipynb)
- **Data Cleaning** [02_data_cleaning](02_data_cleaning.ipynb)
