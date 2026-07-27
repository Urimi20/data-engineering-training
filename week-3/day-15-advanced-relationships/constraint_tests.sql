------------------------------------------------
-- Test 1
-- Should fail because company_id = 999 does not exist
------------------------------------------------

INSERT INTO users
(company_id, full_name, email, role, is_active)
VALUES
(999, 'Test User', 'testuser@email.com', 'Developer', 1);


------------------------------------------------
-- Test 2
-- Should fail because plan_id = 999 does not exist
------------------------------------------------

INSERT INTO subscriptions
(company_id, plan_id, start_date, status)
VALUES
(1, 999, '2026-08-01', 'active');


------------------------------------------------
-- Test 3
-- Should fail because email must be UNIQUE
------------------------------------------------

INSERT INTO users
(company_id, full_name, email, role, is_active)
VALUES
(1, 'Duplicate User', 'arta@technova.com', 'Admin', 1);



------------------------------------------------
-- Test 4
-- Should fail because monthly_price must be positive
------------------------------------------------

INSERT INTO plans
(plan_name, monthly_price, max_users)
VALUES
('Invalid Plan', -50, 20);


------------------------------------------------
-- Test 5
-- Should fail because amount must be greater than 0
------------------------------------------------

INSERT INTO payments
(subscription_id, payment_date, amount, payment_status)
VALUES
(1, '2026-08-05', 0, 'paid');




------------------------------------------------
-- Test 6
-- Should fail because priority is invalid
------------------------------------------------

INSERT INTO support_tickets
(user_id, issue_type, priority, status, created_date)
VALUES
(1, 'Testing Ticket', 'Urgent', 'Open', '2026-08-05');


------------------------------------------------
-- Test 7
-- Should fail because subscription status is invalid
------------------------------------------------

INSERT INTO subscriptions
(company_id, plan_id, start_date, status)
VALUES
(1, 1, '2026-08-05', 'expired');


------------------------------------------------
-- Test 8
-- Should fail because payment_status is invalid
------------------------------------------------

INSERT INTO payments
(subscription_id, payment_date, amount, payment_status)
VALUES
(1, '2026-08-05', 99.99, 'completed');