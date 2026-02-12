/*
File: 07_repeat_customer_revenue_orders.sql
Purpose: Calculate number of orders and revenue from one-time vs repeat customers
*/

WITH customer_order_counts AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
order_revenue AS (
    SELECT
        o.customer_id,
        o.order_id,
        SUM(oi.price + oi.freight_value) AS order_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id, o.order_id
),
customer_type_mapping AS (
    SELECT
        c.customer_unique_id,
        CASE 
            WHEN total_orders = 1 THEN 'One-Time Customer'
            ELSE 'Repeat Customer'
        END AS customer_type
    FROM customer_order_counts c
)

SELECT
    ctm.customer_type,
    COUNT(DISTINCT orv.order_id) AS total_orders,
    ROUND(SUM(orv.order_revenue), 2) AS total_revenue
FROM order_revenue orv
JOIN customers c
    ON orv.customer_id = c.customer_id
JOIN customer_type_mapping ctm
    ON c.customer_unique_id = ctm.customer_unique_id
GROUP BY ctm.customer_type;
/*
Returned: "customer_type","total_orders","total_revenue"
"One-Time Customer","90557","14555586.29"
"Repeat Customer","5921","864187.46"
*/

/* GPT Interpretation:
1️⃣ Orders & Revenue Split
Customer Type	Orders	Revenue	% of Orders	% of Revenue
One-Time Customer	90,557	14,555,586.29	93.8%	94.9%
Repeat Customer	5,921	864,187.46	6.2%	5.1%

Percentages calculated relative to total orders/revenue.
🔹 2️⃣ Key Insights
Revenue is heavily acquisition-driven:
Only 3% of customers are repeat buyers.
Repeat customers contribute only ~5% of total revenue.

One-time buyers dominate both order volume and revenue:
The marketplace’s growth relies primarily on attracting new customers.
Retention is a huge opportunity:
If even a small fraction of one-time buyers became repeat buyers, revenue could increase substantially.
Loyalty programs, post-purchase offers, or subscription incentives could yield high ROI.

🔹 3️⃣ Business-Level Interpretation
This is a classic “low retention, high acquisition” marketplace.
Strategies to improve repeat purchase rates could be more cost-effective than acquiring new customers.
Insights like this are exactly what recruiters/clients look for — you’re connecting customers → orders → revenue, and showing actionable business recommendation
*/