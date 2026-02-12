/*
File: 08_order_reviews_distribution.sql
Purpose: Analyze distribution of review scores
*/

SELECT
    review_score,
    COUNT(*) AS count_reviews,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

/*| review_score | count_reviews | percentage |
| ------------ | ------------- | ---------- |
| 1            | 11,424        | 11.51%     |
| 2            | 3,151         | 3.18%      |
| 3            | 8,179         | 8.24%      |
| 4            | 19,142        | 19.29%     |
| 5            | 57,328        | 57.78%     |
*/

/* GPT Interpretation:Most reviews are positive:
5-star reviews dominate at ~58%.
4-star reviews add another 19%, meaning ~77% of customers rate 4 or 5.

Negative reviews are a minority:
1-star: 11.5%
2-star: 3.2%
Total negative (1–2 stars): ~14.7%

Moderate reviews (3 stars) are ~8%, which is neutral feedback.

🔹 Business Interpretation
Customer satisfaction is high overall.
The small fraction of negative reviews identifies potential products or processes that need improvement.
This is also a signal for repeat customer potential — happy customers may be more likely to buy again (Step 10 will explore this).
*/


