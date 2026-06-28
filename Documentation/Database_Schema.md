# 🗄️ Database Schema

## Overview

The Blinkit Business Intelligence project is built on a relational database consisting of eight interconnected tables. The database is designed to capture different aspects of the business, including customers, products, orders, inventory, marketing campaigns, delivery performance, and customer feedback.

The schema follows a normalized relational structure to ensure data integrity, minimize redundancy, and support efficient analytical queries.

---

# Database Overview

| Table | Purpose |
|--------|---------|
| customers | Stores customer information and purchasing history |
| products | Stores product details, categories, and margins |
| orders | Stores order-level transaction details |
| order_items | Stores individual products within each order |
| inventory | Tracks stock movement and inventory health |
| delivery_performance | Tracks delivery status and performance metrics |
| customer_feedback | Stores customer ratings and feedback |
| marketing_performance | Stores campaign performance metrics |

---

# Entity Relationship Overview

```
Customers
     │
     │ customer_id
     ▼
Orders
     │
     │ order_id
     ▼
Order_Items
     ▲
     │
product_id
     │
Products
     ▲
     │
     ├────────────── Inventory
     │
     └────────────── Delivery_Performance

Orders
     │
     ├──────────── Customer_Feedback
     │
     └──────────── Marketing_Performance
```

---

# Table Details

---

# 1. Customers

### Purpose

Stores customer demographic information and purchase history.

### Primary Key

```
customer_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| customer_id | Unique customer identifier |
| customer_name | Customer name |
| city | Customer city |
| segment | Customer segment |
| registration_date | Date of registration |
| total_orders | Total number of orders |

### Relationships

```
customers.customer_id
        │
        ▼
orders.customer_id
```

Relationship:

**One Customer → Many Orders**

---

# 2. Products

### Purpose

Stores product information used in sales, inventory, and profitability analysis.

### Primary Key

```
product_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| product_id | Unique product identifier |
| product_name | Product name |
| category | Product category |
| unit_price | Selling price |
| margin_percentage | Profit margin percentage |

### Relationships

```
products.product_id
          │
          ├────────► order_items.product_id

          └────────► inventory.product_id
```

Relationship:

**One Product → Many Order Items**

**One Product → Many Inventory Records**

---

# 3. Orders

### Purpose

Contains transaction-level information for every customer order.

### Primary Key

```
order_id
```

### Foreign Keys

```
customer_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| order_id | Unique order identifier |
| customer_id | Customer placing the order |
| order_date | Order date |
| payment_method | Payment type |
| total_amount | Total order amount |

### Relationships

```
Orders
   │
   ├────────► Order Items

   ├────────► Delivery Performance

   └────────► Customer Feedback
```

---

# 4. Order Items

### Purpose

Stores individual products included in each order.

### Primary Key

```
order_item_id
```

### Foreign Keys

```
order_id

product_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| order_item_id | Unique item identifier |
| order_id | Related order |
| product_id | Purchased product |
| quantity | Quantity ordered |
| unit_price | Selling price |

### Relationships

```
Orders
     │
     ▼
Order Items
     ▲
     │
Products
```

---

# 5. Inventory

### Purpose

Tracks inventory movement and stock health.

### Primary Key

```
inventory_id
```

### Foreign Keys

```
product_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| inventory_id | Inventory record |
| product_id | Product |
| stock_received | Quantity received |
| damaged_stock | Damaged quantity |
| inventory_date | Inventory update date |

### Relationships

```
Products
      │
      ▼
Inventory
```

---

# 6. Delivery Performance

### Purpose

Stores delivery-related operational metrics.

### Primary Key

```
delivery_id
```

### Foreign Keys

```
order_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| delivery_id | Delivery identifier |
| order_id | Related order |
| delivery_time_minutes | Delivery duration |
| delivery_status | Delivery status |
| distance_km | Delivery distance |
| reason_if_delayed | Delay reason |

### Relationships

```
Orders
     │
     ▼
Delivery Performance
```

---

# 7. Customer Feedback

### Purpose

Stores customer satisfaction information.

### Primary Key

```
feedback_id
```

### Foreign Keys

```
order_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| feedback_id | Feedback identifier |
| order_id | Related order |
| rating | Customer rating |
| sentiment | Positive / Neutral / Negative |
| feedback_category | Area of feedback |
| feedback_date | Date of feedback |

### Relationships

```
Orders
     │
     ▼
Customer Feedback
```

---

# 8. Marketing Performance

### Purpose

Stores digital marketing campaign performance metrics.

### Primary Key

```
campaign_id
```

### Important Columns

| Column | Description |
|---------|-------------|
| campaign_name | Campaign name |
| channel | Marketing channel |
| spend | Campaign spend |
| revenue_generated | Revenue generated |
| impressions | Total impressions |
| clicks | Total clicks |
| conversions | Total conversions |
| target_audience | Campaign audience |

---

# Relationship Summary

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Customers | Orders | One-to-Many |
| Orders | Order Items | One-to-Many |
| Products | Order Items | One-to-Many |
| Products | Inventory | One-to-Many |
| Orders | Delivery Performance | One-to-One / One-to-Many* |
| Orders | Customer Feedback | One-to-One |
| Marketing Performance | Independent Analytics Table | Standalone |

*Depending on the business process, one order may have one delivery record.

---

# Database Design Principles

The database was designed using relational database best practices:

- Normalized structure to reduce redundancy.
- Primary and foreign keys to maintain referential integrity.
- Separate tables for operational, transactional, and analytical data.
- Scalable design suitable for business intelligence reporting.
- Optimized relationships for SQL analysis and Power BI data modeling.

---

# Data Model Usage in Power BI

The relational schema was imported into Power BI to create a semantic model used for interactive reporting.

The model enables:

- Cross-table filtering
- KPI calculations using DAX
- Category-level analysis
- Customer segmentation
- Product profitability analysis
- Marketing performance reporting
- Operational dashboard creation

---

# Summary

The Blinkit database schema provides a robust foundation for analytical reporting by integrating customer, sales, inventory, marketing, and operations data into a unified relational model.

The structured design supports efficient SQL querying, scalable Power BI dashboards, and comprehensive business intelligence reporting.