# End-to-End E-Commerce Analytics Case Study

# Introduction

This project presents an end-to-end e-commerce analytics case study built using PostgreSQL. Starting from raw CSV files, the dataset was transformed into a structured relational database with properly defined primary keys, foreign keys, and integrity constraints.

The objective was not only to analyze business performance, but to simulate a real-world data workflow — where database design, validation, and data quality checks come before analytical insights.

Using the Brazilian Olist E-Commerce dataset, this project models customer behavior, order lifecycle events, product performance, payment patterns, and revenue trends. By combining structured data modeling with business-focused analysis, the project demonstrates both technical database proficiency and practical analytical thinking.

All SQL scripts used for schema creation, data loading, validation and analysis are organized inside the [project_sql folder.](sql/)

# Background

This project was built with a dual objective in mind: to strengthen my foundation in analytics engineering while applying those skills to real business performance analysis.

Rather than jumping straight into dashboards or surface-level insights, I approached this dataset as if I were working with raw production data from an e-commerce company. The goal was to simulate a real-world workflow: designing a relational schema, enforcing primary and foreign key constraints, loading raw CSV data responsibly, and validating data integrity before performing any analysis.

By structuring the database from the ground up and validating relationships across customers, orders, products, payments, and reviews, this project reflects how data work is handled in professional environments — where clean modeling and reliable data come before business reporting.

Once the data foundation was established, the focus shifted toward business performance questions. The analysis explores revenue trends, customer distribution, product performance, payment behavior, and operational efficiency within the order lifecycle.

This project represents more than exploratory querying — it demonstrates an end-to-end analytics workflow: from raw data ingestion to structured insights that could support real business decisions.

Using a [Brazilian e-commerce dataset (Olist)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), I structured multiple related datasets — customers, orders, order items, payments, reviews, products, and sellers — into a normalized PostgreSQL database.

### Rather than treating the dataset as “analysis-ready,” I approached it like production data:

1. Defined primary and composite keys
2. Enforced foreign key relationships
3. Validated uniqueness assumptions
4. Checked referential integrity
5. Identified missing or inconsistent values
6. Investigated edge cases (zero payments, duplicate reviews, nullable timestamps)

The goal was not just to analyze the data, but to simulate how real analytics work happens in a business environment — starting from raw files and building toward reliable insights.

# Business Question Exploerd

After structuring and validating the database, the analysis focuses on answering practical e-commerce questions such as:

1. How do payment methods distribute across orders?
2. What patterns exist between review scores and delivery timelines?
3. How do order values vary across sellers and products?
4. Are there anomalies in payment behavior?
5. How consistent are shipping deadlines relative to purchase timestamps?

These questions are designed to reflect real stakeholder concerns in an online retail setting.

# Tools Used

- **SQL:** The backbone of the project. Used for schema design, constraint enforcement, validation checks, and exploratory analysis.
- **PostgreSQL**: Relational database system used to model and manage structured e-commerce data across multiple related tables.
- **Visual Studio Code**: Used for writing and executing SQL scripts, managing structured validation files, and maintaining clean project organization.
- **Git & GitHub**: Version control for tracking schema evolution, validation scripts, and documenting the full analytical workflow.

# Approach & Workflow

This project follows a structured pipeline:

1. **Schema Design**
   Tables created with explicit primary keys and foreign key relationships.

2. **Data Loading**
   CSV datasets imported into PostgreSQL using COPY.

3. **Validation Layer**
   Dedicated validation scripts written for each table:
   - Row count checks
   - Uniqueness verification
   - Foreign key integrity checks
   - Logical data consistency validation

4. **Exploratory Analysis**
   Business-focused queries built only after data integrity was confirmed.

This layered approach ensures that analysis is based on trustworthy data rather than assumptions.

# Data Modeling

The database was designed using a relational structure centered around the orders table as the core transactional entity. Supporting tables were modeled to reflect real-world e-commerce relationships while enforcing data integrity through primary and foreign key constraints.

### Core Tables

The following core entities were modeled:

- **customers**
- **orders**
- **order_items**
- **order_payments**
- **order_reviews**
- **products**
- **sellers**

### Key Design Decisions

1. **_Orders as the central fact table_**
   The `orders` table serves as the transactional backbone of the database. All order-related activity (payments, items, reviews) references this table through foreign keys.

2. **_Primary Keys_**
   - `customers(customer_id)`
   - `orders(order_id)`
   - `products(product_id)`
   - `sellers(seller_id)`

Composite primary keys were used where business logic required uniqueness across multiple columns:

- `order_items (order_id, order_item_id)`
- `order_payments (order_id, payment_sequential)`
- `order_reviews (review_id)`
  (Adjusted after detecting duplicate review entries per order)

3. **_Foreign Key Relationships_**

- `orders.customer_id → customers.customer_id`
- `order_items.order_id → orders.order_id`
- `order_items.product_id → products.product_id`
- `order_items.seller_id → sellers.seller_id`
- `order_payments.order_id → orders.order_id`
- `order_reviews.order_id → orders.order_id`

  These constraints ensure referential integrity across transactional and dimension tables.

4. **_Data Types & Lifecycle Considerations_**

   Identifiers were stored as `TEXT` to match the source data format.

   Monetary values were stored as `NUMERIC` to prevent floating-point precision issues.

   Timestamp fields were defined as `TIMESTAMP`, with nullable fields reflecting the order lifecycle (e.g., orders not yet delivered will not have delivery timestamps).

   The schema design emphasizes structural integrity before analytical querying, mirroring production-level database design principles.

# Data Validation

After loading data from raw CSV files using PostgreSQL’s `COPY` command, validation queries were written to ensure structural and business integrity across all tables.

Validation followed a consistent pattern for each entity

1. **Row Count Verification**

   Each table was checked to confirm successful ingestion and expected record volume.

   Example:
   - `customers` → 99,441 rows
   - `orders` → 99,441 rows
   - `order_items` → 112,650 rows
   - `order_payments` → 103,886 rows

2. **Primary Key Integrity**

   Uniqueness checks were performed to confirm that primary and composite keys enforce true uniqueness.

   Examples:
   - No duplicate `customer_id`
   - No duplicate `(order_id, order_item_id)`
   - No duplicate `(order_id, payment_sequential)`

   All primary key checks passed.

3. **Foreign Key Integrity**

   Foreign key relationships were validated using LEFT JOIN checks to ensure no orphaned records exist.

   Examples:
   - All `orders.customer_id` values exist in customers
   - All `order_items.order_id` values exist in orders
   - All `order_payments.order_id` values exist in orders
   - All `order_reviews.order_id` values exist in orders
   - All referential integrity checks passed.

4. **Business Logic Validation**

   Additional validation was performed to detect potential anomalies:
   - No negative payment values
   - No negative price or freight values
   - Shipping limit dates occur on or after purchase timestamps
   - No invalid product dimensions
   - No invalid product length/description metrics
   - 9 zero-value payments identified (primarily voucher-based)

These checks confirm that the dataset is structurally clean and suitable for business analysis.

### Validation Outcome

The dataset demonstrated high structural consistency with minimal anomalies. This allowed analytical queries to be built on a trusted and validated foundation.

# The Analysis

## Key Revenue Insights

- **_Total Revenue:_** ~16M
- **_Average Order Value (AOV)_**: ~161
- Revenue shows strong growth throughout 2017, with a major seasonal spike in **_November 2017_** (likely driven by Black Friday).
- 2018 revenue stabilizes around ~1M per month, suggesting operational maturity and demand consistency.
- The late-2018 revenue decline reflects dataset cutoff, not performance deterioration

### Interpretation

The marketplace demonstrates:

- Strong growth momentum
- Clear seasonality effects
- Stabilized recurring demand entering 2018

Revenue is not overly dependent on a single surge event, indicating sustainable operational scale.

---

## Key Geographic Insights

- **_São Paulo (SP)_** contributes ~37.5% of total revenue, making it the dominant market.
- **_Rio de Janeiro (RJ)_** and **_Minas Gerais (MG)_** contribute ~13.4% and ~11.7%, respectively.
- Together, the top three states account for ~62.6% of total revenue — showing clear geographic concentration.
- Southern states such as **_Rio Grande do Sul (RS), Paraná (PR)_**, and S***anta Catarina (SC)*** each contribute ~4–5%.

### Order Behavior Differences

#### São Paulo (SP):

- Highest order volume (41,745 orders)
- **_Lower AOV_**(Average Order Value) (~143.69)

  → High-frequency, lower-ticket purchasing behavior

#### Rio de Janeiro (RJ):

- Fewer orders
- **_Higher AOV_**(Average Order Value) (~166.85)

  → More premium spending behavior

### Interpretation

- Revenue is heavily concentrated in a few states.
- Expansion into lower-revenue states could reduce geographic risk.
- Marketing strategies may be tailored regionally:
  - Volume-driven strategy in **_SP_**
  - Premium positioning in **_RJ_**

The geographic distribution highlights both strength in core markets and opportunity for diversification.

---

## Key Category Insights

### Revenue Distribution

- The top-performing category is **_beleza_saude (Beauty & Health)_**, contributing ~9.1% (~1.44M) of total revenue.
- No single category contributes more than 10% — indicating strong diversification.
- The top **_10 categories_** account for **_~62%_** of total revenue.

### Interpretation

The marketplace is not dependent on a single vertical.
It operates with a strong revenue core supported by broad category diversity

---

### Category Performance Patterns

- **High-volume, moderate AOV**(Average Order Value) **categories:**
  - **_cama_mesa_banho_** (Bed Table Bath)
  - **_beleza_saude_** (Beauty & Health)

    → Indicate recurring consumer demand.

- **High AOV**(Average Order Value), **lower-frequency categories:**
  - **_relogios_presentes_** (Gift Watches)
  - **_moveis_escritorio_** (Office Furniture)
  - **_instrumentos_musicais_** (Musical Instruments)

  → Reflect discretionary or premium purchases.

- **Very high-ticket categories:**
  - **_pcs_** (Computers) (~1286K AOV)

  → Low volume but high revenue impact per transaction.

#### This demonstrates a mix of:

- Stable recurring demand
- Higher-margin premium goods
- Occasional high-ticket purchases

---

### Pareto (80/20) Analysis

- ~17 categories (~24% of total categories) generate ~80% of revenue.
- The remaining ~75% contribute only ~20%.

---

**This confirms a classic long-tail revenue structure:**

- Strong revenue concentration in a core group
- Supported by a broad but lower-impact assortment

---

### Data Quality Observation

- ~1.31% of total revenue (~207K) is associated with products missing a category label.

While not materially large, this indicates minor classification inconsistencies that could impact reporting accuracy and downstream analytics.

---

## Key Customer Insights

- 97% of customers are one-time buyers.
- Only 3% are repeat buyers.
- Repeat customers contribute ~5% of total revenue (~864K).
- The majority of revenue is acquisition-driven.

### Interpretation

The business model currently relies heavily on new customer acquisition.

Retention-focused initiatives represent a significant growth opportunity.

## Customer Experience & Review Analysis

### Review Distribution

#### Review Score Breakdown

| Review Score | Percentage |
| ------------ | ---------- |
| 5 Stars      | 57.78%     |
| 4 Stars      | 19.29%     |
| 3 Stars      | 8.24%      |
| 2 Stars      | 3.18%      |
| 1 Star       | 11.51%     |

### Satisfaction Summary

- 77% of reviews are 4–5 stars.
- 14.69% are 1–2 stars.
- 3-star reviews account for 8.24%.

### Interpretation

Overall customer satisfaction is strong.

However, the 11.5% share of 1-star reviews represents a meaningful dissatisfaction segment at scale. While most transactions are successful, a noticeable minority experience severe friction.

This suggests targeted operational improvements may yield outsized impact.

---

### Average Review Score by Product Category

#### High-Volume Categories:

| Category                                        | Reviews | Avg Score |
| ----------------------------------------------- | ------- | --------- |
| `cama_mesa_banho` (Bed Table Bath)              | 11,137  | 3.90      |
| `beleza_saude` (Beauty & Health)                | 9,645   | 4.14      |
| `esporte_lazer` (Sport Leisure)                 | 8,640   | 4.11      |
| `moveis_decoracao` (Furniture Decoration)       | 8,331   | 3.90      |
| `informatica_acessorios` (Computer Accessories) | 7,849   | 3.93      |

#### Strong Performing Categories:

- **_beleza_saude_** Beauty & Health - **4.14**
- **_esporte_lazer_** Sport Leisure - **4.11**
- **_perfumaria_** Perfumery - **4.16**
- **_cool_stuff_** Cool Stuff - **4.15**

These categories combine high exposure with strong satisfaction.

#### Risk Zones (High Volume + Lower Ratings):

- **_cama_mesa_banho_** Bed Table Bath - **3.90**
- **_moveis_decoracao_** Furniture Decoration - **3.90**
- **_informatica_acessorios_** Computer Accessories - **3.93**
- **_telefonia_** Telephony/Wireless - **3.95**
- **_moveis_escritorio_** Office Furniture - **3.49**

Notably, `moveis_escritorio` **_Office Furniture_** **(3.49)** stands out as a significant concern given its volume and low rating.

### Interpretation:

Satiscation is uneven acrosss categories.

Improving experince in high-volume, lover-rated categories could disproportionately improve overall brand perception and revenue stability.

---

## Review Score vs Customer Type

| Customer Type | Avg Review Score |
| ------------- | ---------------- |
| One-Time      | 4.15             |
| Repeat        | 4.20             |

### Interpretation

- Repeat customers report slightly higher satisfaction (+0.05).
- The gap is small but directionally consistent.

However:

- Retention is extremely low (~3%).
- Satisfaction levels are high across both groups.

### Critical Insight

Low retention does not appear to be primarily driven by dissatisfaction.

Instead, possible drivers include:

- Non-recurring product categories
- Competitive switching behavior
- Lack of loyalty mechanisms
- Weak re-engagement strategy

This reframes retention as a strategic growth opportunity rather than a quality failure.

---

### Revenue Risk Analysis (Product Satisfaction Category)

Product categories were segmented into:

- **High Satisfaction (≥ 4.0)**

- **Low Satisfaction (< 4.0)**

#### Results

| Segment           | Revenue | % of Total |
| ----------------- | ------- | ---------- |
| High Satisfaction | 11.08M  | 70.88%     |
| Low Satisfaction  | 4.55M   | 29.12%     |

#### Key Insight

Nearly **29% of total revenue** is generated from categories with **below-4.0 ratings**.

### Interpretation

While most revenue is tied to strong-performing categories, almost one-third of total revenue is exposed to weaker satisfaction segments.

This creates:

- Brand perception risk
- Potential churn vulnerability
- Revenue sensitivity to operational quality

Improving customer experience in low-rated categories could protect nearly one-third of total revenue while strengthening long-term retention potential.

---

# Executive Summary

This project analyzes a Brazilian e-commerce marketplace dataset to evaluate revenue performance, geographic concentration, product category dynamics, customer retention, and customer satisfaction.

The business generated approximately **16M in total revenue**, with an average order value of ~161. Revenue grew strongly throughout 2017, with a pronounced seasonal spike in November (likely driven by Black Friday), followed by stable monthly performance in 2018.

Revenue is geographically concentrated, with **São Paulo contributing ~37.5%** and the top three states accounting for ~62.6% of total revenue. This indicates strong core markets but potential diversification risk.

Category analysis reveals a diversified marketplace structure. No single category exceeds 10% of total revenue, though ~24% of categories generate ~80% of revenue, reflecting a classic Pareto distribution.

Customer behavior shows a heavy reliance on acquisition:

- 97% of customers are one-time buyers.
- Repeat customers contribute only ~5% of revenue.

Customer satisfaction is generally strong (77% 4–5 star reviews), but nearly **29% of total revenue is tied to categories with below-4.0 ratings**, indicating measurable experience-related revenue exposure.

Overall, the marketplace demonstrates strong revenue performance and diversification, but presents strategic opportunities in:

- Geographic expansion
- Customer retention optimization
- Targeted improvements in lower-rated high-impact categories

The analysis highlights both operational strengths and growth levers that could materially improve long-term revenue stability.

---

# Business Recommendations

Based on the analysis, the following strategic actions could improve revenue stability, retention, and long-term growth:

---

## 1. Strengthen Customer Retention Strategy

#### Problem:

97% of customers are one-time buyers, and repeat customers contribute only ~5% of revenue.

#### Recommendation:

- Introduce loyalty incentives (points, discounts, tiered benefits).
- Implement post-purchase re-engagement campaigns (email, personalized offers).
- Target high-satisfaction first-time buyers with retention-focused promotions.
- Bundle frequently purchased categories (e.g., Beauty & Health).

#### Impact:

Even a small increase in repeat rate could meaningfully increase revenue without increasing acquisition cost.

## 2. Improve Experience in High-Revenue, Low-Rated Categories

#### Problem:

~29% of revenue comes from categories with below-4.0 ratings.

#### Recommendation:

- Audit operational issues in categories such as:
  - `moveis_escritorio` Office Furniture
  - `cama_mesa_banho` Bed Table Bath
  - `moveis_decoracao` Furniture Decoration

- Investigate delivery delays, product quality complaints, and seller performance.
- Implement stricter seller quality thresholds in lower-rated categories.

Impact:
Protect nearly one-third of revenue while improving brand perception and potential retention.

## 3. Geographic Diversification Strategy

#### Problem:

~62.6% of revenue comes from the top three states.

#### Recommendation:

- Expand marketing investment in underrepresented states.
- Adjust shipping strategies to improve delivery times outside core regions.
- Test region-specific promotions based on purchasing behavior.

#### Impact:

Reduced geographic revenue concentration risk and broader market penetration.

## 4. Optimize Category Portfolio Strategy

#### Problem:

~24% of categories generate ~80% of revenue (Pareto distribution).

#### Recommendation:

- Prioritize inventory and marketing spend on high-performing core categories.
- Reassess low-performing long-tail categories for profitability.
- Develop premium positioning for high-AOV **_(Average Order Value)_** categories (e.g., pcs, office furniture).

Impact:
More efficient capital allocation and improved margin control.

## 5. Reduce Data Classification Gaps

#### Problem:

~1.31% of revenue is tied to products with missing category labels.

#### Recommendation:

- Enforce stricter product categorization controls.
- Implement automated validation rules at seller onboarding.

#### Impact:

Improved reporting accuracy and cleaner downstream analytics.

---

**These recommendations are designed to:**

- Increase revenue efficiency
- Reduce concentration risk
- Improve customer lifetime value
- Strengthen long-term operational resilience

---

# Technical Skills Demonstrated

#### SQL & Data Analysis

- Complex joins across multiple relational tables (orders, customers, products, reviews, payments)
- Common Table Expressions (CTEs)
- Aggregations and window functions
- Revenue segmentation and Pareto analysis
- Behavioral segmentation (repeat vs one-time customers)
- Satisfaction segmentation (review-based risk exposure)

#### Data Modeling & Business Logic

- Revenue calculation including freight values
- Customer lifetime behavior classification
- Category-level performance breakdown
- Risk-based revenue exposure modeling

#### Analytical Thinking

- Connecting customer satisfaction to revenue risk
- Identifying geographic concentration exposure
- Translating data findings into actionable business recommendations
- Moving from descriptive analysis to strategic insight

#### Data Quality Awareness

- Detection of missing product category classifications
- Evaluation of reporting implications

# Next Steps

This project will be expanded to further develop advanced data capabilities.

Planned extensions include:

- **Interactive Business Intelligence Dashboard**
  Building a visualization layer (e.g., Power BI or Tableau) to transform SQL outputs into executive-ready dashboards.
- **Data Warehousing Implementation**
  Designing a structured data warehouse model (fact and dimension tables) to simulate production-level analytics infrastructure.
- **Advanced Analytics & Machine Learning**
  Exploring predictive modeling use cases such as:
  - Customer churn prediction
  - Revenue forecasting
  - Category-level performance forecasting

The long-term objective is to evolve from SQL-based analysis into full-stack data architecture and applied machine learning workflows.
