-- TELCO CUSTOMER CHURN — DATA CLEANING
-- Run these after the initial LOAD DATA INFILE import and
-- before running any EDA queries

-- 1. FIX BLANK TotalCharges
-- 11 rows had a blank string (' ') instead of a real value in
-- TotalCharges, causing MySQL to silently import them as 0
-- during LOAD DATA INFILE (warning 1366: "Incorrect decimal
-- value"). All 11 rows have tenure = 0 — brand-new customers
-- who haven't been billed yet, so NULL is the correct value
-- here, not 0.

UPDATE telco_customers
SET TotalCharges = NULL
WHERE tenure = 0;


-- 2. STRIP HIDDEN CARRIAGE RETURNS (\r) FROM TEXT COLUMNS

-- Bug found: WHERE Churn = 'Yes' matched zero rows, even
-- though the column visibly contained "Yes" values in
-- MySQL Workbench.

-- Root cause: the source CSV used Windows-style line endings
-- (\r\n). LOAD DATA INFILE was told to split rows on \n only,
-- which left a trailing \r (hex 0D) stuck to the last column
-- of every row — invisible in the grid view, but enough to
-- break every exact string match (e.g. 'Yes' \r  != 'Yes').

-- Diagnosed with:
--   SELECT DISTINCT Churn, HEX(Churn), LENGTH(Churn)
--   FROM telco_customers;
--   -> hex ended in ...0D on every row and length was always 
--   1 more than actual length

-- TRIM(TRAILING '\r' FROM ...) did NOT fix it — MySQL reported
-- rows as "changed" but the byte remained. REPLACE('\r','') function 
-- actually removed it. Applied to every text column, since the
-- import affected all of them, not just Churn.

-- SET SQL_SAFE_UPDATES = 0; may be required first, since these
-- UPDATEs have no WHERE clause (they intentionally apply to
-- every row).

SET SQL_SAFE_UPDATES = 0;

UPDATE telco_customers
SET 
    customerID = REPLACE(customerID, '\r', ''),
    gender = REPLACE(gender, '\r', ''),
    Partner = REPLACE(Partner, '\r', ''),
    Dependents = REPLACE(Dependents, '\r', ''),
    PhoneService = REPLACE(PhoneService, '\r', ''),
    MultipleLines = REPLACE(MultipleLines, '\r', ''),
    InternetService = REPLACE(InternetService, '\r', ''),
    OnlineSecurity = REPLACE(OnlineSecurity, '\r', ''),
    OnlineBackup = REPLACE(OnlineBackup, '\r', ''),
    DeviceProtection = REPLACE(DeviceProtection, '\r', ''),
    TechSupport = REPLACE(TechSupport, '\r', ''),
    StreamingTV = REPLACE(StreamingTV, '\r', ''),
    StreamingMovies = REPLACE(StreamingMovies, '\r', ''),
    Contract = REPLACE(Contract, '\r', ''),
    PaperlessBilling = REPLACE(PaperlessBilling, '\r', ''),
    PaymentMethod = REPLACE(PaymentMethod, '\r', '');
