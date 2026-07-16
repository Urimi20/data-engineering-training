import csv

# PART2


def load_csv(file_path):
    data = []

    with open(file_path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)

    return data




def load_orders():
    orders = load_csv("data/orders_raw.csv")
    print(f"Loaded {len(orders)} raw orders")
    return orders


def load_customers():
    customers = load_csv("data/customers_raw.csv")
    print(f"Loaded {len(customers)} customers")
    return customers


def load_products():
    products = load_csv("data/products_raw.csv")
    print(f"Loaded {len(products)} products")
    return products


# PART 3 


def build_lookup_table(rows, key_field):
    lookup = {}

    for row in rows:
        lookup[row[key_field]] = row

    return lookup


# PART 4


def normalize_status(status):
    status = status.strip().lower()

    if status in ["completed", "Completed", "complete", "done"]:
        return "completed"

    if status == "pending":
        return "pending"

    if status in [
        "cancelled",
        "canceled",
    ]:
        return "cancelled"

    else:
        return "unknown"


def normalize_city(city):
    city = city.strip().title()

    if city == "Prishtina":
        return "Prishtina"

    elif city == "Vushtrri":
        return "Vushtrri"

    else:
        return city


def normalize_channel(channel):
    channel = channel.strip().lower()

    if channel in ["online", "Online", "web"]:
        return "online"
    elif channel in ["store", "Store"]:
        return "store"
    elif channel in [""]:
        return "unknown"
    else:
        return "unknown"


#  PART 5 


def is_positive_integer(value):
    try:
        return int(value) > 0
    except:
        return False


def validate_order(order, customers_lookup, products_lookup):

    if not order["order_id"]:
        return False, "missing_order_id"

    if not order["customer_id"]:
        return False, "missing_customer_id"

    if order["customer_id"] not in customers_lookup:
        return False, "invalid_customer_id"

    if not order["product_id"]:
        return False, "missing_product_id"

    if order["product_id"] not in products_lookup:
        return False, "invalid_product_id"

    if not order["order_date"]:
        return False, "missing_order_date"

    if not order["quantity"]:
        return False, "missing_quantity"

    if order["quantity"].isalpha():
        return False, "invalid_quantity"

    if not is_positive_integer(order["quantity"]):
        return False, "negative_quantity"

    if not order["status"]:
        return False, "missing_status"

    if order["status"] not in ["completed", "pending", "cancelled"]:
        return False, "invalid_status"

    return True, "valid"


# PART 6


def calculate_total_amount(order):
    return int(order["quantity"]) * int(order["price"])


def enrich_order(order, customers_lookup, products_lookup):

    customer = customers_lookup[order["customer_id"]]
    product = products_lookup[order["product_id"]]

    clean_order = {
        "order_id": order["order_id"],
        "customer_id": order["customer_id"],
        "customer_name": customer["customer_name"],
        "city": customer["city"],
        "product_id": order["product_id"],
        "product_name": product["product_name"],
        "category": product["category"],
        "quantity": order["quantity"],
        "price": product["price"],
        "total_amount": calculate_total_amount(
            {"quantity": order["quantity"], "price": product["price"]}
        ),
        "status": order["status"],
        "channel": order["channel"],
        "order_date": order["order_date"],
    }

    return clean_order


# PART 7


def write_csv(file_path, rows, fieldnames):
    with open(file_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fieldnames)

        writer.writeheader()
        writer.writerows(rows)


# PART 8
def create_data_quality_report(raw_orders, clean_orders, invalid_orders):

    report = []

    report.append("Data Quality Report - Day 9\n")

    report.append(f"Total raw orders: {len(raw_orders)}")
    report.append(f"Valid orders: {len(clean_orders)}")
    report.append(f"Invalid orders: {len(invalid_orders)}\n")


    report.append("Invalid records by reason:")

    reasons = {}

    for order in invalid_orders:
        reason = order["reason"]

        if reason in reasons:
            reasons[reason] += 1
        else:
            reasons[reason] = 1

    for reason, count in reasons.items():
        report.append(f"- {reason}: {count}")

  
    report.append("\nStatus values after cleaning:")

    statuses = set()

    for order in clean_orders:
        statuses.add(order["status"])

    for status in statuses:
        report.append(f"- {status}")

    
    report.append("\nChannel values after cleaning:")

    channels = set()

    for order in clean_orders:
        channels.add(order["channel"])

    for channel in channels:
        report.append(f"- {channel}")

  
    report.append("\nCity values after cleaning:")

    cities = set()

    for order in clean_orders:
        cities.add(order["city"])

    for city in cities:
        report.append(f"- {city}")

    report.append("\nBronze input files checked:")
    report.append("- orders_raw.csv")
    report.append("- customers_raw.csv")
    report.append("- products_raw.csv")

    report.append("\nSilver output files created:")
    report.append("- orders_clean.csv")
    report.append("- invalid_orders.csv")

    report.append("\nMain data quality problems found:")
    report.append("- Missing quantities")
    report.append("- Invalid customer IDs")
    report.append("- Invalid product IDs")
    report.append("- Invalid quantity values")
    report.append("- Missing status values")

    with open("output/data_quality_report.txt", "w", encoding="utf-8") as file:
        file.write("\n".join(report))


# PART 9 


def create_business_summary(clean_orders):

    total_revenue = 0

    for order in clean_orders:
        total_revenue += order["total_amount"]

    completed_orders = []

    for order in clean_orders:
        if order["status"] == "completed":
            completed_orders.append(order)

    summary = []

    summary.append("Business Summary - Day 9\n")

    summary.append(f"Total orders: {len(clean_orders)}")

    summary.append(f"Total revenue: {total_revenue}")

    summary.append(f"Completed orders: {len(completed_orders)}")

    
    channels = {}

    for order in clean_orders:
        channel = order["channel"]

        if channel in channels:
            channels[channel] += 1
        else:
            channels[channel] = 1

    summary.append("\nOrders by channel:")

    for channel, count in channels.items():
        summary.append(f"- {channel}: {count}")

 
    categories = {}

    for order in clean_orders:
        category = order["category"]

        if category in categories:
            categories[category] += 1
        else:
            categories[category] = 1

    summary.append("\nOrders by category:")

    for category, count in categories.items():
        summary.append(f"- {category}: {count}")

    with open("output/business_summary.txt", "w", encoding="utf-8") as file:
        file.write("\n".join(summary))


# ---------- MAIN ----------


def main():

    # 1. Load raw CSV files
    orders = load_orders()
    customers = load_customers()
    products = load_products()

    # 2. Normalize data

    for order in orders:
        order["status"] = normalize_status(order["status"])
        order["channel"] = normalize_channel(order["channel"])

    for customer in customers:
        customer["city"] = normalize_city(customer["city"])

    # Build lookup tables
    customers_lookup = build_lookup_table(customers, "customer_id")
    products_lookup = build_lookup_table(products, "product_id")

    # 3. Validate orders

    valid_orders = []
    invalid_orders = []

    for order in orders:

        is_valid, reason = validate_order(order, customers_lookup, products_lookup)

        if is_valid:
            valid_orders.append(order)

        else:
            order["reason"] = reason
            invalid_orders.append(order)

    # 4. Enrich valid orders

    clean_orders = []

    for order in valid_orders:

        clean_order = enrich_order(order, customers_lookup, products_lookup)

        clean_orders.append(clean_order)

    # 5. Write CSV files

    clean_fields = [
        "order_id",
        "customer_id",
        "customer_name",
        "city",
        "product_id",
        "product_name",
        "category",
        "quantity",
        "price",
        "total_amount",
        "status",
        "channel",
        "order_date",
    ]

    write_csv("output/orders_clean.csv", clean_orders, clean_fields)

    invalid_fields = [
        "order_id",
        "customer_id",
        "product_id",
        "order_date",
        "quantity",
        "status",
        "channel",
        "reason",
    ]

    write_csv("output/invalid_orders.csv", invalid_orders, invalid_fields)

    # 6. Create data quality report

    create_data_quality_report(orders, clean_orders, invalid_orders)

    # 7. Create business summary report

    create_business_summary(clean_orders)

    print("Pipeline finished successfully.")
    print(f"Valid orders: {len(clean_orders)}")
    print(f"Invalid orders: {len(invalid_orders)}")


if __name__ == "__main__":
    main()
