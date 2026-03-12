-- ============================================================
-- 05_gl_budget_merge.sql
-- General Ledger joined to Budget Forecast
-- Drill-down: what drove the variance at account level
-- ============================================================

WITH gl_bf_merge AS (
    SELECT
        fiscal_year,
        quarter,
        budget_forecast.dept,
        account_name,
        debit,
        credit,
        budget_usd,
        forecast_usd,
        actual_usd,
        variance_usd
    FROM general_ledger
    JOIN budget_forecast
        ON general_ledger.dept = budget_forecast.dept
        AND EXTRACT(QUARTER FROM general_ledger.txn_date) = budget_forecast.quarter::INTEGER
)
SELECT
    fiscal_year,
    quarter,
    dept,
    account_name,
    SUM(debit)  AS total_debit,
    SUM(credit) AS total_credit
FROM gl_bf_merge
GROUP BY fiscal_year, quarter, dept, account_name
ORDER BY fiscal_year, quarter, dept, account_name;
