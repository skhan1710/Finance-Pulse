-- ============================================================
-- 01_pl_department_breakdown.sql
-- Department P&L: Revenue, COGS, Gross Profit, Net Margin
-- ============================================================

WITH revenue AS (
    SELECT dept, SUM(credit) AS total_revenue
    FROM general_ledger
    WHERE account_name IN ('Sales Revenue', 'Online Sales')
    GROUP BY dept
),
cogs AS (
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
)
SELECT
    revenue.dept,
    total_revenue,
    cogs,
    (total_revenue - cogs)                                   AS gross_profit,
    ROUND((total_revenue - cogs) / total_revenue * 100, 2)   AS gross_margin,
    total_exp                                                AS operating_expenses,
    (total_revenue - cogs - total_exp)                       AS net_income,
    ROUND((total_revenue - cogs - total_exp) / total_revenue * 100, 2) AS net_margin
FROM revenue
JOIN cogs              ON revenue.dept = cogs.dept
JOIN operating_expenses ON revenue.dept = operating_expenses.dept
ORDER BY net_income DESC;
