-- ============================================================
-- File: 01_customers.sql
-- Purpose: Create the customers table for the Olist e-commerce
--          analytics database.
--
-- Notes:
-- - Source: Brazilian E-Commerce Public Dataset by Olist
-- - This is a core dimension table.
-- - customer_id is the primary key.
-- - Data types are kept flexible (TEXT) to match raw CSV data.
-- - No foreign keys or constraints added at this stage.
-- ============================================================

CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state CHAR(2)
);

-- Verify table creation (Returns every table in public schema, including customers)
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';