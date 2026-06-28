# 🧹 Data Cleaning Report

## Overview

Data cleaning is a critical step in every data analytics project. Raw datasets often contain inconsistencies such as missing values, duplicate records, incorrect data types, invalid values, and formatting issues that can negatively impact analysis and reporting.

For this project, data cleaning was performed using **Microsoft Excel**, **SQL (PostgreSQL)**, and **Power Query** before building the Power BI dashboards. The objective was to ensure data accuracy, consistency, and reliability for business analysis.

---

# Data Cleaning Workflow

```
Raw CSV Files
        │
        ▼
Microsoft Excel
(Basic Cleaning)
        │
        ▼
PostgreSQL
(SQL Validation & Cleaning)
        │
        ▼
Power Query
(Data Transformation)
        │
        ▼
Power BI Dashboards
```

---

# Excel Data Cleaning

Microsoft Excel was used for the initial inspection and preparation of the raw datasets before importing them into PostgreSQL.

The following cleaning activities were performed:

- Removed duplicate records.
- Checked for missing values.
- Corrected inconsistent formatting.
- Standardized date formats.
- Verified numeric values.
- Removed extra spaces from text fields.
- Checked for invalid entries.
- Validated primary key uniqueness.

---

# Dataset-wise Cleaning

---

# 1. Customers

### Issues Identified

- Minor formatting inconsistencies.
- Date columns stored as text.
- Numeric fields required validation.

### Cleaning Performed

- Converted registration dates to Date format.
- Verified customer IDs for uniqueness.
- Standardized customer segments.
- Removed leading/trailing spaces.
- Validated total_orders values.

---

# 2. Products

### Issues Identified

- Category formatting inconsistencies.
- Margin percentage required validation.

### Cleaning Performed

- Standardized category names.
- Validated unit prices.
- Verified margin percentage values.
- Removed unnecessary whitespace.

---

# 3. Orders

### Issues Identified

- Date formatting inconsistencies.
- Payment methods required standardization.

### Cleaning Performed

- Converted order_date to Date format.
- Standardized payment method values.
- Validated order totals.
- Verified customer references.

---

# 4. Order Items

### Issues Identified

- Quantity validation.
- Product references checked.

### Cleaning Performed

- Verified product IDs.
- Checked quantity values.
- Validated unit prices.
- Confirmed order references.

---

# 5. Delivery Performance

### Issues Identified

- Negative delivery times.
- Missing delay reasons.
- Status consistency.

### Cleaning Performed

- Removed negative delivery time values.
- Standardized delivery status.
- Filled missing delay reasons with "No Delay".
- Validated delivery distance values.

---

# 6. Customer Feedback

### Issues Identified

- Missing feedback categories.
- Rating validation.

### Cleaning Performed

- Verified rating values.
- Standardized sentiment categories.
- Checked feedback dates.
- Removed duplicate feedback entries.

---

# 7. Marketing Performance

### Issues Identified

- Campaign naming inconsistencies.
- Numeric validation.

### Cleaning Performed

- Standardized campaign names.
- Validated impressions.
- Validated clicks.
- Validated conversions.
- Checked marketing spend.
- Verified revenue generated.

---

# 8. Inventory

### Issues Identified

- Duplicate product references.
- Stock validation.

### Cleaning Performed

- Removed duplicate inventory records.
- Validated stock received values.
- Checked damaged stock values.
- Standardized inventory dates.

---

# SQL Data Validation

After importing the cleaned datasets into PostgreSQL, additional validation checks were performed.

These included:

- Duplicate detection
- Missing value checks
- Primary key validation
- Foreign key validation
- Aggregate validation
- Relationship verification

---

## SQL Cleaning Activities

### Duplicate Detection

Duplicate records were identified using SQL aggregation and removed where necessary.

Example:

- Customer IDs
- Product IDs
- Inventory Records

---

### Missing Value Validation

SQL queries were used to identify NULL values in important columns such as:

- Customer ID
- Product ID
- Order Date
- Revenue
- Delivery Time
- Rating

Missing values were either corrected or replaced with appropriate default values where applicable.

---

### Referential Integrity

Relationships between tables were validated using SQL joins.

Examples:

- Customers → Orders
- Orders → Order Items
- Products → Inventory
- Orders → Customer Feedback

This ensured that every foreign key matched a valid primary key.

---

### Data Type Validation

Data types were verified for all tables.

Examples:

- Dates stored as DATE.
- Revenue stored as NUMERIC.
- Ratings stored as INTEGER.
- Delivery time stored as NUMERIC.
- Margin percentage stored as DECIMAL.

---

# Power Query Transformations

After connecting PostgreSQL to Power BI, Power Query was used for additional data transformation.

The following transformations were applied:

- Renamed columns.
- Changed data types.
- Created calculated columns.
- Removed unnecessary columns.
- Verified relationships.
- Checked column formatting.
- Standardized categorical values.

---

# Data Quality Checks

The following quality checks were completed before dashboard development:

| Validation | Status |
|------------|--------|
| Duplicate Records | ✅ Completed |
| Missing Values | ✅ Completed |
| Invalid Dates | ✅ Completed |
| Invalid Numeric Values | ✅ Completed |
| Data Types | ✅ Completed |
| Relationship Validation | ✅ Completed |
| Primary Keys | ✅ Verified |
| Foreign Keys | ✅ Verified |

---

# Data Cleaning Summary

| Dataset | Status |
|----------|--------|
| Customers | ✅ Clean |
| Products | ✅ Clean |
| Orders | ✅ Clean |
| Order Items | ✅ Clean |
| Delivery Performance | ✅ Clean |
| Customer Feedback | ✅ Clean |
| Marketing Performance | ✅ Clean |
| Inventory | ✅ Clean |

---

# Outcome

The data cleaning process significantly improved the quality and consistency of the datasets before analytical processing.

By validating records in Excel, PostgreSQL, and Power Query, the final Power BI dashboards were built on accurate, reliable, and well-structured data.

This ensured that all KPIs, SQL analyses, and dashboard insights reflected trustworthy business information.

---

# Conclusion

A structured data cleaning workflow is essential for producing reliable business intelligence solutions.

The combination of Excel, SQL, and Power Query provided multiple layers of validation, ensuring that the final dashboards accurately represented the underlying business data and supported meaningful decision-making.