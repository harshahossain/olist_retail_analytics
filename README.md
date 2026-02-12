# End-to-End E-Commerce Analytics Case Study

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

### Key Revenue Insights

- Total revenue generated: ~16M
- Average order value: ~161
- Strong growth throughout 2017
- Major seasonal spike in November 2017 (likely Black Friday)
- 2018 shows stabilized monthly revenue around ~1M
- Late 2018 decline reflects dataset cutoff, not performance drop

### Key Geographic Insights

- **_São Paulo (SP)_** contributes ~37.5% of total revenue, making it the dominant market.
- **_Rio de Janeiro (RJ)_** and **_Minas Gerais (MG)_** contribute ~13.4% and ~11.7% respectively. Together with SP, the top three states account for ~62.6% of total revenue, highlighting geographic concentration.
- **_Rio Grande do Sul(RS), Paraná(PR),_** and **_Santa Catarina(SC)_** make up smaller but notable portions (~5–4% each).
- SP drives **_high order volume_** (41,745 orders) but **_lower Average Order Value_** (~143.69), suggesting high-frequency but lower-value purchases.
- RJ shows **_fewer orders_** but a **_higher AOV(Average Order Value)_** (~166.85), indicating more premium spending behavior.
- This distribution indicates strategic opportunities:
  - Expand into lower-revenue states to diversify risk
  - Tailor marketing or product offerings per state based on order behavior

These insights make clear where revenue is concentrated and where growth opportunities exist.

### Key Category Insights

**Revenue Distribution**

- The top-performing category is **_beleza_saude(Beauty & Health)_**, contributing ~9.1% of total revenue (~1.44M).
- No single category dominates revenue — even the highest category contributes less than 10%, indicating strong product diversification.
- The top 10 categories together account for ~62% of total revenue.

This suggests the marketplace is not dependent on a single product vertical.

**Category Performance Patterns**

- Categories like **_cama_mesa_banho(Bed Table Bath)_** and **_beleza_saude(Beauty & Health)_** generate high order volume with moderate AOV(Average Order Value), indicating recurring consumer demand.
- Categories such as **_relogios_presentes(Gift Watches)_**, **_moveis_escritorio(Office Furniture)_**, and **_instrumentos_musicais(Musical Instrument)_** show significantly higher Average Order Values, reflecting premium or discretionary purchases.
- Extremely high-ticket categories like **_pcs(Computers)_** have very high AOV(Average Order Value) (~1286) but low order volume, contributing revenue spikes rather than steady volume.

This highlights a mix of:

- Stable, repeat-demand products
- Higher-margin, lower-frequency premium good-

**Pareto (80/20) Analysis**

- Approximately **_17 product categories (~24% of total categories)_** generate **_~80% of total revenue._**
- The remaining ~75% of categories contribute only ~20% of revenue, forming a classic long-tail distribution.
- This structure indicates a strong revenue core supported by a broad assortment catalog.

**Data Quality Observation**

- **_~1.31%_** of total revenue (~207K) is associated with products **_missing a category_** label.
- While not materially large, this indicates minor data classification inconsistencies that could affect reporting accuracy.

### Key Customer Insights

- 97% of customers are one-time buyers; only 3% are repeat buyers.
- Repeat customers generate only ~5% of total revenue (~864K).
- Majority of revenue comes from new customer acquisition.
- Retention-focused strategies represent significant revenue opportunity.
