/*
File: 02_load_orders.sql

Purpose:
- Loads raw order data from CSV into the orders table
- Assumes orders table already exists
- CSV is stored outside the database and not committed to GitHub

Note:
- Absolute path used locally
- Placeholder path kept in repository for portability
*/
COPY orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
FROM '<YOUR_ABSOLUTE_PATH>\olist_retail_analytics\data\raw\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Quick check to confirm data was loaded
SELECT COUNT(*) FROM orders;