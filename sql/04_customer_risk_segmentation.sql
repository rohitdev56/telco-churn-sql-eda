--Identify active customers who are at a high risk of churning based on 
--their engagement level (number of subscribed add-on services). 
--This helps the marketing team proactively retain customers before they leave.

WITH total_addon_cte AS (
    SELECT
        customerId,
        churn,
        (
            CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END
        ) AS total_addons
    FROM telco_customers
    WHERE InternetService <> 'No'
)
SELECT
    customerId,
    total_addons,
    CASE
        WHEN total_addons <= 2 THEN 'High_risk'
        WHEN total_addons <= 4 THEN 'Medium_risk'
        ELSE 'Low_risk'
    END AS Churn_prediction
FROM total_addon_cte
WHERE churn <> 'Yes';
