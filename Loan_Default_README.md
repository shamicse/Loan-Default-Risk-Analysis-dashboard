# Loan Default Risk Analysis Dashboard

An end-to-end credit risk analytics project that identifies the strongest predictors of loan default and presents them through an interactive Power BI dashboard — built to help lending/risk teams tighten underwriting criteria and reduce portfolio losses.

## Project Overview

Understanding *who* is likely to default — and *why* — is the core job of any credit risk function. This project analyzes 601 loan applications from 500 borrowers, combining loan-level data (amount, purpose, DTI, delinquency) with borrower-level data (credit score, income, employment, tenure) to surface the factors most predictive of default, then turns those findings into a single-page interactive Power BI dashboard.

**Overall default rate: 24.3%** (146 of 601 loans)

## Dataset

| | |
|---|---|
| **Files** | `loan_applications.csv`, `borrower_profiles.csv` |
| **Loan records** | 601 applications |
| **Borrower records** | 500 unique borrowers |
| **Key loan fields** | loan_purpose, loan_amount, term_months, interest_rate, dti_ratio, loan_status, days_delinquent, defaulted |
| **Key borrower fields** | credit_score, employment_status, years_employed, annual_income, home_ownership, dependents, existing_monthly_debt |

## SQL Analysis

All findings were derived from a set of analytical SQL queries (`q_no_8_default_rate_by_employment_group.sql` and related queries) run against a `riskmanagement` database, answering questions such as:

- What is the overall default rate?
- How does default rate vary by credit score band?
- Is there a relationship between DTI ratio and default risk?
- Which loan purposes default most?
- Does loan amount influence default risk?
- How do employment status and tenure affect default risk?

## Dashboard

**`Loan_Default_Risk_Analysis_Dashboard.pbix`** — a single-page Power BI dashboard combining:
- KPI cards: Total Loans, Total Defaults, Default Rate, Avg Credit Score, Avg Loan Amount, Avg Annual Income
- Bar charts: Default Rate by Loan Purpose, by DTI Ratio, by Employment Status
- Donut charts: Default Rate by Credit Score bucket, Default Rate by Loan Amount
- Pie chart: Default Rate by Employment Tenure
- A dedicated Business Insight panel summarizing the key takeaways

![Loan Default Risk Analysis Dashboard](assets/dashboard-screenshot.png)

## Key Insights

- **Credit score is the strongest predictor of default.** Default rate falls from **49.1%** in the 520–599 band to just **6.8%** in the 750–799 band — a nearly 7x difference in risk.
- **DTI (debt-to-income) ratio is the second strongest signal.** Default risk stays low (11–17%) below 40% DTI, then rises sharply, nearly tripling to **34.3%** once DTI crosses 50%. Over 45% of the portfolio sits in that highest-risk band.
- **Newly employed borrowers (<2 years tenure) default at 34.5%**, nearly **1.5x** the rate of borrowers with 2+ years tenure (22.6%).
- **Loan purpose has a moderate effect** — Wedding (32.1%) and Home Improvement (28.6%) loans default most; Medical Expenses (20.6%) and Debt Consolidation (21.6%) default least.
- **Employment status is a weak standalone signal** — default rates only range from 22.7% (Contract) to 27.7% (Part-Time), a much narrower spread than credit score or DTI.
- **Loan amount is not predictive of default** — average loan size is nearly identical between defaulted (~$22.6K) and non-defaulted (~$22.0K) loans.

## Recommended Actions

1. Use credit score and DTI ratio as the primary underwriting filters — they carry by far the most predictive power.
2. Apply a DTI cap (e.g., decline or require compensating factors above 40–45%) to materially reduce portfolio-level default rate.
3. Flag borrowers with <2 years employment tenure for additional review, especially when combined with low credit score or high DTI.
4. Apply moderate additional scrutiny to wedding and home-improvement loan purposes.
5. Do not rely on loan amount or employment status alone as risk-screening variables — treat them as secondary/supporting factors.

## Tools & Tech Stack

- **SQL** — data querying and segment-level default rate analysis
- **Power BI Desktop** — data modeling and interactive dashboard design
- **Power Query / DAX** — data transformation and measures

## Repository Structure

```
Loan-Default-Risk-Analysis-dashboard/
├── loan_applications.csv                         # Loan-level dataset (601 rows)
├── borrower_profiles.csv                         # Borrower-level dataset (500 rows)
├── Loan_Default_Risk_Analysis_Dashboard.pbix      # Power BI dashboard
├── queries/
│   └── default_rate_analysis.sql                 # All analytical SQL queries
├── assets/
│   └── dashboard-screenshot.png                   # Dashboard preview
└── README.md
```

## How to Use

1. Clone this repository.
2. Open `Loan_Default_Risk_Analysis_Dashboard.pbix` in [Power BI Desktop](https://app.powerbi.com/groups/me/reports/f6dccb9d-6a95-4191-940f-38b8f1b5a053/dc4a29fc385d7866806b?experience=power-bi).
3. Run the SQL queries in `queries/` against a `riskmanagement` database (or your own loan dataset) to reproduce the underlying analysis.
4. Use the dashboard filters to explore default rate by credit score, DTI, loan purpose, and employment segment.

## Author

**Shami**
📎 [GitHub](https://github.com/shamicse) · [Repository](https://github.com/shamicse/Loan-Default-Risk-Analysis-dashboard)

---
⭐ If you found this project useful, consider giving it a star!
