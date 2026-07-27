# Maintenance Notes

## Purpose

This practice focuses on maintaining existing database records safely. In real-world systems, data is constantly updated, corrected, reviewed, and reported. Database maintenance helps ensure that information remains accurate while preserving historical records.

---

## Safe Update Workflow

For every update, I followed the same professional workflow:

1. Run a `SELECT` query to verify the current data.
2. Use `UPDATE` with a `WHERE` clause.
3. Run another `SELECT` query to confirm the change.

Using `WHERE` is essential because it prevents accidental updates to every row in the table.

---

## Delete Notes

I tested both safe and unsafe delete operations.

- Safe deletes were performed only on temporary records that were not connected to other tables.
- Attempts to delete students or assignments with related records were blocked by foreign key constraints.

This demonstrates how foreign keys protect important historical data.

---

## Hard Delete vs Soft Delete

**Hard Delete**
- Permanently removes a record from the database.
- Historical information is lost.
- Can cause foreign key errors if related records exist.

**Soft Delete**
- Keeps the record in the database.
- Changes the status (for example, `active` → `dropped`).
- Preserves historical information for future reports.
- Commonly used in real business applications.

---

## NULL Handling

Some submission feedback and attendance notes were intentionally left as `NULL`.

I used:

- `IS NULL` to find missing values.
- `IS NOT NULL` to find existing values.
- `COALESCE()` to replace NULL values with user-friendly text such as **"No feedback yet"** or **"No notes"**.

---

## CASE WHEN Logic

I used `CASE WHEN` to create business-friendly categories.

### Performance
- 90+ → Excellent
- 75–89 → Good
- 60–74 → Needs Improvement
- Below 60 → At Risk

### Attendance
- Present → Attended
- Late → Late Arrival
- Absent → Absent

### Enrollment
- Active → Low Risk
- Completed → Graduated
- Dropped → High Risk

These categories make reports easier to understand.

---

## LEFT JOIN Notes

`LEFT JOIN` was used to identify missing information.

Examples:
- Students without submissions.
- Students without attendance.
- Students without feedback.

Unlike `INNER JOIN`, `LEFT JOIN` keeps all records from the left table and shows `NULL` when no matching record exists.

---

## Key Lessons Learned

- Always verify data before updating it.
- Never use `UPDATE` without a `WHERE` clause.
- Avoid deleting historical data whenever possible.
- Use soft delete to preserve important records.
- Handle missing values correctly with `IS NULL` and `COALESCE()`.
- Use `CASE WHEN` to create meaningful business reports.
- Use `LEFT JOIN` to identify missing data.
- Foreign keys help maintain database integrity and prevent accidental data loss.