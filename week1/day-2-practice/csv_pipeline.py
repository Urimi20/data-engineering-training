import csv

FILE_PATH = "data/students_raw.csv"


def read_csv_file():

    with open(FILE_PATH, mode="r", encoding="utf-8") as file:

        reader = csv.DictReader(file)

        students = []

        for row in reader:

            clean_row = {}

            for key, value in row.items():
                clean_row[key.strip()] = value.strip()

            students.append(clean_row)

    return students


def inspect_records(students):

    print("CSV Inspection")

    print("Total raw records:", len(students))

    print("\nColumns:")

    for column in students[0]:
        print(column, end=", ")

    print("\n\nFirst 3 records:")

    for student in students[:3]:

        print(
            student["student_id"],
            "-",
            student["name"],
            "-",
            student["city"],
            "-",
            student["course"],
        )


students = read_csv_file()

inspect_records(students)

print("---------------------------")


# TASK 3 


def find_data_quality_issues(students):

    missing = []
    invalid = []
    inconsistent = []

    for student in students:

        # Missing values

        if student["attendance"] == "":
            missing.append(f"student_id={student['student_id']}, column=attendance")

        if student["homework_score"] == "":
            missing.append(f"student_id={student['student_id']}, column=homework_score")

        if student["city"] == "":
            missing.append(f"student_id={student['student_id']}, column=city")

        if student["age"] == "":
            missing.append(f"student_id={student['student_id']}, column=age")

        if student["registered_date"] == "":
            missing.append(
                f"student_id={student['student_id']}, column=registered_date"
            )

        if student["course"] == "":
            missing.append(f"student_id={student['student_id']}, column=course")

        # Invalid numeric values

        if student["attendance"] != "" and not student["attendance"].isdigit():

            invalid.append(
                f"student_id={student['student_id']}, column=attendance, value={student['attendance']}"
            )

        # Inconsistent text

        if student["city"] == "VUSHTRRI" or student["city"] == "prishtina":

            inconsistent.append(
                f"student_id={student['student_id']}, column=city, value={student['city']}"
            )

        if student["course"] == "Data engineering":

            inconsistent.append(
                f"student_id={student['student_id']}, column=course, value={student['course']}"
            )

    return missing, invalid, inconsistent


missing, invalid, inconsistent = find_data_quality_issues(students)


total_issues = len(missing) + len(invalid) + len(inconsistent)


print("\nData Quality Report")

print("Total issues found:", total_issues)


print("\nMissing values:")

for x in missing:
    print(x)


print("\nInvalid numeric values:")

for x in invalid:
    print(x)


print("\nInconsistent text values:")

for x in inconsistent:
    print(x)


print("--------------------------------")


# TASK 4 


def clean_student_record(student):

    clean = {}

   
    clean["student_id"] = int(student["student_id"])

   
    clean["name"] = student["name"]

    city = student["city"]

    if city == "":
        city = "Unknown"

    elif city == "VUSHTRRI":
        city = "Vushtrri"

    elif city == "prishtina":
        city = "Prishtina"

    clean["city"] = city

    course = student["course"]

    if course == "":
        course = "Not Assigned"

    elif course == "Data engineering":
        course = "Data Engineering"

    clean["course"] = course


    if student["age"] == "":
        age = 0

    else:
        age = int(student["age"])

    clean["age"] = age



    if student["attendance"] == "" or not student["attendance"].isdigit():

        attendance = 0

    else:

        attendance = int(student["attendance"])

    clean["attendance"] = attendance


    if student["homework_score"] == "" or not student["homework_score"].isdigit():

        homework_score = 0

    else:

        homework_score = int(student["homework_score"])

    clean["homework_score"] = homework_score


    if student["registered_date"] == "":

        registered_date = "Unknown Date"

    else:

        registered_date = student["registered_date"]

    clean["registered_date"] = registered_date



    total_score = attendance + homework_score

    clean["total_score"] = total_score


    if attendance >= 80 and homework_score >= 80:

        performance_status = "Strong"

    elif attendance >= 60 and homework_score >= 60:

        performance_status = "Average"

    else:

        performance_status = "Needs Support"

    clean["performance_status"] = performance_status


    if attendance < 60 or homework_score < 60:

        risk_flag = "At Risk"

    else:

        risk_flag = "OK"

    clean["risk_flag"] = risk_flag

    return clean


def clean_all_records(students):

    cleaned_students = []

    for student in students:

        cleaned_student = clean_student_record(student)

        cleaned_students.append(cleaned_student)

    return cleaned_students



cleaned_students = clean_all_records(students)


print("--------------------------------")

print("Cleaning completed successfully!")

print("Total cleaned records:", len(cleaned_students))

print("--------------------------------")


# TASK 5


print("\nPerformance Status")


for student in cleaned_students:

    print(
        f"{student['name']}: "
        f"{student['performance_status']} - "
        f"{student['risk_flag']}"
    )


print("--------------------------------")


# TASK 6 


OUTPUT_FILE = "output/students_clean.csv"


def save_clean_csv(students):

    with open(OUTPUT_FILE, mode="w", encoding="utf-8", newline="") as file:

        fieldnames = [
            "student_id",
            "name",
            "city",
            "course",
            "age",
            "attendance",
            "homework_score",
            "registered_date",
            "total_score",
            "performance_status",
            "risk_flag",
        ]

        writer = csv.DictWriter(file, fieldnames=fieldnames)

        writer.writeheader()

        writer.writerows(students)


save_clean_csv(cleaned_students)


print("Clean CSV created successfully!")
print("Data quality report created successfully!")


print("--------------------------")

# TASK 8


def count_by_field(students, field):

    result = {}

    for student in students:

        value = student[field]

        if value in result:
            result[value] += 1

        else:
            result[value] = 1

    return result


def calculate_average(students, field):

    total = 0

    for student in students:

        total += student[field]

    return total / len(students)


def get_students_by_status(students, field, value):

    result = []

    for student in students:

        if student[field] == value:

            result.append(student["name"])

    return result


def get_top_students(students, limit=3):

    sorted_students = sorted(students, key=lambda x: x["total_score"], reverse=True)

    return sorted_students[:limit]


def save_text_report(filename, text):

    with open(filename, mode="w", encoding="utf-8") as file:

        file.write(text)


# TASK 7 


print("--------------------------------------")


def generate_summary_report(raw_students, cleaned_students):

    report = ""

    total_raw_records = len(raw_students)

    total_cleaned_records = len(cleaned_students)

    total_issues = len(missing) + len(invalid) + len(inconsistent)

    avg_attendance = calculate_average(cleaned_students, "attendance")

    avg_homework = calculate_average(cleaned_students, "homework_score")

    report += "Final Student Data Report\n"

    report += f"Total raw records: {total_raw_records}\n"

    report += f"Total cleaned records: {total_cleaned_records}\n"

    report += f"Total data quality issues found: {total_issues}\n"

    report += f"Average attendance: {avg_attendance:.2f}\n"

    report += f"Average homework score: {avg_homework:.2f}\n\n"

    

    report += "Students by city:\n"

    cities = count_by_field(cleaned_students, "city")

    for city, count in cities.items():

        report += f"{city}: {count}\n"


    report += "\nStudents by course:\n"

    courses = count_by_field(cleaned_students, "course")

    for course, count in courses.items():

        report += f"{course}: {count}\n"


    report += "\nStrong students:\n"

    strong = get_students_by_status(cleaned_students, "performance_status", "Strong")

    for student in strong:

        report += f"{student}\n"


    report += "\nStudents that need support:\n"

    support = get_students_by_status(
        cleaned_students, "performance_status", "Needs Support"
    )

    for student in support:

        report += f"{student}\n"

    report += "\nAt Risk students:\n"

    risk = get_students_by_status(cleaned_students, "risk_flag", "At Risk")

    for student in risk:

        report += f"{student}\n"

    report += "\nTop 3 students by total score:\n"

    top_students = get_top_students(cleaned_students)

    for student in top_students:

        report += f"{student['name']}: " f"{student['total_score']}\n"

    return report



final_report = generate_summary_report(students, cleaned_students)

print("\n")
print(final_report)


save_text_report("output/summary_report.txt", final_report)


print("Summary report created successfully!")
