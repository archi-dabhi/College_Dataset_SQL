CREATE DATABASE CollegeDB;
USE CollegeDB;


-- Department

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    hod VARCHAR(100)
);

INSERT INTO Departments (department_name, hod) VALUES
('Computer Science', 'Dr. Priya'),
('Mechanical Engineering', 'Dr. Riva'),
('Electrical Engineering', 'Dr. Jiya'),
('Civil Engineering', 'Dr. Pal'),
('Mathematics', 'Dr. Kinal'),
('Physics', 'Dr. Archi'),
('Chemistry', 'Dr. Jal'),
('Biotechnology', 'Dr. Alice'),
('Information Technology', 'Dr. Riya'),
('Business Administration', 'Dr. Vishva');


-- STUDENTS TABLE

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);


INSERT INTO Students (first_name, last_name, email, dob, department_id) VALUES
('Archi', 'patel', 'archipatel@college.edu', '2002-05-10', 1),
('Priya', 'Singh', 'priya.singh@college.edu', '2001-08-21', 2),
('Rahul', 'Patel', 'rahul.patel@college.edu', '2003-01-15', 1),
('Neha', 'Verma', 'neha.verma@college.edu', '2002-12-09', 3),
('Sahil', 'Shah', 'sahil.shah@college.edu', '2001-03-25', 4),
('Anjali', 'Mehta', 'anjali.mehta@college.edu', '2000-07-14', 5),
('Rohan', 'Yadav', 'rohan.yadav@college.edu', '2003-09-29', 6),
('Simran', 'Kaur', 'simran.kaur@college.edu', '2002-04-18', 7),
('Vikas', 'Rao', 'vikas.rao@college.edu', '2001-10-05', 8),
('Karishma', 'Joshi', 'kavita.joshi@college.edu', '2002-08-30', 9);

-- COURSES TABLE

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    department_id INT,
    credits INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Courses (course_name, department_id, credits) VALUES
('Database Systems', 1, 4),
('Thermodynamics', 2, 3),
('Electrical Circuits', 3, 4),
('Structural Engineering', 4, 3),
('Linear Algebra', 5, 4),
('Quantum Mechanics', 6, 4),
('Organic Chemistry', 7, 3),
('Genetic Engineering', 8, 4),
('Web Development', 9, 3),
('Business Strategy', 10, 3);

-- fACULTY TABLE

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Faculty (first_name, last_name, email, department_id) VALUES
('Janvi', 'Sharma', 'janvi.sharma@college.edu', 1),
('Shruti', 'Verma', 'shruti.verma@college.edu', 2),
('Arun', 'Mehta', 'arun.mehta@college.edu', 3),
('Pooja', 'Kumar', 'pooja.kumar@college.edu', 4),
('Kiran', 'Joshi', 'kiran.joshi@college.edu', 5),
('Amit', 'Gupta', 'amit.gupta@college.edu', 6),
('Tanya', 'Roy', 'tanya.roy@college.edu', 7),
('Kriya', 'Das', 'kriya.das@college.edu', 8),
('Lakshmi', 'Nair', 'lakshmi.nair@college.edu', 9),
('Jiya', 'Kapoor', 'jiya.kapoor@college.edu', 10);

-- ENROLLMENTS TABLE

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments (student_id, course_id, semester, grade) VALUES
(1, 1, 'Spring 2024', 'A'),
(2, 2, 'Spring 2024', 'B'),
(3, 1, 'Spring 2024', 'A'),
(3, 3, 'Spring 2024', 'B'),
(4, 3, 'Spring 2024', 'A'),
(5, 4, 'Spring 2024', 'C'),
(6, 5, 'Spring 2024', 'B'),
(7, 6, 'Spring 2024', 'A'),
(8, 7, 'Spring 2024', 'B'),
(9, 9, 'Spring 2024', 'A');

SHOW TABLES;


-- SELECT, WHERE, ORDER BY, GROUP BY

SELECT department_id, COUNT(*) AS total_students
FROM Students
WHERE dob >= '2002-01-01'      
GROUP BY department_id        
ORDER BY total_students DESC;  

-- INNER JOIN

SELECT s.first_name, s.last_name, c.course_name
FROM Students s
INNER JOIN Enrollments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;

-- Subquery

SELECT first_name, last_name
FROM Students
WHERE student_id IN (
    SELECT student_id FROM Enrollments WHERE grade = 'A'
);

-- Aggregate functions

SELECT department_id,
			AVG(credits) AS avg_credits,
			SUM(credits) AS total_credits
FROM Courses
GROUP BY department_id;

-- Create a View

DROP VIEW IF EXISTS StudentCourses_v2;

CREATE VIEW StudentCourses_v2 AS

SELECT s.first_name, s.last_name, c.course_name, e.semester, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- To see output 

SELECT * FROM StudentCourses_v2;

-- Index for optimization

CREATE INDEX idx_student_dept
ON Students(department_id);

SELECT * FROM Students
WHERE department_id = 1;


