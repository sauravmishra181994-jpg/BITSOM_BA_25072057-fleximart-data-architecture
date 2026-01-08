# Part 2: NoSQL Database Analysis – MongoDB for FlexiMart Product Catalog

## Overview
This section evaluates the suitability of MongoDB (a document-oriented NoSQL database) for managing FlexiMart's rapidly expanding and highly diverse product catalog

The main goals are:
- Understand the limitations of RDBMS when dealing with variable product attributes
- Demonstrate how MongoDB's flexible schema and embedded documents solve these challenges
- Identify realistic trade-offs
- Implement practical MongoDB operations using the provided sample product catalog

 Folder Contents:-

part2-nosql/
├── README.md                ← This file
├── nosql_analysis.md        ← Theoretical justification report (Task 2.1)
├── mongodb_operations.js    ← All MongoDB queries & operations (Task 2.2)
└── products_catalog.json    ← Provided sample data (10 products)

## Task 2.1 – NoSQL Justification Report (nosql_analysis.md)

This markdown file contains a structured analysis  covering:

Section A: Limitations of RDBMS
Explains why a traditional relational database (MySQL/PostgreSQL) struggles with:
- Highly variable product attributes across categories
- Frequent schema changes when introducing new product types
- Efficient storage and querying of nested customer reviews

Section B: NoSQL Benefits with MongoDB  
Describes how MongoDB addresses the above issues through:
- Schema flexibility (schemaless documents)
- Embedded documents & arrays (e.g. reviews inside product documents)
- Horizontal scalability for growing catalog volume

section C: Trade-offs   
Highlights two major disadvantages of choosing MongoDB over a relational database for this use-case.

## Task 2.2 – MongoDB Implementation (mongodb_operations.js)

This JavaScript file contains ready-to-execute MongoDB operations that can be run in  MongoDB Compass query bar.

### Operations Implemented:

1. Data Loading  
   Instructions to import `products_catalog.json` into the `products` collection

2. Basic Query* 
   Find Electronics products under ₹50,000 → returns name, price, stock

3. Review Analysis  
   Find products with average rating ≥ 4.0 using aggregation pipeline

4. Update Operation 
   Add a new customer review to product "ELEC001"


Technologies Used

1) Database: MongoDB v6.0+ 
2) Data format: JSON documents with nested objects and arrays
Q3) uery language: MongoDB Query Language 

Learning Outcomes

1) Understood when NoSQL is preferable to RDBMS
2) Encountered schema flexibility in practice
3) Wrote basic to intermediate MongoDB queries and aggregations
4) Recognized real-world trade-offs in database selection