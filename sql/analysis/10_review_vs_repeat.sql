/*
File: 10_review_vs_repeat.sql
Purpose: Check if high-rated customers are more likely to repeat
*/

WITH customer_review_score AS (
    SELECT
        c.customer_unique_id,
        AVG(orv.review_score) AS avg_review_score
    FROM order_reviews orv
    JOIN orders o ON orv.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),
customer_order_counts AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    CASE WHEN coc.total_orders = 1 THEN 'One-Time' ELSE 'Repeat' END AS customer_type,
    ROUND(AVG(crs.avg_review_score)::numeric, 2) AS avg_review_score
FROM customer_review_score crs
JOIN customer_order_counts coc ON crs.customer_unique_id = coc.customer_unique_id
GROUP BY customer_type;
/*
Returned: "customer_type","avg_review_score"
"One-Time","4.15"
"Repeat","4.20"
*/

/* GPT Interpretation:
| Customer Type | Avg Review Score |
| ------------- | ---------------- |
| One-Time      | 4.15             |
| Repeat        | 4.20             |

