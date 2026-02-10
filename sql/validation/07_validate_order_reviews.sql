/*
File: 07_validate_order_reviews.sql
Purpose:
- Validate the integrity and completeness of order_reviews table.
- Ensures FK relationships, score validity, and checks for null/comment patterns.
- Grain: one review event per row (review_event_id), multiple events per order allowed.
*/

-- Row count check
SELECT COUNT(*) AS total_rows
FROM order_reviews;
-- Returned: 99224 rows, which matches the expected count based on the source data and transformations.


-- Surrogate PK uniqueness check
SELECT review_event_id, COUNT(*) AS count_duplicates
FROM order_reviews
GROUP BY review_event_id
HAVING COUNT(*) > 1;
-- Returned: 0 rows



-- Foreign key integrity (reviews → orders)
SELECT r.order_id
FROM order_reviews r
LEFT JOIN orders o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;
-- Returned: 0 rows, all reviews link to valid orders



-- Review score validity (1-5)
SELECT *
FROM order_reviews
WHERE review_score NOT BETWEEN 1 AND 5;
-- Returned: 0 rows



-- NULL comments profiling
SELECT
    COUNT(*) FILTER (WHERE review_comment_title IS NULL) AS null_titles,
    COUNT(*) FILTER (WHERE review_comment_message IS NULL) AS null_messages
FROM order_reviews;
-- Returned: 879656 null titles and 58247 null messages, indicating that many reviews have no comments, which is expected in event-level modeling where not all events have associated comments.



--  One review per order check (optional analytics insight)
SELECT order_id, COUNT(*) AS review_count
FROM order_reviews
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY review_count DESC;
-- Returned: highest review count per order is 3.




-- Latest review per order (example for future analytics)
-- This is not a validation, but wanted to see how to derive a single review per order if needed
SELECT DISTINCT ON (order_id)
       order_id,
       review_score,
       review_creation_date
FROM order_reviews
ORDER BY order_id, review_creation_date DESC;
