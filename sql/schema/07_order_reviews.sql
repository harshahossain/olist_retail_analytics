/*
File: 07_order_reviews.sql
Purpose:
- Stores customer review information for each order at event-level grain.
- Captures satisfaction score and optional textual feedback.
- Uses a surrogate primary key to handle duplicates in source data.
- Maintains FK integrity with orders table.
*/
-- Droping old order_reviews table to remove previous broken schema
-- DROP TABLE IF EXISTS order_reviews;


CREATE TABLE order_reviews (
    review_event_id          SERIAL PRIMARY KEY,  -- surrogate key, auto-increment
    review_id                VARCHAR(32),        -- original review ID from CSV
    order_id                 VARCHAR(32),        -- FK to orders table
    review_score             INTEGER,            -- 1-5
    review_comment_title     TEXT,
    review_comment_message   TEXT,
    review_creation_date     TIMESTAMP,
    review_answer_timestamp  TIMESTAMP,

    CONSTRAINT fk_order_reviews_orders
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- Verify table creation (Returns every table in public schema, including order_reviews)
SELECT table_name
FROM information_schema.tables  
WHERE table_schema = 'public';