/*
File: 03_load_order_items.sql

Purpose:
- Loads raw order_items data from CSV into the order_items table
- Assumes order_items table already exists

Note:
- Absolute path can be replaced with relative path if using psql
*/
COPY order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
FROM '<YOUR_ABSOLUTE_PATH>\olist_retail_analytics\data\raw\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Quick check to confirm data was loaded
SELECT COUNT(*) FROM order_items;
-- Returned: 112650 rows