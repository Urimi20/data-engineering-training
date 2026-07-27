# Data Quality Notes

## 1. What does each table represent in the business?

### companies

Stores information about companies that use the SaaS training platform, including their name, city, and industry.

### users

Stores the users who belong to a company and access the platform.

### plans

Stores the available subscription plans, including their monthly price and the maximum number of users allowed.

### subscriptions

Stores the subscriptions purchased by companies. It connects companies with subscription plans and records the subscription status.

### payments

Stores payment records for company subscriptions, including payment amount, date, and payment status.

### support_tickets

Stores support requests created by users, including the issue type, priority, and ticket status.

---

## 2. Which column should be the primary key in each table?

| Table           | Primary Key     |
| --------------- | --------------- |
| companies       | company_id      |
| users           | user_id         |
| plans           | plan_id         |
| subscriptions   | subscription_id |
| payments        | payment_id      |
| support_tickets | ticket_id       |

Each primary key should use **INTEGER PRIMARY KEY AUTOINCREMENT**.

---

## 3. Which columns should be foreign keys?

- **users.company_id** → references **companies(company_id)**
- **subscriptions.company_id** → references **companies(company_id)**
- **subscriptions.plan_id** → references **plans(plan_id)**
- **payments.subscription_id** → references **subscriptions(subscription_id)**
- **support_tickets.user_id** → references **users(user_id)**

---

## 4. Which fields must be NOT NULL?

### companies

- company_name
- city
- industry

### users

- company_id
- full_name
- email
- role

### plans

- plan_name
- monthly_price
- max_users

### subscriptions

- company_id
- plan_id
- start_date
- status

### payments

- subscription_id
- payment_date
- amount
- payment_status

### support_tickets

- user_id
- issue_type
- priority
- status
- created_date

---

## 5. Which values should be protected with CHECK constraints?

### users

- is_active IN (0, 1)

### plans

- monthly_price > 0
- max_users > 0

### subscriptions

- status IN ('active', 'paused', 'cancelled')

### payments

- amount > 0
- payment_status IN ('paid', 'pending', 'failed')

### support_tickets

- priority IN ('Low', 'Medium', 'High')
- status IN ('Open', 'In Progress', 'Closed')

---

## 6. Which relationships are one-to-many?

- One company can have many users.
- One company can have many subscriptions.
- One plan can be used by many subscriptions.
- One subscription can have many payments.
- One user can create many support tickets.

---

## 7. Which relationship uses a bridge table?

The **subscriptions** table acts as a bridge between **companies** and **plans**.

A company can purchase different plans over time, and each plan can be purchased by many companies.

---

## 8. What kind of invalid data should the database reject?

The database should reject:

- A user linked to a company that does not exist.
- A subscription linked to a company or plan that does not exist.
- A payment linked to a subscription that does not exist.
- A support ticket linked to a user that does not exist.
- Duplicate company names.
- Duplicate email addresses.
- Duplicate plan names.
- Empty company name, city, or industry.
- Empty user name, email, or role.
- Monthly price less than or equal to zero.
- Maximum users less than or equal to zero.
- Payment amount less than or equal to zero.
- Invalid subscription status values.
- Invalid payment status values.
- Invalid ticket priority values.
- Invalid ticket status values.
- Invalid values for **is_active** (anything other than 0 or 1).
- NULL values in required fields.
