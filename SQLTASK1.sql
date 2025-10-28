CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255)
    );
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description VARCHAR(255)
);
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (name, email, address) VALUES
('Ravi Kumar', 'ravi@gmail.com', 'Bangalore'),
('Priya Sharma', 'priya@gmail.com', 'Chennai'),
('Arun Raj', 'arun@gmail.com', 'Hyderabad');

INSERT INTO products (name, price, description) VALUES
('Product A', 50.00, 'High quality item A'),
('Product B', 80.00, 'Durable item B'),
('Product C', 40.00, 'Affordable item C'),
('Product D', 100.00, 'Premium item D');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, CURDATE() - INTERVAL 10 DAY, 200.00),
(2, CURDATE() - INTERVAL 40 DAY, 120.00),
(3, CURDATE() - INTERVAL 5 DAY, 300.00);

SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;


SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;

UPDATE products
SET price = 45.00
WHERE id = 3;

ALTER TABLE products
ADD COLUMN discount DECIMAL(5,2) DEFAULT 0.00;

SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3;

SELECT c.name, o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id;

SELECT * FROM orders
WHERE total_amount > 150.00;

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),  -- Ravi ordered 2 of Product A
(2, 3, 1),  -- Priya ordered 1 of Product C
(3, 4, 3);  -- Arun ordered 3 of Product D

SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';

SELECT AVG(total_amount) AS average_order_total
FROM orders;