-- ============================================================
-- 06_ar_aging.sql
-- Accounts Receivable Aging Schedule with FX Conversion
-- Currencies: USD, EUR, GBP, CAD, AUD
-- ============================================================

WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),
unpaid_dues AS (
    SELECT
        customer,
        currency,
        amount,
        MAX(due_date) OVER () - due_date AS days_overdue,
        CASE
            WHEN MAX(due_date) OVER () - due_date <  '0 days'  THEN 'Current'
            WHEN MAX(due_date) OVER () - due_date <= '30 days' THEN '1-30 days'
            WHEN MAX(due_date) OVER () - due_date <= '60 days' THEN '31-60 days'
            WHEN MAX(due_date) OVER () - due_date <= '90 days' THEN '61-90 days'
            ELSE '90+ days'
        END AS aging_bucket
    FROM ar
    WHERE status IN ('Open', 'Partial')
),
converted AS (
    SELECT
        customer,
        aging_bucket,
        ROUND(amount * rate, 2) AS amount_usd
    FROM unpaid_dues
    JOIN fx_rates ON unpaid_dues.currency = fx_rates.currency
)
SELECT
    customer,
    aging_bucket,
    COUNT(*)                    AS invoice_count,
    ROUND(SUM(amount_usd), 2)  AS total_outstanding_usd
FROM converted
GROUP BY customer, aging_bucket
ORDER BY customer, aging_bucket;
