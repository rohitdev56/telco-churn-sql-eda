# Key Insights — Telco Customer Churn

**Dataset:** 7,043 customers
**Overall churn rate:** **26.5%** (1,869 churned | 5,174 retained)

All churn rates below are calculated within their respective groups (e.g., churned seniors ÷ total seniors), ensuring accurate comparisons across customer segments.

---

# 1. Contract Type — The Strongest Churn Driver

| Contract       | Customers | Churned | Churn Rate |
| -------------- | --------: | ------: | ---------: |
| Month-to-month |     3,875 |   1,655 | **42.71%** |
| One year       |     1,473 |     166 |     11.27% |
| Two year       |     1,695 |      48 |  **2.83%** |

### Business Insight

Contract length is the single strongest predictor of churn.

Customers on **month-to-month contracts** are approximately **15× more likely to churn** than customers on two-year contracts, indicating that long-term contracts significantly improve customer retention.

---

# 2. Payment Method — Automatic Payments Improve Retention

| Payment Method            | Customers | Churned | Churn Rate |
| ------------------------- | --------: | ------: | ---------: |
| Electronic Check          |     2,365 |   1,071 | **45.29%** |
| Mailed Check              |     1,612 |     308 |     19.11% |
| Bank Transfer (Automatic) |     1,544 |     258 |     16.71% |
| Credit Card (Automatic)   |     1,522 |     232 | **15.24%** |

### Business Insight

Customers paying via **Electronic Check** exhibit the highest churn rate.

Automatic payment methods consistently reduce churn, suggesting that payment convenience and billing automation contribute to customer retention.

---

# 3. Customer Tenure — Loyalty Increases Over Time

| Tenure Bucket | Customers | Churn Rate |
| ------------- | --------: | ---------: |
| 0–12 Months   |     2,186 | **47.44%** |
| 13–24 Months  |     1,024 |     28.71% |
| 25–36 Months  |       832 |     21.63% |
| 37–48 Months  |       762 |     19.03% |
| 49–60 Months  |       832 |     14.42% |
| 60+ Months    |     1,407 |  **6.61%** |

### Business Insight

Customer churn steadily decreases as tenure increases.

The first year represents the highest-risk period, while customers retained beyond five years become significantly more loyal.

---

# 4. Internet Service Type

| Internet Service    | Customers | Churned | Churn Rate |
| ------------------- | --------: | ------: | ---------: |
| Fiber Optic         |     3,096 |   1,297 | **41.89%** |
| DSL                 |     2,421 |     459 |     18.96% |
| No Internet Service |     1,526 |     113 |  **7.40%** |

### Business Insight

Despite being the premium offering, **Fiber Optic customers experience the highest churn rate**.

This may indicate pricing concerns, stronger market competition, or service quality issues, making Fiber customers an important segment for further investigation.

---

# 5. Value-Added Services Increase Customer Loyalty

| Online Security     | Customers | Churned | Churn Rate |
| ------------------- | --------: | ------: | ---------: |
| No                  |     3,498 |   1,461 | **41.77%** |
| Yes                 |     2,019 |     295 | **14.61%** |
| No Internet Service |     1,526 |     113 |      7.40% |

A nearly identical trend is observed for **Tech Support**.

### Business Insight

Customers subscribed to support-related services are approximately **three times less likely to churn**, indicating that service engagement is strongly associated with customer retention.

---

# 6. Customer Engagement (Add-on Services)

Customers without internet service were excluded to avoid bias.

| Add-ons | Customers | Churned | Churn Rate |
| ------- | --------: | ------: | ---------: |
| 0       |       693 |     362 | **52.24%** |
| 1       |       966 |     442 |     45.76% |
| 2       |     1,033 |     370 |     35.82% |
| 3       |     1,118 |     306 |     27.37% |
| 4       |       852 |     190 |     22.30% |
| 5       |       571 |      71 |     12.43% |
| 6       |       284 |      15 |  **5.28%** |

### Business Insight

Customer engagement increases with every additional subscribed service.

Customers with **no add-on services** churn at nearly **10× the rate** of customers subscribed to all six available services.

This finding became clear after separating customers without internet service from the analysis, demonstrating the importance of validating unexpected trends before drawing conclusions.

---

# 7. Demographic Factors

| Factor         | Higher Churn Group | Churn Rate |
| -------------- | ------------------ | ---------: |
| Senior Citizen | Senior Customers   | **41.68%** |
| Partner        | No Partner         | **32.96%** |
| Dependents     | No Dependents      | **31.28%** |

### Business Insight

Demographic characteristics influence churn, but their impact is considerably smaller than service usage, tenure, contract type, and payment behavior.

---

# 8. Factors With Minimal Business Impact

| Factor         | Observation                                                         |
| -------------- | ------------------------------------------------------------------- |
| Gender         | Churn rates are nearly identical between male and female customers. |
| Multiple Lines | Only a marginal difference in churn was observed.                   |

### Business Insight

Not every customer attribute contributes meaningfully to churn prediction.

Identifying low-impact variables is equally valuable, as it prevents unnecessary business focus on features that provide little predictive value.

---

# 9. Customer Risk Segmentation (Business Solution)

Using the EDA findings, active customers (`Churn = 'No'`) were segmented into risk categories based on their level of engagement.

| Total Add-on Services | Risk Level    |
| --------------------- | ------------- |
| 0–2                   | **High Risk** |
| 3–4                   | Medium Risk   |
| 5–6                   | Low Risk      |

### Business Objective

Rather than waiting for customers to churn, this segmentation identifies customers who require proactive retention efforts.

High-Risk customers can be targeted with:

* Personalized retention campaigns
* Discounted service bundles
* Free trials of Online Security or Tech Support
* Loyalty rewards
* Customer success outreach

This transforms the project from descriptive analytics into a practical decision-support solution for the marketing and customer retention teams.

---

# Composite Churn Profile

### Highest-Risk Customer

* Month-to-month contract
* 0–12 months tenure
* Electronic Check payment
* Fiber Optic internet
* Few or no add-on services
* No partner or dependents

### Lowest-Risk Customer

* Two-year contract
* 60+ months tenure
* Automatic payment
* Multiple subscribed add-on services
* Long-term engaged customer

These customer profiles illustrate how multiple churn drivers combine to create substantially different levels of churn risk.

---

# Data Quality Improvements

During data preparation, the following issues were identified and resolved:

* Fixed **11 blank TotalCharges values**, all belonging to new customers (`tenure = 0`), using `NULLIF(TRIM(...), '')`.
* Removed hidden carriage return characters (`\r`, Hex `0D`) from all text columns using `REPLACE(column, CHAR(13), '')` after diagnosing the issue with `HEX()` and `LENGTH()`.
* Verified categorical consistency across all service-related fields before performing the analysis.

---

# Business Recommendations

Based on the analysis:

* Encourage Month-to-Month customers to migrate to long-term contracts.
* Prioritize retention efforts during customers' first year.
* Promote Online Security and Tech Support bundles to increase customer engagement.
* Target Electronic Check customers with incentives to switch to automatic payments.
* Use the Customer Risk Segmentation to proactively identify High-Risk customers and launch personalized retention campaigns before churn occurs.
