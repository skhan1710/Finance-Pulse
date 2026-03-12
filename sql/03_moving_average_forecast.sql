-- ============================================================
-- 03_moving_average_forecast.sql
-- 4-Month Rolling Average Revenue Trend
-- ============================================================

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', txn_date) AS month,
        SUM(credit)                   AS revenue
    FROM general_ledger
    WHERE account_name IN ('Sales Revenue', 'Online Sales')
    GROUP BY DATE_TRUNC('month', txn_date)
    ORDER BY month
)
SELECT
    month,
    revenue,
    ROUND(
        AVG(revenue) OVER (
            ORDER BY month
            ROWS BETWEEN 4 PRECEDING AND 1 PRECEDING
        ), 2
    ) AS mvg_avg_revenue
FROM monthly_revenue;
