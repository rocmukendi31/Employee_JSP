-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS jsp_crud_db;
USE jsp_crud_db;

-- Create employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Create patients table
CREATE TABLE IF NOT EXISTS patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    disease VARCHAR(100),
    treatment_status VARCHAR(50)
);

-- Insert sample data for employees (optional)
INSERT INTO employees (employee_name, department, salary) VALUES
('John Doe', 'Engineering', 75000.00),
('Jane Smith', 'Marketing', 65000.00),
('Bob Johnson', 'Sales', 60000.00);

-- Insert sample data for patients (optional)
INSERT INTO patients (patient_name, age, disease, treatment_status) VALUES
('Alice Williams', 45, 'Diabetes', 'Under Treatment'),
('Charlie Brown', 32, 'Hypertension', 'Under Treatment'),
('Diana Prince', 28, 'Asthma', 'Recovered');