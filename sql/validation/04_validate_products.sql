/*
File: 04_validate_products.sql

Purpose:
- Basic validation for the products table after CSV load
- Ensures primary key uniqueness and basic data sanity
- Does NOT modify any data
*/

-- Total number of products loaded
SELECT COUNT(*) AS total_products
FROM products;
-- Returned: 32951 rows

-- Ensure product_id is unique
SELECT product_id, COUNT(*) AS occurrence_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;
-- If the above query returns no rows, product_id is unique as expected
-- Returend No Data, confirming product_id is unique as expected


-- Check for missing product categories
SELECT COUNT(*) AS missing_category
FROM products
WHERE product_category_name IS NULL;
-- Returned: 610 rows with missing category

-- Check for invalid numeric values
SELECT COUNT(*) AS invalid_name_length
FROM products
WHERE product_name_length < 0;
-- Returned: 0 rows with invalid product_name_length

SELECT COUNT(*) AS invalid_description_length
FROM products
WHERE product_description_length < 0;
-- Returned: 0 rows with invalid product_description_length


SELECT COUNT(*) AS invalid_photos_qty
FROM products
WHERE product_photos_qty < 0;
-- Returned: 0 rows with invalid product_photos_qty

SELECT COUNT(*) AS invalid_weight
FROM products
WHERE product_weight_g <= 0;
-- Returned: 4 rows with invalid product_weight_g

SELECT COUNT(*) AS invalid_dimensions
FROM products
WHERE product_length_cm <= 0
   OR product_height_cm <= 0
   OR product_width_cm <= 0;
-- Returned: 0 rows with invalid dimensions
