/*
File: 02_orders.sql

Purpose:
- Creates the orders table (central fact table)
- Each row represents a single customer order
- Links customers to downstream order-related tables

Notes:
- order_id is the primary key
- customer_id references customers(customer_id)
- Timestamp fields are nullable due to order lifecycle variations
*/

CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Verify table creation
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';
