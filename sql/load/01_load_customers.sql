-- CAUTION: The following SQL commands are intended for use in a PostgreSQL environment.
-- Please ensure you have the necessary permissions and that the file paths are correct before executing.
-- In any cases, you will need to run either one of these commands depending on your setup (server-side COPY or client-side \copy).
-- In case of confusion, the first one should be used when you have direct access to the server's file system, while the second one is suitable for running from a client machine with access to the CSV file but needs psql as an enviorment variable.

-- ============================================================
-- File: 01_load_customers.sql
-- Purpose: Load raw customers CSV data into the customers table
-- Source: Brazilian E-Commerce Public Dataset by Olist
-- Notes:
-- - Uses PostgreSQL COPY for fast bulk loading
-- - Assumes local file system access
-- ============================================================

COPY customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
FROM 'YOUR_ABSOLUTE_PATH\olist_retail_analytics\data\raw\olist_customers_dataset.csv'
WITH (
    FORMAT csv,
    HEADER true
);

-- ============================================================
-- File: 01_load_customers.sql
-- Purpose: Load raw customers CSV data into the customers table
-- Source: Brazilian E-Commerce Public Dataset by Olist
-- Notes:
-- - Uses client-side \copy for relative path support
-- - Assumes psql client is run from the project root directory
-- ============================================================

\copy customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
FROM 'data/raw/olist_customers_dataset.csv'
WITH (
    FORMAT csv,
    HEADER true
);