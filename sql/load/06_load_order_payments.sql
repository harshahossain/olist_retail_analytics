/*
File: sql/load/06_load_order_payments.sql 

Purpose:
- Loads raw payment data from CSV into the order_payments table
- Assumes order_payments table already exists
Note:
- Absolute path used locally; can use relative path in psql
- Placeholder path kept in repository for portability
*/

COPY order_payments
FROM '<YOUR_ABSOLUTE_PATH>\data\raw\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Quick check to confirm data was loaded
SELECT COUNT(*) AS total_payments FROM order_payments;
-- Returned: 103886 rows