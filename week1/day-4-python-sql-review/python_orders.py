orders = [
    {
        "order_id": 1,
        "customer": "Arta",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "completed",
        "order_date": "2026-07-01",
    },
    {
        "order_id": 2,
        "customer": "Blend",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 2,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-01",
    },
    {
        "order_id": 3,
        "customer": "Arta",
        "city": "Vushtrri",
        "product": "Keyboard",
        "category": "Accessories",
        "quantity": 1,
        "price": 40,
        "status": "cancelled",
        "order_date": "2026-07-02",
    },
    {
        "order_id": 4,
        "customer": "Dren",
        "city": "Mitrovica",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 1,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-02",
    },
    {
        "order_id": 5,
        "customer": "Elira",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 1,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-03",
    },
    {
        "order_id": 6,
        "customer": "Dren",
        "city": "Mitrovica",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "pending",
        "order_date": "2026-07-03",
    },
    {
        "order_id": 7,
        "customer": "Nora",
        "city": "Vushtrri",
        "product": "Headphones",
        "category": "Accessories",
        "quantity": 1,
        "price": 50,
        "status": "completed",
        "order_date": "2026-07-04",
    },
    {
        "order_id": 8,
        "customer": "Leart",
        "city": "Peja",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 2,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-04",
    },
    {
        "order_id": 9,
        "customer": "Faton",
        "city": "Prizren",
        "product": "Desk Chair",
        "category": "Office",
        "quantity": 1,
        "price": 120,
        "status": "completed",
        "order_date": "2026-07-05",
    },
    {
        "order_id": 10,
        "customer": "Gresa",
        "city": "Prishtina",
        "product": "USB Cable",
        "category": "Accessories",
        "quantity": 3,
        "price": 8,
        "status": "completed",
        "order_date": "2026-07-05",
    },
    {
        "order_id": 11,
        "customer": "Rina",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 650,
        "status": "cancelled",
        "order_date": "2026-07-06",
    },
    {
        "order_id": 12,
        "customer": "Arben",
        "city": "Ferizaj",
        "product": "Desk",
        "category": "Office",
        "quantity": 1,
        "price": 220,
        "status": "pending",
        "order_date": "2026-07-06",
    },
    {
    "order_id": 13,
    "customer": "Besa",
    "city": "Vushtrri",
    "product": "Tablet",
    "category": "Electronics",
    "quantity": 1,
    "price": 300,
    "status": "completed",
    "order_date": "2026-07-07"
},

{
    "order_id": 14,
    "customer": "Valon",
    "city": "Prishtina",
    "product": "Keyboard",
    "category": "Accessories",
    "quantity": 2,
    "price": 45,
    "status": "pending",
    "order_date": "2026-07-07"
}
]

# Task P1 - Print basic data

def basic_data(orders):
    print(f"total orders: {len(orders)}")
    print("-----------------------")
    print("Costumer names:")
    for order in orders :
        print(order["customer"])
    print("-----------------------")
    print("Order details: ")
    for order in orders:
        print(f"{order["customer"]} ordered {order["product"]} from {order["city"]} and the status is {order["status"]} ")


# Task P2 - Filter records

def filter_orders(orders):
    print("completed orders:")
    for order in orders:
      
        if order["status"] == "completed":
            print(f"{order["customer"]} - {order["product"]}")
    
    print("-----------------------")

    print("Pending orders:")
    for order in orders:
      
        if order["status"] == "pending":
            print(f"{order["customer"]} - {order["product"]}")
    print("-----------------------")

    print("cancelled orders:")
    for order in orders:
      
        if order["status"] == "cancelled":
            print(f"{order["customer"]} - {order["product"]}")

    print("-----------------------")

    print("grater than 100 orders:")
    for order in orders:
      
        if order["price"] > 100:
            print(f"{order["customer"]} - {order["product"]}")

    print("-----------------------")

    print("category is Accessories orders:")
    for order in orders:
      
        if order["category"] == "Accessories":
            print(f"{order["customer"]} - {order["product"]}")

# Task P3 - Calculated values

def calculated_values(orders):
    print("completed orders:")
    for order in orders:
        total = order["quantity"] * order["price"]
        print(f"{order['customer']} - {order['product']} - {order['quantity']} x {order['price']} = {total}")


# Task P4 - Sorting and top records
def process_orders_task(orders):

    def get_price(order):
        return order.get("price", 0)

    def get_total_amount(order):
        return order.get("price", 0) * order.get("quantity", 0)

    sorted_by_price = sorted(orders, key=get_price, reverse=True)

    print("\nSorted by price (high to low):")
    for o in sorted_by_price:
        print(f"{o['customer']} - {o['product']} - {o['price']}")

    sorted_by_total = sorted(orders, key=get_total_amount, reverse=True)

    print("\nTop 3 orders by total amount:")
    for o in sorted_by_total[:3]:
        total = get_total_amount(o)
        print(f"{o['customer']} - {o['product']} - {total}")

# Task P5 - Simple summary without GROUP BY

def summary(orders):
    status_count = {"completed": 0, "pending": 0, "cancelled": 0}
    revenue = 0
    customer_count = {}

    for order in orders:
        status_count[order["status"]] += 1

        if order["status"] == "completed":
            revenue += order["price"] * order["quantity"]

        name = order["customer"]
        if name in customer_count:
            customer_count[name] += 1
        else:
            customer_count[name] = 1

    print("\nStatus counts:")

    for k, v in status_count.items():
        print(f"{k}: {v}")

    print("\nCompleted revenue:", revenue)

    print("\nCustomers with more than one order:")
    for name, count in customer_count.items():
        if count > 1:
            print(name)

basic_data(orders)
print("===============")
filter_orders(orders)
print("===============")
calculated_values(orders)
print("===============")
process_orders_task(orders)
print("===============")
summary(orders)
print("===============")


# PART 4 

def find_most_expensive_order(orders):

    most_expensive = orders[0]

    for order in orders:
        if order["price"] > most_expensive["price"]:
            most_expensive = order

    print("Most expensive single order:")
    print(
        f"{most_expensive['customer']} - "
        f"{most_expensive['product']} - "
        f"{most_expensive['price']}"
    )

def find_highest_total_order(orders):

    highest_order = orders[0]
    highest_total = orders[0]["quantity"] * orders[0]["price"]

    for order in orders:
        total_amount = order["quantity"] * order["price"]

        if total_amount > highest_total:
            highest_total = total_amount
            highest_order = order

    print("\nHighest total amount order:")
    print(
        f"{highest_order['customer']} - "
        f"{highest_order['product']} - "
        f"{highest_total}"
    )


def find_invalid_revenue_orders(orders):

    print("\nOrders not counted as revenue:")

    for order in orders:

        if order["status"] == "pending" or order["status"] == "cancelled":

            print(
                f"{order['customer']} - "
                f"{order['product']} - "
                f"{order['status']}"
            )


def calculate_completed_revenue(orders):

    revenue = 0

    for order in orders:

        if order["status"] == "completed":

            total_amount = order["quantity"] * order["price"]

            revenue += total_amount

    print("\nCompleted revenue:", revenue)


find_most_expensive_order(orders)
print("===============")
find_highest_total_order(orders)
print("===============")
find_invalid_revenue_orders(orders)
print("===============")
calculate_completed_revenue(orders)



# BONUS

def count_by_city(orders):

    city_count = {}

    for order in orders:
        city = order["city"]

        if city in city_count:
            city_count[city] += 1
        else:
            city_count[city] = 1

    print("Orders by city:")

    for city, count in city_count.items():
        print(city, ":", count)


def count_by_category(orders):

    category_count = {}

    for order in orders:
        category = order["category"]

        if category in category_count:
            category_count[category] += 1
        else:
            category_count[category] = 1

    print("Orders by category:")

    for category, count in category_count.items():
        print(category, ":", count)


count_by_category(orders)
count_by_city(orders)
