# 📐 DAX Measures Documentation

## Overview

This document contains the primary DAX (Data Analysis Expressions) measures used throughout the Blinkit Business Intelligence Dashboard.

The measures were created to calculate business KPIs, support interactive visualizations, and enable dynamic analysis across Sales, Customers, Marketing, Operations, and Inventory.

---

# Executive Dashboard Measures

## Total Revenue

```DAX
Total Revenue =
SUM(orders[order_total])
```

Purpose:
Calculates the total revenue generated from all customer orders.

---

## Total Orders

```DAX
Total Orders =
COUNT(orders[order_id])
```

Purpose:
Returns the total number of orders.

---

## Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(customers[customer_id])
```

Purpose:
Calculates the number of unique customers.

---

## Average Order Value (AOV)

```DAX
Average Order Value =
DIVIDE([Total Revenue],[Total Orders])
```

Purpose:
Calculates the average amount spent per order.

---

## Average Rating

```DAX
Average Rating =
AVERAGE(customer_feedback[rating])
```

Purpose:
Calculates the average customer rating.

---

## ROAS

```DAX
ROAS =
DIVIDE(
SUM(marketing_performance[revenue_generated]),
SUM(marketing_performance[spend])
)
```

Purpose:
Calculates Return on Advertising Spend.

---

# Sales & Product Measures

## Quantity Sold

```DAX
Quantity Sold =
SUM(order_items[quantity])
```

Purpose:
Calculates total quantity sold.

---

## Products Sold

```DAX
Products Sold =
DISTINCTCOUNT(order_items[product_id])
```

Purpose:
Counts unique products sold.

---

## Revenue

```DAX
Revenue =
SUMX(
order_items,
order_items[quantity] *
order_items[unit_price]
)
```

Purpose:
Calculates revenue using quantity and unit price.

---

## Margin Amount

```DAX
Margin Amount =
SUMX(
order_items,
order_items[quantity]
*
order_items[unit_price]
*
RELATED(products[margin_percentage]) / 100
)
```

Purpose:
Calculates total profit generated.

---

## Margin %

```DAX
Margin % =
DIVIDE(
[Margin Amount],
[Revenue]
)
```

Purpose:
Calculates overall profit margin.

---

## Margin Contribution %

```DAX
Margin Contribution % =
DIVIDE(
[Margin Amount],
CALCULATE(
[Margin Amount],
ALL(products[category])
)
)
```

Purpose:
Calculates category contribution toward total margin.

---

## Repeat Customers

```DAX
Repeat Customers =
CALCULATE(
DISTINCTCOUNT(customers[customer_id]),
customers[total_orders] > 1
)
```

Purpose:
Counts customers with multiple purchases.

---

## Repeat Customer %

```DAX
Repeat Customer % =
DIVIDE(
[Repeat Customers],
[Total Customers]
)
```

Purpose:
Calculates customer retention percentage.

---

# Marketing Measures

## Marketing Spend

```DAX
Marketing Spend =
SUM(marketing_performance[spend])
```

Purpose:
Calculates total campaign spend.

---

## Revenue Generated

```DAX
Revenue Generated =
SUM(marketing_performance[revenue_generated])
```

Purpose:
Calculates total campaign revenue.

---

## Conversion Rate

```DAX
Conversion Rate =
DIVIDE(
SUM(marketing_performance[conversions]),
SUM(marketing_performance[clicks])
)
```

Purpose:
Calculates marketing conversion rate.

---

## Click Through Rate

```DAX
Click Through Rate =
DIVIDE(
SUM(marketing_performance[clicks]),
SUM(marketing_performance[impressions])
)
```

Purpose:
Calculates campaign CTR.

---

## Negative Feedback %

```DAX
Negative Feedback % =
DIVIDE(
CALCULATE(
COUNTROWS(customer_feedback),
customer_feedback[sentiment]="Negative"
),
COUNTROWS(customer_feedback)
)
```

Purpose:
Calculates percentage of negative customer feedback.

---

# Operations Measures

## On-Time Delivery %

```DAX
On Time Delivery % =
DIVIDE(
CALCULATE(
COUNTROWS(delivery_performance),
delivery_performance[delivery_status]="On Time"
),
COUNTROWS(delivery_performance)
)
```

Purpose:
Calculates the percentage of on-time deliveries.

---

## Average Delivery Time

```DAX
Average Delivery Time =
AVERAGE(
delivery_performance[delivery_time_minutes]
)
```

Purpose:
Calculates average delivery duration.

---

## Average Delivery Distance

```DAX
Average Delivery Distance =
AVERAGE(
delivery_performance[distance_km]
)
```

Purpose:
Calculates average delivery distance.

---

# Inventory Measures

## Total Stock Received

```DAX
Total Stock Received =
SUM(inventory[stock_received])
```

Purpose:
Calculates total stock received.

---

## Total Damaged Stock

```DAX
Total Damaged Stock =
SUM(inventory[damaged_stock])
```

Purpose:
Calculates total damaged inventory.

---

## Damage Rate %

```DAX
Damage Rate % =
DIVIDE(
[Total Damaged Stock],
[Total Stock Received]
)
```

Purpose:
Calculates inventory damage percentage.

---

# Supporting Measures

## Revenue Contribution %

```DAX
Revenue Contribution % =
DIVIDE(
[Revenue],
CALCULATE(
[Revenue],
ALL(products[product_name])
)
)
```

Purpose:
Calculates product contribution toward total revenue.

---

## Best Campaign Revenue

```DAX
Best Campaign Revenue =
MAX(
marketing_performance[revenue_generated]
)
```

Purpose:
Returns the highest campaign revenue.

---

# DAX Categories Summary

| Category | Measures |
|----------|----------|
| Executive | 6 |
| Sales | 8 |
| Marketing | 5 |
| Operations | 3 |
| Inventory | 3 |
| Supporting | 2 |

---

# Best Practices Followed

During measure development, the following DAX best practices were applied:

- Used DIVIDE() instead of "/" to safely handle division by zero.
- Created reusable measures instead of repeating calculations.
- Used SUMX() for row-level calculations.
- Leveraged RELATED() for calculations across related tables.
- Organized measures by business domain.
- Used descriptive measure names for readability.
- Avoided unnecessary calculated columns where measures were sufficient.

---

# Conclusion

The DAX measures developed for this project provide the analytical foundation for the Power BI dashboards. They enable dynamic KPI calculations, interactive filtering, and meaningful business analysis across multiple domains, including Sales, Customers, Marketing, Operations, and Inventory.