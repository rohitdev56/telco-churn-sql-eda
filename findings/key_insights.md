# Key Insights — Telco Customer Churn

Dataset: 7,043 customers | Overall churn rate: **26.5%** (1,869 churned / 5,174 retained)

All churn rates below are calculated within their own group (e.g. churned seniors ÷ total seniors), not against the whole customer base — an early version of this analysis divided by total customers instead, which understated every group's real churn rate.

---

## 1. Contract type — the strongest single predictor

| Contract | Customers | Churned | Churn Rate |
|---|---|---|---|
| Month-to-month | 3,875 | 1,655 | **42.71%** |
| One year | 1,473 | 166 | 11.27% |
| Two year | 1,695 | 48 | 2.83% |

Month-to-month customers churn at roughly **15x** the rate of two-year contract customers. Contract length — i.e. how much friction exists to leave — is the single biggest lever in this dataset.

---

## 2. Payment method — automatic vs. manual

| Payment Method | Customers | Churned | Churn Rate |
|---|---|---|---|
| Electronic check | 2,365 | 1,071 | **45.29%** |
| Mailed check | 1,612 | 308 | 19.11% |
| Bank transfer (automatic) | 1,544 | 258 | 16.71% |
| Credit card (automatic) | 1,522 | 232 | 15.24% |

Both automatic payment methods cluster around 15–17% churn, while manual methods sit higher. Electronic check stands out even among manual methods — worth further investigation (possible correlation with demographics or engagement level, not just payment friction).

---

## 3. Tenure — churn risk drops steadily over time

| Tenure Bucket | Customers | % of Base | Churn Rate |
|---|---|---|---|
| 0–12 months | 2,186 | 31.04% | **47.44%** |
| 13–24 months | 1,024 | 14.54% | 28.71% |
| 25–36 months | 832 | 11.81% | 21.63% |
| 37–48 months | 762 | 10.82% | 19.03% |
| 49–60 months | 832 | 11.81% | 14.42% |
| 60+ months | 1,407 | 19.98% | 6.61% |

A clean, monotonic decline — no bucket breaks the trend. New customers are ~7x more likely to churn than customers with 5+ years of tenure. The overall tenure distribution is bimodal (heavy at 0–12mo and 60+mo, lighter in the middle), suggesting most churn-risk decisions happen early, and customers who pass that window tend to stay long-term.

---

## 4. Internet service type — the premium tier churns hardest

| Internet Service | Customers | Churned | Churn Rate |
|---|---|---|---|
| Fiber optic | 3,096 | 1,297 | **41.89%** |
| DSL | 2,421 | 459 | 18.96% |
| No internet | 1,526 | 113 | 7.40% |

Counterintuitive: fiber optic (the premium, more expensive tier) churns at more than 2x the rate of DSL. Possible explanations include higher price sensitivity, more competitive coverage in fiber areas, or service reliability complaints — worth a deeper look if this analysis is extended.

---

## 5. Online security & tech support — add-ons correlate with loyalty

| Online Security | Customers | Churned | Churn Rate |
|---|---|---|---|
| No | 3,498 | 1,461 | **41.77%** |
| Yes | 2,019 | 295 | 14.61% |
| No internet service | 1,526 | 113 | 7.40% |

`TechSupport` shows the same pattern almost exactly. Customers without these add-ons churn at ~3x the rate of those with them — likely a combination of the add-on itself adding stickiness, and being a proxy for a more price-sensitive, lower-engagement customer segment.

---

## 6. Add-on count — a corrected finding

Initial pass (all customers) showed a confusing spike: 0 add-ons had *lower* churn than 1 add-on. Root cause: customers with **no internet service** were mixed into the "0 add-ons" bucket, since none of the add-on columns apply to them, and they have unusually low churn (7.40%, per finding #4).

After filtering to internet customers only (`WHERE InternetService != 'No'`):

| Add-ons | Customers | Churned | Churn Rate |
|---|---|---|---|
| 0 | 693 | 362 | **52.24%** |
| 1 | 966 | 442 | 45.76% |
| 2 | 1,033 | 370 | 35.82% |
| 3 | 1,118 | 306 | 27.37% |
| 4 | 852 | 190 | 22.30% |
| 5 | 571 | 71 | 12.43% |
| 6 | 284 | 15 | 5.28% |

Once the two populations were separated, the trend became clean and monotonic — a ~10x drop in churn from 0 to 6 add-ons. **Lesson: an unexpected kink in an otherwise clean trend is often a sign of mixed populations, not noise.**

---

## Demographics (secondary factors)

| Factor | Group A | Group A Churn | Group B | Group B Churn |
|---|---|---|---|---|
| Senior citizen | Senior (16.2% of base) | 41.68% | Non-senior (83.8%) | 23.61% |
| Partner | Has partner (48.3%) | 19.66% | No partner (51.7%) | 32.96% |
| Dependents | Has dependents (30.0%) | 15.45% | No dependents (70.0%) | 31.28% |

Seniors, and customers without a partner or dependents, all churn at roughly 1.5–2x the rate of their counterparts — smaller effects than contract/tenure/payment, but consistent and directionally real.

---

## Ruled out (checked, not assumed)

| Factor | Group A | Churn | Group B | Churn |
|---|---|---|---|---|
| Gender | Male | 26.16% | Female | 26.92% |
| Multiple lines | Yes | 28.61% | No | 25.04% |

Both show negligible difference between groups — confirmed rather than assumed, since a report that only shows "expected" findings is less trustworthy than one that also rules things out.

---

## Composite churn profile

The highest-risk customer: **new (0–12mo tenure), month-to-month contract, paying by electronic check, with few or no add-on services.** The lowest-risk customer: **long-tenured (60mo+), two-year contract, automatic payment, fully subscribed to add-ons.** The gap between these two profiles spans roughly a 5–10x difference in churn probability depending on which factors stack together.

---

## Data quality notes

- **11 rows** had blank `TotalCharges`, all with `tenure = 0` (brand-new, not yet billed). Resolved with `NULLIF(TRIM(...), '')` during import.
- **All 16 text columns** contained a hidden trailing carriage return (`\r`, hex `0D`) from Windows-style CSV line endings — invisible in MySQL Workbench's grid view, but silently broke every string equality comparison (e.g. `WHERE Churn = 'Yes'` matched zero rows). Diagnosed via `HEX()` and `LENGTH()`, and fixed with `REPLACE(column, CHAR(13), '')` since `TRIM()` alone did not remove it.
