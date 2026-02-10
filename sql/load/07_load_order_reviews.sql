/* 
File: 07_load_order_reviews.sql

Purpose:
- Loads raw review data from CSV into the order_reviews table
- Column order is specified to prevent misalignment between CSV and tabl
- Assumes order_reviews table already exists
Note:
- Absolute path used locally; can use relative path in psql
- Placeholder path kept in repository for portability
*/


/*
The review_id are not unique in olist dataset, 
*/
COPY order_reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
FROM '<YOUR_ABSOLUTE_PATH>\data\raw\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;


-- Quick check to confirm data was loaded
SELECT COUNT(*) AS total_reviews FROM order_reviews;
-- Returned: 99224 total_reviews, which matches the number of rows in the CSV file, confirming successful load.