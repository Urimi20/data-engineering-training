import csv


# FILE FUNCTIONS


def load_csv(file_path):

    with open(file_path, "r", encoding="utf-8") as file:
        return list(csv.DictReader(file))


def write_csv(file_path, data):

    if not data:
        return

    with open(file_path, "w", newline="", encoding="utf-8") as file:

        writer = csv.DictWriter(file, fieldnames=data[0].keys())

        writer.writeheader()
        writer.writerows(data)


# NORMALIZATION FUNCTIONS


def normalize_status(status):

    if not status:
        return ""

    status = status.strip().lower()

    if status in ["completed", "done"]:
        return "completed"

    if status == "pending":
        return "pending"

    if status in ["cancelled", "canceled"]:
        return "cancelled"

    return status


def normalize_city(city):

    if not city:
        return ""

    city = city.strip().lower()

    cities = {
        "prishtina": "Prishtina",
        "vushtrri": "Vushtrri",
        "mitrovica": "Mitrovica",
        "peja": "Peja",
        "prizren": "Prizren",
        "ferizaj": "Ferizaj",
        "gjilan": "Gjilan",
    }

    return cities.get(city, city.title())


def normalize_channel(channel):

    if not channel:
        return "unknown"

    channel = channel.strip().lower()

    if channel == "online":
        return "online"

    if channel == "web":
        return "web"

    if channel == "store":
        return "store"

    if channel == "bank":
        return "bank"

    return "unknown"


# LOOKUP FUNCTIONS


def build_lookup(data, key):

    lookup = {}

    for row in data:
        lookup[row[key]] = row

    return lookup


# VALIDATION


def validate_order(order, customer_lookup, product_lookup, seen_orders):

    if order["order_id"] in seen_orders:
        return False, "duplicate_order"

    seen_orders.add(order["order_id"])

    quantity = order["quantity"].strip()

    if quantity == "":
        return False, "missing_quantity"

    try:

        quantity = int(quantity)

        if quantity <= 0:
            return False, "invalid_quantity"

    except:

        return False, "invalid_quantity"

    status = normalize_status(order["status"])

    if status == "":
        return False, "missing_status"

    if status not in ["completed", "pending", "cancelled"]:
        return False, "invalid_status"

    if order["order_date"].strip() == "":
        return False, "missing_order_date"

    if order["customer_id"] not in customer_lookup:
        return False, "invalid_customer_id"

    if order["product_id"] not in product_lookup:
        return False, "invalid_product_id"

    return True, ""


# SILVER LAYER


def create_silver_orders(orders, customer_lookup, product_lookup):

    clean_orders = []
    invalid_orders = []

    seen_orders = set()

    for order in orders:

        valid, reason = validate_order(
            order, customer_lookup, product_lookup, seen_orders
        )

        if not valid:

            invalid = order.copy()
            invalid["invalid_reason"] = reason

            invalid_orders.append(invalid)

            continue

        customer = customer_lookup[order["customer_id"]]

        product = product_lookup[order["product_id"]]

        clean_order = {
            "order_id": order["order_id"],
            "customer_id": order["customer_id"],
            "customer_name": customer["customer_name"],
            "city": normalize_city(customer["city"]),
            "segment": customer["segment"],
            "product_id": order["product_id"],
            "product_name": product["product_name"],    
            "category": product["category"],
            "quantity": int(order["quantity"]),
            "price": int(product["price"]),
            "status": normalize_status(order["status"]),
            "order_date": order["order_date"],
            "channel": normalize_channel(order["channel"]),
            "total_amount": int(order["quantity"]) * int(product["price"]),
        }

        clean_orders.append(clean_order)

    return clean_orders, invalid_orders


# GOLD LAYER


def create_gold_reports(clean_orders):

    completed_orders = []

    for order in clean_orders:

        if order["status"] == "completed":

            completed_orders.append(order)

    # Revenue by City

    city_revenue = {}

    for order in completed_orders:

        city = order["city"]

        amount = int(order["total_amount"])

        if city not in city_revenue:

            city_revenue[city] = 0

        city_revenue[city] += amount

    revenue_by_city = []

    for city, revenue in city_revenue.items():

        revenue_by_city.append({"city": city, "total_revenue": revenue})

    write_csv("data/gold/revenue_by_city.csv", revenue_by_city)

    # Revenue by Category

    category_revenue = {}

    for order in completed_orders:

        category = order["category"]

        amount = int(order["total_amount"])

        if category not in category_revenue:

            category_revenue[category] = 0

        category_revenue[category] += amount

    revenue_by_category = []

    for category, revenue in category_revenue.items():

        revenue_by_category.append({"category": category, "total_revenue": revenue})

    write_csv("data/gold/revenue_by_category.csv", revenue_by_category)

    # Top Customers

    customer_revenue = {}

    for order in completed_orders:

        customer = order["customer_name"]

        amount = int(order["total_amount"])

        if customer not in customer_revenue:

            customer_revenue[customer] = 0

        customer_revenue[customer] += amount

    top_customers = []

    for customer, revenue in customer_revenue.items():

        top_customers.append({"customer_name": customer, "total_revenue": revenue})

    top_customers.sort(key=lambda x: x["total_revenue"], reverse=True)

    write_csv("data/gold/top_customers.csv", top_customers)

    # Executive Summary


    total_revenue = 0

    total_categories = set()
    total_cities = set()

    for order in completed_orders:

        total_revenue += int(order["total_amount"])

        total_categories.add(order["category"])

        total_cities.add(order["city"])

    with open("data/gold/executive_summary.txt", "w", encoding="utf-8") as file:

        file.write("====================================\n")

        file.write("       EXECUTIVE BUSINESS SUMMARY\n")

        file.write("             Day 11 Pipeline\n")

        file.write("====================================\n\n")

        file.write("Overview:\n")

        file.write(
            "This report summarizes business performance "
            "based on validated completed orders from the Silver layer.\n\n"
        )

        file.write("Key Performance Indicators:\n")

        file.write(f"- Completed Orders: {len(completed_orders)}\n")

        file.write(f"- Completed Revenue: {total_revenue:.2f}\n")

        file.write(f"- Active Cities: {len(total_cities)}\n")

        file.write(f"- Product Categories Sold: {len(total_categories)}\n\n")

        file.write("Business Rules Applied:\n")

        file.write("- Only valid clean orders were included.\n")

        file.write("- Revenue calculation includes completed orders only.\n")

        file.write("- Invalid and inconsistent records were excluded.\n\n")

        file.write("Data Pipeline Status:\n")

        file.write("- Bronze Layer: Raw source data processed.\n")

        file.write("- Silver Layer: Data cleaned, validated, and enriched.\n")

        file.write("- Gold Layer: Business reports generated successfully.\n")

        file.write("\n====================================\n")

        file.write("Generated automatically by Python Data Pipeline\n")

        file.write("====================================\n")

    print("Gold layer created successfully!")


# MAIN


def main():

    orders = load_csv("data/bronze/orders_raw.csv")

    customers = load_csv("data/bronze/customers_raw.csv")

    products = load_csv("data/bronze/products_raw.csv")

    customer_lookup = build_lookup(customers, "customer_id")

    product_lookup = build_lookup(products, "product_id")

    clean_orders, invalid_orders = create_silver_orders(
        orders, customer_lookup, product_lookup
    )

    write_csv("data/silver/orders_clean.csv", clean_orders)

    write_csv("data/silver/invalid_orders.csv", invalid_orders)

    print("Silver layer created successfully!")

    create_gold_reports(clean_orders)

    print("Pipeline finished successfully!")


if __name__ == "__main__":
    main()
