/*
File: 04_category_revenue_percentage.sql
Purpose: Calculate revenue contribution percentage by product category.
*/

WITH category_revenue AS (
    SELECT 
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM order_items oi
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
)

SELECT 
    product_category_name,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        total_revenue * 100.0 / SUM(total_revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_revenue
ORDER BY total_revenue DESC;
/*
Returned: "product_category_name","total_revenue","revenue_percentage"
"beleza_saude","1441248.07","9.10"
"relogios_presentes","1305541.61","8.24"
"cama_mesa_banho","1241681.72","7.84"
"esporte_lazer","1156656.48","7.30"
"informatica_acessorios","1059272.40","6.69"
"moveis_decoracao","902511.79","5.70"
"utilidades_domesticas","778397.77","4.91"
"cool_stuff","719329.95","4.54"
"automotivo","685384.32","4.33"
"ferramentas_jardim","584219.21","3.69"
*/

/* Notes: 
Revenue Percentage by Category
Top category (beleza_saude) = 9.10%
That is very important.

In many marketplaces, top category can contribute:
20%, 30%, Even 40%

Here? Only 9.1%
That means:
Revenue is NOT concentrated in one dominant category.
The business is highly diversified.

~62.34% of revenue comes from top 10 categories.
So: That is balanced.
Not overly concentrated.
Not extremely fragmented either
 ==========================================
 ~1.31% of total revenue (~207K) is linked to products with missing category classification, indicating minor but noticeable data quality issues.
 ===========================================
Business Interpretation of this marketplace is:
Not dependent on one single category
Not a niche retailer
Broad catalog-driven
Revenue distributed across multiple segments
That reduces product category risk.
If one category underperforms, business still survives.
*/
