USE enrollment_data;

-- Creating the 1st table with exam_id as the primary key:
CREATE TABLE students (
    student_id VARCHAR(100) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(100),
    course VARCHAR(100),
    birth_date DATE
);

/* Creating a helper table to maintain the sequence of the student_id (optional approach for generating the next number):
This will act as a counter to keep track of the next number to use for student_id.*/
CREATE TABLE students_sequence (
    id INT AUTO_INCREMENT PRIMARY KEY
);

-- Creating a trigger to automatically generate student_id:
DELIMITER $$
CREATE TRIGGER set_student_id
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    DECLARE next_id INT;

    -- Insert into students_sequence to get the next auto-incremented value
    INSERT INTO students_sequence VALUES (NULL);

    -- Fetch the last inserted ID from entrance_exam_sequence
    SET next_id = LAST_INSERT_ID();

    -- Format the exam_id as STU01, STU02, etc.
    SET NEW.student_id = CONCAT('STU', LPAD(next_id, 2, '0'));
END$$

DELIMITER ;

-- Populating the students table
INSERT INTO students (first_name,
                        last_name,
                        gender,
                        course,
                        birth_date)
VALUES
('James', 'Dauda', 'Male', 'Data Analysis and Visualisation', '2005-01-15'),
('Ajibike ', 'Somolu', 'Female', 'Software Engineering', '2006-03-22'),
('Michael', 'Bintu', 'Male', 'Data Science', '2004-07-08'),
('Emily', 'Ogbonna', 'Female', 'Data Analysis and Visualisation', '2005-09-30'),
('Dotun', 'Solomon', 'Male', 'Software Engineering', '2006-11-12'),
('Sarah', 'Ajibade', 'Female', 'Animation', '2005-04-18'),
('David', 'Usoro', 'Male', 'Product Management', '2004-08-05'),
('Sophia', 'Nkemjika', 'Female', 'Animation', '2005-10-25'),
('James', 'Oladele', 'Male', 'Data Analysis and Visualisation', '2006-02-02'),
('Isabella', 'Hong', 'Female', 'Data Analysis and Visualisation', '2004-12-19'),
('William', 'Apkaeno', 'Male', 'Cloud Computing', '2005-06-29'),
('Iyanuoluwa', 'Sogbesan', 'Female', 'Product Management', '2006-07-14'),
('Emmanuel', 'Osas', 'Male', 'Software Engineering', '2005-08-09'),
('Ava Okoro', 'Female' 'Product Management', '2006-10-03'),
('Alexander', 'Godonu', 'Male', 'Game Development', '2004-09-13'),
('Mary', 'Okorie', 'Female', 'Software Engineering', '2005-12-21'),
('Lucas', 'Robeson', 'Male', 'AI/ML', '2006-03-17'),
('Charity', 'Nnaemeka', 'Female', 'Cyber Security', '2004-05-30'),
('Benjamin', 'Johnson', 'Male', 'Data Science', '2006-09-26'),
('Amaka', 'Lewis', 'Female', 'Cloud Computing', '2005-01-03'),
('Henry', 'Udoh', 'Male', 'DevOps', '2004-11-15'),
('Ene', 'Young', 'Female' 'Data Analysis and Visualisation', '2005-06-20'),
('Matthew', 'Akingbade', 'Male', 'DevOps', '2006-12-08'),
('Evelyn', 'Basil', 'Female', 'UI/UX Design', '2004-02-18'),
('Jackson', 'Abuma', 'Male' 'UI/UX Design', '2005-04-22'),
('Alice', 'Saka', 'Female', 'DevOps', '2006-05-04'),
('Sebastian', 'Chukwuemeka', 'Male', 'UI/UX Design', '2004-06-07'),
('Evelyn', 'Okolo' 'Female' 'AI/ML', '2005-09-16'),
('Chinemerem', 'Chimaobi', 'Male', 'Cyber Security', '2006-10-27'),
('Chidubem', 'Chimaobi', 'Female', 'Data Science', '2006-10-27');

SELECT *
FROM students;

-- Creating the 2nd table with exam_id as the primary key:
CREATE TABLE courses (
    course_id VARCHAR(100) PRIMARY KEY,
    course_name VARCHAR(100),
    duration_months INT
);

/* Creating a helper table to maintain the sequence of the student_id (optional approach for generating the next number):
This will act as a counter to keep track of the next number to use for student_id.*/
CREATE TABLE course_sequence (
    id INT AUTO_INCREMENT PRIMARY KEY
);

-- Creating a trigger to automatically generate course_id:
DELIMITER $$
CREATE TRIGGER set_course_id
BEFORE INSERT ON courses
FOR EACH ROW
BEGIN
    DECLARE next_id INT;

    -- Insert into entrance_exam_sequence to get the next auto-incremented value
    INSERT INTO course_sequence VALUES (NULL);

    -- Fetch the last inserted ID from entrance_exam_sequence
    SET next_id = LAST_INSERT_ID();

    -- Format the exam_id as CO01, CO02, etc.
    SET NEW.course_id = CONCAT('CO', LPAD(next_id, 2, '0'));
END$$

DELIMITER ;

-- Populating the courses table
INSERT INTO courses (course_name,
                        duration_months
                        )
VALUES
('Data Analysis and Visualisation', 6),
('Software Engineering', 14),
('Data Science', 12),
('Cyber Security', 15),
('UI/UX Design', 8),
('Product Management', 4),
('Cloud Computing', 12),
('DevOps', 14),
('AI/ML', 10),
('Game Development', 10),
('Animation', 12);

-- Creating the 3rd table with exam_id as the primary key:
CREATE TABLE entrance_exam (
    exam_id VARCHAR(100) PRIMARY KEY,
    student_id VARCHAR(100),
    mathematics INT,
    english INT,
    current_affairs INT,
    logic_and_reasoning INT
);

SELECT *
FROM entrance_exam;

SELECT exam_id, SUM(mathematics, english, current_affairs, logic_and_reasoning) AS total_score
FROM entrance_exam
WHERE student_id = 'STU01';

/* Creating a helper table to maintain the sequence of the exam_id (optional approach for generating the next number):
This will act as a counter to keep track of the next number to use for exam_id.*/
CREATE TABLE entrance_exam_sequence (
    id INT AUTO_INCREMENT PRIMARY KEY
);
DROP TABLE entrance_exam_sequence;
-- Creating a trigger to automatically generate exam_id:
DELIMITER $$
CREATE TRIGGER set_exam_id
BEFORE INSERT ON entrance_exam
FOR EACH ROW
BEGIN
    DECLARE next_id INT;

    -- Insert into entrance_exam_sequence to get the next auto-incremented value
    INSERT INTO entrance_exam_sequence VALUES (NULL);

    -- Fetch the last inserted ID from entrance_exam_sequence
    SET next_id = LAST_INSERT_ID();

    -- Format the exam_id as TECH24101, TECH24102, etc.
    SET NEW.exam_id = CONCAT('TECH24', LPAD(next_id + 100, 3, '0'));
END$$

DELIMITER ;

-- Creating a Temporary Table for the CSV Data which contains the students' entrance exam scores:
CREATE TEMPORARY TABLE temp_exam_scores (
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender CHAR(10),
    dob DATE,
    mathematics INT,
    english INT,
    current_affairs INT,
    logic_and_reasoning INT
);
-- Loading the CSV Data into the Temporary Table:
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\exam_scores - exam_scores.csv.csv"
INTO TABLE temp_exam_scores
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(first_name, last_name, gender, dob, mathematics, english, current_affairs, logic_and_reasoning);

SELECT *
FROM temp_exam_scores;


SHOW VARIABLES LIKE 'secure_file_priv';

DROP TABLE temp_exam_scores;
-- Inserting Data into the entrance_exam Table Using a JOIN
INSERT INTO entrance_exam (student_id,
            mathematics,
            english,
            current_affairs,
            logic_and_reasoning)
SELECT 
    s.student_id,
    t.mathematics,
    t.english,
    t.current_affairs,
    t.logic_and_reasoning
FROM 
    temp_exam_scores AS t
JOIN 
    students AS s
ON 
    t.first_name = s.first_name
    AND t.last_name = s.last_name
    AND t.dob = s.birth_date;
    
SELECT *
FROM entrance_exam;

-- Creating the 4th table with instructor_id as the primary key:
CREATE TABLE instructors (
    instructor_id VARCHAR(100) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(100),
    course VARCHAR(100)
);

/* Creating a helper table to maintain the sequence of the instructor_id (optional approach for generating the next number):
This will act as a counter to keep track of the next number to use for instructor_id.*/
CREATE TABLE instructor_sequence (
    id INT AUTO_INCREMENT PRIMARY KEY
);

-- Creating a trigger to automatically generate instructor_id:
DELIMITER $$
CREATE TRIGGER set_instructor_id
BEFORE INSERT ON instructors
FOR EACH ROW
BEGIN
    DECLARE next_id INT;

    -- Insert into entrance_exam_sequence to get the next auto-incremented value
    INSERT INTO instructor_sequence VALUES (NULL);

    -- Fetch the last inserted ID from entrance_exam_sequence
    SET next_id = LAST_INSERT_ID();

    -- Formating the instructor_id as INST01, INST02, etc.
    SET NEW.instructor_id = CONCAT('INST', LPAD(next_id, 2, '0'));
END$$

DELIMITER ;

-- Inserting each instructor's data.
INSERT INTO instructors (first_name,
						last_name,
                        gender,
                        course)
VALUES
('Faith', 'Ishola', 'Female', 'Data Analysis and Visualisation'),
('Robert', 'Tamuno', 'Male', 'Software Engineering'),
('Isa', 'Aliyu', 'Male', 'Data Science'),
('Michael', 'Oghenekeno', 'Male', 'Cyber Security'),
('Amina', 'Yakubu', 'Female', 'UI/UX Design'),
('David', 'Okonkwo', 'Male', 'Product Management'),
('Sophia', 'Cornelius', 'Female', 'Cloud Computing'),
('Lucas', 'Gbadebo', 'Male',  'DevOps'),
('Mia', 'Lopez', 'Female', 'AI/ML'),
('Bose', 'Balogun', 'Female', 'Game Development'),
('William', 'Uzor', 'Male', 'Animation')
;

SELECT *
FROM students;

ALTER TABLE enrollment_data.courses
ADD COLUMN instructor_id VARCHAR(100),
ADD CONSTRAINT fk_instructor
FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id);

-- Inserting Data into the instructor_id column in the courses Table Using a JOIN
UPDATE enrollment_data.courses AS c
JOIN instructors AS i
ON c.course_name = i.course
SET c.instructor_id = i.instructor_id;

ALTER TABLE enrollment_data.students
ADD COLUMN instructor_id VARCHAR(100),
ADD CONSTRAINT fk_instructor_id
FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id);

UPDATE enrollment_data.students AS s
JOIN enrollment_data.courses AS c ON s.course = c.course_name  -- Match the course name between students and courses
JOIN enrollment_data.instructors AS i ON c.instructor_id = i.instructor_id  -- Match the instructor based on the course
SET s.instructor_id = i.instructor_id;  -- Update the student table with the correct instructor_id

-- Disabling safe mode
SET SQL_SAFE_UPDATES = 0;
-- re-enabling safe mode
SET SQL_SAFE_UPDATES = 1;

-- 1. Retrieving Data from the Tables:
-- Query 1: Retrieving all students' names and their courses
SELECT first_name,
	last_name,
    course
FROM students;

-- Query 2: Retrieving all course names and their corresponding instructor IDs
SELECT course_name,
	instructor_id
FROM courses;

-- Query 3: Retrieving enrollment exam scores for mathematics, english, and logic_and_reasoning for all students
SELECT student_id,
	mathematics,
    english,
    logic_and_reasoning
FROM entrance_exam;

-- Query 4: Retrieving all instructors' IDs, names, and their courses
SELECT instructor_id,
	CONCAT(first_name, ' ', last_name) as instructor,
	course
FROM instructors;

-- Query 5: Retrieving the list of students enrolled in the Data Analysis and Visualisation course
SELECT first_name,
	last_name,
    course
FROM students
WHERE course = 'Data Analysis and Visualisation';

-- 2. Performing Simple Joins Between Two Tables:
-- Query 1: Joining the courses and instructors tables to display the course names and the names of their instructors
SELECT
	c.course_name,
	CONCAT(i.first_name, ' ', i.last_name) as instructor
FROM courses AS c
JOIN instructors AS i
ON c.instructor_id = i.instructor_id;

/*Query 2: Joining the students and entrance_exam tables to display each student's ID, their names and their scores for logic and reasoning starting
from highest to lowest*/
SELECT
	s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    e.logic_and_reasoning
FROM students AS s
JOIN entrance_exam AS e
ON s.student_id = e.student_id
ORDER BY e.logic_and_reasoning DESC;

-- Query 3: Joining the courses and instructors tables to list all courses that are taught by a female instructor
SELECT c.course_name, CONCAT(i.first_name, ' ', i.last_name) AS female_instructors
FROM courses AS c
JOIN instructors AS i
ON c.instructor_id = i.instructor_id
WHERE i.gender = 'Female';

-- Query 4: Joining the students and entrance_exam tables to display the full name of each student and their average entrance exam score from highest to lowest.
SELECT
	CONCAT(s.first_name, ' ', s.last_name) AS full_name,
	(e.mathematics + e.english + e.current_affairs + e.logic_and_reasoning)/4 AS average_score
FROM
	students AS s
JOIN
	entrance_exam AS e
ON 
	s.student_id = e.student_id
ORDER BY
	average_score DESC;

-- Query 5: Joining the instructors and students tables to display each instructor's name and the names of the students they are teaching.
SELECT
	CONCAT(i.first_name, ' ', i.last_name) AS instructors,
    CONCAT(s.first_name, ' ', s.last_name) AS students
FROM
	instructors AS i
JOIN
	students AS s
ON 
	i.instructor_id = s.instructor_id
ORDER BY
	instructors;