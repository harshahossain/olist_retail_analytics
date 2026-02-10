/*
File: 05_sellers.sql
Purpose:
- Defines the sellers dimension table.
- Stores seller-level geographic information.
- Acts as a lookup table referenced by order_items.seller_id.

Notes:
- Geographic fields are used for regional analysis and logistics insights.

-- =========================================================
*/

CREATE TABLE IF NOT EXISTS sellers (
    seller_id              VARCHAR(32) PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city            TEXT,
    seller_state           CHAR(2)
);

-- Verify table creation (Returns every table in public schema, including sellers)
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';