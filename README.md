# Synthea Health Dataset Dashboard

## Overview
A simple project to mine data from simluated electronic health records and real-world data (RWD) using Synthea Health tools. Data will subsequently be used to generate Dashboards using RShiny and Plotly's Dash library.

More information on the Synthea Patient Generator tool can be found here: https://github.com/synthetichealth/synthea

## Structure
\-bin
    \-synthea-with-dependencies.jar
\-output
    \-fhir
        \-simluated_fhir_record_1.json
        \-simulated_fhir_record_2.json
        \- ...
        \- ...
\-README.md
\-synthea_setup.sh
\-synthea_configuration.txt
\-01_data_mining.ipynb

## Current Work
- **Data Mining** [01_data_mining](01_data_mining.ipynb)
