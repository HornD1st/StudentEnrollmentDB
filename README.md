# StudentEnrollmentDB
A make-shift student enrollment database creation.
# Enrollment Data Management System

This project demonstrates the design and implementation of a database system for managing student enrollment using MySQL. It includes student records, courses, instructors, and entrance exam performance, with an Entity-Relationship Diagram (ERD) to visualize the relationships between the tables.

---

## **Project Overview**

The project revolves around creating a database named `enrollment_data`, which manages:
- **Students**: Personal information and assigned courses.
- **Courses**: Course details and instructors.
- **Instructors**: Instructor profiles and the courses they teach.
- **Entrance Exam**: Exam scores of students for multiple subjects.

Key features include:
- Automated generation of unique IDs for new student entries using **SQL triggers**.
- Dynamic data retrieval using **SQL joins** across multiple tables.
- CRUD operations (Create, Read, Update, Delete) to manage the data effectively.

---

## **Features**

### **1. Database Design**
- Entity-Relationship Diagram (ERD): Visual representation of relationships between entities (see `png_enrollment_data_ERD.png`).

### **2. SQL Features**
- **DDL (Data Definition Language)**: Creation of tables with primary and foreign key constraints.
- **DML (Data Manipulation Language)**: Inserting, updating, and deleting records.
- **Triggers**: Automatically generating unique `student_id` values.
- **SQL Queries**:
  - Retrieve data such as students' scores and instructor assignments.
  - Perform joins for comprehensive insights, such as course-instructor relationships.

---

## **Schema Overview**

The database consists of four main tables:

### 1. **students**
| Column          | Type         | Description                  |
|------------------|--------------|------------------------------|
| student_id       | VARCHAR(6)   | Unique ID for each student   |
| instructor_id    | VARCHAR(100) | Linked instructor ID         |
| first_name       | VARCHAR(100) | First name of the student    |
| last_name        | VARCHAR(100) | Last name of the student     |
| gender           | VARCHAR(100) | Gender of the student        |
| course           | VARCHAR(100) | Course the student enrolled in |
| birth_date       | DATE         | Date of birth of the student |

### 2. **courses**
| Column          | Type         | Description                  |
|------------------|--------------|------------------------------|
| course_id        | VARCHAR(6)   | Unique ID for each course    |
| instructor_id    | VARCHAR(100) | Linked instructor ID         |
| course_name      | VARCHAR(100) | Name of the course           |
| duration_months  | INT          | Duration of the course (months) |

### 3. **instructors**
| Column          | Type         | Description                  |
|------------------|--------------|------------------------------|
| instructor_id    | VARCHAR(100) | Unique ID for each instructor |
| first_name       | VARCHAR(100) | First name of the instructor |
| last_name        | VARCHAR(100) | Last name of the instructor  |
| gender           | VARCHAR(100) | Gender of the instructor     |
| course           | VARCHAR(100) | Course the instructor teaches |

### 4. **entrance_exam**
| Column          | Type         | Description                  |
|------------------|--------------|------------------------------|
| exam_id          | VARCHAR(100) | Unique ID for the exam       |
| student_id       | VARCHAR(100) | Linked student ID            |
| mathematics      | INT          | Mathematics score            |
| english          | INT          | English score                |
| current_affairs  | INT          | Current affairs score        |
| logic_and_reasoning | INT       | Logic and reasoning score    |

---

## **Installation and Setup**

### **1. Prerequisites**
- Install [MySQL Workbench](https://dev.mysql.com/downloads/workbench/).
- Install Git (optional, for version control).

### **2. Steps**
1. Clone this repository or download the files.
   ```bash
   git clone https://github.com/<HornD1st>/<StudentEnrollmentDB>.git
2. Open 3MTT Applied Assignment 6 SQL Script.sql in MySQL Workbench.
3. Execute the script to create the database and tables.
4. Load sample data using the included SQL queries

### **3. Sample Queries**
Here are a few sample queries to get you started:

1. **Retrieve all students enrolled in a specific course**:
   ```SQL
   SELECT 
       first_name, last_name, course
   FROM 
       students
   WHERE 
       course = 'Data Analysis and Visualisation';
2. **Find the top-performing student in the entrance exam based on total scores**:
   ```SQL
   SELECT 
    s.first_name, 
    s.last_name, 
    (e.mathematics + e.english + e.current_affairs + e.logic_and_reasoning) AS total_score
   FROM 
    students s
   JOIN 
    entrance_exam e
   ON 
    s.student_id = e.student_id
   ORDER BY 
    total_score DESC
   LIMIT 1;
3. **List all courses and the instructors teaching them**:
   ```SQL
   SELECT 
    c.course_name, 
    i.first_name AS instructor_first_name, 
    i.last_name AS instructor_last_name
   FROM 
    courses c
   JOIN 
    instructors i
   ON 
    c.instructor_id = i.instructor_id;
4. **Get the count of students by gender**:
   ```SQL
   SELECT 
    gender, 
    COUNT(*) AS total_students
   FROM 
    students
   GROUP BY 
    gender;
