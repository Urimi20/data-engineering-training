# Management Summary

## Executive Assessment

The cleaned e-commerce dataset is considered suitable for management reporting after the
cleaning and validation process, provided that the reported results are based only on the
trusted Silver dataset.

The pipeline identified and handled data-quality issues found in the raw exports, including
duplicate records, invalid quantities, invalid prices, inconsistent status values, inconsistent
city names, and inconsistent customer information.

## Data Volume

- Raw customer records received: [INSERT RESULT]
- Trusted customer records: [INSERT RESULT]
- Raw order records received: [INSERT RESULT]
- Trusted order records: [INSERT RESULT]
- Excluded/invalid order records: [INSERT RESULT]
- Cleaning success rate: [INSERT RESULT]%

## Most Important Data-Quality Problems

The main problems identified in the source data were:

1. Duplicate customer and order records.
2. Invalid quantity values, including zero or negative quantities.
3. Invalid unit prices, including zero or negative prices.
4. Inconsistent status values such as different capitalization or formatting.
5. Inconsistent city names and spelling.
6. Customer references that could not always be matched to trusted customers.
7. Inconsistent payment method values.

These issues were addressed during the cleaning process where possible.
Records that did not satisfy the required validation rules were excluded from the trusted
reporting population.

## Trusted Revenue

Trusted revenue is calculated only from completed orders in the cleaned dataset.

Revenue is defined as:

    quantity × unit_price

Trusted completed-order revenue:

**[INSERT TRUSTED TOTAL REVENUE]**

## Business Performance

### Strongest City

The city with the highest trusted completed-order revenue was:

**[INSERT CITY]**

Revenue:

**[INSERT REVENUE]**

### Strongest Product Category

The product category with the highest trusted completed-order revenue was:

**[INSERT CATEGORY]**

Revenue:

**[INSERT REVENUE]**

## Recommendation

The first source-system improvement should be to enforce validation rules before data is
exported.

In particular, the source system should require:

- Positive integer quantities.
- Positive unit prices.
- Valid order statuses from a controlled list.
- Consistent city values.
- Unique order IDs.
- Valid customer references.
- Standardized payment-method values.

Preventing these problems at the source would reduce the amount of downstream cleaning
and increase confidence in management reporting.

## Final Decision

The cleaned dataset can be used for the requested reporting because the final reporting
population is based on validated and standardized records rather than the original raw
exports.

However, the source-system quality issues should be addressed to prevent the same problems
from appearing in future exports.