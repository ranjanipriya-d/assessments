-- Lab 1:

CREATE SCHEMA FINALS;
USE FINALS;
-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    address VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

-- Insert data into Customers table
INSERT INTO Customers (customer_id, customer_name, address, email, phone_number) VALUES
(1, 'PharmaCo Inc.', '123 Pharma St., Pharma City', 'info@pharmaco.com', '123-456-7890'),
(2, 'MediCare Solutions', '456 Health Blvd., Medtown', 'contact@medicare.com', '234-567-8901'),
(3, 'PharmaPlus Ltd.', '789 Wellness Ave., Pharmaville', 'support@pharmaplus.com', '345-678-9012'),
(4, 'HealLife Pharmaceuticals', '987 Cure Road, Healville', 'info@heallife.com', '456-789-0123');

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    product_category VARCHAR(50)
);

-- Insert data into Products table
INSERT INTO Products (product_id, product_name, product_category) VALUES
(101, 'Product A', 'Category 1'),
(102, 'Product B', 'Category 2'),
(103, 'Product C', 'Category 1'),
(104, 'Product D', 'Category 3'),
(105, 'Product E', 'Category 2'),
(106, 'Product F', 'Category 1'),
(107, 'Product G', 'Category 3'),
(108, 'Product H', 'Category 2');

-- Create Sales_Records table
CREATE TABLE Sales_Records (
    record_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sales_amount DECIMAL(10, 2),
    sales_date DATE
);

-- Insert data into Sales_Records table
INSERT INTO Sales_Records (record_id, customer_id, product_id, sales_amount, sales_date) VALUES
(1, 1, 101, 1000.50, '2024-03-01'),
(2, 2, 102, 2000.75, '2024-03-02'),
(3, 1, 103, 1500.25, '2024-03-03'),
(4, 3, 104, 3000.00, '2024-03-04'),
(5, 4, 105, 1200.90, '2024-03-05'),
(6, 2, 106, 1800.30, '2024-03-06'),
(7, 1, 107, 2500.60, '2024-03-07'),
(8, 3, 108, 4000.75, '2024-03-08');


select * from customers;

select * from products;

select * from Sales_Records;
select product_id, avg(sales_amount) from sales_records where MONTH(Sales_date) = '03'group by product_id ;
SELECT p.product_name, sr.product_id,
SUM(sr.sales_amount) AS total_sales FROM Sales_Records  sr 
join products p on  sr.product_id= p.product_id GROUP BY sr.product_id order by total_sales desc limit 3;


select distinct sr.customer_id, c.customer_name, percent_rank() over (order by sr.sales_Amount asc), rank () over (order by sr.customer_id asc) from sales_records sr  join customers c on c.customer_id= sr.customer_id ;



WITH TotalSalesByDate AS ( SELECT customer_id,count(record_id) AS frequency FROM sales_records GROUP BY customer_id)
SELECT customer_id,frequency,CASE
        WHEN frequency > 4 THEN 'Consistent'
        ELSE 'Occassional'
    END AS buying
FROM
    TotalSalesByDate;


































-- Lab 2:
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(10),
    departure_airport VARCHAR(50),
    arrival_airport VARCHAR(50),
    departure_date DATE,
    arrival_date DATE,
    base_price DECIMAL(10, 2)
);

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(100),
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    frequent_flyer_status BOOLEAN
);

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY,
    flight_id INT,
    passenger_id INT,
    ticket_price DECIMAL(10, 2),
    ticket_date DATE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id)
);


INSERT INTO Flights VALUES (1, 'FL123', 'JFK', 'LAX', '2024-04-01', '2024-04-01', 500.00);
INSERT INTO Flights VALUES (2, 'FL456', 'LAX', 'ORD', '2024-04-02', '2024-04-02', 400.00);
INSERT INTO Flights VALUES (3, 'FL789', 'ORD', 'DFW', '2024-04-03', '2024-04-03', 300.00);

INSERT INTO Passengers VALUES (1, 'John Doe', 35, 'Male', true);
INSERT INTO Passengers VALUES (2, 'Jane Smith', 28, 'Female', false);
INSERT INTO Passengers VALUES (3, 'Michael Johnson', 40, 'Male', true);

INSERT INTO Tickets VALUES (101, 1, 1, 500.00, '2024-03-30');
INSERT INTO Tickets VALUES (102, 2, 2, 400.00, '2024-03-31');
INSERT INTO Tickets VALUES (103, 3, 3, 300.00, '2024-04-01');
INSERT INTO Tickets VALUES (104, 1, 2, 500.00, '2024-03-30');
INSERT INTO Tickets VALUES (105, 2, 3, 400.00, '2024-03-31');
INSERT INTO Tickets VALUES (106, 3, 1, 300.00, '2024-04-01');

select * from Flights;
select * from Passengers;
select * from Tickets;

select t.flight_id,f.departure_airport, f.arrival_airport,avg(t.ticket_price)  from tickets t  join flights f on t.flight_id=f.flight_id group by t.flight_id ;

select f.flight_id, f.departure_date,count(t.ticket_id) as tot from flights f join tickets t on t.flight_id=f.flight_id  where Month(t.ticket_date) = Month(Curdate())-1 group by f.flight_id order by tot desc;

select p.passenger_name ,sum(t.ticket_price) as tot from passengers p join tickets t on t.passenger_id=p.passenger_id group by p.passenger_name order by tot desc limit 5;

select monthname(ticket_date) as months , count(ticket_id) as counts from tickets group by months order by counts desc;





-- Lab3:
-- Create Players table
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(255),
    player_email VARCHAR(255),
    registration_date DATE
);

-- Create Games table
CREATE TABLE Games (
    game_id INT PRIMARY KEY,
    game_name VARCHAR(255),
    game_genre VARCHAR(255),
    release_date DATE
);

-- Create PlayerScores table
CREATE TABLE PlayerScores (
    score_id INT PRIMARY KEY,
    player_id INT,
    game_id INT,
    score INT,
    play_date DATE,
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (game_id) REFERENCES Games(game_id)
);



-- Insert statements for Players table
INSERT INTO Players (player_id, player_name, player_email, registration_date) VALUES
(1, 'John Doe', 'johndoe@example.com', '2023-01-15'),
(2, 'Jane Smith', 'janesmith@example.com', '2023-02-20'),
(3, 'Mark Johnson', 'markjohnson@example.com', '2023-03-10');

-- Insert statements for Games table
INSERT INTO Games (game_id, game_name, game_genre, release_date) VALUES
(1, 'Fortnite', 'Battle Royale', '2020-07-25'),
(2, 'Minecraft', 'Sandbox', '2011-11-18'),
(3, 'League of Legends', 'MOBA', '2009-10-27');

-- Insert statements for PlayerScores table
INSERT INTO PlayerScores (score_id, player_id, game_id, score, play_date) VALUES
(1, 1, 1, 250, '2023-01-20'),
(2, 1, 2, 500, '2023-02-01'),
(3, 2, 1, 300, '2023-02-15'),
(4, 2, 3, 700, '2023-03-05'),
(5, 3, 1, 400, '2023-03-20'),
(6, 3, 2, 600, '2023-03-25'),
(7, 3, 3, 800, '2023-04-01');


select * from Players;
select * from Games;
select * from PlayerScores;

select g.game_id, g.game_name, count(ps.player_id) as c  from playerscores ps join games g on g.game_id= ps.game_id group by g.game_id order by c desc limit 3 ;
select  g.game_id,  g.game_name,avg(ps.score) as average_score, max(ps.score) as high_Score,count(ps.player_id) as no_of_players from playerscores ps join games g on g.game_id= ps.game_id group by g.game_id order by no_of_players desc ;

select player_id,count(game_id) as cts from playerscores group by player_id order by cts;



-- Lab 4:
-- Create Patients table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    admission_date DATE,
    discharge_date DATE,
    diagnosis VARCHAR(100),
    bill_amount DECIMAL(10, 2)
);

-- Insert data into Patients table
INSERT INTO Patients (patient_id, patient_name, age, gender, admission_date, discharge_date, diagnosis, bill_amount)
VALUES
    (1, 'John Doe', 45, 'Male', '2023-01-15', '2023-01-30', 'Hypertension', 1500.00),
    (2, 'Jane Smith', 30, 'Female', '2023-02-10', '2023-02-20', 'Diabetes', 2000.00),
    (3, 'Michael Johnson', 65, 'Male', '2023-03-05', '2023-03-20', 'Stroke', 3500.00),
    (4, 'Emily Wilson', 50, 'Female', '2023-04-12', '2023-04-25', 'Pneumonia', 2800.00),
    (5, 'David Brown', 55, 'Male', '2023-05-20', '2023-06-05', 'Heart Attack', 5000.00);

-- Create Doctors table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50),
    years_of_experience INT
);

-- Insert data into Doctors table
INSERT INTO Doctors (doctor_id, doctor_name, specialization, years_of_experience)
VALUES
    (101, 'Dr. Smith', 'Cardiology', 10),
    (102, 'Dr. Johnson', 'Neurology', 15),
    (103, 'Dr. Brown', 'Endocrinology', 8),
    (104, 'Dr. Wilson', 'Pulmonology', 12),
    (105, 'Dr. White', 'Internal Medicine', 5);

-- Create Treatments table
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    treatment_name VARCHAR(100),
    treatment_date DATE,
    cost DECIMAL(10, 2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Insert data into Treatments table
INSERT INTO Treatments (treatment_id, patient_id, doctor_id, treatment_name, treatment_date, cost)
VALUES
    (1, 1, 101, 'Angioplasty', '2023-01-20', 5000.00),
    (2, 2, 103, 'Insulin Therapy', '2023-02-15', 1000.00),
    (3, 3, 102, 'Physical Therapy', '2023-03-10', 2000.00),
    (4, 4, 104, 'Oxygen Therapy', '2023-04-15', 1500.00),
    (5, 5, 101, 'Heart Surgery', '2023-05-25', 10000.00);

select * from Patients;
select * from doctors;
Select * from treatments;

select d.doctor_id, d.doctor_name, sum(t.cost) as costs from doctors d join treatments t on t.doctor_id=d.doctor_id group by doctor_id order by costs desc limit 5;
select treatment_name, cost , cume_dist() over( order by cost desc) from treatments t;

select gender,diagnosis,round(avg(datediff(discharge_date,admission_date)),2) from patients group by gender,diagnosis;










-- Lab 5:
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    major VARCHAR(50),
    enrollment_year INT
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT,
    department VARCHAR(50)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade DECIMAL(4,2),
    semester VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);



-- Inserting data into the Students table
INSERT INTO Students (student_id, student_name, major, enrollment_year) VALUES
(1, 'John Doe', 'Computer Science', 2020),
(2, 'Jane Smith', 'Biology', 2021),
(3, 'Alice Johnson', 'History', 2019),
(4, 'Michael Brown', 'Mathematics', 2020),
(5, 'Emily Wilson', 'Psychology', 2021),
(6, 'David Lee', 'Economics', 2019);

-- Inserting data into the Courses table
INSERT INTO Courses (course_id, course_name, credits, department) VALUES
(101, 'Introduction to Computer Science', 3, 'Computer Science'),
(102, 'Cell Biology', 4, 'Biology'),
(103, 'World History', 3, 'History'),
(104, 'Calculus I', 4, 'Mathematics'),
(105, 'Introduction to Psychology', 3, 'Psychology'),
(106, 'Microeconomics', 3, 'Economics');

-- Inserting data into the Enrollments table
INSERT INTO Enrollments (enrollment_id, student_id, course_id, grade, semester) VALUES
(1, 1, 101, 85.0, 'Fall'),
(2, 1, 104, 78.5, 'Fall'),
(3, 2, 102, 92.0, 'Spring'),
(4, 3, 103, 88.5, 'Fall'),
(5, 3, 106, 95.0, 'Spring'),
(6, 4, 101, 90.0, 'Fall'),
(7, 4, 104, 85.5, 'Spring'),
(8, 5, 105, 87.5, 'Fall'),
(9, 5, 106, 91.0, 'Spring'),
(10, 6, 106, 94.0, 'Fall');


select * from students;
select * from courses;
select * from enrollments;

-- 17
select c. department,e.semester, avg(e.grade) from enrollments e join courses c on c.course_id=e.course_id group by c.department, e.semester;
-- 18 
select major, count(student_id) as cts, enrollment_year from students group by student_id order by cts desc ;
-- 19 
select e.semester,  s.student_id, s.student_name,sum(c.credits)  as cts
from courses c join enrollments e on c.course_id=e.course_id 
join students s on e.student_id=s.student_id  group by  s.student_id,e.semester order by cts desc ;

-- 20 
select s.enrollment_year,c.course_name, count(s.student_id) as cts
from courses c join enrollments e on c.course_id=e.course_id 
join students s on e.student_id=s.student_id  group by s.enrollment_year, c.course_name order by cts desc;

CREATE or REPLACE VIEW fin20 AS
SELECT s.enrollment_year, count(s.student_id) as cts,c.course_name
FROM courses c
join enrollments e on c.course_id=e.course_id 
join students s on e.student_id=s.student_id  group by s.enrollment_year, c.course_name ;

select * from fin20;
select enrollment_year, cts,course_name , dense_rank() over(partition by enrollment_year order by cts desc) from fin20;