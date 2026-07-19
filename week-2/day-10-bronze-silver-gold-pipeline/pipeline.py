import csv



def read_csv(file):

    with open(file, "r", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def write_csv(file, data):

    with open(file, "w", newline="", encoding="utf-8") as f:

        if len(data) == 0:
            return

        writer = csv.DictWriter(f, fieldnames=data[0].keys())

        writer.writeheader()
        writer.writerows(data)



# BRONZE


def bronze_layer():

    orders = read_csv("data/bronze/orders_raw.csv")

    customers = read_csv("data/bronze/customers_raw.csv")

    products = read_csv("data/bronze/products_raw.csv")

    print("=== BRONZE ===")
    print("Orders:", len(orders))
    print("Customers:", len(customers))
    print("Products:", len(products))

    return orders, customers, products




def clean_customers(customers_raw):

    customers = []
    used_ids = set()

    for c in customers_raw:

        customer_id = c["customer_id"]

        if customer_id in used_ids:
            continue

        used_ids.add(customer_id)

        city = c["city"].strip().lower()

        if city == "":
            city = "Unknown"

        customers.append(
            {
                "customer_id": customer_id,
                "customer_name": c["customer_name"],
                "city": city.title(),
            }
        )

    write_csv("data/silver/customers_clean.csv", customers)

    return customers




def clean_products(products_raw):

    products = []

    for p in products_raw:

        try:

            price = int(p["price"])

            if price <= 0:
                continue

        except:

            continue

        category = p["category"]

        if category == "":
            category = "Unknown"

        products.append(
            {
                "product_id": p["product_id"],
                "product_name": p["product_name"],
                "category": category,
                "price": price,
            }
        )

    write_csv("data/silver/products_clean.csv", products)

    return products



def create_lookup(data, key):

    result = {}

    for item in data:

        result[item[key]] = item

    return result



def normalize_status(status):

    status = status.lower()

    if status in ["completed", "complete", "done"]:
        return "completed"

    elif status in ["cancelled", "canceled"]:
        return "cancelled"

    elif status == "pending":
        return "pending"

    return status


def normalize_channel(channel):

    channel = channel.lower()

    if channel in ["online", "web", "mobile"]:
        return "online"

    elif channel == "store":
        return "store"

    return "unknown"




def clean_orders(orders_raw, customers, products):

    clean_orders = []
    invalid_orders = []

    customer_dict = create_lookup(customers, "customer_id")

    product_dict = create_lookup(products, "product_id")

    used_orders = set()

    for order in orders_raw:

        order_id = order["order_id"]

        # duplicate check

        if order_id in used_orders:

            invalid_orders.append({**order, "reason": "Duplicate order"})

            continue

        used_orders.add(order_id)

        # missing date

        if order["order_date"] == "":

            invalid_orders.append({**order, "reason": "Missing date"})

            continue

        # quantity

        try:

            quantity = int(order["quantity"])

            if quantity <= 0:
                raise ValueError

        except:

            invalid_orders.append({**order, "reason": "Invalid quantity"})

            continue

        # missing status

        if order["status"].strip() == "":

            invalid_orders.append({**order, "reason": "Missing status"})

            continue

        # customer check

        if order["customer_id"] not in customer_dict:

            invalid_orders.append({**order, "reason": "Customer not found"})

            continue

        # product check

        if order["product_id"] not in product_dict:

            invalid_orders.append({**order, "reason": "Product not found"})

            continue

        customer = customer_dict[order["customer_id"]]

        product = product_dict[order["product_id"]]

        clean_orders.append(
            {
                "order_id": order_id,
                "customer_id": customer["customer_id"],
                "customer_name": customer["customer_name"],
                "city": customer["city"],
                "product_id": product["product_id"],
                "product_name": product["product_name"],
                "category": product["category"],
                "quantity": quantity,
                "price": product["price"],
                "total_amount": quantity * product["price"],
                "status": normalize_status(order["status"]),
                "channel": normalize_channel(order["channel"]),
                "order_date": order["order_date"],
            }
        )

    write_csv("data/silver/orders_clean.csv", clean_orders)

    write_csv("data/silver/invalid_orders.csv", invalid_orders)

    print("\n=== SILVER COMPLETE ===")
    print("Valid:", len(clean_orders))
    print("Invalid:", len(invalid_orders))

    return clean_orders, invalid_orders



# GOLD


def read_silver_orders():

    return read_csv("data/silver/orders_clean.csv")

def revenue_by_category(orders):

    report = {}

    for order in orders:

        if order["status"] != "completed":
            continue

        category = order["category"]

        if category not in report:

            report[category] = {"revenue": 0, "orders": 0}

        report[category]["revenue"] += int(order["total_amount"])

        report[category]["orders"] += 1

    output = []

    for category, data in report.items():

        output.append(
            {
                "category": category,
                "completed_revenue": data["revenue"],
                "total_completed_orders": data["orders"],
            }
        )

    write_csv("data/gold/revenue_by_category.csv", output)

    return output


def revenue_by_city(orders):

    report = {}

    for order in orders:

        if order["status"] != "completed":
            continue

        city = order["city"]

        if city not in report:

            report[city] = {"revenue": 0, "orders": 0}

        report[city]["revenue"] += int(order["total_amount"])

        report[city]["orders"] += 1

    output = []

    for city, data in report.items():

        output.append(
            {
                "city": city,
                "completed_revenue": data["revenue"],
                "total_completed_orders": data["orders"],
            }
        )

    write_csv("data/gold/revenue_by_city.csv", output)

    return output


def revenue_by_customer(orders):

    report = {}

    for order in orders:

        if order["status"] != "completed":
            continue

        name = order["customer_name"]

        if name not in report:

            report[name] = {"city": order["city"], "revenue": 0, "orders": 0}

        report[name]["revenue"] += int(order["total_amount"])

        report[name]["orders"] += 1

    output = []

    for customer, data in report.items():

        output.append(
            {
                "customer_name": customer,
                "city": data["city"],
                "completed_revenue": data["revenue"],
                "total_completed_orders": data["orders"],
            }
        )

    write_csv("data/gold/revenue_by_customer.csv", output)

    return output


def top_products(orders):

    report = {}

    for order in orders:

        if order["status"] != "completed":
            continue

        product = order["product_name"]

        if product not in report:

            report[product] = {
                "category": order["category"],
                "quantity": 0,
                "revenue": 0,
            }

        report[product]["quantity"] += int(order["quantity"])

        report[product]["revenue"] += int(order["total_amount"])

    output = []

    for product, data in report.items():

        output.append(
            {
                "product_name": product,
                "category": data["category"],
                "total_quantity_sold": data["quantity"],
                "completed_revenue": data["revenue"],
            }
        )

    output.sort(key=lambda x: x["completed_revenue"], reverse=True)

    write_csv("data/gold/top_products.csv", output)

    return output


def create_summary(
    raw_orders, clean_orders, invalid_orders, categories, cities, customers, products
):

    completed = [x for x in clean_orders if x["status"] == "completed"]

    pending = [x for x in clean_orders if x["status"] == "pending"]

    cancelled = [x for x in clean_orders if x["status"] == "cancelled"]

    revenue = sum(int(x["total_amount"]) for x in completed)

    top_category = max(categories, key=lambda x: x["completed_revenue"])

    top_city = max(cities, key=lambda x: x["completed_revenue"])

    top_customer = max(customers, key=lambda x: x["completed_revenue"])

    top_product = max(products, key=lambda x: x["completed_revenue"])

    reasons = {}

    for item in invalid_orders:

        reason = item["reason"]

        reasons[reason] = reasons.get(reason, 0) + 1

    invalid_reason = max(reasons, key=reasons.get)

    text = f"""
Executive Summary - Day 10 Pipeline


Total raw orders:
{len(raw_orders)}

Valid silver orders:
{len(clean_orders)}

Invalid orders:
{len(invalid_orders)}

Completed orders:
{len(completed)}

Pending orders:
{len(pending)}

Cancelled orders:
{len(cancelled)}

Completed revenue:
{revenue}

Top category:
{top_category["category"]}

Top city:
{top_city["city"]}

Top customer:
{top_customer["customer_name"]}

Top product:
{top_product["product_name"]}

Most common invalid reason:
{invalid_reason}

Business recommendation:
Focus on completed sales performance, improve data validation,
and investigate invalid orders before reporting.
"""

    with open("data/gold/executive_summary.txt", "w", encoding="utf-8") as f:

        f.write(text)


# MAIN

def main():

    orders_raw, customers_raw, products_raw = bronze_layer()

    customers = clean_customers(customers_raw)

    products = clean_products(products_raw)

    clean_orders_data, invalid_orders = clean_orders(orders_raw, customers, products)

    categories = revenue_by_category(clean_orders_data)

    cities = revenue_by_city(clean_orders_data)

    customers_report = revenue_by_customer(clean_orders_data)

    products_report = top_products(clean_orders_data)

    create_summary(
        orders_raw,
        clean_orders_data,
        invalid_orders,
        categories,
        cities,
        customers_report,
        products_report,
    )


if __name__ == "__main__":

    main()
