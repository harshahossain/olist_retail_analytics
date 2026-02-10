/*
File: 04_products.sql

Purpose:
- Creates the products table
- Each row represents a unique product in the Olist catalog
- product_id is the primary key
- Numeric columns represent measurements; text columns describe product
*/
CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
-- Verify table creation
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';