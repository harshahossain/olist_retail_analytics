/*
File: 01_revenue_analysis.sql
Purpose: Analyze overall revenue performance and sales trends.
Revenue is defined as SUM(payment_value) from order_payments.
*/

-- Total revenue generated across all orders
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM order_payments;
-- Returned: total_revenue: 16008872.12

-- Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;
-- Returned: total_orders: 99441

-- Average revenue per order
SELECT 
    ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM order_payments;
-- Returned: avg_order_value: 160.99

-- Monthly revenue trend
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(p.payment_value), 2) AS monthly_revenue
FROM orders o
JOIN order_payments p 
    ON o.order_id = p.order_id
GROUP BY order_month
ORDER BY order_month;
/* Returned: "order_month","monthly_revenue"
"2016-09-01 00:00:00","252.24"
"2016-10-01 00:00:00","59090.48"
"2016-12-01 00:00:00","19.62"
"2017-01-01 00:00:00","138488.04"
"2017-02-01 00:00:00","291908.01"
"2017-03-01 00:00:00","449863.60"
"2017-04-01 00:00:00","417788.03"
"2017-05-01 00:00:00","592918.82"
"2017-06-01 00:00:00","511276.38"
"2017-07-01 00:00:00","592382.92"
"2017-08-01 00:00:00","674396.32"
"2017-09-01 00:00:00","727762.45"
"2017-10-01 00:00:00","779677.88"
"2017-11-01 00:00:00","1194882.80"
"2017-12-01 00:00:00","878401.48"
"2018-01-01 00:00:00","1115004.18"
"2018-02-01 00:00:00","992463.34"
"2018-03-01 00:00:00","1159652.12"
"2018-04-01 00:00:00","1160785.48"
"2018-05-01 00:00:00","1153982.15"
"2018-06-01 00:00:00","1023880.50"
"2018-07-01 00:00:00","1066540.75"
"2018-08-01 00:00:00","1022425.32"
"2018-09-01 00:00:00","4439.54"
"2018-10-01 00:00:00","589.67" */

-- ===========================================
/* 
Notes: 
1️. Total Revenue
Total Revenue: 16,008,872.12
That’s ~16 million (currency in BRL).
For a marketplace-style business over ~2 years, this is meaningful scale.

2️. Total Orders
Total Orders: 99,441
So roughly 100K orders generated 16M in revenue.

3️. Average Order Value (AOV)
AOV: 160.99
That’s a clean KPI.
Meaning:
On average, each customer order generates ~161 BRL.
That’s a very useful metric for:
Marketing budget planning
Customer acquisition cost benchmarking
Revenue forecasting
Already this is business language.

 4️. Monthly Revenue Trend — Real Insights
Now the interesting part.

 > Early Months (2016)
Sep 2016 → 252
Oct 2016 → 59K
Dec 2016 → 19
These are not real business performance months.

This suggests:
Platform launch period
Incomplete dataset coverage
Soft rollout
We treat 2016 as ramp-up phase.

 > 2017 → Strong Growth Phase

Looking at the pattern:

Jan 2017 → 138K
Feb 2017 → 291K
Mar 2017 → 449K
May 2017 → 592K
Aug 2017 → 674K
Oct 2017 → 779K
Nov 2017 → 1.19M

That’s aggressive growth.
Revenue scaled nearly 10x from early 2017 to late 2017.

That signals:
Marketplace expansion
Seller onboarding growth
Marketing scale-up
Increased customer adoption

> November 2017 Spike
Nov 2017 → 1,194,882
That’s your first major spike.
Likely explanation:
Black Friday.
This is exactly how analysts identify seasonal retail patterns.

 > 2018 → Stabilization Around 1M+
Most 2018 months:
~1.0M – 1.16M

That suggests:
The business matured and stabilized at ~1M monthly revenue.
That’s strong marketplace consistency.

 > Sharp Drop in Sept & Oct 2018

Sept 2018 → 4,439
Oct 2018 → 589

This is not real decline.
This is dataset cutoff.

Meaning:
Orders after certain date are incomplete
We shouldn’t interpret these as business collapse
*/