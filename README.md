# Telco Customer Churn Analysis — SQL End-to-End EDA

## Overview

This project performs an end-to-end Exploratory Data Analysis (EDA) on the **Telco Customer Churn** dataset containing **7,043 customer records** using **MySQL**.

The objective is to identify the key factors influencing customer churn, uncover actionable business insights, and build a rule-based **Customer Risk Segmentation** to help the marketing team proactively retain customers before they churn.

---

## Project Objectives

* Perform data quality assessment and cleaning.
* Analyze customer churn across demographic, service, and billing dimensions.
* Identify the strongest business drivers of churn.
* Segment active customers into churn risk categories based on customer engagement.
* Provide actionable recommendations for customer retention.

---

## Dataset

* **Dataset:** Telco Customer Churn
* **Records:** 7,043 customers
* **Tool:** MySQL Workbench

---

## Data Cleaning & Quality Checks

The following data quality issues were identified and resolved:

* Fixed **11 blank `TotalCharges` values** (all belonging to new customers with `tenure = 0`) using `NULLIF()`.
* Removed hidden **carriage return (`\r`) characters** from text columns using `REPLACE()` after diagnosing the issue with `HEX()` and `LENGTH()`.
* Verified data consistency across categorical columns.
* Performed duplicate and missing value checks.

---

## Exploratory Data Analysis

The analysis explored churn across multiple business dimensions, including:

* Overall churn rate
* Contract type
* Internet service
* Payment method
* Customer tenure
* Monthly charges
* Total charges
* Senior citizen status
* Partner and dependents
* Add-on services
* Phone service
* Multiple lines
* Gender

---

## Key Findings

### Contract Type

* **Month-to-month customers:** **42.7% churn**
* **One-year contracts:** significantly lower churn
* **Two-year contracts:** **2.8% churn**

Contract type is the strongest predictor of customer churn.

---

### Payment Method

Electronic check customers have the highest churn rate.

* Electronic Check: **45.3%**
* Automatic payment methods: **15–17%**

---

### Customer Tenure

Customer loyalty increases with tenure.

* **0–12 months:** 47.4% churn
* **60+ months:** 6.6% churn

---

### Customer Engagement (Add-on Services)

Among customers with internet service:

* 0 Add-ons: 52.2% churn
* 6 Add-ons: 5.3% churn

Customers subscribed to more value-added services are significantly less likely to churn.

# Low Impact Features

The following attributes showed little to no relationship with churn:

* Gender
* Multiple Lines


# Customer Risk Segmentation (Business Solution)

To move beyond descriptive analytics, a rule-based customer risk segmentation was developed for active customers (`Churn = 'No'`).

Customers were classified based on the number of subscribed value-added services:

| Total Add-on Services | Risk Level  |
| --------------------- | ----------- |
| 0–2                   | High Risk   |
| 3–4                   | Medium Risk |
| 5–6                   | Low Risk    |

This segmentation enables the marketing team to identify customers who are more likely to churn due to lower engagement and proactively target them with retention campaigns.

## Business Recommendations
Based on the analysis:

* Launch personalized retention campaigns for High-Risk customers.
* Offer discounts and promotional bundles for customers with fewer add-on services.
* Encourage Month-to-Month customers to upgrade to long-term contracts.
* Promote Online Security, Tech Support, and Streaming bundles to increase customer engagement.
* Prioritize retention efforts for new customers during their first year.
* Target Electronic Check users with incentives to switch to automatic payment methods.
* Monitor High-Risk customers monthly to evaluate campaign effectiveness.
  
# Skills Demonstrated

* SQL Data Cleaning, Exploratory Data Analysis (EDA), Aggregate Functions, CASE Statements
 ,Common Table Expressions (CTEs), Window Functions ,Business Problem Solving, Customer Segmentation
 ,Churn Analysis, Business Recommendation Development

## Project Structure

sql/
│── 01_table_creation.sql
│── 02_data_cleaning.sql
│── 03_eda_queries.sql
│── 04_customer_risk_segmentation.sql

## Business Impact

This project demonstrates how SQL can be used not only to analyze historical customer churn but also to identify **current customers who require proactive retention efforts**. By combining exploratory analysis with business-focused customer segmentation, the project shows how data-driven insights can support marketing strategies, improve customer engagement, and reduce future churn.

This version is more portfolio-ready because it highlights both your technical SQL skills and your ability to translate analysis into business actions—something hiring managers for data analyst roles often value.
