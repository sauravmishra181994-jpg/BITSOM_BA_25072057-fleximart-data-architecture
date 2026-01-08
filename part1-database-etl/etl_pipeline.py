#TASK 1.1

# The code performs ETL (Extract, Transform, Load) on three CSV files: sales_raw.csv, 
# customer_raw.csv, and product_raw.csv.
# Libraries used: pandas for data manipulation, re for phone standardization
# sqlalchemy for database loading

# note:-- imports are showing unresolved because dependencies are not installed in this runtime environment
##the code worked fine and executed in VSCode

import pandas as pd
import numpy as np
import re
from sqlalchemy import create_engine
from datetime import datetime


# Function to standardize phone numbers to +91-XXXXXXXXXX format
def standardize_phone(phone):
    if pd.isnull(phone):
        return 'Unknown'
    digits = re.sub(r'\D', '', str(phone))
    if len(digits) > 10:
        digits = digits[-10:]
    return f'+91-{digits}'


# Function to standardize dates to YYYY-MM-DD
def standardize_date(date_str):
    formats = ['%Y-%m-%d', '%d/%m/%Y', '%m-%d-%Y', '%d-%m-%Y', '%m/%d/%Y']
    for fmt in formats:
        try:
            return pd.to_datetime(date_str, format=fmt).strftime('%Y-%m-%d')
        except ValueError:
            pass
    return None  # If there is no format matches


# Extract and Transform Customer data
df_customer = pd.read_csv('customer_raw.csv')
original_customer = len(df_customer)
nulls_customer = df_customer.isnull().sum().sum()
df_customer = df_customer.drop_duplicates()
dups_customer = original_customer - len(df_customer)
df_customer['email'] = df_customer['email'].fillna('unknown@email.com')
df_customer['phone'] = df_customer['phone'].apply(standardize_phone)
df_customer['registration_date'] = df_customer['registration_date'].apply(standardize_date)
df_customer = df_customer.dropna(subset=['registration_date'])
# Adding surrogate key
df_customer['sk_customer_id'] = range(1, len(df_customer) + 1)
clean_customer = len(df_customer)


df_customer.head()



# Extract and Transform Product data
df_product = pd.read_csv('product_raw.csv')
original_product = len(df_product)
nulls_product = df_product.isnull().sum().sum()
df_product = df_product.drop_duplicates()
dups_product = original_product - len(df_product)
df_product['category'] = df_product['category'].str.title()
df_product['price'] = df_product['price'].fillna(0.0)
df_product['stock_quantity'] = df_product['stock_quantity'].fillna(0)
# Adding surrogate key
df_product['sk_product_id'] = range(1, len(df_product) + 1)
clean_product = len(df_product)


df_product.head()

# Extract and Transform Sales data
df_sales = pd.read_csv('sales_raw.csv')
orig_sales = len(df_sales)
nulls_sales = df_sales.isnull().sum().sum()
df_sales = df_sales.drop_duplicates()
dups_sales = orig_sales - len(df_sales)
df_sales['customer_id'] = df_sales['customer_id'].fillna('Unknown')
df_sales['product_id'] = df_sales['product_id'].fillna('Unknown')
df_sales['transaction_date'] = df_sales['transaction_date'].apply(standardize_date)
df_sales = df_sales.dropna(subset=['transaction_date'])  # Drop if date cannot be parsed
# Adding surrogate key
df_sales['sk_transaction_id'] = range(1, len(df_sales) + 1)
clean_sales = len(df_sales)


df_sales.head()


# Generate data quality report
with open('data_quality_report.txt', 'w') as f:
    f.write("Data Quality Report :-\n")
   
    f.write(" For Sales Data:---\n")
    f.write(f"Number of processed records: {orig_sales}\n")
    f.write(f"Number of duplicates removed: {dups_sales}\n")
    f.write(f"Number of missing values handled: {nulls_sales}\n")
    f.write(f"Number of records loaded successfully: {clean_sales}\n\n")
    f.write("For Customer Data:---\n")
    f.write(f"Number of processed records {original_customer}\n")
    f.write(f"Number of duplicates removed: {dups_customer}\n")
    f.write(f"Number of missing values handled: {nulls_customer}\n")
    f.write(f"Number of records loaded successfully: {clean_customer}\n\n")
    f.write("For Product Data:---\n")
    f.write(f"Number of processed records: {original_product}\n")
    f.write(f"Number of duplicates removed: {dups_product}\n")
    f.write(f"Number of missing values handled: {nulls_product}\n")
    f.write(f"Number of records loaded successfully: {clean_product}\n")



    # import file for connecting to mysql and connection
# i have used this in terminal:- "pip install mysql-connector-python", 
# also used "pip install python-dotenv" in terminal

import _mysql_connector
from dotenv import load_dotenv
import os

def upload_data_db(df: pd.DataFrame, table_name):
    load_dotenv()
    #creating host details:-
    conn_string = mysql.connector.connect(
        host=os.getenv("MYSQL_HOST_URL"),
        user=os.getenv("MYSQL_USER"),
        password=os.getenv("MYSQL_PWD"),
        database=os.getenv("MYSQL_DB")
    )
    #initiating a cursor:-
    cursor = conn_string.cursor()
    
    #inserting data into database:-
    cols_names = ", ".join(df.columns)
    placeholder = ", ".join(["%s"] * len(df.columns))
    sql = f"""
        INSERT INTO {os.getenv('MYSQL_DB')}.{table_name} ({cols_names})
        VALUES ({placeholder})
    """
    cursor.executemany(sql, df.values.tolist())
    conn_string.commit()
    cursor.close()
    conn_string.close() 
