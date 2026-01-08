# Part 3: Data Warehouse and Analytics

## Overview
This part builds a star-schema data warehouse for FlexiMart to support historical sales analysis and OLAP reporting.

Goals:
- To design and document a classic star schema
- To populate the warehouse with realistic sample data
- To write analytical SQL queries for business insights

folder contents:- 

part3-datawarehouse/
├── README.md              ← This file
├── star_schema_design.md  ← Schema description, decisions & data flow example
├── warehouse_schema.sql   ← DDL for dim_date, dim_product, dim_customer, fact_sales
├── warehouse_data.sql     ← INSERT statements (
└── analytics_queries.sql  ← 3 OLAP queries with business scenarios


# Task 3.1 – Star Schema Design (star_schema_design.md)
- Schema Overview: Text description of fact_sales + 3 dimensions (date, product, customer)
- Design Decisions: Granularity, surrogate keys, drill-down/roll-up support
- **Sample Data Flow: Example showing how one sales transaction maps to the warehouse

# Task 3.2 – Implementation
- `warehouse_schema.sql`: Provided DDL -code was already shared
- `warehouse_data.sql`:  inserts meeting minimum requirements

# Task 3.3 – OLAP Queries (analytics_queries.sql)
1. Monthly Sales Drill-Down
   Year → Quarter → Month totals (total_sales, total_quantity)

2. Top 10 Products by Revenue 
   Product name, category, units sold, revenue, % of total revenue

3. Customer Segmentation 
   High / Medium / Low value customers (count, total revenue, avg spend)

 how to use
1. Create database `fleximart_dw`
2. Run `warehouse_schema.sql`
3. Run `warehouse_data.sql`
4. Execute queries in `analytics_queries.sql` to verify results

 tyechnologies
- Database: MySQL / PostgreSQL compatible
