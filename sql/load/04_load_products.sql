/*
File: 04_load_products.sql

Purpose:
- Loads raw product data from CSV into the products table
- Assumes products table already exists
- Absolute path used locally; can use relative path in psql
*/
COPY products (
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
FROM '<YOUR_ABSOLUTE_PATH>\data\raw\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Quick check to confirm data was loaded
SELECT COUNT(*) AS total_products FROM products;
-- Returned: 32951 rows