-- Hospital database ---

CREATE DATABASE hospital_DB;
USE hospital_DB;

-- tables ---=

CREATE TABLE department (
department_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
location VARCHAR(100),
PRIMARY KEY (department_id)
);

CREATE TABLE doctor (
doctor_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(250) NOT NULL,
age INT CHECK (age > 0),
phonenumber VARCHAR(15) UNIQUE,
salary DECIMAL(10,2),
shift VARCHAR(25),
specialty VARCHAR(100),
department_id INT NOT NULL,
PRIMARY KEY (doctor_id),
FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE room (
room_id INT NOT NULL AUTO_INCREMENT,
type VARCHAR(100),
status VARCHAR(50),
capacity INT CHECK (capacity > 0),
PRIMARY KEY (room_id)
);

CREATE TABLE patient (
patient_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
age INT CHECK (age > 0),
address VARCHAR(100),
phonenumber VARCHAR(15) UNIQUE,
birthday DATE,
room_id INT NOT NULL,
doctor_id INT NOT NULL,
PRIMARY KEY (patient_id),
FOREIGN KEY (room_id) REFERENCES room(room_id),
FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE staff (
employee_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100),
age INT CHECK (age > 0),
phonenumber VARCHAR(15) UNIQUE,
role VARCHAR(50),
salary DECIMAL(10,2),
department_id INT,
PRIMARY KEY (employee_id),
FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE nurse (
nurse_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
age INT CHECK (age > 0),
address VARCHAR(100),
phonenumber VARCHAR(15) UNIQUE,
salary DECIMAL(10,2),
shift VARCHAR(20),
department_id INT,
PRIMARY KEY (nurse_id),
FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE appointment (
appointment_id INT NOT NULL AUTO_INCREMENT,
date DATE NOT NULL,
status VARCHAR(50),
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
PRIMARY KEY (appointment_id),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE bills (
bill_id INT NOT NULL AUTO_INCREMENT,
date DATE,
amount DECIMAL(10,2),
payment_method VARCHAR(20),
patient_id INT NOT NULL,
PRIMARY KEY (bill_id),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE medication (
medication_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
stock INT,
exp_date DATE,
price DECIMAL(10,2),
type VARCHAR(100),
PRIMARY KEY (medication_id)
);

CREATE TABLE medical_record (
record_id INT NOT NULL AUTO_INCREMENT,
date DATE,
treatment VARCHAR(200),
diagnosis VARCHAR(200),
notes VARCHAR(200),
patient_id INT NOT NULL ,
PRIMARY KEY (record_id),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE prescription (
prescription_id INT NOT NULL AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
PRIMARY KEY (prescription_id),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE prescription_medication (
prescription_id INT NOT NULL,
medication_id INT NOT NULL,
dose VARCHAR(50),
duration VARCHAR(50),
notes VARCHAR(200),
PRIMARY KEY (prescription_id, medication_id),
FOREIGN KEY (prescription_id) REFERENCES prescription(prescription_id),
FOREIGN KEY (medication_id) REFERENCES medication(medication_id)
);

-- constrains ----
ALTER TABLE medication
ADD CONSTRAINT check_stock CHECK (stock >= 0);

ALTER TABLE staff
ADD CONSTRAINT check_salary CHECK (salary >= 0);

-- entering data ----\

INSERT INTO department (department_id, name, location)
VALUES
(1, 'Cardiology', 'Building A'),
(2, 'Neurology', 'Building B'),
(3, 'Orthopedics', 'Building C'),
(4, 'Pediatrics', 'Building D');

INSERT INTO room (room_id, type, status, capacity)
VALUES
(101, 'ICU', 'occupied', 1),
(102, 'General', 'available', 3),
(103, 'General', 'available', 2),
(104, 'ICU', 'occupied', 1);

INSERT INTO doctor (doctor_id, name, age, phonenumber, salary, shift, specialty, department_id)
VALUES
(1, 'Dr. Karim', 22, '01100001', 90000, 'morning', 'Cardiologist', 1),
(2, 'Dr. Fahd', 23, '01500001', 85000, 'evening', 'Neurologist', 2),
(3, 'Dr. Nour', 20, '01000001', 80000, 'morning', 'Orthopedist', 3),
(4, 'Dr. Peter', 30, '01200001', 87000, 'evening', 'Pediatrician', 4);

INSERT INTO patient (patient_id, name, age, address, phonenumber, birthday, room_id, doctor_id)
VALUES
(1, 'Ali ahhmed', 20, 'Alex', '01110001', '2005-03-02', 101, 1),
(2, 'Sara', 30, 'Nasr City', '01110002', '1995-06-10', 102, 2),
(3, 'Wael Sief', 40, 'Giza', '01110003', '1985-07-15', 103, 3),
(4, 'Roaa Loay', 28, 'Cairo', '01110004', '1997-11-05', 104, 4),
(5, 'Patient 5', 20, 'Alex', '01110005', '2005-03-02', 102, 1),
(6, 'Patient 6', 20, 'Sinai', '01110006', '2004-03-02', 103, 1);

INSERT INTO staff (employee_id, name, age, phonenumber, role, salary, department_id)
VALUES
(1, 'Ahmed Gamal', 45, '01221111111', 'Administrator', 70000.00, 1),
(2, 'Mona Adel', 30, '01222222222', 'Janitor', 35000.00, 3),
(3, 'Adel ahmed', 24, '0124567222', 'Janitor', 35000.00, 2),
(4, 'Hassan Sayed', 50, '01223333333', 'Security Guard', 40000.00, 4);

INSERT INTO nurse (nurse_id, name, age, address, phonenumber, salary, shift, department_id)
VALUES
(1, 'Layla ehab', 28, 'Maadi, Cairo', '01001111111', 55000.00, 'morning', 1),
(2, 'Omar Tarek', 35, 'Heliopolis, Cairo', '01002222222', 60000.00, 'evening', 2),
(3, 'Jana', 24, 'Alexandria', '01003433333', 52000.00, 'night', 4),
(4, 'NOurhan', 26, 'Alexandria', '01003423333', 55000.00, 'night', 3);

INSERT INTO appointment (appointment_id, date, status, patient_id, doctor_id)
VALUES
(1, '2025-03-10', 'Completed', 1, 1),
(2, '2025-03-12', 'Scheduled', 2, 2),
(3, '2025-03-15', 'Cancelled', 3, 3),
(4, '2025-03-17', 'Scheduled', 4, 4),
(5, '2025-03-18', 'Scheduled', 6, 1);

INSERT INTO medication (medication_id, name, stock, exp_date, price, type)
VALUES
(1, 'Aspirin', 200, '2026-12-31', 5.00, 'Painkiller'),
(2, 'Antibiotic', 150, '2025-05-20', 120.50, 'Antibiotic'),
(3, 'Paracetamol', 300, '2027-08-15', 40.00, 'Painkiller'),
(4, 'Ibuprofen', 250, '2026-11-30', 60.50, 'Anti-inflammatory');

INSERT INTO medical_record (record_id, date, treatment, diagnosis, notes, patient_id)
VALUES
(1, '2025-01-13', 'Angioplasty and stent placement.', 'Coronary Artery Disease', 'Patient stable after procedure. Requires follow-up.', 1),
(2, '2025-01-16', 'Physical therapy, pain medication.', 'Herniated Disc ', 'Patient is responding well to physical therapy.', 2),
(3, '2025-02-02', 'Non-surgical management, RICE protocol.', 'Ankle Sprain ', 'Strict rest for 1 week. Review in 10 days.', 3),
(4, '2025-02-06', 'Fever reduction, fluid intake increase.', 'Viral Gastroenteritis', 'Symptoms resolving. Discharge expected tomorrow.', 4);

INSERT INTO prescription (prescription_id, patient_id, doctor_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

INSERT INTO prescription_medication (prescription_id, medication_id, dose, duration, notes)
VALUES
(1, 1, '100mg', '5 days', 'No smoking'),
(2, 2, '250mg', '7 days', 'Take with water'),
(3, 3, '500mg', '3 days', 'After meals'),
(4, 4, '200mg', '4 days', 'With food');

INSERT INTO bills (bill_id, date, amount, payment_method, patient_id)
VALUES
(1, '2025-01-12', 150.00, 'Cash', 1),
(2, '2025-01-15', 300.00, 'Card', 2),
(3, '2025-02-01', 200.00, 'Cash', 3),
(4, '2025-02-05', 450.00, 'Card', 4);

-- updating exmaple ---
UPDATE room
SET status = 'maintenance'
WHERE room_id = 102;

UPDATE bills
SET amount = 1705.00
WHERE bill_id = 1;

UPDATE patient
SET phonenumber = '0121110100'
WHERE patient_id = 1;

-- delete example --
DELETE FROM prescription_medication
WHERE prescription_id = 2;

DELETE FROM prescription
WHERE prescription_id = 2;

DELETE FROM prescription_medication
WHERE prescription_id = 1 AND medication_id = 1;

-- modify table ----
ALTER TABLE patient
ADD email VARCHAR(100);

ALTER TABLE medication
ADD provider VARCHAR(100);

-- queries -----
SELECT P.name, P.age, R.type, R.status
FROM patient P
JOIN room R ON P.room_id = R.room_id;

SELECT p.name AS patient_name, d.name AS doctor_name
FROM appointment AS a
JOIN patient AS p ON a.patient_id = p.patient_id
JOIN doctor AS d ON a.doctor_id = d.doctor_id;

SELECT * FROM bills
WHERE amount > 200;

SELECT name, role, salary
FROM staff
WHERE salary >= 40000.00
ORDER BY salary DESC;

SELECT room_id, COUNT(*) AS totalpatients
FROM patient
GROUP BY room_id;

SELECT DISTINCT specialty
FROM doctor;

SELECT type AS medication_type, SUM(stock) AS total_stock, COUNT(*) AS medication_count
FROM medication
GROUP BY type;

SELECT * FROM patient
LIMIT 5;

SELECT d.name AS doctor_name, COUNT(*) AS total_appointments
FROM appointment a
JOIN doctor d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id;


SELECT p.name AS patient_name,
COUNT(pr.prescription_id) AS prescription_count
FROM prescription pr
JOIN patient p ON pr.patient_id = p.patient_id
GROUP BY p.patient_id
HAVING COUNT(pr.prescription_id) > 0;

-- removing a column --
ALTER TABLE patient
DROP COLUMN email;

