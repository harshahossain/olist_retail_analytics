/*
File: 03_order_items.sql

Purpose:
- Creates the order_items table
- Each row represents a single item in an order
- Links orders, products, and sellers

Notes:
- Composite primary key: (order_id, order_item_id)
- Foreign keys: 
    - order_id → orders(order_id)
    - product_id → products(product_id)
    - seller_id → sellers(seller_id)
- Price and freight are numeric
- shipping_limit_date is a timestamp, nullable
*/
CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2) NOT NULL,
    freight_value NUMERIC(10,2) NOT NULL,
    
    PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

    -- Note: product_id → products, seller_id → sellers FKs added after those tables exist
);
-- Verify table creation
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';