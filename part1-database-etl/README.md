# Part 1: Database Design and ETL Pipeline

## Overview
This section handles data insertion, cleaning, and loading of raw FlexiMart CSV files into a relational database (MySQL), along with schema documentation and key business queries.

Goals:
- Build a robust ETL pipeline to handle real-world data quality issues
- Document a normalized 3NF schema
- Deliver analytical SQL queries for business insights

## Folder Contents
part1-database-etl/
├── README.md                ← This file
├── etl_pipeline.py          ← Complete ETL script (extract → transform → load)
├── schema_documentation.md  ← ER description, 3NF justification, sample data
├── business_queries.sql     ← 3 analytical business queries
├── data_quality_report.txt  ← Auto-generated report 
└── requirements.txt         ← Python dependencies
## Key Deliverables

 Task 1.1 – ETL Pipeline (etl_pipeline.py)
- Reads: customers_raw.csv, products_raw.csv, sales_raw.csv
- Cleans: duplicates, missing values, phone formats, categories, dates
- Loads: Into 4 tables (customers, products, orders, order_items)
- Generates: data_quality_report.txt with stats

 Task 1.2 – Schema Documentation (schema_documentation.md)
- Text-based ER description of all 4 tables + relationships
- 3NF justification (functional dependencies & anomaly prevention)
- Sample records from each table

 Task 1.3 – Business Queries (business_queries.sql)
1. Customer purchase history  
   Customers with ≥2 orders and >₹5,000 spent (name, email, orders, total)

2. Product Sales Analysis  
   Category performance: # products, qty sold, revenue (>₹10k)

3. monthly Sales Trend 2024  
   Month name, orders, revenue, cumulative revenue (running total)

How to Run
1. Install dependencies: `pip install -r requirements.txt`
2. Update Database credentials in  script
3. Run ETL: `python etl_pipeline.py`
4. Execute queries in `business_queries.sql` against `fleximart` database

 Technologies
- Python: pandas, SQLAlchemy
- Database: MySQL 
- Schema: 3NF normalized relational design