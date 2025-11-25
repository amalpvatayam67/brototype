# Learn About NoSQL Databases — Key-Value, Document-Based Models, and Examples

## What Are NoSQL Databases?

NoSQL (“Not Only SQL”) databases store data in **flexible, scalable, non-relational** structures.
They are ideal for big data, distributed systems, and applications requiring high performance.

Unlike SQL, NoSQL databases do **not** enforce fixed table schemas or relationships.

---

# Types of NoSQL Databases

## Key-Value Databases

Key-value databases store data as **key → value pairs**, similar to a dictionary or hash map.

### Characteristics

- Simple structure
- Extremely fast read/write
- Great for caching, sessions, real-time apps

### Examples

- **Redis**
- **Amazon DynamoDB**
- **Riak**

### Example Key-Value Data

```
"user:1001" → "Amal"
"cart:203" → {"item": "Laptop", "qty": 1}
```

---

## Document-Based Databases

Store data as **documents**, usually in JSON or BSON format.

### Characteristics

- Schema-less (fields can vary per document)
- Easy to store nested data
- Popular in modern web apps, APIs, and microservices

### Examples

- **MongoDB**
- **CouchDB**
- **ArangoDB**

### Example MongoDB Document

```json
{
  "id": 1,
  "name": "Amal",
  "skills": ["Cybersecurity", "Python"],
  "location": { "city": "Kozhikode", "state": "Kerala" }
}
```

---

# Popular NoSQL Databases Explained

## MongoDB (Document-Based)

- Stores data in JSON-like documents
- Flexible and scalable
- Great for applications with rapidly changing schemas

**Used in:** Web apps, real-time analytics, microservices

---

## Cassandra (Wide-Column / Key-Value Hybrid)

- Designed for high write throughput
- Distributed, fault-tolerant
- Handles massive datasets across many servers

**Used in:** Banking systems, IoT platforms, large-scale logging

---

# SQL vs NoSQL (Quick Comparison)

| Feature       | SQL Databases   | NoSQL Databases                    |
| ------------- | --------------- | ---------------------------------- |
| Structure     | Tables          | Documents, key-value pairs, graphs |
| Schema        | Fixed           | Schema-less                        |
| Scaling       | Vertical        | Horizontal                         |
| Relationships | Strong          | Usually weak or none               |
| Best For      | Structured data | Large, unstructured data           |

---

# When to Use NoSQL?

Use NoSQL when:

- Data structure constantly changes
- You need to scale horizontally
- You need high-speed reads/writes
- Data is semi-structured or unstructured
- You build modern, distributed systems

---
