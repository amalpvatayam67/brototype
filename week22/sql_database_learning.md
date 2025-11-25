# Learn About SQL Databases — Structure, Relational Model, and Examples

## What Are SQL Databases?

SQL (Structured Query Language) databases store data in **structured tables**.  
They are reliable, consistent, and follow strict rules to maintain data integrity.

---

## 1. Structure of SQL Databases

### Tables

Collections of rows and columns, similar to spreadsheets.

### Columns (Attributes)

Define the type of data stored (e.g., INT, VARCHAR, DATE).

### Rows (Records)

Individual entries in a table.

### Primary Key (PK)

Unique identifier for each row.

### Foreign Key (FK)

Establishes relationships between tables.

### Index

Improves search speed inside tables.

---

## 2. Relational Model

The relational model defines how data in different tables is linked.

### Relationship Types

#### One-to-One (1:1)

One record ↔ One record  
Example: user ↔ user_profile

#### One-to-Many (1:N)

One record ↔ Many records  
Example: customer → orders

#### Many-to-Many (M:N)

Requires a linking table  
Example: students ↔ courses ↔ student_courses

---

## 3. Common SQL Operations

### SELECT

```sql
SELECT * FROM users;
```

### INSERT

```sql
INSERT INTO users (name, email) VALUES ('Amal', 'amal@example.com');
```

### UPDATE

```sql
UPDATE users SET name='Amal P' WHERE id=1;
```

### DELETE

```sql
DELETE FROM users WHERE id=1;
```

---

## 4. Popular SQL Databases

- **MySQL** – widely used; great for PHP, Laravel, WordPress
- **PostgreSQL** – powerful, advanced
- **SQLite** – lightweight, used in mobile apps
- **Microsoft SQL Server** – enterprise use
- **MariaDB** – MySQL alternative with performance benefits

---

## 5. Why SQL Databases Are Important

- Strong data integrity
- Structured and organized
- Easy to query
- Stable for large systems
- Widely used in backend & cybersecurity

---
