-- ============================================================
-- 02_monthly_revenue_growth.sql
-- Month-over-Month Revenue Growth using LAG window function
-- ============================================================

SELECT
    DATE_TRUNC('month', txn_date) AS month,
    SUM(credit)                   AS revenue,
    ROUND(
        (SUM(credit) - LAG(SUM(credit)) OVER (ORDER BY DATE_TRUNC('month', txn_date)))
        / LAG(SUM(credit)) OVER (ORDER BY DATE_TRUNC('month', txn_date)) * 100, 2
    )                             AS revenue_growth_pct
FROM general_ledger
WHERE account_name IN ('Sales Revenue', 'Online Sales')
GROUP BY DATE_TRUNC('month', txn_date)
ORDER BY month;
