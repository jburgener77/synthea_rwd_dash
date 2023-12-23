#!/bin/bash

# Script used to generate example dataset from Synthea. Details at https://github.com/synthetichealth/synthea/wiki/Basic-Setup-and-Running
# Requires Java 11 or newer

java -jar bin/synthea-with-dependencies.jar -s 4121 -p 500 California
