# Day 15 - Advanced Relationships, Foreign Keys, Constraints and Reporting

## Project Goal

The goal of this project is to design a normalized relational database for a SaaS training platform using SQLite. The database demonstrates the use of primary keys, foreign keys, constraints, bridge tables, and SQL reporting queries.

---

## Business Scenario

A SaaS training platform manages companies, users, subscription plans, subscriptions, payments, and support tickets.

The database stores business information in separate related tables to avoid duplicated data and improve data integrity. Business reports are generated using SQL JOINs and aggregation queries.

---

## Database Tables

### companies

Stores company information.

Columns:

- company_id
- company_name
- city
- industry

---

### users

Stores platform users.

Columns:

- user_id
- company_id
- full_name
- email
- role
- is_active

Relationship:

- Many users belong to one company.

---

### plans

Stores available subscription plans.

Columns:

- plan_id
- plan_name
- monthly_price
- max_users

---

### subscriptions

Stores company subscriptions.

Columns:

- subscription_id
- company_id
- plan_id
- start_date
- status

Relationships:

- One company can have many subscriptions.
- One plan can be used by many companies.

---

### payments

Stores subscription payments.

Columns:

- payment_id
- subscription_id
- payment_date
- amount
- payment_status

Relationship:

- One subscription can have many payments.

---

### support_tickets

Stores support requests created by users.

Columns:

- ticket_id
- user_id
- issue_type
- priority
- status
- created_date

Relationship:

- One user can create many support tickets.

---

## Relationships

- Companies → Users (One-to-Many)
- Companies → Subscriptions (One-to-Many)
- Plans → Subscriptions (One-to-Many)
- Subscriptions → Payments (One-to-Many)
- Users → Support Tickets (One-to-Many)

The **subscriptions** table acts as the bridge between companies and plans.

---

## Constraints Used

- PRIMARY KEY AUTOINCREMENT
- FOREIGN KEY
- NOT NULL
- UNIQUE
- CHECK

Examples:

- Company name must be unique.
- User email must be unique.
- Plan name must be unique.
- Payment amount must be greater than zero.
- Monthly price must be positive.
- Subscription status:
  - active
  - paused
  - cancelled
- Payment status:
  - paid
  - pending
  - failed
- Support ticket priority:
  - Low
  - Medium
  - High
- Support ticket status:
  - Open
  - In Progress
  - Closed
- User activity:
  - 0 = Inactive
  - 1 = Active

---

## SQL Files

### schema.sql

Creates all database tables and constraints.

### seed_data.sql

Inserts sample data for testing.

### constraint_tests.sql

Contains invalid insert statements to verify database constraints.

### relationship_queries.sql

Contains JOIN queries to test relationships between tables.

### business_reports.sql

Contains business reports using JOIN, GROUP BY, SUM, COUNT, and AVG.

### data_quality_notes.md

Explains the database design, relationships, and constraints.

---

## Business Reports

The project includes reports such as:

- Total paid revenue
- Paid revenue by company
- Paid revenue by plan
- Active subscriptions by plan
- Users by company
- Support tickets by company
- Open tickets by priority
- Companies with unpaid or pending payments
- Top 5 companies by revenue
- Average payment by plan
- Companies with the most support tickets
- Executive summary

---

## Technologies

- SQLite
- SQL
- Relational Database Design

---

## Learning Outcomes

After completing this project, I learned how to:

- Design a normalized relational database.
- Create one-to-many relationships.
- Use bridge tables.
- Apply foreign keys and constraints.
- Protect data integrity using CHECK and UNIQUE constraints.
- Create business reports using SQL JOINs and aggregation functions.
- Validate data quality through constraint testing.
