from order_data import orders

# PART 1

def print_raw_summary(orders):
    print("total number of raw data:", len(orders))

    print("-" * 40)

    for order in orders[:3]:
        print(
            f"{order['customer_name']} is from {order['city']} and ordered {order['category']} with quantity {order['quantity']} at price {order['price']}."
        )

    print("-" * 40)

    statuses = []
    cities = []
    categories = []
    channels = []

    for order in orders:
        if order["status"] not in statuses:
            statuses.append(order["status"])

        if order["city"] not in cities:
            cities.append(order["city"])

        if order["category"] not in categories:
            categories.append(order["category"])

        if order["channel"] not in channels:
            channels.append(order["channel"])

    print("Unique statuses:", statuses)
    print("Unique cities:", cities)
    print("Unique categories:", categories)
    print("Unique channels:", channels)

# PART 2 


def validate_order(order):
    reasons = []

    
    required_fields = [
        "order_id",
        "customer_name",
        "city",
        "product",
        "category",
        "quantity",
        "price",
        "status",
        "channel"
    ]

    for field in required_fields:
        if field not in order or order[field] is None or order[field] == "":
            reasons.append(f"missing {field}")


    
    if order.get("quantity") is not None:
        if order["quantity"] <= 0:
            reasons.append("invalid quantity")


    
    if order.get("price") is not None:
        if order["price"] <= 0:
            reasons.append("invalid price")


    valid_statuses = [
        "completed",
        "complete",
        "pending",
        "cancelled",
        "returned"
    ]

    if order.get("status"):
        if order["status"].lower() not in valid_statuses:
            reasons.append("invalid status")


    
    valid_channels = [
        "online",
        "store"
    ]

    if order.get("channel"):
        if order["channel"].lower() not in valid_channels:
            reasons.append("invalid channel")


    return reasons


def separate_orders(orders):

    valid = []
    invalid = []

    for order in orders:

        reasons = validate_order(order)

        if len(reasons) == 0:
            valid.append(order)

        else:
            invalid.append({
                "order_id": order["order_id"],
                "reasons": reasons
            })

    return valid, invalid


def write_invalid_records(invalid):

    with open("output/invalid_records.txt", "w") as f:

        for record in invalid:
            f.write(
                f"Order {record['order_id']} -> {', '.join(record['reasons'])}\n"
            )


def write_validation_report(total, valid, invalid):

    with open("output/validation_report.txt", "w") as f:

        f.write(f"Total records: {total}\n")
        f.write(f"Valid records: {valid}\n")
        f.write(f"Invalid records: {invalid}\n")

# PART 3


def normalize_order(order):
    cleaned_order = order.copy()

    status = cleaned_order["status"].lower()
    city = cleaned_order["city"].lower()
    category = cleaned_order["category"].lower()
    channel = cleaned_order["channel"].lower()
    price = cleaned_order["price"]
    quantity = cleaned_order["quantity"]

    if status in ["complete", "completed"]:
        cleaned_order["status"] = "completed"

    if city == "prishtine":
        cleaned_order["city"] = "Prishtina"

    if category == "accessories":
        cleaned_order["category"] = "Accessories"

    if channel == "online":
        cleaned_order["channel"] = "online"

    if price is None and quantity is None:
        cleaned_order["total_amount"] = None
    else:
        cleaned_order["total_amount"] = quantity * price

    return cleaned_order


def print_clean_summary(cleaned_orders):
    statuses = []
    cities = []
    categories = []
    channels = []

    for order in cleaned_orders:

        if order["status"] not in statuses:
            statuses.append(order["status"])

        if order["city"] not in cities:
            cities.append(order["city"])

        if order["category"] not in categories:
            categories.append(order["category"])

        if order["channel"] not in channels:
            channels.append(order["channel"])

    print("Cleaned statuses:", statuses)
    print("Cleaned cities:", cities)
    print("Cleaned categories:", categories)
    print("Cleaned channels:", channels)


def clean_orders(valid_orders):
    cleaned = []

    for order in valid_orders:
        cleaned.append(normalize_order(order))

    return cleaned

# PART 4

def get_raw_records(raw_orders):
    return len(raw_orders)


def get_valid_records(valid_orders):
    return len(valid_orders)


def get_invalid_records(invalid_orders):
    total_reasons = 0

    for record in invalid_orders:
        total_reasons += len(record["reasons"])

    return len(invalid_orders), total_reasons


def get_completed_orders(cleaned_orders):
    completed_orders = []

    for order in cleaned_orders:
        if order["status"] == "completed":
            completed_orders.append(order)

    return completed_orders


def get_non_revenue_orders(cleaned_orders):
    count = 0

    for order in cleaned_orders:
        if order["status"] in ["pending", "cancelled", "returned"]:
            count += 1

    return count


def get_completed_revenue(completed_orders):
    return sum(order["total_amount"] for order in completed_orders)


def get_average_completed_value(completed_revenue, completed_count):
    if completed_count > 0:
        return completed_revenue / completed_count
    return 0


def get_highest_order(completed_orders):
    if len(completed_orders) > 0:
        return max(order["total_amount"] for order in completed_orders)
    return 0


def get_lowest_order(completed_orders):
    if len(completed_orders) > 0:
        return min(order["total_amount"] for order in completed_orders)
    return 0


def print_business_metrics(raw_orders, valid_orders, invalid_orders, cleaned_orders):

    completed_orders = get_completed_orders(cleaned_orders)
    completed_count = len(completed_orders)

    completed_revenue = get_completed_revenue(completed_orders)

    invalid_count, total_reasons = get_invalid_records(invalid_orders)

    print("Raw records:", get_raw_records(raw_orders))
    print("Valid records:", get_valid_records(valid_orders))
    print("Invalid records:", invalid_count)
    print("Total invalid reasons:", total_reasons)
    print("Completed orders:", completed_count)
    print("Non-revenue orders:", get_non_revenue_orders(cleaned_orders))
    print("Completed revenue:", completed_revenue)
    print("Average completed order value:", get_average_completed_value(completed_revenue, completed_count))
    print("Highest order:", get_highest_order(completed_orders))
    print("Lowest completed order:", get_lowest_order(completed_orders))



# PART 5

def count_by_status(cleaned_orders):
    status_count = {}

    for order in cleaned_orders:
        status = order["status"]

        if status not in status_count:
            status_count[status] = 0

        status_count[status] += 1

    return status_count

def count_by_city(cleaned_orders):
    city_count = {}

    for order in cleaned_orders:
        city = order["city"]

        if city not in city_count:
            city_count[city] = 0

        city_count[city] += 1

    return city_count

def count_by_category(cleaned_orders):
    category_count = {}

    for order in cleaned_orders:
        category = order["category"]

        if category not in category_count:
            category_count[category] = 0

        category_count[category] += 1

    return category_count

def count_by_channel(cleaned_orders):
    channel_count = {}

    for order in cleaned_orders:
        channel = order["channel"]

        if channel not in channel_count:
            channel_count[channel] = 0

        channel_count[channel] += 1

    return channel_count

def completed_revenue_by_city(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            city = order["city"]

            if city not in revenue:
                revenue[city] = 0

            revenue[city] += order["total_amount"]

    return revenue

def completed_revenue_by_category(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            category = order["category"]

            if category not in revenue:
                revenue[category] = 0

            revenue[category] += order["total_amount"]

    return revenue

def completed_revenue_by_channel(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            channel = order["channel"]

            if channel not in revenue:
                revenue[channel] = 0

            revenue[channel] += order["total_amount"]

    return revenue

def completed_revenue_by_customer(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            customer = order["customer_name"]

            if customer not in revenue:
                revenue[customer] = 0

            revenue[customer] += order["total_amount"]

    return revenue


def customers_with_multiple_orders(cleaned_orders):
    customers = {}

    for order in cleaned_orders:
        customer = order["customer_name"]

        if customer not in customers:
            customers[customer] = 0

        customers[customer] += 1

    result = {}

    for customer, count in customers.items():
        if count > 1:
            result[customer] = count

    return result

# PART 5 - Dynamic reports using dictionaries

def count_by_status(cleaned_orders):
    status_count = {}

    for order in cleaned_orders:
        status = order["status"]

        if status not in status_count:
            status_count[status] = 0

        status_count[status] += 1

    return status_count


def count_by_city(cleaned_orders):
    city_count = {}

    for order in cleaned_orders:
        city = order["city"]

        if city not in city_count:
            city_count[city] = 0

        city_count[city] += 1

    return city_count


def count_by_category(cleaned_orders):
    category_count = {}

    for order in cleaned_orders:
        category = order["category"]

        if category not in category_count:
            category_count[category] = 0

        category_count[category] += 1

    return category_count


def count_by_channel(cleaned_orders):
    channel_count = {}

    for order in cleaned_orders:
        channel = order["channel"]

        if channel not in channel_count:
            channel_count[channel] = 0

        channel_count[channel] += 1

    return channel_count


def completed_revenue_by_city(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            city = order["city"]

            if city not in revenue:
                revenue[city] = 0

            revenue[city] += order["total_amount"]

    return revenue


def completed_revenue_by_category(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            category = order["category"]

            if category not in revenue:
                revenue[category] = 0

            revenue[category] += order["total_amount"]

    return revenue


def completed_revenue_by_channel(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            channel = order["channel"]

            if channel not in revenue:
                revenue[channel] = 0

            revenue[channel] += order["total_amount"]

    return revenue


def completed_revenue_by_customer(cleaned_orders):
    revenue = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            customer = order["customer_name"]

            if customer not in revenue:
                revenue[customer] = 0

            revenue[customer] += order["total_amount"]

    return revenue


def customers_with_multiple_orders(cleaned_orders):
    customers = {}

    for order in cleaned_orders:
        customer = order["customer_name"]

        if customer not in customers:
            customers[customer] = 0

        customers[customer] += 1

    result = {}

    for customer, count in customers.items():
        if count > 1:
            result[customer] = count

    return result


def products_ordered_more_than_once(cleaned_orders):
    products = {}

    for order in cleaned_orders:
        product = order["product"]

        if product not in products:
            products[product] = 0

        products[product] += 1

    result = {}

    for product, count in products.items():
        if count > 1:
            result[product] = count

    return result



# PART 6    

def sort_by_revenue(data):
    sorted_data = []

    for name in data:
        sorted_data.append([name, data[name]])

    for i in range(len(sorted_data)):
        for j in range(i + 1, len(sorted_data)):
            if sorted_data[i][1] < sorted_data[j][1]:
                sorted_data[i], sorted_data[j] = sorted_data[j], sorted_data[i]

    return sorted_data



def top_completed_orders(cleaned_orders):
    
    completed_orders = []

    for order in cleaned_orders:
        if order["status"] == "completed":
            completed_orders.append(order)

    for i in range(len(completed_orders)):
        for j in range(i + 1, len(completed_orders)):
            if completed_orders[i]["total_amount"] < completed_orders[j]["total_amount"]:
                completed_orders[i], completed_orders[j] = completed_orders[j], completed_orders[i]

    print("Top 5 completed orders:")

    for order in completed_orders[:5]:
        print(
            f"Order ID: {order['order_id']} | "
            f"Customer: {order['customer_name']} | "
            f"Amount: {order['total_amount']}"
        )


def top_customers_by_revenue(cleaned_orders):
    customers = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            customer = order["customer_name"]

            if customer not in customers:
                customers[customer] = 0

            customers[customer] += order["total_amount"]

    sorted_customers = sort_by_revenue(customers)

    print("\nTop 3 customers by completed revenue:")

    for customer in sorted_customers[:3]:
        print(f"{customer[0]}: {customer[1]}")


def top_products_by_revenue(cleaned_orders):
    products = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            product = order["product"]

            if product not in products:
                products[product] = 0

            products[product] += order["total_amount"]

    sorted_products = sort_by_revenue(products)

    print("\nTop 3 products by completed revenue:")

    for product in sorted_products[:3]:
        print(f"{product[0]}: {product[1]}")

def top_cities_by_revenue(cleaned_orders):
    cities = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            city = order["city"]

            if city not in cities:
                cities[city] = 0

            cities[city] += order["total_amount"]

    sorted_cities = sort_by_revenue(cities)

    print("\nTop 3 cities by completed revenue:")

    for city in sorted_cities[:3]:
        print(f"{city[0]}: {city[1]}")

def categories_sorted_by_revenue(cleaned_orders):
    categories = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            category = order["category"]

            if category not in categories:
                categories[category] = 0

            categories[category] += order["total_amount"]

    sorted_categories = sort_by_revenue(categories)

    print("\nCategories by completed revenue:")

    for category in sorted_categories:
        print(f"{category[0]}: {category[1]}")

def channels_sorted_by_revenue(cleaned_orders):
    channels = {}

    for order in cleaned_orders:
        if order["status"] == "completed":

            channel = order["channel"]

            if channel not in channels:
                channels[channel] = 0

            channels[channel] += order["total_amount"]

    sorted_channels = sort_by_revenue(channels)

    print("\nChannels by completed revenue:")

    for channel in sorted_channels:
        print(f"{channel[0]}: {channel[1]}")


# PART 7 

def data_quality_report(orders, valid_orders, invalid_orders, cleaned_orders):

    print("\nData Quality Investigation")
    print("-" * 40)

    print("Invalid records removed:")

    for record in invalid_orders:
        print(
            "Order",
            record["order_id"],
            "removed because",
            record["reasons"]
        )


    non_revenue = 0

    for order in cleaned_orders:
        if order["status"] in ["pending", "cancelled", "returned"]:
            non_revenue += 1

    print("\nValid orders that do not count as revenue:", non_revenue)


    statuses = []

    for order in orders:
        if order["status"] not in statuses:
            statuses.append(order["status"])

    print("\nStatus before normalization:", statuses)


    print("\nNormalization changes:")

    for old, new in zip(valid_orders, cleaned_orders):

        if old["status"] != new["status"]:
            print(old["status"], "changed to", new["status"])

        if old["city"] != new["city"]:
            print(old["city"], "changed to", new["city"])

        if old["category"] != new["category"]:
            print(old["category"], "changed to", new["category"])

        if old["channel"] != new["channel"]:
            print(old["channel"], "changed to", new["channel"])


    print("\nRevenue problems:")
    print(
        "If we calculate revenue before validation, "
        "invalid orders and wrong values can affect the result."
    )

    print(
        "If pending, cancelled, and returned orders count as revenue, "
        "revenue will be higher than the real completed sales."
    )



# PART 8 - Output Files


def write_invalid_records_file(invalid_orders, orders):

    with open("output/invalid_records.txt", "a") as f:

        f.write("\n" + "-" * 40 + "\n")

        for invalid in invalid_orders:

            customer = ""

            for order in orders:
                if order["order_id"] == invalid["order_id"]:
                    customer = order.get("customer_name", "")
                    break

            f.write(
                f"Order ID: {invalid['order_id']} | "
                f"Customer: {customer} | "
                f"Reasons: {', '.join(invalid['reasons'])}\n"
            )



def write_validation_report_file(
    raw_orders,
    valid_orders,
    invalid_orders,
    cleaned_orders
):

    with open("output/validation_report.txt", "a") as f:

        f.write("\n" + "-" * 40 + "\n")

        total_reasons = 0

        for record in invalid_orders:
            total_reasons += len(record["reasons"])

        f.write(f"Raw records: {len(raw_orders)}\n")
        f.write(f"Valid records: {len(valid_orders)}\n")
        f.write(f"Invalid records: {len(invalid_orders)}\n")
        f.write(f"Total invalid reasons: {total_reasons}\n\n")


        statuses_before = []
        cities_before = []
        categories_before = []
        channels_before = []

        for order in raw_orders:
            if order["status"] not in statuses_before:
                statuses_before.append(order["status"])

            if order["city"] not in cities_before:
                cities_before.append(order["city"])

            if order["category"] not in categories_before:
                categories_before.append(order["category"])

            if order["channel"] not in channels_before:
                channels_before.append(order["channel"])


        statuses_after = []
        cities_after = []
        categories_after = []
        channels_after = []

        for order in cleaned_orders:
            if order["status"] not in statuses_after:
                statuses_after.append(order["status"])

            if order["city"] not in cities_after:
                cities_after.append(order["city"])

            if order["category"] not in categories_after:
                categories_after.append(order["category"])

            if order["channel"] not in channels_after:
                channels_after.append(order["channel"])


        f.write("Statuses before: " + str(statuses_before) + "\n")
        f.write("Statuses after: " + str(statuses_after) + "\n\n")

        f.write("Cities before: " + str(cities_before) + "\n")
        f.write("Cities after: " + str(cities_after) + "\n\n")

        f.write("Categories before: " + str(categories_before) + "\n")
        f.write("Categories after: " + str(categories_after) + "\n\n")

        f.write("Channels before: " + str(channels_before) + "\n")
        f.write("Channels after: " + str(channels_after) + "\n")



def write_business_report(cleaned_orders):

    with open("output/business_report.txt", "a") as f:

        f.write("\n" + "-" * 40 + "\n")
        f.write("Business Report\n")
        f.write("-" * 40 + "\n")

        completed_orders = []

        for order in cleaned_orders:
            if order["status"] == "completed":
                completed_orders.append(order)

        completed_count = len(completed_orders)

        revenue = 0
        for order in completed_orders:
            revenue += order["total_amount"]

        non_revenue = 0
        for order in cleaned_orders:
            if order["status"] in ["pending", "cancelled", "returned"]:
                non_revenue += 1


        f.write(f"Completed orders: {completed_count}\n")
        f.write(f"Non-revenue orders: {non_revenue}\n")
        f.write(f"Completed revenue: {revenue}\n\n")


        sorted_orders = completed_orders[:]

        for i in range(len(sorted_orders)):
            for j in range(i + 1, len(sorted_orders)):
                if sorted_orders[i]["total_amount"] < sorted_orders[j]["total_amount"]:
                    sorted_orders[i], sorted_orders[j] = sorted_orders[j], sorted_orders[i]

        f.write("Top 5 completed orders:\n")

        for order in sorted_orders[:5]:
            f.write(
                f"Order {order['order_id']} | "
                f"{order['customer_name']} | "
                f"{order['total_amount']}\n"
            )


        f.write("\nRecommendation:\n")
        f.write(
            "Use only valid completed orders for revenue. "
            "Exclude invalid and non-completed orders to avoid incorrect reporting.\n"
        )



# MAIN
def main():

    print_raw_summary(orders)

    print("\n" + "-" * 40)

    # PART 2 - Validation
    valid_orders, invalid_orders = separate_orders(orders)

    write_invalid_records(invalid_orders)

    write_validation_report(
        len(orders),
        len(valid_orders),
        len(invalid_orders)
    )

    print("Validation completed")

    print("\n" + "-" * 40)


    # PART 3 - Cleaning
    cleaned_orders = clean_orders(valid_orders)

    print_clean_summary(cleaned_orders)

    print("\n" + "-" * 40)


    # PART 4 - Business Metrics
    print_business_metrics(
        orders,
        valid_orders,
        invalid_orders,
        cleaned_orders
    )

    print("\n" + "-" * 40)


    # PART 5 - Dynamic Reports

    print("Orders by status:")
    print(count_by_status(cleaned_orders))

    print("\nOrders by city:")
    print(count_by_city(cleaned_orders))

    print("\nOrders by category:")
    print(count_by_category(cleaned_orders))

    print("\nOrders by channel:")
    print(count_by_channel(cleaned_orders))

    print("\nCompleted revenue by city:")
    print(completed_revenue_by_city(cleaned_orders))

    print("\nCompleted revenue by category:")
    print(completed_revenue_by_category(cleaned_orders))

    print("\nCompleted revenue by channel:")
    print(completed_revenue_by_channel(cleaned_orders))

    print("\nCompleted revenue by customer:")
    print(completed_revenue_by_customer(cleaned_orders))

    print("\nCustomers with multiple orders:")
    print(customers_with_multiple_orders(cleaned_orders))

    print("\nProducts ordered more than once:")
    print(products_ordered_more_than_once(cleaned_orders))


    print("\n" + "-" * 40)


    # PART 6 - Ranking

    top_completed_orders(cleaned_orders)
    top_customers_by_revenue(cleaned_orders)
    top_products_by_revenue(cleaned_orders)
    top_cities_by_revenue(cleaned_orders)
    categories_sorted_by_revenue(cleaned_orders)
    channels_sorted_by_revenue(cleaned_orders)


    print("\n" + "-" * 40)


    # PART 7 - Data Quality

    data_quality_report(
        orders,
        valid_orders,
        invalid_orders,
        cleaned_orders
    )

    write_invalid_records_file(invalid_orders, orders)

    write_validation_report_file(
       orders,
       valid_orders,
       invalid_orders,
      cleaned_orders
    )

    write_business_report(cleaned_orders)


if __name__ == "__main__":
    main()