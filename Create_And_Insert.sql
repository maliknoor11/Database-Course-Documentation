CREATE DATABASE CompanyDB4;
GO
USE CompanyDB4;
GO

-- =============================================
-- TASK 1: CREATE TABLES (DDL)
-- =============================================

-- 1. Create Department Table
CREATE TABLE Department (
    DNum INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL,
    SSN VARCHAR(9),
    HiringDate DATE
);

-- 2. Create Location Table
CREATE TABLE Location (
    Location VARCHAR(50),
    DNum INT,
    PRIMARY KEY (Location, DNum),
    FOREIGN KEY (DNum) REFERENCES Department(DNum)
);

-- 3. Create Employee Table
CREATE TABLE Employee (
    SSN VARCHAR(9) PRIMARY KEY,
    FName VARCHAR(30) NOT NULL,
    LName VARCHAR(30) NOT NULL,
    Gender CHAR(1),
    Birthday DATE,
    Supervisor VARCHAR(9),
    DNum INT,
    FOREIGN KEY (DNum) REFERENCES Department(DNum),
    FOREIGN KEY (Supervisor) REFERENCES Employee(SSN)
);

-- 4. Add Foreign Key for Manager in Department
ALTER TABLE Department
ADD FOREIGN KEY (SSN) REFERENCES Employee(SSN);

-- 5. Create Project Table
CREATE TABLE Project (
    PNum INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    City VARCHAR(50),
    DNum INT,
    FOREIGN KEY (DNum) REFERENCES Department(DNum)
);

-- 6. Create Work Table
CREATE TABLE Work (
    SSN VARCHAR(9),
    PNum INT,
    WorkingHours INT,
    PRIMARY KEY (SSN, PNum),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN),
    FOREIGN KEY (PNum) REFERENCES Project(PNum)
);

-- 7. Create Dependent Table
CREATE TABLE Dependent (
    SSN VARCHAR(9),
    DName VARCHAR(50),
    Birthday DATE,
    Gender CHAR(1),
    PRIMARY KEY (SSN, DName),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
);


-- =============================================
-- TASK 2: INSERT DATA AND DML OPERATIONS
-- =============================================

-- Insert Departments (5 rows)
INSERT INTO Department (DNum, DName) VALUES
(1, 'Research'),
(2, 'Administration'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'HR');

-- Insert Locations (5 rows)
INSERT INTO Location VALUES
('Houston', 1),
('Stafford', 2),
('Bellaire', 3),
('Sugarland', 4),
('Dallas', 5);

-- Insert Employees (5 rows minimum)
INSERT INTO Employee VALUES
('111111111', 'John', 'Smith', 'M', '1975-01-09', NULL, 1),
('222222222', 'Franklin', 'Wong', 'M', '1985-12-08', '111111111', 1),
('333333333', 'Alicia', 'Jones', 'F', '1990-07-19', '111111111', 2),
('444444444', 'Jennifer', 'Wallace', 'F', '1988-06-20', '333333333', 3),
('555555555', 'Ahmad', 'Jabbar', 'M', '1992-03-29', '333333333', 4);

-- Update Department Managers
UPDATE Department SET SSN = '111111111', HiringDate = '2020-01-01' WHERE DNum = 1;
UPDATE Department SET SSN = '333333333', HiringDate = '2021-06-15' WHERE DNum = 2;

-- Insert Projects (5 rows)
INSERT INTO Project VALUES
(1, 'ProductX', 'Houston', 'Houston', 1),
(2, 'ProductY', 'Stafford', 'Houston', 2),
(3, 'Network Setup', 'Bellaire', 'Houston', 3),
(4, 'Marketing Campaign', 'Sugarland', 'Houston', 4),
(5, 'Training Program', 'Dallas', 'Dallas', 5);

-- Insert Work assignments (5 rows)
INSERT INTO Work VALUES
('111111111', 1, 32),
('222222222', 1, 20),
('333333333', 2, 25),
('444444444', 3, 40),
('555555555', 4, 35);

-- Insert Dependents (5 rows)
INSERT INTO Dependent VALUES
('111111111', 'Alice', '2005-04-05', 'F'),
('111111111', 'Michael', '2008-01-04', 'M'),
('222222222', 'Joy', '2010-05-03', 'F'),
('333333333', 'Sam', '2012-10-25', 'M'),
('444444444', 'Anna', '2015-02-28', 'F');


-- =============================================
-- DML PRACTICE QUERIES
-- =============================================

-- SELECT: Get all employees and their departments
SELECT e.FName, e.LName, d.DName
FROM Employee e
JOIN Department d ON e.DNum = d.DNum;

-- SELECT: Find employees working on projects
SELECT e.FName, e.LName, p.PName, w.WorkingHours
FROM Employee e
JOIN Work w ON e.SSN = w.SSN
JOIN Project p ON w.PNum = p.PNum;

-- UPDATE: Change working hours
UPDATE Work
SET WorkingHours = 30
WHERE SSN = '111111111' AND PNum = 1;

-- UPDATE: Change employee department
UPDATE Employee
SET DNum = 2
WHERE SSN = '555555555';

-- DELETE: Remove a dependent
DELETE FROM Dependent
WHERE SSN = '444444444' AND DName = 'Anna';

-- Final SELECT to verify changes
SELECT * FROM Employee;
SELECT * FROM Work;
SELECT * FROM Dependent;