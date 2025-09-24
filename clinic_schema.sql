-- =============================================
-- Clinic Booking System - MySQL Database Schema
-- Final Project for Database Design Course
-- =============================================

-- Drop database if exists (optional, for testing)
DROP DATABASE IF EXISTS clinic_booking_system;

-- Create database
CREATE DATABASE clinic_booking_system;

-- Use database
USE clinic_booking_system;

-- =============================================
-- TABLE 1: Clinics
-- One clinic can have many doctors
-- =============================================
CREATE TABLE Clinics (
    clinic_id INT PRIMARY KEY AUTO_INCREMENT,
    clinic_name VARCHAR(100) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABLE 2: Specializations
-- e.g., Cardiology, Pediatrics, Dermatology
-- =============================================
CREATE TABLE Specializations (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT,
    specialization_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- =============================================
-- TABLE 3: Doctors
-- Each doctor belongs to one clinic and one specialization
-- One-to-Many: Clinic → Doctors, Specialization → Doctors
-- =============================================
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    specialization_id INT NOT NULL,
    clinic_id INT NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    years_of_experience TINYINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES Clinics(clinic_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =============================================
-- TABLE 4: Patients
-- =============================================
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABLE 5: Appointments
-- Many-to-Many relationship between Patients and Doctors
-- =============================================
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Composite Unique: One patient can't book same doctor at same time
    UNIQUE KEY unique_appointment (doctor_id, appointment_date, appointment_time),
    
    -- Foreign Keys
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- =============================================
-- TABLE 6: Users (Optional — for login/auth if extended later)
-- =============================================
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Store hashed passwords
    role ENUM('admin', 'doctor', 'patient') DEFAULT 'patient',
    patient_id INT NULL, -- NULL if not a patient
    doctor_id INT NULL,  -- NULL if not a doctor
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Ensure only one of patient_id or doctor_id is set (if applicable)
    CHECK (
        (role = 'patient' AND patient_id IS NOT NULL AND doctor_id IS NULL) OR
        (role = 'doctor' AND doctor_id IS NOT NULL AND patient_id IS NULL) OR
        (role = 'admin' AND patient_id IS NULL AND doctor_id IS NULL)
    ),
    
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- =============================================
-- INSERT SAMPLE DATA (Optional — for testing)
-- =============================================

INSERT INTO Clinics (clinic_name, address, phone, email) VALUES
('City General Clinic', '123 Main St, Cityville', '+1-555-1234', 'citygeneral@example.com'),
('Downtown Medical Center', '456 Oak Ave, Downtown', '+1-555-5678', 'downtownmed@example.com');

INSERT INTO Specializations (specialization_name, description) VALUES
('Cardiology', 'Heart and cardiovascular system specialists'),
('Pediatrics', 'Child healthcare specialists'),
('Dermatology', 'Skin, hair, and nail specialists');

INSERT INTO Doctors (first_name, last_name, email, phone, specialization_id, clinic_id, license_number, years_of_experience) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '+1-555-0001', 1, 1, 'LIC-001', 8),
('Bob', 'Smith', 'bob.smith@example.com', '+1-555-0002', 2, 1, 'LIC-002', 5),
('Carol', 'Davis', 'carol.davis@example.com', '+1-555-0003', 3, 2, 'LIC-003', 10);

INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email, address) VALUES
('John', 'Doe', '1985-06-15', 'Male', '+1-555-1111', 'john.doe@example.com', '789 Pine St, Cityville'),
('Jane', 'Roe', '1990-03-22', 'Female', '+1-555-2222', 'jane.roe@example.com', '321 Elm St, Downtown');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason) VALUES
(1, 1, '2025-09-10', '10:00:00', 'Scheduled', 'Annual heart checkup'),
(2, 2, '2025-09-11', '14:30:00', 'Scheduled', 'Child vaccination follow-up');

-- =============================================
-- END OF SCHEMA
-- =============================================
