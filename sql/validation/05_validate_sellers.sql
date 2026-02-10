-- 
-- File: 04_validate_sellers.sql
-- Purpose:
--   Validates sellers data integrity and relationships.
-- 

-- Row count check
SELECT COUNT(*) FROM sellers;
-- Returned: 3095 rows


-- Primary key uniqueness check
SELECT seller_id, COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;
-- Returned no rows, confirming seller_id is unique as expected


-- Check for missing seller_state
SELECT *
FROM sellers
WHERE seller_state IS NULL;
-- Returned: 0 rows with missing seller_state


-- Validate seller_state format (should be 2 characters)
SELECT *
FROM sellers
WHERE seller_state IS NOT NULL
  AND LENGTH(seller_state) <> 2;
-- Returned: 0 rows with invalid seller_state format


-- Validate seller references from order_items
SELECT oi.seller_id
FROM order_items oi
LEFT JOIN sellers s
  ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;
-- Returned: 0 rows, confirming all seller_id in order_items have a matching record in sellers