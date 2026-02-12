/*
File: 09_order_reviews_by_category.sql
Purpose: Average review score per product category
*/

SELECT
    p.product_category_name,
    ROUND(AVG(orv.review_score)::numeric, 2) AS avg_review_score,
    COUNT(orv.review_id) AS total_reviews
FROM order_reviews orv
JOIN orders o
    ON orv.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(orv.review_id) >= 100 -- Filter to categories with more atleast 100 reviews for reliability
ORDER BY avg_review_score DESC;
/* Returned:"product_category_name","avg_review_score","total_reviews"
"livros_interesse_geral","4.45","549"
"livros_tecnicos","4.37","266"
"alimentos_bebidas","4.32","279"
"malas_acessorios","4.32","1088"
"fashion_calcados","4.23","261"
"alimentos","4.22","495"
"pet_shop","4.19","1939"
"papelaria","4.19","2507"
"pcs","4.18","200"
"eletrodomesticos","4.17","806"
"brinquedos","4.16","4091"
"perfumaria","4.16","3421"
"instrumentos_musicais","4.15","675"
"eletroportateis","4.15","677"
"cool_stuff","4.15","3772"
"eletrodomesticos_2","4.14","238"
"beleza_saude","4.14","9645"
*/

-- checking according to most reviews
SELECT
    p.product_category_name,
    ROUND(AVG(orv.review_score)::numeric, 2) AS avg_review_score,
    COUNT(orv.review_id) AS total_reviews
FROM order_reviews orv
JOIN orders o
    ON orv.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_reviews DESC
LIMIT 20;
/* Returned: "product_category_name","avg_review_score","total_reviews"
"cama_mesa_banho","3.90","11137"
"beleza_saude","4.14","9645"
"esporte_lazer","4.11","8640"
"moveis_decoracao","3.90","8331"
"informatica_acessorios","3.93","7849"
"utilidades_domesticas","4.06","6943"
"relogios_presentes","4.02","5950"
"telefonia","3.95","4517"
"ferramentas_jardim","4.04","4329"
"automotivo","4.07","4213"
"brinquedos","4.16","4091"
"cool_stuff","4.15","3772"
"perfumaria","4.16","3421"
"bebes","4.01","3048"
"eletronicos","4.04","2749"
"papelaria","4.19","2507"
"fashion_bolsas_e_acessorios","4.14","2039"
"pet_shop","4.19","1939"
"moveis_escritorio","3.49","1687"
"","3.84","1598"
*/
