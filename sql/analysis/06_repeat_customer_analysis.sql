/*
File: 06_repeat_customer_analysis.sql
Purpose: Identify repeat vs one-time customers based on number of orders.
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
)

SELECT
    CASE 
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_customers
FROM customer_order_counts
GROUP BY customer_type;
/*
Returned: "customer_type","customer_count","percentage_of_customers"
"One-Time Customer","90557","97.00"
"Repeat Customer","2801","3.00"
*/
/* Notes:
One-Time Customers: 90,557 → 97% of all customers
Repeat Customers: 2,801 → 3% of all customers

Insight:
The vast majority of buyers only purchase once. Repeat purchasing is extremely rare in this dataset.
This is a critical observation for any business: customer retention is very low */

/* GPT Interpretation:
What This Means for the Business

    High acquisition-dependent revenue:
    Revenue mostly comes from attracting new customers, not repeat business.

    Retention opportunity:
    If even a small fraction of one-time customers can be converted into repeat buyers, total revenue could increase significantly.

    Marketing focus:
    Loyalty programs, personalized offers, or subscription incentives could pay off big here.
*/