# BITSOM_BA_25072057-fleximart-data-architecture

# FlexiMart Data Architecture Project

**Student Name:** SAURAV MISHRA  
**Student ID:**  BITSOM_BA_25072057
**Email:** saurav.mishra181994@gmail.com 
**Date:** January 2026

## Project Overview

This project implements a complete modern data architecture for FlexiMart, a mid-sized retail chain specializing in groceries and daily essentials.  
The system covers three main layers:  
- Relational OLTP database with ETL pipeline  
- NoSQL product catalog for flexible item attributes  
- Star-schema Data Warehouse optimized for business analytics and reporting

The architecture demonstrates the movement from operational data → cleaned & enriched OLTP → document-based product catalog → analytical data warehouse.

## Repository Structure


├── part1-database-etl/
│   ├── etl_pipeline.py              # Main ETL script (extract → transform → load)
│   ├── schema_documentation.md      # Detailed table descriptions + ER diagram explanation
│   ├── business_queries.sql         # 8–10 analytical/business-oriented SQL queries
│   └── data_quality_report.txt      # Summary of data quality checks & issues found/fixed
│
├── part2-nosql/
│   ├── nosql_analysis.md            # Design decisions & comparison relational vs document model
│   ├── mongodb_operations.js        # CRUD + aggregation examples in MongoDB shell syntax
│   └── products_catalog.json        # Sample exported product documents
│
├── part3-datawarehouse/
│   ├── star_schema_design.md        # Dimensional modeling decisions + star/snowflake explanation
│   ├── warehouse_schema.sql         # Fact & dimension table creation scripts
│   ├── warehouse_data.sql           # INSERT statements / ETL loading into DW
│   └── analytics_queries.sql        # Business KPI queries(sales trends, top products, customer segments)
│
└── README.md                        # This file

Technologies Used

Programming      : Python 3.7+
Data Processing  : pandas
Relational DB    : MySQL 8.0 
NoSQL DB         : MongoDB 6.0
ETL/Loading      : Native Python + mysql-connector-python / pymongo
Querying         : SQL & MongoDB Aggregation Pipeline

Setup Instructions
1. Prerequisites

MySQL 8.0+ server running 
MongoDB 6.0+ server running 
Python 3.10+ with required packages

# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql
## Key Learnings

Designing hybrid architectures (RDBMS + NoSQL + Data Warehouse) helps  to think about where different types of questions are best answered.
Proper dimensional modeling (star schema) dramatically improves query performance and simplifies reporting compared to querying normalized OLTP tables.
ETL processes need careful data quality handling — especially dealing with missing values, duplicates, and referential integrity across systems.
MongoDB shines for flexible, hierarchical product data, while relational databases remain superior for transactional consistency and complex joins.

## Challenges Faced & Solutions

Inconsistent source data formats & missing values:-
→ Implemented multi-stage cleaning in pandas (null handling, type coercion, deduplication) + logging of rejected/invalid records
Slowly changing dimensions (customer/product attributes)
→ Chose Type 2 SCD for products & customers in data warehouse to preserve historical 
Issues in connecting to databases