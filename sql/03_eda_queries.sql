-- TELCO CUSTOMER CHURN — EDA QUERIES
-- All churn rates are calculated WITHIN their own group
-- (e.g. churned seniors ÷ total seniors), not against the
-- whole customer base, so percentages are directly comparable
-- across groups.


-- 1. OVERALL CHURN RATE
-- What % of all customers churned vs. were retained?
SELECT 
ROUND((SUM(CASE WHEN Churn = "Yes" THEN 1 ELSE 0 END) * 100.0)/ Count(*),2) AS Churn_customers_perc,
ROUND((SUM(CASE WHEN Churn = "No" THEN 1 ELSE 0 END) * 100.0)/ Count(*),2) AS Retained_customers_perc
FROM telco_customers;

-- 2. SENIOR CITIZEN vs CHURN
-- % of customers who are senior citizens, and their churn
-- rate compared to non-seniors.

Select
Round(SUM(CASE WHEN seniorCitizen = 1 THEN 1 Else 0 END) *100 / Count(*),2) AS seniorCitizen_perc,
Round(SUM(CASE WHEN seniorCitizen = 0 THEN 1 Else 0 END) *100 / Count(*),2) AS Non_seniorCitizen_perc,
Round(SUM(CASE WHEN seniorCitizen = 1  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN seniorCitizen = 1 THEN 1 Else 0 END),2) AS seniorCitizen_churn_perc,
Round(SUM(CASE WHEN seniorCitizen = 0  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN seniorCitizen = 0 THEN 1 Else 0 END),2) AS non_seniorCitizen_churn_perc
From telco_customers;

-- 3. PARTNER vs CHURN
-- Does having a partner correlate with lower churn?
Select
Round(SUM(CASE WHEN partner = "Yes" THEN 1 Else 0 END) *100 / Count(*),2) AS partner_perc,
Round(SUM(CASE WHEN partner = "No" THEN 1 Else 0 END) *100 / Count(*),2) AS Non_partner_perc,
Round(SUM(CASE WHEN partner = "Yes"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN partner = "Yes" THEN 1 Else 0 END),2) AS partner_churn_perc,
Round(SUM(CASE WHEN partner = "No"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN partner = "No" THEN 1 Else 0 END),2) AS non_partner_churn_perc
From telco_customers;

-- 4. DEPENDENTS vs CHURN
-- Same pattern as Partner — does having dependents lower churn?
Select
Round(SUM(CASE WHEN dependents = "Yes" THEN 1 Else 0 END) *100 / Count(*),2) AS dependents_perc,
Round(SUM(CASE WHEN dependents = "No" THEN 1 Else 0 END) *100 / Count(*),2) AS non_dependents_perc,
Round(SUM(CASE WHEN dependents = "Yes"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN dependents = "Yes" THEN 1 Else 0 END),2) AS dependents_churn_perc,
Round(SUM(CASE WHEN dependents = "No"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN dependents = "No" THEN 1 Else 0 END),2) AS non_dependents_churn_perc
From telco_customers;


-- 5. GENDER vs CHURN
-- Sanity check: confirming (not assuming) gender has no
-- meaningful effect on churn.
Select
Round(SUM(CASE WHEN gender = "Male" THEN 1 Else 0 END) *100 / Count(*),2) AS male_perc,
Round(SUM(CASE WHEN gender = "Female" THEN 1 Else 0 END) *100 / Count(*),2) AS female_perc,
Round(SUM(CASE WHEN gender = "Male"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN gender = "Male" THEN 1 Else 0 END),2) AS male_churn_perc,
Round(SUM(CASE WHEN gender = "Female"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN gender = "Female" THEN 1 Else 0 END),2) AS female_churn_perc
From telco_customers;


-- 6. CONTRACT TYPE vs CHURN
-- Strongest predictor in the dataset: month-to-month vs
-- one year vs two year contracts
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;


-- 7. PAYMENT METHOD vs CHURN
-- Compares automatic (bank transfer / credit card) vs manual
-- (electronic check / mailed check) payment methods.

Select paymentMethod,
count(*) AS total_customers,
SUM(case when churn = "YES" then 1 else 0 END) AS churn_customers,
Round(SUM(case when churn = "YES" then 1 else 0 END) * 100.0 / Count(*),2) AS churn_rate_pct
From telco_customers
GROUP BY paymentMethod
ORDER BY churn_rate_pct DESC;

-- 8. TENURE BUCKETS vs CHURN
-- Groups customers into 6 tenure ranges to see whether churn
-- risk drops as tenure increases.

SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '60+ months'
    END AS tenure_bucket,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telco_customers), 2) AS pct_of_total,
    Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
    Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
FROM telco_customers
GROUP BY tenure_bucket
ORDER BY MIN(tenure);

-- 9. INTERNET SERVICE TYPE vs CHURN
-- DSL vs Fiber optic vs No internet service.

Select 
InternetService,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by InternetService
ORDER BY churn_rate_pct
DESC;

-- 10. ONLINE SECURITY vs CHURN
-- Do customers without OnlineSecurity churn more?
-- Note: "No internet service" is a separate category from "No",
-- since it represents customers the add-on doesn't apply to.

Select 
OnlineSecurity,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by OnlineSecurity
ORDER BY churn_rate_pct
DESC;

-- 11. TECH SUPPORT vs CHURN
-- Same structure as OnlineSecurity — checking if the pattern
-- repeats for a different add-on service.

Select 
TechSupport,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by TechSupport
ORDER BY churn_rate_pct
DESC;

-- 12. MULTIPLE LINES vs CHURN
-- Sanity check: confirming MultipleLines has little to no
-- effect on churn (churn rate stays roughly flat across groups).

Select 
MultipleLines,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by MultipleLines
ORDER BY churn_rate_pct
DESC;

-- 13. TOTAL ADD-ON COUNT vs CHURN
-- Counts how many of the 6 add-on services (OnlineSecurity,
-- OnlineBackup, DeviceProtection, TechSupport, StreamingTV,
-- StreamingMovies) each customer has, then checks if more
-- add-ons correlate with lower churn.
--
-- IMPORTANT: filtered to InternetService != "No" only.
-- Without this filter, customers with no internet service
-- (who can't have any add-ons) get lumped into the "0 add-ons"
-- bucket and distort the trend — this WHERE clause separates
-- that population out so the relationship reads cleanly.

SELECT 
    (CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END) AS total_addons,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
Where InternetService != "No"
GROUP BY total_addons
ORDER BY total_addons;
