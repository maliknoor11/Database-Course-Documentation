CREATE DATABASE Aggregation;
GO
USE Aggregation;
GO

CREATE TABLE Instructors ( 
    InstructorID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
CREATE TABLE Categories ( 
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(50) 
); 
CREATE TABLE Courses ( 
    CourseID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    InstructorID INT, 
    CategoryID INT, 
    Price DECIMAL(6,2), 
    PublishDate DATE, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
); 
CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
CREATE TABLE Enrollments ( 
    EnrollmentID INT PRIMARY KEY, 
    StudentID INT, 
    CourseID INT, 
    EnrollDate DATE, 
    CompletionPercent INT, 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
); 

-- Instructors 
INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21'); 

-- Categories 
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 

-- Courses 
INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 

-- Students 
INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 

-- Enrollments 
INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3);


--Beginner Level Tasks
--task1
SELECT COUNT(*) FROM Students;

--task2
SELECT COUNT(*) FROM Enrollments;

--task3
SELECT CourseID, AVG(Rating)
FROM Enrollments
GROUP BY CourseID;

--task4
SELECT InstructorID, COUNT(*)
FROM Courses
GROUP BY InstructorID;

--task5
SELECT CategoryID, COUNT(*)
FROM Courses
GROUP BY CategoryID;

--task6
SELECT CourseID, COUNT(*)
FROM Enrollments
GROUP BY CourseID;

--task7
SELECT CategoryID, AVG(Price)
FROM Courses
GROUP BY CategoryID;

--task8
SELECT MAX(Price) FROM Courses;

--task9
SELECT CourseID, MIN(Rating), MAX(Rating), AVG(Rating)
FROM Enrollments
GROUP BY CourseID;

--task10
SELECT COUNT(*)
FROM Enrollments
WHERE Rating = 5;

--Intermediate Level Tasks
--task1
SELECT CourseID, AVG(CompletionPercent)
FROM Enrollments
GROUP BY CourseID;

--task2
SELECT StudentID, COUNT(*)
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 1;

--task3
SELECT c.CourseID, c.Price * COUNT(e.CourseID) AS Revenue
FROM Courses c, Enrollments e
WHERE c.CourseID = e.CourseID
GROUP BY c.CourseID, c.Price;

--task4
SELECT c.InstructorID, COUNT(DISTINCT e.StudentID)
FROM Courses c, Enrollments e
WHERE c.CourseID = e.CourseID
GROUP BY c.InstructorID;

--task5
SELECT CategoryID, AVG(EnrollmentCount)
FROM (
    SELECT c.CategoryID, COUNT(e.CourseID) AS EnrollmentCount
    FROM Courses c, Enrollments e
    WHERE c.CourseID = e.CourseID
    GROUP BY c.CourseID, c.CategoryID
) AS temp
GROUP BY CategoryID;

--task6
SELECT c.InstructorID, AVG(e.Rating)
FROM Courses c, Enrollments e
WHERE c.CourseID = e.CourseID
GROUP BY c.InstructorID;

--task7
SELECT TOP 3 CourseID, COUNT(*) AS EnrollmentCount 
FROM Enrollments 
GROUP BY CourseID 
ORDER BY COUNT(*) DESC;

--task8
SELECT CourseID, COUNT(*)
FROM Enrollments
WHERE CompletionPercent = 100
GROUP BY CourseID;

--task9
SELECT CourseID, 
COUNT(*) AS Total,
SUM(CASE WHEN CompletionPercent = 100 THEN 1 ELSE 0 END) AS Completed
FROM Enrollments
GROUP BY CourseID;

--task10
SELECT COUNT(*)
FROM Courses
WHERE YEAR(PublishDate) = 2023;

