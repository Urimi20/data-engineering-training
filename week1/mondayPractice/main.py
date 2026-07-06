students = [
    {"student_id": 1, "name": "Arta", "city": "Vushtrri", "course": "Python", "age": 17, "attendance": 90, "homework_score": 85},
    {"student_id": 2, "name": "Blend", "city": "Prishtina", "course": "React", "age": 18, "attendance": 60, "homework_score": 70},
    {"student_id": 3, "name": "Dion", "city": "Vushtrri", "course": "Python", "age": 16, "attendance": 75, "homework_score": 95},
    {"student_id": 4, "name": "Elira", "city": "Mitrovica", "course": "React", "age": 17, "attendance": 80, "homework_score": 60},
    {"student_id": 5, "name": "Faton", "city": "Vushtrri", "course": "Data Engineering", "age": 19, "attendance": 100, "homework_score": 90},
    {"student_id": 6, "name": "Gresa", "city": "Prishtina", "course": "Python", "age": 18, "attendance": 55, "homework_score": 88},
]


def is_empty(data):
    return len(data) == 0


def separator(title):
    print("\n" + "-" * 50)
    print(title)
    print("-" * 50)


def task_1(data):
    separator("DETYRA 1")

    print("Total Students:", len(data))

    print("\nStudent names:")
    for s in data:
        print(s["name"])

    print("\nStudent details:")
    for s in data:
        print(f'{s["name"]} is from {s["city"]} and is learning {s["course"]}')


def task_2(data):
    separator("DETYRA 2")

    vushtrri = []
    low_attendance = []
    high_hw = []

    for s in data:
        if s["city"] == "Vushtrri":
            vushtrri.append(s["name"])

        if s["attendance"] < 70:
            low_attendance.append(s["name"])

        if s["homework_score"] > 85:
            high_hw.append(s["name"])

    print("Students from Vushtrri:")
    print(vushtrri)

    print("Students with low attendance:")
    print(low_attendance)

    print("Students with homework score above 85:")
    print(high_hw)


def task_3(data):
    separator("DETYRA 3")

    avg_att = sum(s["attendance"] for s in data) / len(data)
    avg_hw = sum(s["homework_score"] for s in data) / len(data)

    print("Average attendance:", round(avg_att, 2))
    print("Average homework score:", round(avg_hw, 2))

    cities = {}
    courses = {}

    for s in data:
        cities[s["city"]] = cities.get(s["city"], 0) + 1
        courses[s["course"]] = courses.get(s["course"], 0) + 1

    print("Students by city:")
    print(cities)

    print("Students by course:")
    print(courses)


def task_4(data):
    separator("DETYRA 4")

    for s in data:
        if s["attendance"] >= 80 and s["homework_score"] >= 80:
            status = "Strong"
        elif s["attendance"] >= 60 and s["homework_score"] >= 60:
            status = "Average"
        else:
            status = "Needs Support"

        print(f'{s["name"]}: {status}')


def task_5(data):
    separator("DETYRA 5")

    report = []

    for s in data:
        if s["attendance"] >= 80 and s["homework_score"] >= 80:
            status = "Strong"
        elif s["attendance"] >= 60 and s["homework_score"] >= 60:
            status = "Average"
        else:
            status = "Needs Support"

        report.append({
            "student_id": s["student_id"],
            "name": s["name"],
            "course": s["course"],
            "performance_status": status
        })

    for r in report:
        print(f'{r["student_id"]} - {r["name"]} - {r["course"]} - {r["performance_status"]}')


def add_student(data, student):
    data.append(student)


def sort_by_homework(data):
    return sorted(data, key=lambda x: x["homework_score"], reverse=True)


def top_3_students(data):
    return sorted(data, key=lambda x: x["attendance"] + x["homework_score"], reverse=True)[:3]


task_1(students)
task_2(students)
task_3(students)
task_4(students)
task_5(students)

separator("BONUS")

add_student(students, {
    "student_id": 7,
    "name": "Nora",
    "city": "Prishtina",
    "course": "Python",
    "age": 18,
    "attendance": 88,
    "homework_score": 92,
})

print("\nSorted by homework:")
for s in sort_by_homework(students):
    print(s["name"], s["homework_score"])

print("\nTop 3 students:")
for s in top_3_students(students):
    print(s["name"], s["attendance"] + s["homework_score"])