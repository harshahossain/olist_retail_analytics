/*
File: 06_order_payments.sql
Purpose:
- Stores payment-level information for each order.
- An order may have multiple payment records (installments or mixed methods).

Grain:
- One row per payment attempt per order.

Notes:
- payment_sequential indicates payment sequence within an order.
- payment_value represents the amount paid in this record.
*/
CREATE TABLE IF NOT EXISTS order_payments (
    order_id               VARCHAR(32),
    payment_sequential     INTEGER,
    payment_type           TEXT,
    payment_installments   INTEGER,
    payment_value          NUMERIC(10,2),

    CONSTRAINT pk_order_payments PRIMARY KEY (order_id, payment_sequential),
    CONSTRAINT fk_order_payments_orders
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Verify table creation (Returns every table in public schema, including order_payments)
SELECT table_name
FROM information_schema.tables  
WHERE table_schema = 'public';