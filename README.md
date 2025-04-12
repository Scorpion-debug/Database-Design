# Bookstore Database Design & Programming with SQL

This project involves creating a relational MySQL database for a **Bookstore**. The database includes tables for managing books, authors, customers, orders, shipping, and other essential operations of the bookstore. Additionally, GitHub Actions is used to automate testing of the SQL scripts.

## Project Overview

The goal is to design and implement a relational database using MySQL, structure it for optimal data storage, and ensure security and accessibility through user management. 

### Key Features
- Database schema design with multiple tables for managing books, authors, customers, orders, etc.
- Data insertion scripts to populate tables with sample data.
- Various query types (e.g., `SELECT *`, `JOIN`, `WHERE`) to test database functionality.
- Continuous integration using GitHub Actions to validate database scripts.

## Tools & Technologies

- **MySQL**: The database management system for building and managing the database.
- **Draw.io**: Tool for visualizing the database schema and relationships.
- **GitHub Actions**: Automates testing and CI/CD pipelines.

## Project Structure

- **`answers.sql`**: SQL file containing database schema creation, data insertion, and example queries.
- **`.github/workflows/demo.yml`**: GitHub Actions CI/CD pipeline configuration file.
- **`README.md`**: Project documentation (this file).

## Tables Created

1. **country**: Stores country information.
2. **address_status**: Stores address status (e.g., current, old).
3. **address**: Stores customer addresses.
4. **customer**: Stores customer information.
5. **customer_address**: Relates customers to their addresses.
6. **author**: Stores author information.
7. **book_language**: Stores supported languages for books.
8. **publisher**: Stores publisher information.
9. **book**: Stores book details, including title, publication year, price, and stock quantity.
10. **book_author**: Many-to-many relationship between books and authors.
11. **shipping_method**: Stores available shipping methods.
12. **order_status**: Stores the status of customer orders.
13. **cust_order**: Stores customer orders.
14. **order_line**: Stores the line items in each order (books and quantities).
15. **order_history**: Stores the history of order statuses.

## How to Set Up the Database Locally

### 1. Create a MySQL Database

Run the following command to create the database and set up the tables:

```bash
mysql -u root -e "CREATE DATABASE IF NOT EXISTS bookstore;"
```

### 2. Run the SQL Scripts

Run the `answers.sql` script to create the tables and insert sample data into the database:

```bash
mysql -u root bookstore < ./answers.sql
```

### 3. Verify Database Setup

You can check if the tables were created successfully by running a basic query:

```bash
mysql -u root -e "SELECT * FROM book;" bookstore
```

This should return the books that were inserted during the script execution.

## GitHub Actions CI/CD

This project uses **GitHub Actions** to automate the testing of the database schema and queries every time changes are pushed to the `main` branch.

### CI/CD Workflow

1. **GitHub Actions Configuration**: The workflow is defined in `.github/workflows/test.yml`.
2. **Setup**: It uses a Docker container to run MySQL and execute the SQL scripts (`answers.sql`).
3. **Test**: After running the SQL scripts, it verifies the database setup by running a few queries, such as checking the number of books in the `book` table.

### Triggering the CI/CD Pipeline

The pipeline will automatically run when you push changes to the `main` branch of your repository.

## Example Queries

Here are a few example queries you can run on the database:

### 1. **Select All Books**

```sql
SELECT * FROM book;
```

### 2. **Select Books by Publisher**

```sql
SELECT b.title, p.name
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
WHERE p.name = 'Penguin Books';
```

### 3. **Select Customers in a Specific Country**

```sql
SELECT c.first_name, c.last_name, a.city
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country co ON a.country_id = co.country_id
WHERE co.country_name = 'United States';
```

### 4. **Select Orders by Status**

```sql
SELECT o.order_id, os.status_name
FROM cust_order o
JOIN order_status os ON o.order_status_id = os.order_status_id
WHERE os.status_name = 'Shipped';
```

---

## Authors

- Fredrick Maeba
- Mercy Jepkosgei
- Mary Mbithe

```

---

### Key Points:
1. **`README.md`** provides clear instructions on setting up the database locally, running the SQL scripts, and verifying the setup.
2. **CI/CD Setup** is explained, including how GitHub Actions tests your SQL script automatically on each push.
3. **Queries Section** shows examples of different queries to test and interact with the database.
