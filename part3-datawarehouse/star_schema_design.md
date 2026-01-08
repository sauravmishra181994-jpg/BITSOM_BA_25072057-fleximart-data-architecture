# TASK 3.1

# Star Schema Design - FlexiMart Data Warehouse

## Section 1: Schema Overview

The star schema for FlexiMart Data Warehouse follows a classic star schema design optimized for analytical queries and business intelligence reporting.  
It consists of one central fact table surrounded by dimension tables.

### FACT TABLE: fact_sales
grain:-  One row per product per order line item (lowest level of detail - order item level)

Business Process:- sales transactions (completed customer purchases)

Measures (Numeric Facts):-

- `quantity_sold`     → Number of units sold (integer)
- `unit_price`        → Price per unit at the time of sale (decimal)
- `discount_amount`   → Discount applied to this line item (decimal, default 0)
- `total_amount`      → Final amount paid for this line item  
  `(quantity_sold × unit_price - discount_amount)`

Foreign Keys / Dimension References:-

- `date_key`      → references `dim_date.date_key`  
- `product_key`   → references `dim_product.product_key`  
- `customer_key`  → references `dim_customer.customer_key`



### DIMENSION TABLE: dim_date

Purpose: - Time dimension for all time-based analysis, drill-down, and trend reporting

Type:-Conformed, role-playing dimension (single shared date dimension)

Key Attributes:-

- `date_key` (PK)       → Surrogate integer key (format: YYYYMMDD)
- `full_date`           → Actual calendar date (DATE type)
- `day_of_week`         → Name of day (Monday, Tuesday, ..., Sunday)
- `day_of_month`        → 1–31
- `month`               → 1–12
- `month_name`          → January, February, ..., December
- `quarter`             → Q1, Q2, Q3, Q4
- `year`                → Four-digit year (e.g., 2024)
- `is_weekend`          → Boolean (true for Saturday/Sunday)

Usage Examples: -
Year-over-year comparison, weekday vs weekend sales, seasonal trends, quarter-to-date reporting

### DIMENSION TABLE: dim_product

Purpose:-  Describes the products being sold – enables product hierarchy and category analysis

Type: - Type 1 Slowly Changing Dimension (full overwrite for simplicity)

Key Attributes:-

- `product_key` (PK)    → Surrogate auto-increment integer
- `product_id`          → Original business key / SKU (string)
- `product_name`        → Full product name/description
- `category`            → Major category (Electronics, Fashion, Groceries, etc.)
- `subcategory`         → More detailed classification (Smartphones, Denim, Cooking Oil, etc.)
- `unit_price`          → Current/list price of the product (for reference)

Usage EXAamples: - Top-selling categories, product performance ranking, category contribution analysis, price band analysis

### DIMENSION TABLE: dim_customer

Purpose: -Contains customer master data for segmentation, geographic, and customer lifetime value analysis

Type: -Type 1 Slowly Changing Dimension (full overwrite for simplicity)

Key Attributes:=

- `customer_key` (PK)   → Surrogate auto-increment integer
- `customer_id`         → Original customer identifier (string)
- `customer_name`       → Full name of customer
- `city`                → City of customer
- `state`               → State/region
- `customer_segment`    → Marketing segment (High, Medium, Low, New, etc.)

Usage examples:  
Geographic sales distribution, customer segmentation (RFM / value-based), top customers by revenue, regional performance

## Summary - Star Schema Characteristics

- Classic star schema (single fact table + multiple dimensions)
- Denormalized dimensions for query performance
- Surrogate keys used throughout for better performance and SCD handling
- Supports common OLAP operations:  
  - Slice & Dice  
  - Drill-down / Roll-up  
  - Year-over-year / Month-over-month comparison  


Section 2: Design Decisions 

Choice of granularity – transaction line-item level
The grain is defined at the individual order line-item level (one row per product sold in each order). This is the most granular level possible in a sales fact table and provides maximum analytical flexibility. It allows reporting at any level while still supporting easy aggregation (SUM, COUNT) for higher-level summaries. Choosing a higher grain (e.g. per order) would lose the ability to analyze product-level performance, mix of products in baskets, or category contribution within individual transactions.

Use of surrogate keys instead of natural keys
Surrogate keys (auto-increment integers) are used instead of natural keys (product_id, customer_id, YYYYMMDD) for several reasons:-
1) Better performance (smaller index size and  faster joins)
2) Protection from source system changes (e.g., product code format change)
3) Support for Slowly Changing Dimensions  in the future
4) Consistent key length and type across all dimensions

Support for drill-down and roll-up operations
The design fully supports OLAP operations:
Roll-up: Easy aggregation along any dimension (e.g., SUM(total_amount) GROUP BY year → quarter → month, or category → subcategory)
Drill-down: Detailed attributes in dimensions (day_of_week, is_weekend, subcategory, city/state) enable going from summary to granular levels (e.g., total sales by quarter → by weekend days → by specific product in specific city) without changing the fact table structure.



Section 3: Sample Data Flow


Source Transaction:
Order #101, Customer "John Doe", Product "Laptop", Qty: 2, Price: 50000

Becomes in Data Warehouse:
fact_sales: {
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  total_amount: 100000
}

dim_date: {date_key: 20240115, full_date: '2024-01-15', month: 1, quarter: 'Q1'...}
dim_product: {product_key: 5, product_name: 'Laptop', category: 'Electronics'...}
dim_customer: {customer_key: 12, customer_name: 'John Doe', city: 'Mumbai'...}

