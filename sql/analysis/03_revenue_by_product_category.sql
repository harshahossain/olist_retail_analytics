/*
File: 03_revenue_by_product_category.sql
Purpose: Analyze revenue performance across product categories.
Revenue is defined as SUM(order_payments.payment_value),
aggregated by product category.
*/

-- Revenue by product category
SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(
        SUM(oi.price + oi.freight_value) / 
        COUNT(DISTINCT oi.order_id),
        2
    ) AS avg_order_value
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

/*
Returned: "product_category_name","total_revenue","total_orders","avg_order_value"
"beleza_saude","1441248.07","8836","163.11"
"relogios_presentes","1305541.61","5624","232.14"
"cama_mesa_banho","1241681.72","9417","131.86"
"esporte_lazer","1156656.48","7720","149.83"
"informatica_acessorios","1059272.40","6689","158.36"
"moveis_decoracao","902511.79","6449","139.95"
"utilidades_domesticas","778397.77","5884","132.29"
"cool_stuff","719329.95","3632","198.05"
"automotivo","685384.32","3897","175.87"
"ferramentas_jardim","584219.21","3518","166.07" 
*/