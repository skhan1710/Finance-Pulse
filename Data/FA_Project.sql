WITH revenue AS (
    SELECT dept, SUM(credit) AS total_revenue
    FROM general_ledger
    WHERE account_name IN ('Sales Revenue', 'Online Sales')
    GROUP BY dept
),
COGS AS (
    SELECT dept, SUM(debit) AS cogs
    FROM general_ledger
    WHERE account_name = 'COGS'
    GROUP BY dept
),
operating_expenses AS (
    SELECT dept, SUM(debit) AS total_exp
    FROM general_ledger
    WHERE account_name IN ('Payroll Expense', 'Travel Expense')
    GROUP BY dept
),
monthly_revenue AS (
SELECT 
    DATE_TRUNC('month', txn_date) AS month,
    SUM(credit) AS revenue,
    ROUND(
        (SUM(credit) - LAG(SUM(credit)) OVER (ORDER BY DATE_TRUNC('month', txn_date)))
        / LAG(SUM(credit)) OVER (ORDER BY DATE_TRUNC('month', txn_date)) * 100, 2
    ) AS revenue_growth_pct
FROM general_ledger
WHERE account_name IN ('Sales Revenue', 'Online Sales')
GROUP BY month
ORDER BY month
),
t1 AS (
    SELECT 
        DATE_TRUNC('month', txn_date) AS month,
        SUM(credit) AS revenue
    FROM general_ledger
    WHERE account_name IN ('Sales Revenue','Online Sales')
    GROUP BY month 
	ORDER BY month
),
moving_average_forecast AS ( 
SELECT 
	month, 
	revenue,
	ROUND(
		AVG(revenue) OVER (
			ORDER BY month ROWS BETWEEN 4 PRECEDING AND 1 PRECEDING
			),2
		) AS mvg_revenue
FROM t1
)
SELECT 
    revenue.dept, 
    total_revenue, 
    cogs, 
    (total_revenue - cogs) AS gross_profit,
    ROUND((total_revenue - cogs) / total_revenue * 100, 2) AS gross_margin,
    total_exp AS operating_expenses,
    (total_revenue - cogs - total_exp) AS net_income,
    ROUND((total_revenue - cogs - total_exp) / total_revenue * 100, 2) AS net_margin
FROM revenue
    JOIN COGS ON revenue.dept = COGS.dept
    JOIN operating_expenses ON revenue.dept = operating_expenses.dept
ORDER BY net_income DESC;
SELECT 
    DATE_TRUNC('month', txn_date) AS months,
    SUM(CASE WHEN account_name IN ('Sales Revenue', 'Online Sales') THEN credit ELSE 0 END) AS revenue,
    SUM(CASE WHEN account_name IN ('COGS', 'Payroll Expense', 'Travel Expense') THEN debit ELSE 0 END) AS total_expenses,
    SUM(CASE WHEN account_name IN ('Sales Revenue', 'Online Sales') THEN credit ELSE 0 END)
        - SUM(CASE WHEN account_name IN ('COGS', 'Payroll Expense', 'Travel Expense') THEN debit ELSE 0 END) AS net_income
FROM general_ledger
GROUP BY DATE_TRUNC('month', txn_date)
ORDER BY months;

SELECT 
    fiscal_year, 
    quarter,
	dept,
    SUM(budget_usd) AS total_budget,
    SUM(actual_usd) AS total_actual,
    SUM(variance_usd) AS variance,
    ROUND(SUM(variance_usd) / SUM(budget_usd) * 100, 2) AS variance_pct_of_budget
FROM budget_forecast
GROUP BY fiscal_year, quarter, dept
ORDER BY fiscal_year, quarter, dept;

WITH gl_bf_merge AS (SELECT fiscal_year,quarter,budget_forecast.dept,
		account_name,
		debit,credit,
		budget_usd,
		forecast_usd,
		actual_usd,
		variance_usd
FROM general_ledger
JOIN budget_forecast
	ON general_ledger.dept = budget_forecast.dept
	AND EXTRACT(QUARTER FROM general_ledger.txn_date) = budget_forecast.quarter::INTEGER
)
SELECT fiscal_year, quarter, dept, account_name,
    SUM(debit) AS total_debit,
    SUM(credit) AS total_credit
FROM gl_bf_merge
GROUP BY fiscal_year, quarter, dept, account_name;

WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),
unpaid_dues AS (
    SELECT customer, currency, amount,
        MAX(due_date) OVER () - due_date AS days_overdue,
        CASE 
            WHEN MAX(due_date) OVER () - due_date < '0 days' THEN 'Current'
            WHEN MAX(due_date) OVER () - due_date <= '30 days' THEN '1-30 days'
            WHEN MAX(due_date) OVER () - due_date <= '60 days' THEN '31-60 days'
            WHEN MAX(due_date) OVER () - due_date <= '90 days' THEN '61-90 days'
            ELSE '90+ days'
        END AS aging_bucket
    FROM ar
    WHERE status IN ('Open', 'Partial')
),
converted AS (
    SELECT customer, aging_bucket, 
        ROUND(amount * rate, 2) AS amount_usd
    FROM unpaid_dues
    JOIN fx_rates ON unpaid_dues.currency = fx_rates.currency
),
receivables AS (
	SELECT customer, ROUND(SUM(amount)/SUM(SUM(amount)) OVER (),3) total_receivable 
	FROM ar
	WHERE status IN ('Open','Partial')
	GROUP BY customer
	ORDER BY total_receivable DESC
)
SELECT 
    customer, 
    aging_bucket,
    COUNT(*) AS invoice_count,
    ROUND(SUM(amount_usd), 2) AS total_outstanding_usd
FROM converted
GROUP BY customer, aging_bucket
ORDER BY customer, aging_bucket;

WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),
liabilities AS (
    SELECT vendor, currency, amount,
        MAX(duedate) OVER () - duedate AS days_overdue,
        CASE 
            WHEN MAX(duedate) OVER () - duedate < '0 days' THEN 'Current'
            WHEN MAX(duedate) OVER () - duedate <= '30 days' THEN '1-30 days'
            WHEN MAX(duedate) OVER () - duedate <= '60 days' THEN '31-60 days'
            WHEN MAX(duedate) OVER () - duedate <= '90 days' THEN '61-90 days'
            ELSE '90+ days'
        END AS ap_bucket
    FROM ap
    WHERE status IN ('Open', 'Partial')
),
converted AS (
    SELECT vendor, ap_bucket, 
        ROUND(amount * rate, 2) AS amount_usd
    FROM liabilities
    JOIN fx_rates ON liabilities.currency = fx_rates.currency
)
SELECT 
    vendor, 
    ap_bucket,
    COUNT(*) AS invoice_count,
    ROUND(SUM(amount_usd), 2) AS total_outstanding_usd
FROM converted
GROUP BY vendor, ap_bucket
ORDER BY vendor, ap_bucket;


WITH fx_rates AS (
    SELECT 'USD' AS currency, 1.00 AS rate
    UNION ALL SELECT 'EUR', 1.08
    UNION ALL SELECT 'GBP', 1.27
    UNION ALL SELECT 'CAD', 0.74
    UNION ALL SELECT 'AUD', 0.65
),
non_usd_total_exp AS (SELECT 
    ROUND(SUM(CASE WHEN expense_claims.currency = 'USD' THEN amount ELSE 0 END), 2) AS usd_expenses,
    ROUND(SUM(CASE WHEN expense_claims.currency != 'USD' THEN amount * rate ELSE 0 END), 2) AS non_usd_expenses,
    ROUND(SUM(CASE WHEN expense_claims.currency != 'USD' THEN amount * rate ELSE 0 END) / SUM(amount * rate) * 100, 2) AS pct_fx_exposed
FROM expense_claims
JOIN fx_rates ON fx_rates.currency = expense_claims.currency
),
category_spending_usd AS (
SELECT category, COUNT(*) AS claim_count, 
	ROUND(SUM(amount * rate), 2) AS total_amount,
    ROUND(AVG(amount* rate), 2) AS avg_claim
FROM expense_claims
JOIN fx_rates
	ON fx_rates.currency = expense_claims.currency
GROUP BY category
ORDER BY total_amount DESC 
),
quarterly_trend AS (SELECT 
    DATE_TRUNC('quarter', submit_date) AS quarter,
    category,
    ROUND(SUM(amount * rate), 2) AS total_usd
FROM expense_claims
JOIN fx_rates ON fx_rates.currency = expense_claims.currency
GROUP BY quarter, category
ORDER BY quarter, category
),
scenerio_analysis AS (
SELECT category,
    ROUND(SUM(CASE 
        WHEN expense_claims.currency = 'USD' THEN amount 
        ELSE amount * rate * 0.90 
    END), 2) AS fx_down_10pct,
    ROUND(SUM(CASE 
        WHEN expense_claims.currency = 'USD' THEN amount 
        ELSE amount * rate * 0.95 
    END), 2) AS fx_down_5pct,
    ROUND(SUM(amount * rate), 2) AS base_case,
    ROUND(SUM(CASE 
        WHEN expense_claims.currency = 'USD' THEN amount 
        ELSE amount * rate * 1.05 
    END), 2) AS fx_up_5pct,
    ROUND(SUM(CASE 
        WHEN expense_claims.currency = 'USD' THEN amount 
        ELSE amount * rate * 1.10 
    END), 2) AS fx_up_10pct
FROM expense_claims
JOIN fx_rates ON fx_rates.currency = expense_claims.currency
GROUP BY category
),
z_score_summary AS (SELECT claimid, employeeid,category, amount,approved_by,
    ROUND((amount * rate - AVG(amount * rate) OVER (PARTITION BY category)) 
    / STDDEV(amount * rate) OVER (PARTITION BY category), 3) AS z_score
FROM expense_claims
JOIN fx_rates ON fx_rates.currency = expense_claims.currency
),
flagged_claims AS  (SELECT claimid, employeeid,approved_by, category,amount,z_score,
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
	    (COUNT(*) OVER(PARTITION BY category, flag) * 100.0) / 
	    COUNT(*) OVER(PARTITION BY category), 2) AS "%claims"
FROM flagged_claims
ORDER BY category
)
SELECT *
FROM total_claims