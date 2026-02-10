/*
File: 03_validate_order_items.sql

Purpose:
- Basic validation for the order_items table after CSV load
- Ensures composite primary key uniqueness, foreign key integrity, and general data sanity
- Does NOT modify any data
*/
-- =============================================================
-- Total number of order items loaded
SELECT COUNT(*) AS total_order_items FROM order_items;
-- Returned: 112650 rows
-- Ensure composite primary key (order_id, order_item_id) is unique

-- =============================================================
SELECT order_id, order_item_id, COUNT(*) AS occurrence_count
FROM order_items
GROUP BY order_id, order_item_id    
HAVING COUNT(*) > 1;
-- Returned: 0 rows, confirming composite primary key is unique  
-- =============================================================

-- =============================================================
-- Check for order_ids in order_items that do not exist in orders
SELECT oi.order_id, oi.order_item_id
FROM order_items oi
LEFT JOIN orders o
  ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
-- Returned: 0 rows, confirming all order_items have valid order_id references
-- =============================================================

-- =============================================================
-- Count items with missing product_id or seller_id
SELECT COUNT(*) AS missing_products
FROM order_items
WHERE product_id IS NULL;

SELECT COUNT(*) AS missing_sellers
FROM order_items
WHERE seller_id IS NULL;
-- Returned: 0 rows for both, confirming no missing product_id or seller_id values
-- =============================================================

-- =============================================================
-- Quick check for negative or zero values
SELECT COUNT(*) AS invalid_price
FROM order_items
WHERE price <= 0;

SELECT COUNT(*) AS invalid_freight
FROM order_items
WHERE freight_value < 0;
-- Returned: 0 rows for both, confirming all price and freight values are positive
-- ============================================================= 

-- =============================================================
-- Check for shipping_limit_date values that are in the past (relative to order purchase date)
SELECT oi.order_id, oi.order_item_id, oi.shipping_limit_date, o.order_purchase_timestamp
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE oi.shipping_limit_date < o.order_purchase_timestamp;
-- Returned: 0 rows, confirming all shipping_limit_date values are on or after order purchase timestamp
-- =============================================================