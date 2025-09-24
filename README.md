# 🏥 Clinic Booking System — Final Project

> *“Health is not just the absence of disease — it’s timely care, well organized.”*

This is my final project submission for the Database Design course.  
I chose **Question 1: Build a Complete Database Management System**.

## 🗃️ Database Overview

A **relational MySQL database** for a multi-clinic medical booking system.

### Features

✅ **6 Tables**: Clinics, Specializations, Doctors, Patients, Appointments, Users  
✅ **All Constraints**: PK, FK, NOT NULL, UNIQUE, CHECK, ENUM  
✅ **Relationships**:
- One-to-Many: Clinic → Doctors, Specialization → Doctors
- Many-to-Many: Patients ↔ Doctors (via Appointments)
✅ **Sample Data Included**

## 🛠️ How to Use

1. Copy the SQL from `clinic_schema.sql`
2. Run it in **MySQL Workbench**, **phpMyAdmin**, or any MySQL client
3. The script will:
   - Create database `clinic_booking_system`
   - Create all tables with constraints
   - Insert sample data for testing

## 📂 Files

- `clinic_schema.sql` — Complete database schema with sample data

## 🎯 Learning Outcomes

- Designed a real-world relational schema
- Applied 1NF, 2NF, 3NF principles
- Implemented referential integrity with foreign keys
- Used ENUM, CHECK, UNIQUE constraints for data quality

---

> 👨‍💻 Created by Eden Demissie — for the PLP Database Design Final Project.  
> Submitted on: September 2025
