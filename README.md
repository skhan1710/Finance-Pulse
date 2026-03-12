# Finance Pulse
### Corporate Financial Intelligence: P&L Analysis, Expense Anomaly Detection & AR/AP Aging

**Domain:** FP&A · Financial Reporting · Expense Management · Working Capital  
**Author:** Safwan Khan


## Overview

Financial Pulse simulates the type of analysis performed by FP&A teams during a monthly or quarterly close. Using synthetic financial data across a general ledger, AR/AP schedules, budget forecasts, and employee expense claims, the project analyzes revenue performance, department profitability, working capital exposure, and unusual expense activity.

The project combines SQL-based financial modeling in PostgreSQL with Tableau dashboards to produce executive-ready insights.


## Tools
- **PostgreSQL** — SQL analytics and financial modeling
- **Tableau** — dashboard visualization and business reporting
- **CSV datasets** — synthetic financial data simulating enterprise systems


## Dashboards

<p align="center">
  <img src="Dashboard Images/Dashboard_1.png" width="600"><br>
   <sub><b><i>Dashboard 1 (Revenue KPIs + Moving Average)</i></b></sub>
</p>

<p align="center">
  <img src="Dashboard Images/Dashboard_2.png" width="600"><br>
   <sub><b><i>Dashboard 2 (Department P&L + Net Margin)</i></b></sub>
</p>

<p align="center">
  <img src="Dashboard Images/Dashboard3.png" width="600"><br>
  <sub><b><i>Dashboard 3 Aging Analysis dashboard (AR/AP)</i></b></sub>
</p>


**Revenue KPIs · Department Profitability · AR/AP Aging · Budget Variance · Expense Analysis · Anomaly Detection**

Full written analysis available in [`/reports/financial_analysis_report.md`](reports/financial_analysis_report.md)


## Key Insights

**Revenue & Profitability**
- Latest quarter revenue: $189,803.67 — down 2.6% QoQ, but net income rose 12.4% to $62,985.12, pointing to improved cost control
- Gross margin: 82.41% · Net margin: 31.51% — both up significantly quarter-over-quarter
- Only one month in the dataset produced negative net income: September 2024 (-$4,386), when operating expenses hit $37,864 against revenue of just $47,820

**Department Performance**
- Operations led on net margin at 45.4%, followed by Finance (43.3%) and IT (37.6%)
- HR posted the weakest profitability at 22.7%, driven by COGS of $91,809 against revenue of $320,118
- Finance generated the highest total revenue at $361,822

**Working Capital Risk**
- Total receivables: $2.28M · Total payables: $1.35M · AR/AP ratio: 1.7
- 86.8% of AR invoices fall in the 90+ day bucket, indicating a significant collection risk and potential working capital pressure with the largest exposures concentrated in Soylent ($499K) and Globex ($497K)
- BluePrints ($325K) is the largest vendor liability on the payables side

**Budget Variance**
- Marketing was the most persistent overspender, exceeding budget in four consecutive quarters across 2024–2025
- Sales ran consistently ahead of budget throughout 2024
- Finance in Q4 2024 posted the largest single-quarter negative variance: -$21,609 (-18.36%)

**Expense Monitoring**
- 1,000 employee claims analyzed across 5 categories totaling $379K
- 36.8% flagged as Unusual or Investigate using z-score anomaly detection
- A ±10% FX movement on non-USD expenses shifts total spend by ~$6,100 in either direction


## Technical Highlights

| Technique | Where Used |
|-----------|------------|
| CTEs | P&L build, AR/AP aging, expense analysis, anomaly detection |
| LAG window function | Month-over-month revenue growth |
| AVG OVER / STDDEV OVER | 4-month moving average, z-score calculation |
| ROWS BETWEEN framing | Rolling window for moving average |
| Multi-currency FX conversion | AR aging, AP aging, expense scenario analysis |
| CASE WHEN scenario modeling | FX sensitivity (−10% to +10%) |
| Multi-table JOIN | GL + budget forecast merge |
| Statistical flagging | Z-score with Investigate / Unusual / Normal labels |


## Repository Structure

```
Finance-Pulse/
│
├── sql/
│   ├── 01_pl_department_breakdown.sql
│   ├── 02_monthly_revenue_growth.sql
│   ├── 03_moving_average_forecast.sql
│   ├── 04_budget_variance.sql
│   ├── 05_gl_budget_merge.sql
│   ├── 06_ar_aging.sql
│   ├── 07_ap_aging.sql
│   ├── 08_expense_analysis.sql
│   └── 09_zscore_anomaly_detection.sql
│
├── dashboards/
│   └── FA_project1.twb
│
├── data/
│   ├── GeneralLedger.csv
│   ├── BudgetForecast.csv
│   ├── AccountsReceivable.csv
│   ├── AccountsPayable.csv
│   └── ExpenseClaims.csv
│
├── reports/
│   └── financial_analysis_report.md
│
└── README.md
```


## How to Run

1. Set up a PostgreSQL instance (local or via [supabase.com](https://supabase.com) for a free hosted option)
2. Create tables: `general_ledger`, `budget_forecast`, `ar`, `ap`, `expense_claims`
3. Load the CSV files from `/data/`
4. Run scripts in `/sql/` in numbered order
5. Connect Tableau to your PostgreSQL instance and open `FA_project1.twb`


*This project uses a fully synthetic dataset modeled after real-world financial structures. No actual company data was used.*
