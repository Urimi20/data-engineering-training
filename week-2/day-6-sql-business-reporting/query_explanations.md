# Query Explanations - Day 6

---

### Query title: Completed revenue by category

**File:** join_reports.sql
**Business question:** Which product category generated the most completed revenue?
**Tables used:** orders, products
**Why JOIN is needed:** orders ka vetëm product_id, ndërsa category dhe price janë te products, prandaj duhet lidhja për me llogarit revenue.
**Why WHERE is needed:** vetëm completed orders përfaqësojnë revenue real.
**Why GROUP BY is needed:** duam një rresht për çdo kategori.
**What I understood:** Për me marrë insight real për biznesin, duhet me lidh të dhënat dhe me filtru vetëm ato që kanë vlerë reale (completed).

---

### Query title: Completed revenue by product_name

**File:** join_reports.sql
**Business question:** Which products generate the most money?
**Tables used:** orders, products
**Why JOIN is needed:** product_name dhe price janë te products, jo te orders.
**Why WHERE is needed:** pa këtë filter do përfshiheshin edhe pending/cancelled.
**Why GROUP BY is needed:** me i grupu rezultatet sipas çdo produkti.
**What I understood:** Jo çdo produkt kontribuon njësoj – disa produkte janë shumë më të rëndësishme për revenue.

---

### Query title: Order count by city

**File:** join_reports.sql
**Business question:** Which cities have the most orders?
**Tables used:** orders, customers
**Why JOIN is needed:** city nuk ekziston te orders, por te customers.
**Why GROUP BY is needed:** për me numëru porositë për çdo qytet.
**What I understood:** Lokacioni i klientëve është shumë i rëndësishëm për strategji shitjeje.

---

### Query title: Completed revenue by city

**File:** join_reports.sql
**Business question:** Which city generates the most revenue?
**Tables used:** orders, customers, products
**Why JOIN is needed:** duhet city nga customers dhe price nga products.
**Why WHERE is needed:** vetëm completed janë revenue real.
**Why GROUP BY is needed:** një rezultat për çdo qytet.
**What I understood:** Qyteti me më shumë porosi nuk është gjithmonë ai me më shumë revenue.

---

### Query title: Top 3 customers by completed revenue

**File:** join_reports.sql
**Business question:** Who are the most valuable customers?
**Tables used:** orders, customers, products
**Why JOIN is needed:** duhet customer_name dhe price për llogaritje.
**Why WHERE is needed:** vetëm completed orders kanë vlerë reale.
**Why GROUP BY is needed:** për me mbledh revenue për çdo klient.
**Why ORDER BY + LIMIT is needed:** për me marrë vetëm top 3.
**What I understood:** Jo çdo klient ka të njëjtën vlerë – disa janë shumë më fitimprurës.

---

### Query title: Products with completed quantity > 2

**File:** group_by_reports.sql
**Business question:** Which products are selling in higher quantities?
**Tables used:** orders
**Why WHERE is needed:** vetëm completed orders janë shitje reale.
**Why GROUP BY is needed:** për me grupu sipas produktit.
**Why HAVING is needed:** për me filtru vetëm produktet me sasi > 2 pas agregimit.
**What I understood:** HAVING përdoret kur filtrojmë rezultate të agreguara, jo të dhëna individuale.

---

### Query title: Customers with more than one order

**File:** group_by_reports.sql
**Business question:** Which customers are repeat buyers?
**Tables used:** orders
**Why GROUP BY is needed:** për me numëru porositë për çdo customer_id.
**Why HAVING is needed:** për me zgjedh vetëm ata me më shumë se 1 porosi.
**What I understood:** Repeat customers janë shumë të rëndësishëm për biznesin.

---

### Query title: Completed revenue (total)

**File:** basic_aggregations.sql
**Business question:** How much real revenue did the business generate?
**Tables used:** orders, products
**Why JOIN is needed:** price nuk është në orders.
**Why WHERE is needed:** vetëm completed janë revenue real.
**What I understood:** Revenue nuk është thjesht numër orders, por varet nga quantity dhe price.

---

### Query title: Pending and cancelled potential value

**File:** basic_aggregations.sql
**Business question:** How much potential revenue is not yet realized?
**Tables used:** orders, products
**Why JOIN is needed:** për me marrë price dhe llogarit total.
**Why WHERE is needed:** për me zgjedh vetëm pending dhe cancelled.
**What I understood:** Jo çdo vlerë që duket si revenue është reale – duhet dallim mes actual dhe potential.
