-- ============================================================
-- File: 01_validate_customers.sql
-- Purpose:
-- Basic data validation checks for the customers table after
-- initial CSV load.
--
-- These checks help confirm that the customers table can be
-- safely used as a core dimension for downstream analysis
-- and joins (e.g. with orders).
--
-- No data is modified in this file.
-- ============================================================


-- 1. Row count check
-- Confirms that data was successfully loaded into the table.
SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. Primary key uniqueness check
-- Ensures customer_id can reliably act as a primary key.
-- Any rows returned here indicate duplicate customer IDs.
SELECT customer_id, COUNT(*) AS occurrence_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 3. Primary key null check
-- customer_id should never be NULL.
-- A non-zero result indicates corrupted or incomplete data.
SELECT COUNT(*) AS null_customer_ids
FROM customers
WHERE customer_id IS NULL;

-- 4. State code distribution check
-- Quick sanity check on customer_state values.
-- Used to spot unexpected NULLs or malformed state codes.
SELECT customer_state, COUNT(*) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC;

-- ============================================================
-- Validation Summary:
-- - Total rows: 99,441
-- - No duplicate or NULL customer_id values
-- - customer_state values are clean and well-formed
-- Result: customers table approved for downstream use.
-- ============================================================
