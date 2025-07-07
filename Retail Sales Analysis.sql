use my_db3;
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  region VARCHAR(50)
);
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2)
);
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  quantity INT,
  order_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1, 'Sneha Sen', 'East'),
(2, 'Arjun Roy', 'West'),
(3, 'Priya Das', 'North'),
(4, 'Tanvi Paul', 'South'),
(5, 'Raj Mehra', 'East'),
(6, 'Ishita Bose', 'West'),
(7, 'Vikram Sinha', 'North'),
(8, 'Neha Kumari', 'South'),
(9, 'Sourav Ghosh', 'East'),
(10, 'Nisha Yadav', 'North');
INSERT INTO products VALUES
(1, 'Bluetooth Speaker', 'Electronics', 1500.00),
(2, 'Office Chair', 'Furniture', 4500.00),
(3, 'Notebook Set', 'Stationery', 200.00),
(4, 'Laptop Bag', 'Accessories', 1200.00),
(5, 'Desk Lamp', 'Furniture', 900.00),
(6, 'Wireless Mouse', 'Electronics', 700.00),
(7, 'Pen Pack', 'Stationery', 100.00),
(8, 'Monitor 24"', 'Electronics', 8500.00);
INSERT INTO orders VALUES
(101, 1, 1, 2, '2024-12-12'),
(102, 2, 2, 1, '2024-12-18'),
(103, 3, 3, 10, '2025-01-05'),
(104, 4, 4, 1, '2025-01-10'),
(105, 5, 5, 2, '2025-02-02'),
(106, 6, 6, 3, '2025-02-12'),
(107, 7, 7, 15, '2025-02-20'),
(108, 8, 8, 1, '2025-03-01'),
(109, 9, 1, 1, '2025-03-10'),
(110, 10, 2, 1, '2025-03-15'),
(111, 1, 6, 2, '2025-04-01'),
(112, 2, 4, 1, '2025-04-04'),
(113, 3, 3, 5, '2025-04-10'),
(114, 4, 5, 1, '2025-05-05'),
(115, 5, 2, 2, '2025-05-10'),
(116, 6, 7, 10, '2025-05-20'),
(117, 7, 1, 1, '2025-06-01'),
(118, 8, 8, 2, '2025-06-05'),
(119, 9, 6, 1, '2025-06-10'),
(120, 10, 4, 1, '2025-06-15');

select * from customers; 
select * from orders; 
select * from products;

-- Monthly sales by region
SELECT region, MONTH(order_date) AS month,
       SUM(p.price * o.quantity) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY region, MONTH(order_date);

--  Top 5 customers by total spend
SELECT c.customer_name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Sales by category
SELECT p.category, SUM(p.price * o.quantity) AS category_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

-- Average order value
SELECT AVG(p.price * o.quantity) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Sales trend by month
SELECT MONTH(order_date) AS month, 
       SUM(p.price * o.quantity) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY MONTH(order_date);

