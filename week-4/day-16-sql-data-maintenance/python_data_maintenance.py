students = [
    {"student_id": 1, "name": "Rijon", "city": "Vushtrri", "status": "active"},
    {"student_id": 2, "name": "Eljesa", "city": "Prishtina", "status": "active"},
    {"student_id": 3, "name": "Urim", "city": "Mitrovica", "status": "active"}
]


def print_students():
    print("\nCurrent Students:")
    for student in students:
        print(student)


def update_student_city(student_id, new_city):
    for student in students:
        if student["student_id"] == student_id:
            student["city"] = new_city
            print(f"City updated for student {student_id}")
            return
    print("Student not found.")


def update_student_status(student_id, new_status):
    for student in students:
        if student["student_id"] == student_id:
            student["status"] = new_status
            print(f"Status updated for student {student_id}")
            return
    print("Student not found.")


def hard_delete_student(student_id):
    for student in students:
        if student["student_id"] == student_id:
            students.remove(student)
            print(f"Student {student_id} permanently deleted.")
            return
    print("Student not found.")


def soft_delete_student(student_id):
    for student in students:
        if student["student_id"] == student_id:
            student["status"] = "dropped"
            print(f"Student {student_id} marked as dropped.")
            return
    print("Student not found.")


update_student_city(3, "Prishtina")
print_students()

update_student_status(2, "completed")
print_students()

soft_delete_student(1)
print_students()

hard_delete_student(3)
print_students()