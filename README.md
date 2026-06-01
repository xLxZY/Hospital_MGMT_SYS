# Hospital Database Management System

A relational database project built using MySQL to simulate a hospital management system. The database manages patients, doctors, departments, appointments, prescriptions, medical records, billing, staff, nurses, and medications while maintaining data integrity through primary keys, foreign keys, constraints, and relationships.

## Features

* Manage hospital departments
* Store doctor and nurse information
* Track patient records
* Schedule appointments
* Manage prescriptions and medications
* Generate billing information
* Maintain medical history records
* Support hospital staff management
* Enforce relational integrity using foreign keys

## Database Design

The database contains the following tables:

| Table                   | Description                      |
| ----------------------- | -------------------------------- |
| Department              | Hospital departments             |
| Doctor                  | Doctors and specialties          |
| Nurse                   | Nursing staff                    |
| Staff                   | Administrative and support staff |
| Room                    | Patient rooms                    |
| Patient                 | Patient information              |
| Appointment             | Patient appointments             |
| Medical_Record          | Medical history and diagnosis    |
| Medication              | Medication inventory             |
| Prescription            | Doctor prescriptions             |
| Prescription_Medication | Junction table for prescriptions |
| Bills                   | Patient billing records          |

## Technologies Used

* MySQL
* SQL
* Relational Database Design
* Data Modeling

## Database Relationships

### One-to-Many Relationships

* Department → Doctors
* Department → Nurses
* Department → Staff
* Doctor → Patients
* Doctor → Appointments
* Patient → Appointments
* Patient → Bills
* Patient → Medical Records

### Many-to-Many Relationships

* Prescriptions ↔ Medications

  * Implemented through `prescription_medication`

## Constraints Implemented

* Primary Keys
* Foreign Keys
* UNIQUE Constraints
* CHECK Constraints
* NOT NULL Constraints

Examples:

```sql
CHECK(age > 0)
CHECK(stock >= 0)
CHECK(salary >= 0)
UNIQUE(phonenumber)
```

## Sample Operations

### Insert Data

```sql
INSERT INTO patient
(name, age, address, phonenumber)
VALUES
('Ali Ahmed',20,'Alex','01110001');
```

### Update Data

```sql
UPDATE room
SET status='maintenance'
WHERE room_id=102;
```

### Delete Data

```sql
DELETE FROM prescription
WHERE prescription_id=2;
```

### Query Example

```sql
SELECT p.name AS patient_name,
       d.name AS doctor_name
FROM appointment a
JOIN patient p
ON a.patient_id = p.patient_id
JOIN doctor d
ON a.doctor_id = d.doctor_id;
```

## Learning Outcomes

Through this project I practiced:

* Database normalization
* Relational database design
* Creating and managing SQL tables
* Using joins and aggregate functions
* Implementing constraints
* Managing one-to-many and many-to-many relationships
* Writing complex SQL queries
* Data manipulation using INSERT, UPDATE, and DELETE statements
