# Telecom Customer Churn Analysis

## Business Problem
A telecom company wants to understand why customers are leaving, identify high-risk customer segments, and recommend retention strategies.

## Dataset
- Rows: 7,043
- Columns: 21
- Target: `Churn`
- Source file: `data/raw/Telco-Customer-Churn.csv`

## Tools
Excel • MySQL • Power BI • Python • Scikit-learn

## Project Workflow
1. Data Understanding & Cleaning
2. SQL Business Analysis
3. Power BI Dashboard
4. Python EDA
5. Customer Risk Segmentation
6. Optional Machine Learning Churn Prediction
7. Business Recommendations
8. Final Report

## Key Business Questions
- What is the overall churn rate?
- Which contract type has the highest churn?
- Which customer segments are high risk?
- How do tenure and monthly charges relate to churn?
- Which services/payment methods are associated with higher churn?
- Which customers should the retention team prioritize?

## Folder Structure
```text
data/
  raw/
  cleaned/
sql/
python/
powerbi/
excel/
report/
screenshots/
docs/
```

## Current Dataset Checks
- 7,043 customers
- 21 columns
- 0 duplicate rows
- 0 duplicate customer IDs
- 11 blank `TotalCharges` values that need cleaning
