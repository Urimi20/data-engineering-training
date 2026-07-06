from main import students, is_empty, separator


def task_6(data):
    separator("DETYRA 6 - FINAL REPORT")

    if is_empty(data):
        print("No data")
        return

    total = len(data)

    avg_att = sum(s["attendance"] for s in data) / total
    avg_hw = sum(s["homework_score"] for s in data) / total

    by_city = {}
    by_course = {}

    low_att = []
    strong = []
    support = []

    for s in data:
        by_city[s["city"]] = by_city.get(s["city"], 0) + 1
        by_course[s["course"]] = by_course.get(s["course"], 0) + 1

        if s["attendance"] < 70:
            low_att.append(s["name"])

        if s["attendance"] >= 80 and s["homework_score"] >= 80:
            strong.append(s["name"])
        elif s["attendance"] < 60 or s["homework_score"] < 60:
            support.append(s["name"])

    print("Student Report")
    print("-" * 40)

    print(f"Total students: {total}")
    print(f"Average attendance: {round(avg_att, 2)}")
    print(f"Average homework score: {round(avg_hw, 2)}")

    print("\nStudents by city:")
    for city, count in by_city.items():
        print(f"- {city}: {count}")

    print("\nStudents by course:")
    for course, count in by_course.items():
        print(f"- {course}: {count}")

    print("\nStudents with low attendance:")
    for name in low_att:
        print(f"- {name}")

    print("\nStrong students:")
    for name in strong:
        print(f"- {name}")

    print("\nStudents that need support:")
    for name in support:
        print(f"- {name}")


task_6(students)