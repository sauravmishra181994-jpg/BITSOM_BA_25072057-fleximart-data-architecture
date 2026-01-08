 ## TASK 1.2:- Database Schema Documentation  

 1) Entity-Relationship Description (Text Format)
 
ENTITY: df_customer
Purpose: Stores unique customer information after cleaning and deduplication
Attributes:

sk_customer_id       INTEGER          Surrogate primary key (auto-increment)
customer_id          VARCHAR(10)      Unique identifier for each customer
first_name           VARCHAR(50)      Customer's first name
last_name            VARCHAR(50)      Customer's last name
email                VARCHAR(100)     Customer's email address
phone                VARCHAR(20)      Standardized phone number (+91-XXXXXXXXXX format)
city                 VARCHAR(50)      City of residence
registration_date    DATE             Date when customer registered

Relationships: One customer can place MANY sales transactions (1:M with sales)
 Note that:-  Surrogate keys `sk_` are used for internal reference integrity and future-proofing 

ENTITY: df_product
Purpose: Stores product catalog information with standardized categories
Attributes:

sk_product_id        INTEGER          Surrogate primary key (auto-increment)
product_id           VARCHAR(10)      Unique product identifier 
product_name         VARCHAR(100)     Full name/description of the product
category             VARCHAR(50)      Product category  
price                DECIMAL(10,2)    Standard selling price
stock_quantity       INTEGER          Current stock level (0 if any vaue is missing)

Relationships: One product can appear in MANY sales transactions (1:MANY with sales)


ENTITY: df_sales
Purpose: Stores  transactional data with surrogate keys for analysis
Attributes:

sk_transaction_id    INTEGER          Surrogate primary key (auto-increment)
transaction_id       VARCHAR(10)      Unique transaction identifier
customer_id          VARCHAR(10)      References original customer_id ('Unknown' if missing)
product_id           VARCHAR(10)      References original product_id ('Unknown' if missing)
quantity             INTEGER          Number of units sold
unit_price           DECIMAL(10,2)    Price per unit at time of sale
transaction_date     DATE             Standardized date of transaction (YYYY-MM-DD)
status               VARCHAR(20)      Transaction status (Completed, Pending, Cancelled)

Relationships:
    Many sales ←→ One customer (M:1 with customer via customer_id)
    Many sales ←→ One product   (M:1 with product via product_id)




2)  Normalization Explanation (3NF)

    The current schema design is in Third Normal Form (3NF).

     Identifying Functional Dependencies:- 
    => df_customer: `customer_id → {first_name, last_name, email, phone, city, registration_date}`
    => df_product: `product_id → {product_name, category, price, stock_quantity}`
    => df_sales: `sk_transaction_id → {transaction_id, customer_id, product_id, quantity, unit_price, transaction_date, status}`  
`transaction_id` is not used as PK because there were duplicates in source data

    (Q) Why the design satisfies 3NF ?
    1. 1NF — all attributes are atomic (no repeating groups or multi-valued attributes).
    2. 2NF — no partial dependencies exist because  all non-key attributes in each table depend on the entire primary key .
    3. 3NF— there are no transitive dependencies: All non-key attributes depend only on the primary key and not on other non-key attributes.
        
        
    (Q) How the design avoids common anomalies ?
    =>Update anomaly — Changing a customer's phone number requires only one update  instead of updating multiple sales rows.
    =>Insert anomaly — A new customer can be added even if they haven't made any purchase yet 
    =>Delete anomaly — Deleting a completed transaction does not remove the customer or product   information, preserving historical reference 

    The use of surrogate keys, separation of concerns, and preservation of original business keys while removing duplicates/transitive ones result in a clean, maintainable, and analytically friendly schema in 3 Normal Form.




3) Sample Data Representation
# df_customer (2 sample records)

| sk_customer_id | customer_id | first_name | last_name | email                    | phone           | city      | registration_date |
|----------------|-------------|------------|-----------|--------------------------|-----------------|-----------|-------------------|
| 1              | C001        | Rahul      | Sharma    | rahul.sharma@gmail.com   | +91-9876543210  | Bangalore | 2023-01-15        |
| 2              | C002        | Priya      | Patel     | priya.patel@yahoo.com    | +91-9988776655  | Mumbai    | 2023-02-20        |

# df_product (2 sample records)

| sk_product_id | product_id | product_name            | category     | price    | stock_quantity |
|---------------|------------|-------------------------|--------------|----------|----------------|
| 2             | P002       | Nike Running Shoes      | Fashion      | 3499.00  | 80             |
| 3             | P009       | Basmati Rice 5kg        | Groceries    | 650.00   | 300            |

# df_sales (2 sample records)

| sk_transaction_id | transaction_id | customer_id | product_id | quantity | unit_price | transaction_date | status     |
|-------------------|----------------|-------------|------------|----------|------------|------------------|------------|
| 1                 | T001           | C001        | P001       | 1        | 45999.00   | 2024-01-15       | Completed  |
| 2                 | T002           | C002        | P004       | 2        | 2999.00    | 2024-01-16       | Completed  |
