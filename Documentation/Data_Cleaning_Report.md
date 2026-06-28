 Data Cleaning Report

 Objective

The purpose of data cleaning was to ensure data quality, consistency, and accuracy before performing analytical queries.

---

 Customer Table

 Actions Performed

* Validated customer_id uniqueness
* Checked missing values
* Corrected data types
* Corrected registration_date format
* Corrected pincode data type
* Corrected total_orders data type
* Corrected avg_order_value data type

 Result

No duplicate records found.

No missing values detected.

---

 Orders Table

 Actions Performed

* Validated order_id uniqueness
* Checked missing values
* Validated order values
* Verified date and timestamp fields

 Result

No duplicate records found.

No invalid records detected.

---

 Products Table

 Actions Performed

* Validated product_id uniqueness
* Checked missing values
* Checked negative pricing values

 Result

No duplicate products found.

No invalid prices detected.

---

 Order Items Table

 Actions Performed

* Checked invalid quantities
* Checked invalid unit prices
* Validated foreign key references

 Result

No data quality issues identified.

---

 Delivery Performance Table

 Actions Performed

* Checked delivery times
* Investigated negative delivery_time_minutes
* Verified delivery status values

 Findings

Negative delivery times represented early deliveries and were retained as valid records.

---

 Customer Feedback Table

 Actions Performed

* Checked rating values
* Validated sentiment values
* Validated feedback dates

 Result

No invalid ratings detected.

---

 Marketing Performance Table

 Actions Performed

* Checked campaign metrics
* Validated spend values
* Validated revenue values

 Result

No invalid records detected.

---

 Inventory Table

 Actions Performed

* Checked duplicate inventory records
* Validated stock_received values
* Validated damaged_stock values

 Result

Inventory data passed validation checks.

---

 Conclusion

The dataset successfully passed all data quality validation checks and was considered suitable for analytical processing.
