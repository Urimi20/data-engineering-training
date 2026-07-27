-- ===========================================
-- Relationship Queries
-- ===========================================

------------------------------------------------
-- 1. Show users together with their company name
------------------------------------------------

SELECT
    u.user_id,
    u.full_name,
    u.email,
    c.company_name
FROM users u
INNER JOIN companies c
ON u.company_id = c.company_id;


------------------------------------------------
-- 2. Show subscriptions together with company
--    name and plan name
------------------------------------------------

SELECT
    s.subscription_id,
    c.company_name,
    p.plan_name,
    s.start_date,
    s.status
FROM subscriptions s
INNER JOIN companies c
ON s.company_id = c.company_id
INNER JOIN plans p
ON s.plan_id = p.plan_id;


------------------------------------------------
-- 3. Show payments together with company name,
--    plan name and subscription status
------------------------------------------------

SELECT
    pay.payment_id,
    c.company_name,
    p.plan_name,
    s.status AS subscription_status,
    pay.amount,
    pay.payment_status
FROM payments pay
INNER JOIN subscriptions s
ON pay.subscription_id = s.subscription_id
INNER JOIN companies c
ON s.company_id = c.company_id
INNER JOIN plans p
ON s.plan_id = p.plan_id;


------------------------------------------------
-- 4. Show support tickets together with user
--    name, email and company name
------------------------------------------------

SELECT
    st.ticket_id,
    u.full_name,
    u.email,
    c.company_name,
    st.issue_type,
    st.priority,
    st.status
FROM support_tickets st
INNER JOIN users u
ON st.user_id = u.user_id
INNER JOIN companies c
ON u.company_id = c.company_id;


------------------------------------------------
-- 5. Show all companies and their users
--    using LEFT JOIN
------------------------------------------------

SELECT
    c.company_name,
    u.full_name,
    u.email
FROM companies c
LEFT JOIN users u
ON c.company_id = u.company_id;


------------------------------------------------
-- 6. Show companies that currently have no users
------------------------------------------------

SELECT
    c.company_id,
    c.company_name
FROM companies c
LEFT JOIN users u
ON c.company_id = u.company_id
WHERE u.user_id IS NULL;


------------------------------------------------
-- 7. Show users that have not opened any
--    support tickets
------------------------------------------------

SELECT
    u.user_id,
    u.full_name,
    u.email
FROM users u
LEFT JOIN support_tickets st
ON u.user_id = st.user_id
WHERE st.ticket_id IS NULL;


------------------------------------------------
-- 8. Show subscriptions that have no payments yet
------------------------------------------------

SELECT
    s.subscription_id,
    c.company_name,
    p.plan_name
FROM subscriptions s
LEFT JOIN payments pay
ON s.subscription_id = pay.subscription_id
INNER JOIN companies c
ON s.company_id = c.company_id
INNER JOIN plans p
ON s.plan_id = p.plan_id
WHERE pay.payment_id IS NULL;


------------------------------------------------
-- 9. Show active subscriptions with pending
--    or failed payments
------------------------------------------------

SELECT
    s.subscription_id,
    c.company_name,
    p.plan_name,
    pay.payment_status,
    pay.amount
FROM subscriptions s
INNER JOIN payments pay
ON s.subscription_id = pay.subscription_id
INNER JOIN companies c
ON s.company_id = c.company_id
INNER JOIN plans p
ON s.plan_id = p.plan_id
WHERE s.status = 'active'
AND pay.payment_status IN ('pending', 'failed');