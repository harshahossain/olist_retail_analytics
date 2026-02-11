/*
File: 02_revenue_by_state.sql
Purpose: Analyze revenue distribution across Brazilian states.
Revenue is calculated using SUM(order_payments.payment_value).
*/

-- Revenue by customer state
SELECT 
    c.customer_state,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
JOIN order_payments p 
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;
-- LIMIT 5; cleanup
/* Returned: "customer_state","total_revenue","total_orders","avg_order_value"
"SP","5998226.96","41745","143.69"
"RJ","2144379.69","12852","166.85"
"MG","1872257.26","11635","160.92"
"RS","890898.54","5466","162.99"
"PR","811156.38","5045","160.78"
*/
-- ===========================================

-- Revenue contribution percentage by state
WITH state_revenue AS (
    SELECT 
        c.customer_state,
        SUM(p.payment_value) AS total_revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_payments p ON o.order_id = p.order_id
    GROUP BY c.customer_state
)
SELECT 
    customer_state,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        (total_revenue / SUM(total_revenue) OVER ()) * 100, 
        2
    ) AS revenue_percentage
FROM state_revenue
ORDER BY total_revenue DESC;
-- LIMIT 6; cleanup
/* Returned: "customer_state","total_revenue","revenue_percentage"
"SP","5998226.96","37.47"
"RJ","2144379.69","13.39"
"MG","1872257.26","11.70"
"RS","890898.54","5.57"
"PR","811156.38","5.07"
"SC","623086.43","3.89"
*/
-- ===========================================

/*
Insights:
Revenue by State — Interpretation
🥇 1. São Paulo (SP)

Revenue: 5,998,226.96
Orders: 41,745
AOV: 143.69

SP alone generates:
Roughly 37–38% of total revenue (5.99M out of 16M).
That is massive concentration.
But notice something interesting:
SP has the lowest AOV among the top 5.

Meaning:
High volume
Lower average spend per order
Likely mature, highly competitive market

This is typical of large metropolitan regions.

🥈 2. Rio de Janeiro (RJ)

Revenue: 2,144,379.69
Orders: 12,852
AOV: 166.85

Higher AOV than SP.

Meaning:
Fewer orders
Higher average spend per transaction

This could indicate:
Different product mix
Higher-income demographic
Different purchasing behavior

🥉 3. Minas Gerais (MG)
Revenue: 1,872,257.26
Orders: 11,635
AOV: 160.92

Similar AOV to RJ but slightly lower.

Stable mid-tier state.

4️⃣ RS & PR
Both:
Around 800–900K revenue
AOV around ~161–163
These states look structurally similar in customer spending behavior.

🧠 Business-Level Insight
This business is heavily concentrated in:
SP + RJ + MG
Let’s approximate:
SP (6M)
RJ (2.1M)
MG (1.87M)

That’s roughly:
~10M of 16M revenue
≈ 62% of total revenue from just 3 states

That is strategic concentration risk.
If something disrupts SP market → major revenue hit. */