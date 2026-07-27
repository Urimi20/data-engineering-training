
INSERT INTO companies (company_name, city, industry) VALUES
('TechNova', 'Prishtina', 'Technology'),
('DataPlus', 'Vushtrri', 'Software'),
('CloudWorks', 'Mitrovica', 'Cloud Services'),
('FutureSoft', 'Peja', 'Education'),
('CodeLab', 'Ferizaj', 'IT Consulting');

INSERT INTO plans (plan_name, monthly_price, max_users) VALUES
('Basic', 49.99, 10),
('Pro', 99.99, 50),
('Enterprise', 249.99, 200);


INSERT INTO users (company_id, full_name, email, role, is_active) VALUES
(1, 'Arta Krasniqi', 'arta@technova.com', 'Admin', 1),
(1, 'Blend Hoxha', 'blend@technova.com', 'Developer', 1),
(1, 'Sara Gashi', 'sara@technova.com', 'Support', 1),

(2, 'Leart Berisha', 'leart@dataplus.com', 'Manager', 1),
(2, 'Gresa Shala', 'gresa@dataplus.com', 'Developer', 1),

(3, 'Dren Kelmendi', 'dren@cloudworks.com', 'Admin', 1),
(3, 'Elira Mustafa', 'elira@cloudworks.com', 'Developer', 0),

(4, 'Albin Ahmeti', 'albin@futuresoft.com', 'Admin', 1),
(4, 'Era Hoxha', 'era@futuresoft.com', 'Support', 1),

(5, 'Luan Rexha', 'luan@codelab.com', 'Manager', 1),
(5, 'Ardiana Gashi', 'ardiana@codelab.com', 'Developer', 1),
(5, 'Besnik Krasniqi', 'besnik@codelab.com', 'Support', 1);



INSERT INTO subscriptions (company_id, plan_id, start_date, status) VALUES
(1, 2, '2026-01-10', 'active'),
(2, 1, '2026-02-05', 'paused'),
(3, 3, '2026-03-12', 'active'),
(4, 2, '2026-04-01', 'cancelled'),
(5, 3, '2026-05-15', 'active'),
(1, 3, '2026-06-20', 'active');


INSERT INTO payments (subscription_id, payment_date, amount, payment_status) VALUES
(1, '2026-01-10', 99.99, 'paid'),
(1, '2026-02-10', 99.99, 'paid'),
(1, '2026-03-10', 99.99, 'pending'),

(2, '2026-02-05', 49.99, 'paid'),
(2, '2026-03-05', 49.99, 'failed'),

(3, '2026-03-12', 249.99, 'paid'),
(3, '2026-04-12', 249.99, 'paid'),

(4, '2026-04-01', 99.99, 'failed'),

(5, '2026-05-15', 249.99, 'paid'),
(5, '2026-06-15', 249.99, 'pending'),

(6, '2026-06-20', 249.99, 'paid'),
(6, '2026-07-20', 249.99, 'paid');


INSERT INTO support_tickets
(user_id, issue_type, priority, status, created_date)
VALUES
(1, 'Login Problem', 'High', 'Open', '2026-06-01'),
(1, 'Password Reset', 'Medium', 'Closed', '2026-06-05'),

(2, 'Billing Issue', 'High', 'In Progress', '2026-06-08'),

(4, 'Subscription Upgrade', 'Low', 'Closed', '2026-06-10'),
(4, 'API Error', 'High', 'Open', '2026-06-15'),

(5, 'Dashboard Bug', 'Medium', 'Closed', '2026-06-18'),

(6, 'Performance Issue', 'High', 'Open', '2026-06-20'),

(7, 'Email Notification', 'Low', 'Closed', '2026-06-22'),

(8, 'Account Locked', 'Medium', 'In Progress', '2026-06-24'),

(10, 'Report Export', 'Low', 'Closed', '2026-06-26'),

(11, 'Payment Failed', 'High', 'Open', '2026-06-28'),

(12, 'Two-Factor Authentication', 'Medium', 'Closed', '2026-06-30');