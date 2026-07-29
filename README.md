# Loan Default Risk Analysis — Findings & Business Insights

**Dataset:** 601 loan applications across 500 borrowers
**Overall Default Rate:** 24.29% (146 of 601 loans)

---

## 1. What is the overall default rate?

| Total Loans | Total Defaults | Default Rate |
|---|---|---|
| 601 | 146 | **24.29%** |

**Business Insight:** Roughly 1 in 4 loans in the portfolio default. This is a high baseline rate that should anchor all segment-level comparisons below — any segment meaningfully above ~24% is a red flag, and any segment meaningfully below is a candidate for preferential underwriting terms.

---

## 2. How does default rate break down by credit score range?

| Credit Score Band | Total Loans | Defaults | Default Rate |
|---|---|---|---|
| 520–599 | 116 | 57 | **49.14%** |
| 600–649 | 93 | 27 | 29.03% |
| 650–699 | 75 | 21 | 28.00% |
| 700–749 | 86 | 14 | 16.28% |
| 750–799 | 88 | 6 | **6.82%** |
| 800–849 | 104 | 15 | 14.42% |
| 850+ | 39 | 6 | 15.38% |

**Business Insight:** Credit score is the strongest single risk signal in the dataset. Default risk drops sharply and consistently from the 520–599 band (~49%) down to the 750–799 band (~7%) — a nearly 7x difference in risk. This strongly supports tiered pricing/approval thresholds, with the 520–649 range warranting the tightest scrutiny (or decline) and the 700–799 range representing the "sweet spot" for approval. The slight uptick above 800 is a minor anomaly, likely due to smaller sample sizes in those bands rather than a genuine risk increase, and shouldn't be over-interpreted.

---

## 3. Is there a relationship between DTI ratio and default likelihood?

*(Note: the original query's bucket logic had a syntax issue — `dti_ratio < 20 and 29` doesn't evaluate as intended in SQL. Corrected range logic was used below.)*

| DTI Ratio Band | Total Loans | Defaults | Default Rate |
|---|---|---|---|
| 0–19% | 48 | 8 | 16.67% |
| 20–29% | 78 | 10 | 12.82% |
| 30–39% | 107 | 12 | 11.21% |
| 40–49% | 97 | 23 | 23.71% |
| 50%+ | 271 | 93 | **34.32%** |

**Business Insight:** Default risk is stable and relatively low (11–17%) for borrowers with DTI under 40%, then rises sharply once DTI crosses 40%, and nearly triples for borrowers at 50%+ DTI. Since over 45% of all loans in the portfolio fall into that 50%+ band, DTI concentration is a material portfolio-level risk. A DTI cap (e.g., declining or requiring compensating factors above 40–45%) would likely meaningfully reduce the overall default rate.

---

## 4. Which loan purposes have the highest default rate?

| Loan Purpose | Total Loans | Defaults | Default Rate |
|---|---|---|---|
| Wedding | 56 | 18 | **32.14%** |
| Home Improvement | 70 | 20 | 28.57% |
| Auto Loan | 59 | 16 | 27.12% |
| Business Loan | 58 | 14 | 24.14% |
| Education | 53 | 12 | 22.64% |
| Vacation | 62 | 14 | 22.58% |
| Major Purchase | 68 | 15 | 22.06% |
| Debt Consolidation | 51 | 11 | 21.57% |
| Moving | 56 | 12 | 21.43% |
| Medical Expenses | 68 | 14 | **20.59%** |

**Business Insight:** Discretionary, non-essential purposes — **Wedding** and **Home Improvement** — carry the highest default rates, both well above the portfolio average. This may reflect that these loans are often taken on by borrowers already under financial strain rather than for income-generating or essential needs. Medical Expenses and Debt Consolidation loans, despite sounding "riskier" on the surface, actually default the least — possibly because they're taken more cautiously or are smaller/more necessity-driven. Underwriting or pricing could reasonably differentiate by purpose, with added scrutiny on wedding and home improvement loans.

---

## 5. Does average loan amount differ between defaulted and non-defaulted loans?

| Status | Total Loans | Avg Loan Amount | Min | Max |
|---|---|---|---|---|
| Non-Default | 455 | $22,013 | $2,000 | $49,800 |
| Default | 146 | $22,571 | $2,400 | $49,700 |

**Business Insight:** Loan amount is **not** a meaningful differentiator — average amounts are nearly identical (~$22K) between defaulted and non-defaulted loans, and the full range is similar in both groups. This tells us default risk is driven by *borrower* characteristics (credit score, DTI, tenure) rather than by the *size* of the loan itself. Loan amount alone is not a useful risk-screening variable in this portfolio.

---

## 6. How does employment status affect default risk?

| Employment Status | Total Loans | Defaults | Default Rate |
|---|---|---|---|
| Part-Time | 65 | 18 | **27.69%** |
| Self-Employed | 105 | 26 | 24.76% |
| Full-Time | 305 | 73 | 23.93% |
| Retired | 60 | 14 | 23.33% |
| Contract | 66 | 15 | 22.73% |

**Business Insight:** Employment status shows relatively modest variation (22.7%–27.7%) compared to credit score or DTI — it's a weaker standalone risk signal. Part-Time workers carry the highest default rate and Contract workers the lowest, but the spread is only ~5 points, meaning employment status alone shouldn't drive underwriting decisions — it's better used as a secondary/supporting factor alongside credit score and DTI.

---

## 7. How does years employed (tenure) affect default risk?

| Employment Tenure | Total Loans | Defaults | Default Rate |
|---|---|---|---|
| <2 years | 84 | 29 | **34.52%** |
| 2–5 years | 146 | 24 | 16.44% |
| 6–10 years | 110 | 33 | **30.00%** |
| 10+ years | 261 | 60 | 22.99% |

**Business Insight:** The relationship isn't perfectly linear — the <2 year and 6–10 year bands both show elevated risk (30–35%), while 2–5 years is the safest band (16%). The clearest, most actionable signal is that **new employment (<2 years)** carries the highest default risk in the dataset. The 6–10 year uptick is less intuitive and may warrant deeper investigation (e.g., career-change borrowers, industry-specific effects) rather than being taken at face value.

---

## 8. Are borrowers with <2 years of employment more likely to default?

| Employment Group | Total Loans | Defaults | Default Rate |
|---|---|---|---|
| <2 years | 84 | 29 | **34.52%** |
| 2+ years | 517 | 117 | 22.63% |

**Business Insight:** Yes — clearly. Borrowers with under 2 years of job tenure default at nearly **1.5x the rate** of more established borrowers (34.5% vs 22.6%). This is a strong, simple, and easily-collected underwriting signal. Combined with the credit score and DTI findings, a borrower who is both newly employed *and* has high DTI/low credit score represents a compounding risk profile that likely deserves the strictest review.

---

## Summary of Key Risk Drivers (Ranked by Impact)

1. **Credit Score** — strongest predictor; default rate ranges from ~7% to ~49% across bands.
2. **DTI Ratio** — second strongest; risk roughly triples once DTI exceeds 50%.
3. **Employment Tenure (<2 years)** — meaningful and simple risk flag (+12 points vs. tenured borrowers).
4. **Loan Purpose** — moderate differentiator; wedding/home improvement loans riskier than medical/debt consolidation.
5. **Employment Status** — weak standalone signal; better used as a supporting factor.
6. **Loan Amount** — not predictive of default; roughly equal across defaulted and non-defaulted loans.

## Dashboard Screenshot
<img width="1373" height="797" alt="Image" src="https://github.com/user-attachments/assets/8b02bb0b-ac7d-4469-8d32-9ef9cabe81a7" />

## live dashboard
https://app.powerbi.com/groups/me/reports/f6dccb9d-6a95-4191-940f-38b8f1b5a053/dc4a29fc385d7866806b?experience=power-bi

