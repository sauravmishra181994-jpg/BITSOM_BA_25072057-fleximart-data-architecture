
## TASK 2.1
## Section A: Limitations of RDBMS 

The current relational database struggles significantly with product catalog diversity 

1) Products with varying attributes:-
   different product types (laptops, shoes, etc.) require different attributes. In a relational model, this forces either  a single wide table with hundreds of mostly-NULL columns, or an Entity-Attribute-Value  model which is notoriously slow and complex to query. 
2) Frequent schema changes:-
   every time a new product category is introduced , the schema must be altered (new columns or new tables). In a live production system, these ALTER TABLE operations can cause downtime, locking, or require complex migrations 
3) Storing nested customer reviews:-
   reviews from customers are naturally hierarchical. In RDBMS, this requires separate tables  with multiple JOINs, leading to complex queries, performance degradation with large volumes, and difficulty in retrieving a complete review thread efficiently.



## Section B: NoSQL Benefits 

MongoDB addresses the relational pain points effectively through its document-oriented, schema-flexible design.

1) Flexible schema:-
   Each product is stored as a single document. Laptops can have fields like `ram`, `processor` ; shoes can have `size`, `color` — all without affecting other products. New attributes can be added to any document at any time without schema migration.
2) Embedded documents for reviews:-
   Customer reviews can be stored as an array of embedded sub-documents directly inside the product document:
    for example-
   {
     "_id": "P001",
     "name": "Samsung Galaxy S21",
     "reviews": [
       { "user": "Rahul", "rating": 5, "comment": "Great camera!", "date": "2024-02-10" },
       { "user": "Priya", "rating": 4, "comment": "Battery drains fast" }
     ]
   }
This code eliminates JOINs, enables atomic updates, and allows fast retrieval of complete product + reviews in one operation.
3) Horizontal scalability:-
MongoDB scales out easily by adding more servers. Product catalog and review data can be distributed across clusters, supporting millions of products and high read/write traffic — something vertical scaling in MySQL quickly becomes expensive.


## Section C: Trade-offs (Disadvantages of MongoDB vs MySQL)

1) Weaker consistency guarantees:-
MongoDB offers eventual consistency by default, whereas MySQL provides ACID transactions. For financial data (orders, payments) this can be risky however, product catalog is usually more  tolerant of slight eventual consistency.
2) Higher storage overhead & complex queries:-
Embedding reviews increases storage due to data duplication (same customer info repeated across products). Complex analytical queries (e.g., "average rating per category across all products") often require aggregation pipelines that are more difficult to write compared to SQL JOINs with GROUP BY.


