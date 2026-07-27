PRAGMA foreign_keys = ON;


-- 10. Total paid revenue from payments where payment_status = paid
SELECT
    SUM(amount) AS total_paid_revenue
FROM payments
WHERE payment_status = 'paid';


-- 11. Paid revenue by company
SELECT
    c.company_name,
    SUM(p.amount) AS paid_revenue
FROM companies c
JOIN subscriptions s
    ON c.company_id = s.company_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'paid'
GROUP BY c.company_name
ORDER BY paid_revenue DESC;


-- 12. Paid revenue by plan
SELECT
    pl.plan_name,
    SUM(p.amount) AS paid_revenue
FROM plans pl
JOIN subscriptions s
    ON pl.plan_id = s.plan_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'paid'
GROUP BY pl.plan_name
ORDER BY paid_revenue DESC;


-- 13. Number of active subscriptions by plan
SELECT
    pl.plan_name,
    COUNT(s.subscription_id) AS active_subscriptions
FROM plans pl
JOIN subscriptions s
    ON pl.plan_id = s.plan_id
WHERE s.status = 'active'
GROUP BY pl.plan_name
ORDER BY active_subscriptions DESC;


-- 14. Number of users by company
SELECT
    c.company_name,
    COUNT(u.user_id) AS number_of_users
FROM companies c
LEFT JOIN users u
    ON c.company_id = u.company_id
GROUP BY c.company_name
ORDER BY number_of_users DESC;


-- 15. Support tickets by company
SELECT
    c.company_name,
    COUNT(st.ticket_id) AS total_support_tickets
FROM companies c
LEFT JOIN users u
    ON c.company_id = u.company_id
LEFT JOIN support_tickets st
    ON u.user_id = st.user_id
GROUP BY c.company_name
ORDER BY total_support_tickets DESC;


-- 16. Open support tickets by priority
SELECT
    priority,
    COUNT(ticket_id) AS open_tickets
FROM support_tickets
WHERE status = 'Open'
GROUP BY priority
ORDER BY open_tickets DESC;


-- 17. Companies with active subscriptions but unpaid/pending payments
SELECT DISTINCT
    c.company_name,
    s.subscription_id,
    p.payment_status
FROM companies c
JOIN subscriptions s
    ON c.company_id = s.company_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE s.status = 'active'
AND p.payment_status IN ('pending', 'failed');


-- 18. Top 5 companies by paid revenue
SELECT
    c.company_name,
    SUM(p.amount) AS paid_revenue
FROM companies c
JOIN subscriptions s
    ON c.company_id = s.company_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'paid'
GROUP BY c.company_name
ORDER BY paid_revenue DESC
LIMIT 5;


-- 19. Average payment amount by plan
SELECT
    pl.plan_name,
    AVG(p.amount) AS average_payment_amount
FROM plans pl
JOIN subscriptions s
    ON pl.plan_id = s.plan_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
GROUP BY pl.plan_name
ORDER BY average_payment_amount DESC;


-- 20. Companies with the highest number of support tickets
SELECT
    c.company_name,
    COUNT(st.ticket_id) AS ticket_count
FROM companies c
LEFT JOIN users u
    ON c.company_id = u.company_id
LEFT JOIN support_tickets st
    ON u.user_id = st.user_id
GROUP BY c.company_name
ORDER BY ticket_count DESC;


-- 21. Executive summary combining company, plan, revenue and ticket count
SELECT
    c.company_name,
    pl.plan_name,
    s.status AS subscription_status,
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'paid'
            THEN p.amount
            ELSE 0
        END
    ), 0) AS total_paid_revenue,
    COUNT(DISTINCT st.ticket_id) AS ticket_count
FROM companies c
LEFT JOIN subscriptions s
    ON c.company_id = s.company_id
LEFT JOIN plans pl
    ON s.plan_id = pl.plan_id
LEFT JOIN payments p
    ON s.subscription_id = p.subscription_id
LEFT JOIN users u
    ON c.company_id = u.company_id
LEFT JOIN support_tickets st
    ON u.user_id = st.user_id
GROUP BY
    c.company_name,
    pl.plan_name,
    s.status
ORDER BY total_paid_revenue DESC;