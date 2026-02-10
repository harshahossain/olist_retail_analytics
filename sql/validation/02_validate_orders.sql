/*
File: 02_validate_orders.sql

Purpose:
- Basic validation for the orders table after CSV load
- Ensures primary key uniqueness, foreign key integrity, and general data sanity
- Does NOT modify any data
*/

-- Total number of orders loaded
SELECT COUNT(*) AS total_orders
FROM orders;
--99441 rows returned

-- Ensure order_id is unique
SELECT order_id, COUNT(*) AS occurrence_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
-- returned 0 rows, confirming order_id is unique

-- Find any orders pointing to non-existent customers
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c
  ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- returned 0 rows, confirming all orders have valid customer_id references

-- Count of orders by status
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;
-- Simple status checking of the orders, helps confirm data looks reasonable and matches expected lifecycle stages (e.g. 'delivered', 'approved', etc.)

-- Count orders with missing timestamps
SELECT
  COUNT(*) AS missing_purchase_timestamp
FROM orders
WHERE order_purchase_timestamp IS NULL;
-- returned 0 rows, confirming all orders have a purchase timestamp
