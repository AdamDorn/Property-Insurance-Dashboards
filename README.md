# Property Insurance Data Analysis & Dashboard

This project showcases a full-cycle data analytics workflow using a real-world home insurance dataset. It includes data cleaning using Python, interactive data exploration in Power BI, and advanced visuals using Seaborn and Matplotlib.

---

# Project Files

- `data/cleaned_home_insurance.csv` – Cleaned dataset used for analysis  
- `data/property_insurance_data_cleaning.json` – Mapping logic used during preprocessing  
- `insurance_dashboard.pbix` – Power BI dashboard file  
- `notebooks/advanced_visuals.py` – Python script for advanced Seaborn visuals  
- `visuals/` – Screenshots of the dashboard

---

## SQL Data Cleaning and Transformation for Home Insurance Dataset Overview

This SQL script performs data cleaning, date formatting, relabeling categorical variables, and feature engineering on the home_insurance dataset. The goal is to prepare a clean, user-friendly, and analysis-ready table named home_insurance_cleaned for use in Power BI or other BI tools.

Step-by-Step Breakdown
1. Initial Inspection
SELECT * FROM home_insurance;

View the raw data and identify columns needing cleaning or transformation.

2. Date Columns Formatting
Added new date columns (QUOTE_DATE_FORMAT, COVER_START_FORMAT, P1_DOB_FORMAT, MTA_DATE_FORMAT) as DATE type.

Converted string dates (in dd/mm/yyyy format) to SQL DATE using STR_TO_DATE().

Dropped the old string date columns.

Renamed the new formatted date columns to original names for consistency.

3. Create Cleaned Table
Created a new table home_insurance_cleaned selecting relevant columns.

Renamed columns with descriptive, user-friendly names for reporting.

4. Drop Columns with High Missing Values
Dropped Payment Frequency, Clerical Work, and Part-Time Employment Status due to many missing values.

5. Categorical Variable Relabeling
Updated short or coded values to meaningful labels for columns such as:

Employment Status (E, R, S, etc. → 'Employed', 'Retired', 'Self-Employed', etc.)

Marital Status (S, M, O, etc. → 'Single', 'Married', 'Other', etc.)

Payment Method (PUREDD, NONDD, DD-OTHER → descriptive text)

Binary flags (columns with 'Y'/'N') converted to 'Yes'/'No' for readability.

Gender codes 'M'/'F' converted to 'Male'/'Female'.

6. Feature Engineering: Customer Age
Identified the latest quote date (2011-12-15) in the dataset to maintain historical relevance.

Added a new column Customer Age.

Calculated age based on Customer DOB and latest quote date using TIMESTAMPDIFF().

Result
The final table, home_insurance_cleaned, contains clean, well-labeled, and formatted data ready for analysis or dashboard reporting in Power BI.

Notes
Dates are stored as SQL DATE type for consistency.

Binary columns are converted to descriptive Yes/No labels.

Columns with excessive missing data were removed to improve data quality.

Age calculation is anchored to the dataset's most recent quote date for accuracy in historical context.

How to Use
Run the entire script sequentially to transform raw data into the cleaned dataset.

Export home_insurance_cleaned as CSV for Power BI or other tools.

Use clean and descriptive columns for easy visualization and analysis.

---

## Power BI Dashboard Overview

The Power BI report contains **five pages**, each targeting key insurance business insights.

### Page 1: Overview
- **Cards**: Total customers, average premium, number of policies
- **Visuals**: 
  - Age distribution histogram
  - Pie chart of policy status
  - Bar chart of customer age by gender

### Page 2: Payment Behavior
- **Visuals**:
  - Payment method distribution
  - Payment method vs. premium box plot

### Page 3: Policy and Product Features
- **Visuals**:
  - Sum insured (building and contents) vs. premium
  - Cards showing average building and content coverage

### Page 4: Security Features
- **Visuals**:
  - Approved locks and alarms vs. premium
  - Max days unoccupied vs. premium
  - Card for % of customers with approved security

### Page 5: Business Impact (Python Analysis)
- **Boxplots using Seaborn**:
  - Ownership Type vs. Annual Premium
  - Marital Status vs. Annual Premium
  - Employment Status vs. Annual Premium
---

## Tools Used

- **Power BI** – For building the interactive dashboard
- **Python** (pandas, seaborn, matplotlib) – For cleaning and advanced visualization
- **GitHub** – Version control and project sharing

---

## About the Dataset

The dataset includes 1.2 million records and over 60 features from a home insurance company. Columns cover customer demographics, policy data, property details, and premium pricing.

---

## Use Case

This project was built to showcase job-ready data analysis and business intelligence skills for a **Data Analyst role** in the **insurance industry**, including:

- Data cleaning and transformation
- Exploratory Data Analysis (EDA)
- Key metrics reporting
- Business-oriented storytelling using visuals

---

## Author

**Adam Dorn**  
Aspiring Data Analyst/Data Scientist | Background: Food Science → Insurance Analytics  
Passion for business insights & data-driven decision-making  

---

## Data Source

This project uses the publicly available **[Home Insurance Dataset](https://www.kaggle.com/datasets/tejashvi14/home-insurance)** from Kaggle.  
The dataset is released under a **[CC0: Public Domain License](https://creativecommons.org/publicdomain/zero/1.0/)**, which allows unrestricted use and sharing. Attribution is appreciated but not required.

---

