-- Inspect columns and rows --
SELECT *
FROM home_insurance;

-- Setup columns to format dates --
ALTER TABLE home_insurance 
ADD COLUMN QUOTE_DATE_FORMAT DATE,
ADD COLUMN COVER_START_FORMAT DATE,
ADD COLUMN P1_DOB_FORMAT DATE,
ADD COLUMN MTA_DATE_FORMAT DATE
;

-- Update new column with formatted quote date --
SET SQL_SAFE_UPDATES = 0;

UPDATE home_insurance
SET QUOTE_DATE_FORMAT = 
str_to_date (QUOTE_DATE, '%d/%m/%Y')
WHERE QUOTE_DATE <> '' AND QUOTE_DATE IS NOT NULL;

UPDATE home_insurance
SET COVER_START_FORMAT =
str_to_date (COVER_START, '%d/%m/%Y')
WHERE COVER_START <> '' AND COVER_START IS NOT NULL;

UPDATE home_insurance
SET P1_DOB_FORMAT =
str_to_date(P1_DOB, '%d/%m/%Y')
WHERE P1_DOB <> '' AND P1_DOB IS NOT NULL;

UPDATE home_insurance
SET MTA_DATE_FORMAT =
str_to_date(MTA_DATE, '%d/%m/%Y')
WHERE MTA_DATE <> '' AND MTA_DATE IS NOT NULL;

-- Check table --
SELECT *
FROM home_insurance;

-- DROP OLD COLUMN --
ALTER TABLE home_insurance 
DROP COLUMN QUOTE_DATE_FORMAT,
DROP COLUMN MTA_DATE,
DROP COLUMN P1_DOB,
DROP COLUMN COVER_START;

-- RENAME NEW COLUMNS AS OLD COLUMNS --
ALTER TABLE home_insurance 
CHANGE COLUMN P1_DOB_FORMAT P1_DOB DATE,
CHANGE COLUMN COVER_START_FORMAT COVER_START DATE,
CHANGE COLUMN MTA_DATE_FORMAT MTA_FORMAT DATE;

ALTER TABLE home_insurance
CHANGE COLUMN MTA_FORMAT MTA_DATE DATE;

-- CHECK TABLE --
SELECT*
FROM home_insurance;

CREATE TABLE home_insurance_cleaned AS
SELECT
  QUOTE_DATE AS `Quote Date`,
  COVER_START AS `Cover Start Date`,
  CLAIM3YEARS AS `Had Claims Last 3 Years`,
  P1_EMP_STATUS AS `Employment Status`,
  P1_PT_EMP_STATUS AS `Part-Time Employment Status`,
  BUS_USE AS `Business Use`,
  CLERICAL AS `Clerical Work`,
  AD_BUILDINGS AS `Add-On Buildings`,
  RISK_RATED_AREA_B AS `Risk Area - Buildings`,
  SUM_INSURED_BUILDINGS AS `Sum Insured Buildings`,
  NCD_GRANTED_YEARS_B AS `NCD Years (Buildings)`,
  AD_CONTENTS AS `Add-On Contents`,
  RISK_RATED_AREA_C AS `Risk Area - Contents`,
  SUM_INSURED_CONTENTS AS `Sum Insured Contents`,
  NCD_GRANTED_YEARS_C AS `NCD Years (Contents)`,
  CONTENTS_COVER AS `Contents Cover`,
  BUILDINGS_COVER AS `Buildings Cover`,
  SPEC_SUM_INSURED AS `Specified Items Sum`,
  SPEC_ITEM_PREM AS `Specified Item Premium`,
  UNSPEC_HRP_PREM AS `Unspecified HRP Premium`,
  P1_DOB AS `Customer DOB`,
  P1_MAR_STATUS AS `Marital Status`,
  P1_POLICY_REFUSED AS `Policy Refused Before`,
  P1_SEX AS `Sex`,
  BEDROOMS AS `Bedrooms`,
  ROOF_CONSTRUCTION AS `Roof Construction`,
  WALL_CONSTRUCTION AS `Wall Construction`,
  FLOODING AS `Flood Risk`,
  LISTED AS `Listed Property`,
  MAX_DAYS_UNOCC AS `Max Days Unoccupied`,
  NEIGH_WATCH AS `Neighborhood Watch`,
  OCC_STATUS AS `Occupancy Status`,
  OWNERSHIP_TYPE AS `Ownership Type`,
  PROP_TYPE AS `Property Type`,
  SAFE_INSTALLED AS `Safe Installed`,
  SUBSIDENCE AS `Subsidence`,
  YEARBUILT AS `Year Built`,
  PAYMENT_METHOD AS `Payment Method`,
  PAYMENT_FREQUENCY AS `Payment Frequency`,
  MTA_DATE AS `MTA Date`,
  MTA_FLAG AS `MTA Flag`,
  MTA_FAP AS `MTA FAP`,
  MTA_APRP AS `MTA APRP`,
  LAST_ANN_PREM_GROSS AS `Annual Premium`,
  POL_STATUS AS `Policy Status`
FROM home_insurance;

SELECT *
FROM home_insurance_cleaned;

-- Drop columns with significant missing values --

ALTER TABLE home_insurance_cleaned
DROP COLUMN `Payment Frequency`;

ALTER TABLE home_insurance_cleaned
DROP COLUMN `Clerical Work`;

ALTER TABLE home_insurance_cleaned
DROP COLUMN `Part-Time Employment Status`;

SELECT *
FROM home_insurance_cleaned;

-- Attempt to relabel columns to meaningful values --
UPDATE home_insurance_cleaned
SET `Employment Status` = CASE
    WHEN LOWER(`Employment Status`) = 'e' THEN 'Employed'
    WHEN LOWER(`Employment Status`) = 'r' THEN 'Retired'
    WHEN LOWER(`Employment Status`) = 's' THEN 'Self-Employed'
    WHEN LOWER(`Employment Status`) = 'h' THEN 'Homemaker'
    WHEN LOWER(`Employment Status`) = 'n' THEN 'Not Working'
    WHEN LOWER(`Employment Status`) = 'u' THEN 'Unknown'
    ELSE 'Other'
END;

SELECT*
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Marital Status` = CASE
    WHEN LOWER(`Marital Status`) = 's' THEN 'Single'
    WHEN LOWER(`Marital Status`) = 'm' THEN 'Married'
    WHEN LOWER(`Marital Status`) = 'o' THEN 'Other'
    WHEN LOWER(`Marital Status`) = 'w' THEN 'Widowed'
    WHEN LOWER(`Marital Status`) = 'd' THEN 'Divorced'
    WHEN LOWER(`Marital Status`) = 'p' THEN 'Separated'
    WHEN LOWER(`Marital Status`) = 'a' THEN 'Unknown'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Payment Method` = CASE
    WHEN UPPER(`Payment Method`) = 'PUREDD' THEN 'Direct Debit - Full'
    WHEN UPPER(`Payment Method`) = 'DD-OTHER' THEN 'Direct Debit - Other'
    WHEN UPPER(`Payment Method`) = 'NONDD' THEN 'Non–Direct Debit'
    ELSE 'Unknown'
END;

SELECT * 
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Had Claims Last 3 Years` = CASE 
    WHEN `Had Claims Last 3 Years` = 'Y' THEN 'Yes'
    WHEN `Had Claims Last 3 Years` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Business Use` = CASE 
    WHEN `Business Use` = 'Y' THEN 'Yes'
    WHEN `Business Use` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Add-On Buildings` = CASE 
    WHEN `Add-On Buildings` = 'Y' THEN 'Yes'
    WHEN `Add-On Buildings` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Add-On Contents` = CASE 
    WHEN `Add-On Contents` = 'Y' THEN 'Yes'
    WHEN `Add-On Contents` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Contents Cover` = CASE 
    WHEN `Contents Cover` = 'Y' THEN 'Yes'
    WHEN `Contents Cover` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Buildings Cover` = CASE 
    WHEN `Buildings Cover` = 'Y' THEN 'Yes'
    WHEN `Buildings Cover` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Policy Refused Before` = CASE 
    WHEN `Policy Refused Before` = 'Y' THEN 'Yes'
    WHEN `Policy Refused Before` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT * 
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Sex` = CASE 
    WHEN `Sex` = 'M' THEN 'Male'
    WHEN `Sex` = 'F' THEN 'Female'
    ELSE 'Unknown'
END;

SELECT * 
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Flood Risk` = CASE 
    WHEN `Flood Risk` = 'Y' THEN 'Yes'
    WHEN `Flood Risk` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Neighborhood Watch` = CASE 
    WHEN `Neighborhood Watch` = 'Y' THEN 'Yes'
    WHEN `Neighborhood Watch` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Safe Installed` = CASE 
    WHEN `Safe Installed` = 'Y' THEN 'Yes'
    WHEN `Safe Installed` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `Subsidence` = CASE 
    WHEN `Subsidence` = 'Y' THEN 'Yes'
    WHEN `Subsidence` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

UPDATE home_insurance_cleaned
SET `MTA Flag` = CASE 
    WHEN `MTA Flag` = 'Y' THEN 'Yes'
    WHEN `MTA Flag` = 'N' THEN 'No'
    ELSE 'Unknown'
END;

SELECT *
FROM home_insurance_cleaned;

-- Add customer age using newest date from Quote Date column --

SELECT MAX(`Quote Date`) AS Latest_Quote_Date
FROM home_insurance_cleaned;

-- Last quote was 2011-12-15 --
-- Add age column --
ALTER TABLE home_insurance_cleaned
ADD COLUMN `Customer Age` INT;

-- Calculate age based on last quote date of 2011-12-15 --
UPDATE home_insurance_cleaned
SET `Customer Age` = TIMESTAMPDIFF(YEAR, `Customer DOB`, '2011-12-15')
WHERE `Customer DOB` IS NOT NULL;

SELECT *
FROM home_insurance_cleaned;


