/*
    -- File: 06_validate_order_payments.sql
    -- Purpose:
    --   Validates order payments data integrity and relationships.
    --   Ensures composite primary key uniqueness, foreign key integrity, and general data sanity.
    --   Does NOT modify any data.
    -- =========================================================
*/

-- row count check
SELECT COUNT(*) FROM order_payments;
-- Returned: 103886 rows


-- composite primary key uniqueness check
SELECT order_id, payment_sequential, COUNT(*)
FROM order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;
-- Returned no rows, confirming (order_id, payment_sequential) is unique as expected


-- FK integrity (payments → orders)
SELECT p.order_id
FROM order_payments p
LEFT JOIN orders o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;
-- Returned: 0 rows, confirming all order_id in order_payments have a matching record in orders

-- Check for any negative payment values
SELECT *
FROM order_payments
WHERE payment_value < 0;
-- Returned: 0 rows, confirming no negative payment values

-- Check for any zero payment values (could be valid but worth reviewing)
SELECT *
FROM order_payments
WHERE payment_value = 0;
-- Returned: 9 rows with zero payment_value, which may indicate free orders or data issues worth investigating further

-- Summary of zero payment values by payment_type
SELECT payment_type,
       COUNT(*) AS count_zero_payments
FROM order_payments
WHERE payment_value = 0
GROUP BY payment_type
ORDER BY count_zero_payments DESC;
-- 6 vouchers, 3 not_defined

-- Payment type distribution (profiling)
SELECT payment_type, COUNT(*) AS cnt
FROM order_payments
GROUP BY payment_type
ORDER BY cnt DESC;
-- Returned:
-- credit_card: 76.8K rows
-- boleto: 19.8K rows
-- voucher: 5.8K rows
-- debit_card: 1.5K rows
-- not_defined: 3 rows