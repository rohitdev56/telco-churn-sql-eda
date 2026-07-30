SELECT 
ROUND((SUM(CASE WHEN Churn = "Yes" THEN 1 ELSE 0 END) * 100.0)/ Count(*),2) AS Churn_customers_perc,
ROUND((SUM(CASE WHEN Churn = "No" THEN 1 ELSE 0 END) * 100.0)/ Count(*),2) AS Retained_customers_perc
FROM telco_customers;

Select
Round(SUM(CASE WHEN seniorCitizen = 1 THEN 1 Else 0 END) *100 / Count(*),2) AS seniorCitizen_perc,
Round(SUM(CASE WHEN seniorCitizen = 0 THEN 1 Else 0 END) *100 / Count(*),2) AS Non_seniorCitizen_perc,
Round(SUM(CASE WHEN seniorCitizen = 1  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN seniorCitizen = 1 THEN 1 Else 0 END),2) AS seniorCitizen_churn_perc,
Round(SUM(CASE WHEN seniorCitizen = 0  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN seniorCitizen = 0 THEN 1 Else 0 END),2) AS non_seniorCitizen_churn_perc
From telco_customers;

Select
Round(SUM(CASE WHEN partner = "Yes" THEN 1 Else 0 END) *100 / Count(*),2) AS partner_perc,
Round(SUM(CASE WHEN partner = "No" THEN 1 Else 0 END) *100 / Count(*),2) AS Non_partner_perc,
Round(SUM(CASE WHEN partner = "Yes"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN partner = "Yes" THEN 1 Else 0 END),2) AS partner_churn_perc,
Round(SUM(CASE WHEN partner = "No"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN partner = "No" THEN 1 Else 0 END),2) AS non_partner_churn_perc
From telco_customers;

Select
Round(SUM(CASE WHEN dependents = "Yes" THEN 1 Else 0 END) *100 / Count(*),2) AS dependents_perc,
Round(SUM(CASE WHEN dependents = "No" THEN 1 Else 0 END) *100 / Count(*),2) AS non_dependents_perc,
Round(SUM(CASE WHEN dependents = "Yes"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN dependents = "Yes" THEN 1 Else 0 END),2) AS dependents_churn_perc,
Round(SUM(CASE WHEN dependents = "No"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN dependents = "No" THEN 1 Else 0 END),2) AS non_dependents_churn_perc
From telco_customers;

Select
Round(SUM(CASE WHEN gender = "Male" THEN 1 Else 0 END) *100 / Count(*),2) AS male_perc,
Round(SUM(CASE WHEN gender = "Female" THEN 1 Else 0 END) *100 / Count(*),2) AS female_perc,
Round(SUM(CASE WHEN gender = "Male"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN gender = "Male" THEN 1 Else 0 END),2) AS male_churn_perc,
Round(SUM(CASE WHEN gender = "Female"  AND CHURN = "YES" THEN 1 Else 0 END) *100 / SUM(CASE WHEN gender = "Female" THEN 1 Else 0 END),2) AS female_churn_perc
From telco_customers;

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

Select paymentMethod,
count(*) AS total_customers,
SUM(case when churn = "YES" then 1 else 0 END) AS churn_customers,
Round(SUM(case when churn = "YES" then 1 else 0 END) * 100.0 / Count(*),2) AS churn_rate_pct
From telco_customers
GROUP BY paymentMethod
ORDER BY churn_rate_pct DESC;

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

Select 
InternetService,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by InternetService
ORDER BY churn_rate_pct
DESC;

Select 
OnlineSecurity,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by OnlineSecurity
ORDER BY churn_rate_pct
DESC;

Select 
TechSupport,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by TechSupport
ORDER BY churn_rate_pct
DESC;

Select 
MultipleLines,
Count(*) AS total_customers,
Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
Round(Sum(CASE WHEN churn = "Yes" THEN 1 ELSE 0 END) * 100.0 / COunt(*),2) AS churn_rate_pct 
From telco_customers
Group by MultipleLines
ORDER BY churn_rate_pct
DESC;

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
