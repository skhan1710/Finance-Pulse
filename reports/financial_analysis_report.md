# Financial Pulse — Analysis Report
**Period Covered:** January 2023 – June 2025  
**Dataset:** Synthetic financial data across general ledger, AR/AP, budget forecast, and expense claims  
**Prepared by:** Safwan Khan

## Executive Summary

Revenue for the most recent quarter came in at $189,803.67, down 2.6% from the prior quarter. The more important story is that net income rose 12.4% to $62,985.12 over the same period, suggesting the business got more disciplined on costs even as sales dipped. Gross margin reached 82.41% and net margin hit 31.51%, both up significantly quarter-over-quarter.

Three issues warrant attention heading into the next period:

1. **Working capital concentration risk.** 86.8% of accounts receivable sits in the 90+ day bucket, totaling $2,005,783.98 of the $2.28M balance. Two customers, Soylent and Globex, account for just under $1M of that exposure combined. Without active collection effort, this becomes a cash flow problem.

2. **Marketing overspending.** Marketing exceeded budget in four consecutive quarters across 2024 and 2025. This is not a one-time variance. It is a pattern that suggests the original budget assumptions no longer reflect how that department operates.

3. **Expense flagging rate.** 36.8% of employee expense claims were flagged as Unusual or Investigate under z-score analysis. That rate is high enough to justify a structured internal review rather than case-by-case handling.


## Revenue & Profitability

### Overall Trend

Revenue across the full dataset ranged from a low of $42,630.88 (July 2023) to a high of $87,267.76 (March 2024). Month-over-month growth was volatile throughout, with swings of 20 to 30% in either direction not being uncommon. The 4-month moving average shows the underlying trajectory was broadly flat with a modest upward bias through 2023 and into early 2024, followed by a softer patch in mid-to-late 2024.

The sharpest MoM increase was +69.15% in August 2023, when revenue jumped from $42,630.88 to $72,110.93. The steepest decline was -30.66% in April 2025, when revenue fell from $74,338.09 to $51,549.60. The 4-month moving average smooths both of these extremes, which is precisely its value. It shows the underlying trend was far more stable than the month-to-month swings suggest.

### The September 2024 Near-Loss

September 2024 was the closest the business came to a loss in the dataset, with net income of just $136.35 on revenue of $53,235.18. Total expenses that month hit $53,098.83, the highest expense figure in the dataset relative to revenue. The squeeze came from the operating expense side, not a revenue collapse. Revenue was within a normal range; costs simply ran up against it.

In a real business context, this pattern typically points to a one-time charge: unplanned payroll, a large travel event, or a cost accrual hitting in a single period. The analytical takeaway is that the business was not structurally unprofitable in September. It absorbed an unusual cost that compressed a single month's result, and margins recovered in the months that followed.

### February 2025 Margin Compression

February 2025 stands out for a different reason. Revenue of $60,094.24 was not dramatically low, but total expenses hit $49,630.91, leaving a net income of just $10,463.33 and a net margin of 17.4%. The expense load that month was disproportionately high relative to revenue, producing one of the weakest margin results outside of the September 2024 period.

This kind of isolated expense spike, without a corresponding revenue increase, is the signature of a one-time cost event: a write-off, an inventory adjustment, or a catch-up accrual that concentrated costs into a single period. It does not appear to reflect a structural deterioration in the business's cost base, given that margins recovered in the following months.

### Key Monthly Figures

| Month | Revenue | Net Income | MoM Growth |
|-------|---------|------------|------------|
| Jan 2023 | $72,606.93 | $25,890.67 | +1,488.73% |
| Aug 2023 | $66,380.23 | $27,290.12 | +34.63% |
| Dec 2023 | $84,203.13 | $46,146.69 | +2.86% |
| Mar 2024 | $87,267.76 | $48,979.08 | +32.59% |
| Sep 2024 | $53,235.18 | $136.35 | +9.83% |
| Feb 2025 | $60,094.24 | $10,463.33 | -7.68% |
| Apr 2025 | $52,754.56 | $11,734.02 | -24.39% |
| May 2025 | $74,721.63 | $32,028.91 | +41.64% |
| Jun 2025 | $62,327.48 | $19,222.19 | -16.59% |

---

## Department P&L

### Net Margin by Department

| Department | Revenue | COGS | Gross Profit | GM% | Operating Expenses | Net Income | Net Margin |
|------------|---------|------|--------------|-----|--------------------|------------|------------|
| Finance | $361,822.40 | $68,528.65 | $293,293.75 | 81.06% | $131,014.51 | $162,279.24 | 44.85% |
| Operations | $321,762.59 | $49,254.35 | $272,508.24 | 84.69% | $126,876.33 | $145,631.91 | 45.26% |
| Sales | $327,128.81 | $54,345.88 | $272,782.93 | 83.39% | $150,612.76 | $122,170.17 | 37.35% |
| IT | $323,974.21 | $63,932.48 | $260,041.73 | 80.27% | $137,960.94 | $122,080.79 | 37.68% |
| Marketing | $318,475.76 | $70,065.35 | $248,410.41 | 78.00% | $130,579.40 | $117,831.01 | 37.00% |
| HR | $320,118.16 | $91,809.62 | $228,308.54 | 71.32% | $135,260.20 | $93,048.34 | 29.07% |

### What the Numbers Say

**Operations** leads on net margin at 45.26%, with the lowest COGS in the company at $49,254. Nearly $42,000 less than HR on a similar revenue base. That cost structure advantage is the primary driver of its margin leadership.

**Finance** generated the highest total revenue at $361,822 and the highest net income at $162,279. A 44.85% net margin on the largest revenue base makes Finance the strongest overall performer by any measure.

**HR** is the concern. Revenue of $320,118 is in line with other departments, but COGS of $91,810 is the highest in the company, about $28,000 above the next highest (Marketing at $70,065). That cost load compresses gross margin to 71.32% before operating expenses enter the picture, leaving HR with the lowest net margin at 29.07%. In a real business, HR COGS of this magnitude would typically reflect direct service delivery costs: contractor spend, benefits administration, or outsourced functions coded to cost of goods. The structure of the cost, not just its size, would be the first thing to investigate.

**Sales** carries the highest operating expenses at $150,613, roughly $24,000 more than Operations on a similar revenue base. This is consistent with a sales function running client-facing activities, travel, and commission structures that naturally inflate operating costs. The 37.35% net margin versus Operations' 45.26% reflects the cost of revenue generation rather than inefficiency.


## Budget Variance Analysis

### Company-Level

The most recent quarter on record (Q4 2025) came in at $485K actual against a $500K budget, a favorable variance of $15K or -3%. That is a reasonable outcome and suggests the business closed the year broadly in control of its spend.

The full-year picture across 2024 and into 2025 is more mixed, driven by two departments pulling in opposite directions.

### Department-Level Patterns

**Marketing — Persistent Overspending**

Marketing exceeded its budget in four consecutive quarters:

| Quarter | Variance vs. Budget |
|---------|-------------------|
| Q2 2024 | +11.72% |
| Q4 2024 | +12.42% |
| Q1 2025 | +14.58% |
| Q2 2025 | +11.08% |

Four consecutive quarters of double-digit overspending tells you more about the budget than it does about the department. When variance is this consistent, the assumption should be that the budget itself is wrong. Either the original plan was built too conservatively, or the department's scope expanded without a corresponding revision. Carrying a budget that everyone knows is wrong creates planning noise. The right response heading into the next cycle is a zero-based reforecast of Marketing's actual cost structure, not another round of variance explanations.

**Sales — Consistently Ahead of Budget**

Sales ran ahead of budget every quarter in 2024:

| Quarter | Variance vs. Budget |
|---------|-------------------|
| Q1 2024 | +13.06% |
| Q2 2024 | +8.22% |
| Q3 2024 | +6.89% |
| Q4 2024 | +0.35% |

Positive variance in Sales is the good version of the same problem Marketing has. The budget does not reflect reality. In this case it means Sales is likely being underbudgeted, possibly as a conservative planning posture. The pattern warrants a budget reset for the next planning cycle, both to give Sales an accurate target and to improve overall forecast reliability.

**Finance — Single Large Negative Variance**

Finance in Q4 2024 posted the largest single-quarter negative variance in the dataset: -$21,609 against budget, or -18.36%. Outside of that quarter, Finance's budget performance was broadly stable. A single large negative variance in an otherwise well-controlled department is the profile of a one-time event: a year-end audit fee, an accrual reversal, or a headcount change that landed in Q4. Finance does not have a systemic budget problem. It had one unusual quarter that skews the full-year picture.

**Recommendation**

The combined evidence points to a planning process that needs recalibration rather than a business that is out of control. Marketing is structurally over budget, Sales is structurally under budget, and Finance absorbed a one-time hit. A mid-year reforecast cadence, particularly for Marketing, would significantly improve the signal quality of variance reporting going forward.


## AR/AP Aging & Working Capital

### Receivables

Total open receivables stand at **$2.28M** across 599 invoices. The aging breakdown is the concern:

| Aging Bucket | Invoice Count | Amount (USD) |
|--------------|--------------|--------------|
| 90+ days | 520 | $2,005,783.98 |
| 61–90 days | 30 | $81,876.06 |
| 31–60 days | 22 | $92,810.86 |
| 1–30 days | 27 | $100,487.86 |

86.8% of invoices by count — and 87.9% by dollar value — fall in the 90+ day bucket. In a real business, a figure this high would immediately raise questions about whether payment terms are being enforced, whether specific customers are in dispute, or whether the AR balance is simply being allowed to age passively. The concentration in two customers makes this easier to act on. These are not diffuse, hard-to-collect balances spread across dozens of accounts. Two targeted collection conversations could meaningfully move the needle on working capital.

**Customer Concentration**

| Customer | Outstanding Balance |
|----------|-------------------|
| Soylent | $499,276.25 |
| Globex | $497,083.27 |
| Initech | $438,486.13 |
| Acme | $423,441.63 |
| Umbrella | $422,670.48 |

Soylent and Globex together account for $996,359.52, or 43.7% of total receivables. That level of concentration in two customers is a meaningful risk. If either slows payments further or disputes an invoice, the impact on working capital is immediate and material.

### Payables

Total open payables stand at **$1.35M** across 543 invoices:

| Aging Bucket | Invoice Count | Amount (USD) |
|--------------|--------------|--------------|
| 90+ days | 484 | $1,217,257.97 |
| 61–90 days | 20 | $44,870.17 |
| 31–60 days | 16 | $41,685.38 |
| 1–30 days | 23 | $44,984.17 |

89.1% of AP invoices are 90+ days overdue. The fact that both AR and AP show the same aging concentration pattern is analytically interesting. It suggests this may reflect the payment culture of the business broadly, rather than a specific issue on either side. A business that stretches both receivables and payables symmetrically is effectively using its entire supplier and customer base to manage liquidity. That works until a key vendor enforces terms or a key customer escalates a dispute.

**Vendor Concentration**

| Vendor | Outstanding Balance |
|--------|-------------------|
| BluePrints | $325,385.77 |
| ABC Supplies | $281,907.22 |
| TechMart | $254,266.82 |
| Global Office | $253,822.28 |
| Fast Travel | $232,666.79 |

BluePrints at $325,385.77 is the largest AP exposure. Unlike the receivables side where two customers dominate, payables are more evenly spread across five vendors, which slightly reduces concentration risk but does not change the overall aging concern.

### Working Capital Position

With an AR/AP ratio of 1.7, the headline position looks healthy. The business is owed significantly more than it owes. But the 90+ day concentration on both sides means this ratio flatters the actual liquidity position. Much of the receivables balance may not convert to cash on a predictable timeline, while the stretched payables represent obligations that could become urgent if vendors begin enforcing terms.


## Expense Analysis & Anomaly Detection

### Category Overview

Total employee expenses across 1,000 claims came to $378,792.44 converted to USD.

| Category | Claims | Avg Claim (USD) | Base Case Total |
|----------|--------|-----------------|----------------|
| Supplies | 206 | $391.86 | $80,723.37 |
| Meals | 199 | $388.29 | $77,269.22 |
| Travel | 203 | $367.75 | $74,653.09 |
| Entertainment | 195 | $378.56 | $73,818.29 |
| Training | 197 | $367.15 | $72,328.48 |

Supplies is the largest category by total spend at $80,723.37. Average claim sizes are consistent across categories, ranging from $367 to $392, which suggests volume of claims rather than individual claim sizes is the primary driver of category differences.

### FX Exposure

Of the $378,792.44 in total expense claims, **$294,799.48 (77.83%)** was denominated in non-USD currencies. Only $83,992.96 was in USD. This means the vast majority of employee expense spend is exposed to exchange rate movement, which makes the FX scenario analysis directly relevant to budgeting.

### Z-Score Anomaly Detection

Each claim was benchmarked against the average and standard deviation of its own category. Claims were then classified into three tiers:

| Flag | Claims | Total Value |
|------|--------|-------------|
| Normal (\|z\| ≤ 1) | 632 | $232K |
| Unusual (\|z\| > 1) | 335 | $116K |
| Investigate (\|z\| > 2) | 33 | $30K |

**36.8% of all claims were flagged** as Unusual or Investigate. The Investigate tier, 33 claims totaling $30K, is the highest priority for review. These are claims sitting more than two standard deviations above their category mean.

It is worth being clear about what z-score flagging does and does not tell you. A high z-score does not mean a claim is fraudulent. It means it is unusual relative to the category peer group. A legitimate large conference registration would trigger a flag in the Training category just as a questionable expense would. The value of this model is that it surfaces the claims most deserving of human review, rather than requiring a reviewer to manually sort through all 1,000 submissions.

**Z-Score Distribution by Category**

| Category | Normal | Unusual | Investigate |
|----------|--------|---------|-------------|
| Entertainment | 65.13% | 30.77% | 4.10% |
| Meals | 58.29% | 39.20% | 2.51% |
| Supplies | 63.59% | 33.98% | 2.43% |
| Training | 63.45% | 33.50% | 3.05% |
| Travel | 67.00% | 28.57% | 4.43% |

Travel has the highest Investigate rate at 4.43%, followed by Entertainment at 4.10%. Both are categories where individual spend is more variable by nature, which makes the flagging rate less surprising but no less worth reviewing.

### Top 10 Investigate-Flagged Claims

| Claim ID | Employee ID | Approved By | Category | Amount (USD) | Z-Score |
|----------|-------------|-------------|----------|--------------|---------|
| CL30690 | E1109 | MgrB | Training | $1,013.08 | 2.69 |
| CL30438 | E1000 | MgrA | Training | $1,008.91 | 2.68 |
| CL30072 | E1021 | MgrA | Training | $992.86 | 2.61 |
| CL30010 | E1106 | MgrB | Travel | $967.99 | 2.56 |
| CL30228 | E1077 | MgrA | Training | $973.46 | 2.53 |
| CL30537 | E1071 | MgrC | Training | $974.29 | 2.53 |
| CL30647 | E1023 | MgrB | Travel | $948.21 | 2.47 |
| CL30493 | E1009 | MgrC | Travel | $942.96 | 2.45 |
| CL30742 | E1105 | MgrA | Training | $947.22 | 2.42 |
| CL30710 | E1090 | MgrB | Supplies | $961.03 | 2.40 |

Six of the top 10 flagged claims are in Training and three are in Travel, the two categories where individual amounts are most likely to spike for legitimate reasons such as conference registrations or international trips. MgrA appears as approver on four of the top 10, which is worth noting. Not as evidence of wrongdoing, but as a prompt to confirm those approvals followed standard authorization procedures.

### What This Means in Practice

A 36.8% flag rate across 1,000 claims is high enough that reviewing every flagged claim manually is not practical. The right approach is to prioritize the Investigate tier, 33 claims totaling $30K, for immediate review, use the Unusual tier as a secondary watchlist, and focus particular attention on any approver who appears repeatedly across Investigate-flagged claims. Repeated approval of statistical outliers by the same manager is a stronger signal than the dollar amount alone.


## FX Sensitivity Analysis

77.83% of total expense spend is denominated in non-USD currencies, making exchange rate movement a meaningful planning variable rather than a minor footnote.

| Category | -10% FX | -5% FX | Base Case | +5% FX | +10% FX |
|----------|---------|--------|-----------|--------|---------|
| Supplies | $74,818.27 | $77,770.82 | $80,723.37 | $83,675.91 | $86,628.46 |
| Meals | $70,982.14 | $74,125.68 | $77,269.22 | $80,412.76 | $83,556.30 |
| Travel | $68,537.89 | $71,595.49 | $74,653.09 | $77,710.69 | $80,768.29 |
| Entertainment | $68,038.06 | $70,928.17 | $73,818.29 | $76,708.40 | $79,598.51 |
| Training | $66,936.13 | $69,632.30 | $72,328.48 | $75,024.66 | $77,720.83 |

A 10% adverse FX movement would increase total expense spend by approximately $30,700 across all five categories. A 10% favorable move would reduce it by a similar amount. Given that nearly 78% of claims are non-USD denominated, this sensitivity is not a tail risk — it is a planning reality that should be reflected in any expense budget that includes international headcount or travel.

The practical implication is straightforward: any expense budget denominated in USD but incurred partly in foreign currencies should carry a FX sensitivity buffer, particularly for Travel and Supplies where non-USD spend tends to be most variable.

---

*This report was produced from synthetic financial data modeled after real-world enterprise structures. All figures are for analytical and portfolio demonstration purposes only.*
