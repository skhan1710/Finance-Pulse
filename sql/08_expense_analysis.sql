-- ============================================================
-- 08_expense_analysis.sql
-- Employee Expense Analysis:
--   - FX Exposure Summary
--   - Category Spending in USD
--   - Quarterly Trend by Category
--   - FX Scenario Analysis (±5%, ±10%)
-- ============================================================

WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),

-- 1. FX Exposure Summary
fx_exposure AS (
    SELECT
        ROUND(SUM(CASE WHEN expense_claims.currency = 'USD' THEN amount                ELSE 0   END), 2) AS usd_expenses,
        ROUND(SUM(CASE WHEN expense_claims.currency != 'USD' THEN amount * rate         ELSE 0   END), 2) AS non_usd_expenses,
        ROUND(SUM(amount * rate), 2)                                                                      AS total_expenses,
        ROUND(SUM(CASE WHEN expense_claims.currency != 'USD' THEN amount * rate ELSE 0 END)
              / SUM(amount * rate) * 100, 2)                                                              AS pct_fx_exposed
    FROM expense_claims
    JOIN fx_rates ON fx_rates.currency = expense_claims.currency
),

-- 2. Category Spending in USD
category_spending AS (
    SELECT
        category,
        COUNT(*)                        AS claim_count,
        ROUND(SUM(amount * rate), 2)    AS total_amount,
        ROUND(AVG(amount * rate), 2)    AS avg_claim
    FROM expense_claims
    JOIN fx_rates ON fx_rates.currency = expense_claims.currency
    GROUP BY category
    ORDER BY total_amount DESC
),

-- 3. Quarterly Trend by Category
quarterly_trend AS (
    SELECT
        DATE_TRUNC('quarter', submit_date) AS quarter,
        category,
        ROUND(SUM(amount * rate), 2)       AS total_usd
    FROM expense_claims
    JOIN fx_rates ON fx_rates.currency = expense_claims.currency
    GROUP BY DATE_TRUNC('quarter', submit_date), category
    ORDER BY quarter, category
),

-- 4. FX Scenario Analysis
scenario_analysis AS (
    SELECT
        category,
        ROUND(SUM(CASE WHEN expense_claims.currency = 'USD' THEN amount ELSE amount * rate * 0.90 END), 2) AS fx_down_10pct,
        ROUND(SUM(CASE WHEN expense_claims.currency = 'USD' THEN amount ELSE amount * rate * 0.95 END), 2) AS fx_down_5pct,
        ROUND(SUM(amount * rate), 2)                                                                        AS base_case,
        ROUND(SUM(CASE WHEN expense_claims.currency = 'USD' THEN amount ELSE amount * rate * 1.05 END), 2) AS fx_up_5pct,
        ROUND(SUM(CASE WHEN expense_claims.currency = 'USD' THEN amount ELSE amount * rate * 1.10 END), 2) AS fx_up_10pct
    FROM expense_claims
    JOIN fx_rates ON fx_rates.currency = expense_claims.currency
    GROUP BY category
)

-- Return all four result sets
SELECT * FROM fx_exposure;
SELECT * FROM category_spending;
SELECT * FROM quarterly_trend;
SELECT * FROM scenario_analysis;
