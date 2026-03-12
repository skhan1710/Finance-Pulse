-- ============================================================
-- 07_ap_aging.sql
-- Accounts Payable Aging Schedule with FX Conversion
-- Currencies: USD, EUR, GBP, CAD, AUD
-- ============================================================

WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),
liabilities AS (
    SELECT
        vendor,
        currency,
        amount,
        MAX(duedate) OVER () - duedate AS days_overdue,
        CASE
            WHEN MAX(duedate) OVER () - duedate <  '0 days'  THEN 'Current'
            WHEN MAX(duedate) OVER () - duedate <= '30 days' THEN '1-30 days'
            WHEN MAX(duedate) OVER () - duedate <= '60 days' THEN '31-60 days'
            WHEN MAX(duedate) OVER () - duedate <= '90 days' THEN '61-90 days'
            ELSE '90+ days'
        END AS ap_bucket
    FROM ap
    WHERE status IN ('Open', 'Partial')
),
converted AS (
    SELECT
        vendor,
        ap_bucket,
        ROUND(amount * rate, 2) AS amount_usd
    FROM liabilities
    JOIN fx_rates ON liabilities.currency = fx_rates.currency
)
SELECT
    vendor,
    ap_bucket,
    COUNT(*)                    AS invoice_count,
    ROUND(SUM(amount_usd), 2)  AS total_outstanding_usd
FROM converted
GROUP BY vendor, ap_bucket
ORDER BY vendor, ap_bucket;
