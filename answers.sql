-- ============================================
-- DATABASE CREATION
-- ============================================
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

-- ============================================
-- TABLE: country
-- ============================================
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Insert data into country
INSERT INTO country (country_name) VALUES ('United States'), ('Canada');

-- Select from country
SELECT * FROM country;

-- ============================================
-- TABLE: address_status
-- ============================================
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Insert data into address_status
INSERT INTO address_status (status_name) VALUES ('Current'), ('Old');

-- Select with WHERE
SELECT * FROM address_status WHERE status_name = 'Current';

-- ============================================
-- TABLE: address
-- ============================================
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(10),
    country_id INT,
    status_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Insert data into address
INSERT INTO address (street_address, city, state, postal_code, country_id, status_id)
VALUES 
('123 Main St', 'New York', 'NY', '10001', 1, 1),
('456 Maple Rd', 'Toronto', 'ON', 'M4B1B3', 2, 2);

-- Select with ORDER BY
SELECT * FROM address ORDER BY city ASC;

-- ============================================
-- TABLE: customer
-- ============================================
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15)
);

-- Insert data into customer
INSERT INTO customer (first_name, last_name, email, phone_number)
VALUES 
('Alice', 'Smith', 'alice@example.com', '1234567890'),
('Bob', 'Jones', 'bob@example.com', '9876543210');

-- Select with LIMIT
SELECT * FROM customer LIMIT 1;

-- ============================================
-- TABLE: customer_address
-- ============================================
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Insert data into customer_address
INSERT INTO customer_address (customer_id, address_id)
VALUES 
(1, 1),
(2, 2);

-- Select with JOIN
SELECT c.first_name, a.city
FROM customer_address ca
JOIN customer c ON ca.customer_id = c.customer_id
JOIN address a ON ca.address_id = a.address_id;

-- ============================================
-- TABLE: author
-- ============================================
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE
);

-- Insert data into author
INSERT INTO author (first_name, last_name, date_of_birth)
VALUES 
('George', 'Orwell', '1903-06-25'),
('Jane', 'Austen', '1775-12-16');

-- Select with WHERE
SELECT * FROM author WHERE last_name = 'Orwell';

-- ============================================
-- TABLE: book_language
-- ============================================
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- Insert data into book_language
INSERT INTO book_language (language_name)
VALUES ('English'), ('French');

-- Select all
SELECT * FROM book_language;

-- ============================================
-- TABLE: publisher
-- ============================================
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255)
);

-- Insert data into publisher
INSERT INTO publisher (name, address)
VALUES ('Penguin Books', '80 Strand, London'),
       ('HarperCollins', '195 Broadway, New York');

-- Select using pattern
SELECT * FROM publisher WHERE name LIKE '%Books%';

-- ============================================
-- TABLE: book
-- ============================================
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year INT,
    isbn VARCHAR(13) UNIQUE,
    language_id INT,
    publisher_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Insert data into book
INSERT INTO book (title, publication_year, isbn, language_id, publisher_id, price, stock_quantity)
VALUES 
('1984', 1949, '1234567890123', 1, 1, 15.99, 100),
('Pride and Prejudice', 1813, '9876543210987', 1, 2, 12.50, 80);

-- Select all
SELECT * FROM book;

-- ============================================
-- TABLE: book_author
-- ============================================
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Insert data into book_author
INSERT INTO book_author (book_id, author_id)
VALUES (1, 1), (2, 2);

-- Select with JOIN
SELECT b.title, a.first_name, a.last_name
FROM book_author ba
JOIN book b ON ba.book_id = b.book_id
JOIN author a ON ba.author_id = a.author_id;

-- ============================================
-- TABLE: shipping_method
-- ============================================
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL
);

-- Insert data into shipping_method
INSERT INTO shipping_method (method_name)
VALUES ('Standard'), ('Express');

-- Select with ORDER BY
SELECT * FROM shipping_method ORDER BY method_name DESC;

-- ============================================
-- TABLE: order_status
-- ============================================
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Insert data into order_status
INSERT INTO order_status (status_name)
VALUES ('Pending'), ('Shipped');

-- Select all
SELECT * FROM order_status;

-- ============================================
-- TABLE: cust_order
-- ============================================
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- Insert data into cust_order
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id)
VALUES (1, 1, 1), (2, 2, 2);

-- Select with JOIN
SELECT o.order_id, c.first_name, sm.method_name, os.status_name
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN shipping_method sm ON o.shipping_method_id = sm.shipping_method_id
JOIN order_status os ON o.order_status_id = os.order_status_id;

-- ============================================
-- TABLE: order_line
-- ============================================
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Insert data into order_line
INSERT INTO order_line (order_id, book_id, quantity)
VALUES (1, 1, 2), (2, 2, 1);

-- Select with JOIN
SELECT ol.order_line_id, b.title, ol.quantity
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id;

-- ============================================
-- TABLE: order_history
-- ============================================
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

-- Insert data into order_history
INSERT INTO order_history (order_id, status_id)
VALUES (1, 1), (2, 2);

-- Select with JOIN and filter
SELECT oh.history_id, os.status_name, oh.status_change_date
FROM order_history oh
JOIN order_status os ON oh.status_id = os.order_status_id
WHERE os.status_name = 'Shipped';

