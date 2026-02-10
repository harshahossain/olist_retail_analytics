/*
File: sql/load/05_load_sellers.sql
Purpose:
- Loads raw seller data from CSV into the sellers table
- Assumes sellers table already exists 

 Note:
- Absolute path used locally; can use relative path in psql
- Placeholder path kept in repository for portability
*/

COPY sellers
FROM '<YOUR_ABSOLUTE_PATH>\data\raw\olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Quick check to confirm data was loaded
SELECT COUNT(*) AS total_sellers FROM sellers;
-- Returned: 3095 rows