-- ============================================================
-- 09_zscore_anomaly_detection.sql
-- Z-Score Anomaly Detection on Employee Expense Claims
-- Flags: Normal (|z| ≤ 1) | Unusual (|z| > 1) | Investigate (|z| > 2)
-- ============================================================

WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),
z_score_summary AS (
    SELECT
        claimid,
        employeeid,
        category,
        amount,
        approved_by,
        ROUND(
            (amount * rate - AVG(amount * rate) OVER (PARTITION BY category))
            / STDDEV(amount * rate) OVER (PARTITION BY category),
        3) AS z_score
    FROM expense_claims
    JOIN fx_rates ON fx_rates.currency = expense_claims.currency
),
flagged_claims AS (
    SELECT
        claimid,
        employeeid,
        approved_by,
        category,
        amount,
        z_score,
        CASE
            WHEN ABS(z_score) > 2 THEN 'Investigate'
            WHEN ABS(z_score) > 1 THEN 'Unusual'
            ELSE 'Normal'
        END AS flag
    FROM z_score_summary
),
total_claims AS (
    SELECT DISTINCT
        category,
        flag,
        ROUND(
            (COUNT(*) OVER (PARTITION BY category, flag) * 100.0)
            / COUNT(*) OVER (PARTITION BY category),
        2) AS pct_claims
    FROM flagged_claims
    ORDER BY category
)
SELECT * FROM total_claims;
