

CREATE DATABASE student_management;
USE student_management;

DROP DATABASE student_management;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    duration VARCHAR(20),
    fees INT
);
DROP TABLE courses;

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    exam_type VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students VALUES
(101, 'Rahul Sharma', 'rahul@gmail.com', 20, 'Male', 'Delhi', '9876543210'),
(102, 'Priya Verma', 'priya@gmail.com', 19, 'Female', 'Noida', '9876543211'),
(103, 'Aman Kumar', 'aman@gmail.com', 21, 'Male', 'Meerut', '9876543212'),
(104, 'Neha Singh', 'neha@gmail.com', 20, 'Female', 'Ghaziabad', '9876543213'),
(105, 'Vikas Yadav', 'vikas@gmail.com', 22, 'Male', 'Delhi', '9876543214');

INSERT INTO courses VALUES
(1, 'BCA', '3 Years', 45000),
(2, 'BBA', '3 Years', 40000),
(3, 'BTECH', '4 Years', 80000);

INSERT INTO enrollment VALUES
(1, 101, 1, '2024-07-15'),
(2, 102, 1, '2024-07-16'),
(3, 103, 2, '2024-07-15'),
(4, 104, 1, '2024-07-17'),
(5, 105, 3, '2024-07-18');

INSERT INTO marks VALUES
(1, 101, 1, 85, 'Final'),
(2, 102, 1, 92, 'Final'),
(3, 103, 2, 78, 'Final'),
(4, 104, 1, 88, 'Final'),
(5, 105, 3, 95, 'Final');

INSERT INTO attendance VALUES
(1, 101, 1, '2024-08-01', 'Present'),
(2, 101, 1, '2024-08-02', 'Absent'),
(3, 102, 1, '2024-08-01', 'Present'),
(4, 103, 2, '2024-08-01', 'Present'),
(5, 105, 3, '2024-08-01', 'Present');

SELECT * FROM students;

SELECT s.student_id, s.name, c.course_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;


SELECT s.name, m.marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks > 80;

SELECT c.course_name, MAX(m.marks) AS highest_marks
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_name;

SELECT c.course_name, ROUND(AVG(m.marks), 2) AS average_marks
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_name;

SELECT * FROM students WHERE city = 'Delhi';

SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT 
    s.name,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) * 100.0 / COUNT(*) AS attendance_percentage
FROM students s
JOIN attendance a ON s.student_id = a.student_id
WHERE s.student_id = 101
GROUP BY s.name;

UPDATE marks SET marks = 90 WHERE student_id = 101 AND course_id = 1;

SELECT * FROM marks WHERE student_id = 101;

SELECT s.name, m.marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
ORDER BY m.marks DESC;