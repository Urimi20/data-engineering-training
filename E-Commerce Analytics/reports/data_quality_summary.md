# Data Quality Summary

## 1. Overview

This report summarizes the data-quality checks performed on the raw e-commerce
customer and order data.

The purpose is to show how the dataset moved from the raw source population
to the final trusted reporting population.

---

## 2. Data Quality Results

| Quality Check | Result |
|---|---:|
| Raw order count | [INSERT RESULT] |
| Raw customer count | [INSERT RESULT] |
| Duplicate order records | [INSERT RESULT] |
| Duplicate customer records | [INSERT RESULT] |
| Invalid / excluded orders | [INSERT RESULT] |
| Clean / trusted orders | [INSERT RESULT] |
| Missing customer references | [INSERT RESULT] |
| Invalid quantity observations | [INSERT RESULT] |
| Invalid price observations | [INSERT RESULT] |
| Unexpected status observations | [INSERT RESULT] |
| Cleaning success rate | [INSERT RESULT]% |

---

## 3. Order Quality

The raw order data was checked for duplicate records, invalid quantities,
invalid prices and unexpected status values.

Orders with a quantity of zero or below were considered invalid.

Orders with a unit price of zero or below were considered invalid.

Status values were checked against the accepted normalized values:

- pending
- completed
- cancelled
- refunded

---

## 4. Customer Quality

Customer data was checked for duplicate customer IDs and missing customer
information.

Customer references from trusted orders were also checked against the trusted
customer dataset.

Orders without a matching trusted customer were reported as missing customer
references.

---

## 5. Cleaning Results

The raw dataset contained:

- **[INSERT RAW ORDER COUNT]** order records.
- **[INSERT RAW CUSTOMER COUNT]** customer records.

After cleaning and validation:

- **[INSERT CLEAN ORDER COUNT]** orders remained trusted.
- **[INSERT INVALID ORDER COUNT]** order records were excluded.
- The cleaning success rate was **[INSERT RATE]%**.

---

## 6. Main Data-Quality Problems

The main issues identified were:

1. Duplicate order records.
2. Duplicate customer records.
3. Invalid quantity values.
4. Invalid unit prices.
5. Inconsistent status values.
6. Inconsistent city and customer-type values.
7. Missing customer references.

The cleaning process standardized values where a reliable correction rule was
available and separated records that could not be trusted for reporting.

---

## 7. Trusted Data Decision

The final trusted dataset is used for management reporting.

Only records that passed the defined validation rules were included in the
trusted reporting population.

Revenue calculations and business analysis are therefore based on the cleaned
Silver data rather than directly on the raw exports.

---

## 8. Revenue Validation

Trusted revenue is calculated only from completed trusted orders.

The revenue formula is:

```text
total_amount = quantity × unit_price