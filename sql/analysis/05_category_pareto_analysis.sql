/*
File: 05_category_pareto_analysis.sql
Purpose: Identify cumulative revenue contribution by category
to perform Pareto (80/20) analysis.
*/

WITH category_revenue AS (
    SELECT 
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM order_items oi
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
),

ranked_revenue AS (
    SELECT
        product_category_name,
        total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS overall_revenue
    FROM category_revenue
)

SELECT
    product_category_name,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        cumulative_revenue * 100.0 / overall_revenue,
        2
    ) AS cumulative_revenue_percentage
FROM ranked_revenue
ORDER BY total_revenue DESC;

/* Notes: 
At:
pet_shop → 79.77%
pcs → 81.24%
> 17 categories ≈ 80% of revenue. From beleza_saude down to pet_shop = 17 categories
That means:
With Total ≈ 70+ categories, only 17 are driving the 80% of revenue.
That's roughly ~24% of categories are responsible for 80% of revenue.
This is a classic Pareto distribution.(80/20 rule) */

/* GPT Interpretation:
Business Interpretation
This marketplace shows:
Moderate category concentration
Revenue driven primarily by a core set of categories
Long tail of low-performing categories

This is classic marketplace structure:
A strong “core catalog”
Many small niche categories contributing marginal revenue

📈 The Long Tail
Looking at the bottom:
Many categories contribute: < 0.1%, < 0.05% of revenue

Examples:
seguros_e_servicos
fashion_roupa_infanto_juvenil
cds_dvds_musicais
These are extremely small contributors.

That suggests:
Large catalog breadth
Not all categories are strategically important
Some may exist just for assortment completeness
🏆 Final Business-Level Insight

This business:
✅ Is diversified at top level
✅ Still follows Pareto principle
✅ Has a strong revenue core (~17 categories)
✅ Has a long tail of low-impact categories
✅ Has minor data quality issues (1.31% uncategorized revenue) */