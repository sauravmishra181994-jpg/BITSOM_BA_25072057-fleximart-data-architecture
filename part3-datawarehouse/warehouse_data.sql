-- TASK 3.2  warehouse_data.sql


-- Sample data population for FlexiMart Data Warehouse


USE fleximart_dw;
-- 1. dim_date - 30 days (Jan-Feb 2024)

INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday',    1, 1, 'January',   'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday',   2, 1, 'January',   'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January',   'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday',  4, 1, 'January',   'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday',    5, 1, 'January',   'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday',  6, 1, 'January',   'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday',    7, 1, 'January',   'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday',    8, 1, 'January',   'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January',   'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday',   14, 1, 'January',   'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday',   15, 1, 'January',   'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January',   'Q1', 2024, TRUE),
(20240121, '2024-01-21', 'Sunday',   21, 1, 'January',   'Q1', 2024, TRUE),
(20240126, '2024-01-26', 'Friday',   26, 1, 'January',   'Q1', 2024, FALSE), 
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January',   'Q1', 2024, TRUE),
(20240128, '2024-01-28', 'Sunday',   28, 1, 'January',   'Q1', 2024, TRUE),
(20240201, '2024-02-01', 'Thursday',  1, 2, 'February', 'Q1', 2024, FALSE),
(20240202, '2024-02-02', 'Friday',    2, 2, 'February', 'Q1', 2024, FALSE),
(20240203, '2024-02-03', 'Saturday',  3, 2, 'February', 'Q1', 2024, TRUE),
(20240204, '2024-02-04', 'Sunday',    4, 2, 'February', 'Q1', 2024, TRUE),
(20240205, '2024-02-05', 'Monday',    5, 2, 'February', 'Q1', 2024, FALSE),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, TRUE),
(20240211, '2024-02-11', 'Sunday',   11, 2, 'February', 'Q1', 2024, TRUE),
(20240214, '2024-02-14', 'Wednesday',14, 2, 'February', 'Q1', 2024, FALSE), 
(20240217, '2024-02-17', 'Saturday', 17, 2, 'February', 'Q1', 2024, TRUE),
(20240218, '2024-02-18', 'Sunday',   18, 2, 'February', 'Q1', 2024, TRUE),
(20240224, '2024-02-24', 'Saturday', 24, 2, 'February', 'Q1', 2024, TRUE),
(20240225, '2024-02-25', 'Sunday',   25, 2, 'February', 'Q1', 2024, TRUE),
(20240228, '2024-02-28', 'Wednesday',28, 2, 'February', 'Q1', 2024, FALSE),
(20240229, '2024-02-29', 'Thursday', 29, 2, 'February', 'Q1', 2024, FALSE); 


-- 2. dim_product - 15 products

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001', 'Samsung Galaxy S23 ',   'Electronics', 'mobile',     124999.00),
('P002', 'Apple MacBook Air ',       'Electronics', 'Laptops',          99999.00),
('P003', 'Sony WH-1000XM5',            'Electronics', 'Headphones',       29990.00),
('P004', 'Nike Air Zoom Pegasus ',   'Fashion',     'Sports Shoes',      12999.00),
('P005', 'Levis 501 Original Jeans', 'Fashion',     'Denim',             4599.00),
('P006', 'Adidas Originals T-shirt',   'Fashion',     'Casual Wear',       2599.00),
('P007', 'Woodland Trekking Shoes',    'Fashion',     'Outdoor',           5999.00),
('P008', 'Basmati Rice 5kg',           'Groceries',   'Staples',            650.00),
('P009', 'Organic Honey 1kg',          'Groceries',   'Sweeteners',         399.00),
('P010', 'Fortune Sunflower Oil ',   'Groceries',   ' Oil',        899.00),
('P011', 'Dettol Handwash ',      'Groceries',   'Personal ',      129.00),
('P012', 'iPhone 14 Pro 128GB',        'Electronics', 'MOBILE ',    119900.00),
('P013', 'Dell 27  Monitor',        'Electronics', 'Monitors',         28990.00),
('P014', 'Puma Running Shoes',         'Fashion',     'Sports Shoes',      4999.00),
('P015', 'Masoor Dal 1kg',             'Groceries',   'Pulses',             145.00);


-- 3. dim_customer - 12 customers

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001', 'Rahul Sharma',      'Bangalore',  'Karnataka',    'High'),
('C002', 'Priya Patel',       'Mumbai',     'Maharashtra',  'Medium'),
('C003', 'Amit Kumar',        'Delhi',      'Delhi',        'High'),
('C004', 'Sneha Reddy',       'Hyderabad',  'Telangana',    'Medium'),
('C005', 'Vikram Singh',      'Chennai',    'Tamil Nadu',   'Low'),
('C006', 'Anjali Mehta',      'Bangalore',  'Karnataka',    'Medium'),
('C007', 'Ravi Verma',        'Pune',       'Maharashtra',  'High'),
('C008', 'Pooja Iyer',        'Bangalore',  'Karnataka',    'Low'),
('C009', 'Karthik Nair',      'Kochi',      'Kerala',       'Medium'),
('C010', 'Neha Shah',         'Ahmedabad',  'Gujarat',      'High'),
('C011', 'Manish Joshi',      'Jaipur',     'Rajasthan',    'Low'),
('C012', 'Divya Menon',       'Bangalore',  'Karnataka',    'Medium');


-- 4. fact_sales - 40 transactions

INSERT INTO fact_sales 
    (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
-- January 
(20240106, 1,  1, 1, 124999.00, 0.00, 124999.00),   
(20240106, 4,  2, 2,  12999.00, 0.00,  25998.00),   
(20240107, 8,  3, 5,    650.00, 0.00,   3250.00),
(20240107, 9,  4, 3,    399.00, 0.00,   1197.00),
(20240113, 2,  7, 1,  99999.00, 0.00,  99999.00),   
(20240113, 12, 10, 1, 119900.00, 0.00, 119900.00),
(20240114, 6,  6, 4,   2599.00, 0.00,  10396.00),
(20240115, 3,  1, 2,  29990.00, 1500.00, 58480.00),
(20240120, 13, 3, 1,  28990.00, 0.00,   28990.00),

-- February 
(20240203, 1,  7, 1, 124999.00, 5000.00, 119999.00),
(20240203, 12, 10, 1, 119900.00, 4000.00, 115900.00),
(20240204, 4,  2, 3,  12999.00, 0.00,   38997.00),
(20240210, 5,  5, 2,   4599.00, 0.00,    9198.00),
(20240211, 7,  8, 1,   5999.00, 300.00,   5699.00),
(20240214, 6,  9, 5,   2599.00, 0.00,   12995.00),   
(20240214, 9,  4, 4,    399.00, 0.00,    1596.00),
(20240108, 10, 11, 6,    899.00, 0.00,   5394.00),
(20240126, 11, 12, 8,    129.00, 0.00,   1032.00),
(20240201, 15, 1,  10,   145.00, 0.00,   1450.00),
(20240205, 14, 6,  2,   4999.00, 0.00,   9998.00),
(20240217, 2,  3,  1,  99999.00, 0.00,  99999.00),
(20240218, 13, 7,  1,  28990.00, 0.00,  28990.00),
(20240224, 1,  10, 1, 124999.00, 0.00, 124999.00),

(20240102, 8,  5, 4,  650.00, 0.00,  2600.00),
(20240103, 9,  8, 3,  399.00, 0.00,  1197.00),
(20240104, 10, 9, 2,  899.00, 0.00,  1798.00),
(20240105, 11, 11, 7,  129.00, 0.00,   903.00),
(20240127, 15, 12, 12, 145.00, 0.00,  1740.00),
(20240202, 4,  1,  1, 12999.00, 0.00, 12999.00),
(20240202, 5,  2,  2,  4599.00, 0.00,  9198.00),
(20240225, 6,  4,  3,  2599.00, 0.00,  7797.00),
(20240121, 7,  6,  1,  5999.00, 0.00,  5999.00),
(20240228, 14, 7,  2,  4999.00, 0.00,  9998.00),
(20240110, 3,  3,  1, 29990.00, 0.00, 29990.00),
(20240111, 13, 10, 1, 28990.00, 0.00, 28990.00),
(20240209, 1,  1,  1,124999.00, 0.00,124999.00),
(20240216, 12, 3,  1,119900.00, 0.00,119900.00),
(20240223, 2,  7,  1, 99999.00, 0.00, 99999.00);