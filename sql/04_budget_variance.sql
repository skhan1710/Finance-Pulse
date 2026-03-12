-- ============================================================
-- 04_budget_variance.sql
-- Quarterly Actual vs Budget vs Forecast by Department
-- ============================================================

SELECT
    fiscal_year,
    quarter,
    dept,
    SUM(budget_usd)                                              AS total_budget,
    SUM(actual_usd)                                              AS total_actual,
    SUM(variance_usd)                                            AS variance,
    ROUND(SUM(variance_usd) / SUM(budget_usd) * 100, 2)         AS variance_pct_of_budget
FROM budget_forecast
GROUP BY fiscal_year, quarter, dept
ORDER BY fiscal_year, quarter, dept;
