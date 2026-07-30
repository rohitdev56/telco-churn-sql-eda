# Telco Customer Churn — SQL Exploratory Data Analysis

## Overview
End-to-end SQL EDA on the Telco Customer Churn dataset (7,043 customers), 
including data cleaning, quality checks, and churn-driver analysis.

## Key Findings
- Contract type is the strongest churn predictor: Month-to-month customers 
  churn at 42.7% vs. 2.8% for two-year contracts (~15x difference)
- Payment method matters: Electronic check users churn at 45.3% vs. ~15-17% 
  for automatic payment methods
- Tenure and churn are inversely related: New customers (0-12mo) churn at 
  47.4% vs. 6.6% for customers with 60+ months tenure
- Add-on services reduce churn: Among internet customers, churn drops from 
  52.2% (0 add-ons) to 5.3% (6 add-ons)
- Ruled out: gender and MultipleLines show no meaningful churn difference

## Data Quality Issues Found & Fixed
- 11 rows with blank `TotalCharges` (all tenure=0 customers) — resolved with NULLIF
- Hidden `\r` (carriage return) characters across all text columns from 
  Windows-style line endings, silently breaking string comparisons — 
  diagnosed via HEX()/LENGTH() and fixed with REPLACE()

## Tools Used
MySQL, MySQL Workbench

## Files
- `sql/01_table_creation.sql` — schema
- `sql/02_data_cleaning.sql` — NULL handling, carriage return fix
- `sql/03_eda_queries.sql` — churn rate analysis across all dimensions
