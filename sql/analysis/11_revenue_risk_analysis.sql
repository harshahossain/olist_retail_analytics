/*
File: 11_revenue_risk_analysis.sql
Purpose: Analyze potential revenue risks by identifying high & low satisfaction orders by average scores
         Assess how much revenue is concentrated in product categories with below-average customer satisfaction.
*/
WITH category_reviews AS (
    SELECT 
        p.product_category_name,
        ROUND(AVG(r.review_score), 2) AS avg_review_score
    FROM order_reviews r
    JOIN orders o ON r.order_id = o.order_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
),

category_revenue AS (
    SELECT 
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
),

combined AS (
    SELECT 
        cr.product_category_name,
        cr.avg_review_score,
        crev.total_revenue,
        CASE 
            WHEN cr.avg_review_score >= 4.0 THEN 'High Satisfaction'
            ELSE 'Low Satisfaction'
        END AS satisfaction_segment
    FROM category_reviews cr
    JOIN category_revenue crev 
        ON cr.product_category_name = crev.product_category_name
)

SELECT 
    satisfaction_segment,
    ROUND(SUM(total_revenue), 2) AS segment_revenue,
    ROUND(
        SUM(total_revenue) * 100.0 / 
        SUM(SUM(total_revenue)) OVER (), 2
    ) AS revenue_percentage
FROM combined
GROUP BY satisfaction_segment
ORDER BY revenue_percentage DESC;

/* Returned: "satisfaction_segment","segment_revenue","revenue_percentage"
"High Satisfaction","11081915.52","70.88"
"Low Satisfaction","4553932.63","29.12"
*/

/* GPT Interpretation:
Assess how much revenue is tied to product categories with varying customer satisfaction levels.
Product categories were segmented into:
High Satisfaction → Avg Review Score ≥ 4.0
Low Satisfaction → Avg Review Score < 4.0
Revenue was then aggregated by segment.

Results
Segment	Revenue	% of Total Revenue
High Satisfaction	11.08M	70.88%
Low Satisfaction	4.55M	29.12%

Key Insight
Nearly 29% of total revenue is generated from categories with below-4.0 average ratings.
Business Interpretation
While the majority of revenue comes from high-performing categories, a significant portion of total revenue is tied to weaker satisfaction segments.

This creates:
Brand perception risk
Potential churn risk
Revenue vulnerability if customer experience deteriorates

Strategic Implication
Improving satisfaction in low-rated categories could:
Protect nearly one-third of total revenue
Improve retention potential
Strengthen long-term revenue stability
*/