# Verified Business Report - Day 7 SQL Detective Day

## 1. Total order activity

Insight:
The dataset contains all customer transactions, including completed, pending, and cancelled orders.

Verified result:
Total orders: [PUT RESULT FROM V1]

SQL query used:
V1 - Count all orders

Business meaning:
This shows the total transaction activity and provides the starting point for analyzing business performance.

## 2. Completed revenue

Insight:
Only completed orders are included because pending and cancelled orders should not generate revenue.

Verified result:
Completed revenue: [PUT RESULT FROM V7]

SQL query used:
V7 - Calculate completed revenue only

Business meaning:
This represents the actual revenue generated from successful customer purchases.

## 3. Revenue by product

Insight:
Some products contribute more revenue than others based on their selling price and quantity sold.

Verified result:
[PUT RESULTS FROM V8]

SQL query used:
V8 - Calculate completed revenue by product_name

Business meaning:
This helps identify the products that have the biggest financial impact.

## 4. Revenue by category

Insight:
Revenue performance differs between product categories.

Verified result:
[PUT RESULTS FROM V9]

SQL query used:
V9 - Calculate completed revenue by category

Business meaning:
This helps understand which product groups are driving business revenue.

## 5. Orders by city

Insight:
Customer activity varies depending on location.

Verified result:
[PUT RESULTS FROM V10]

SQL query used:
V10 - Count orders by city

Business meaning:
This shows which cities generate the highest order activity and customer engagement.

## 6. Customers with more than one order

Insight:
Some customers return and place multiple orders.

Verified result:
[PUT RESULTS FROM V11]

SQL query used:
V11 - Find customers with more than one order

Business meaning:
Repeat customers are valuable because they show stronger customer retention.

## 7. Orders not counted as revenue

Insight:
Pending and cancelled orders should not be included in revenue calculations.

Verified result:
[PUT RESULTS FROM V13]

SQL query used:
V13 - Find orders that should not count as real revenue

Business meaning:
Separating unsuccessful transactions prevents inaccurate revenue reporting.

## 8. Final recommendation

Based on the verified data, my recommendation is:

Focus on the products and categories generating the highest completed revenue.
Monitor pending and cancelled orders to understand possible issues in the sales process.
Continue improving customer retention by focusing on customers with repeat purchases.
