create schema inttest2;
use inttest2;

CREATE TABLE L1_maintenance_records (
    maintenance_id INT PRIMARY KEY,
    machine_id INT,
    technician_name VARCHAR(255),
    maintenance_date DATE,
    maintenance_type VARCHAR(255),
    cost DECIMAL(10, 2)
);


INSERT INTO L1_maintenance_records (maintenance_id, machine_id, technician_name, maintenance_date, maintenance_type, cost) VALUES
(1, 1001, 'John Doe', '2024-03-15', 'Full Service', 1200.00),
(2, 1002, 'Jane Smith', '2024-03-20', 'Oil Change', 200.00),
(3, 1003, 'Mike Johnson', '2024-03-22', 'Belt Replacement', 450.00),
(4, 1001, 'Emily Davis', '2024-03-25', 'Calibration', 300.00),
(5, 1004, 'John Doe', '2024-04-01', 'Full Service', 1500.00);


CREATE TABLE L2_updates (
    update_id VARCHAR(255) PRIMARY KEY,
    product_id VARCHAR(255),
    release_date DATE,
    incident_count_pre_update INT,
    incident_count_post_update INT,
    user_feedback_score DECIMAL(3, 1)
);


INSERT INTO L2_updates (update_id, product_id, release_date, incident_count_pre_update, incident_count_post_update, user_feedback_score) VALUES
('U001', 'P100', '2024-03-01', 25, 5, 4.3),
('U002', 'P101', '2024-03-10', 40, 15, 3.8),
('U003', 'P102', '2024-03-15', 30, 2, 4.8),
('U004', 'P100', '2024-03-20', 10, 8, 4.1),
('U005', 'P103', '2024-03-25', 50, 20, 3.5);


CREATE TABLE L3_patients (
    patient_id VARCHAR(255) PRIMARY KEY,
    patient_name VARCHAR(255),
    date_of_birth DATE,
    insurance_provider VARCHAR(255)
);

INSERT INTO L3_patients (patient_id, patient_name, date_of_birth, insurance_provider) VALUES
('P001', 'John Smith', '1980-05-20', 'HealthCare Inc.'),
('P002', 'Jane Doe', '1975-08-04', 'MedSecure'),
('P003', 'Michael Bay', '1990-02-17', 'WellLife'),
('P004', 'Alice Johnson', '1983-11-13', 'HealthCare Inc.'),
('P005', 'Chris Evans', '1987-06-13', 'MedSecure');

CREATE TABLE L3_visits (
    visit_id VARCHAR(255) PRIMARY KEY,
    patient_id VARCHAR(255),
    facility_id VARCHAR(255),
    visit_date DATE,
    reason_for_visit VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES L3_patients(patient_id)
);


INSERT INTO L3_visits (visit_id, patient_id, facility_id, visit_date, reason_for_visit) VALUES
('V001', 'P001', 'F001', '2024-03-15', 'Routine Checkup'),
('V002', 'P002', 'F002', '2024-03-18', 'Consultation'),
('V003', 'P003', 'F003', '2024-03-20', 'Emergency'),
('V004', 'P004', 'F001', '2024-03-22', 'Routine Checkup'),
('V005', 'P005', 'F002', '2024-03-25', 'Consultation');


CREATE TABLE L3_treatments (
    treatment_id VARCHAR(255) PRIMARY KEY,
    visit_id VARCHAR(255),
    treatment VARCHAR(255),
    outcome VARCHAR(255),
    FOREIGN KEY (visit_id) REFERENCES L3_visits(visit_id)
);


INSERT INTO L3_treatments (treatment_id, visit_id, treatment, outcome) VALUES
('T001', 'V001', 'Vaccine', 'Successful'),
('T002', 'V002', 'Therapy', 'Ongoing'),
('T003', 'V003', 'Surgery', 'Complicated'),
('T004', 'V004', 'Vaccine', 'Successful'),
('T005', 'V005', 'Physical Therapy', 'Improved');


CREATE TABLE L3_facilities (
    facility_id VARCHAR(255) PRIMARY KEY,
    facility_name VARCHAR(255),
    location VARCHAR(255)
);


INSERT INTO L3_facilities (facility_id, facility_name, location) VALUES
('F001', 'Main Hospital', 'Downtown'),
('F002', 'North Clinic', 'Uptown'),
('F003', 'East Specialty', 'Suburban'),
('F004', 'West Emergency', 'City Outskirts'),
('F005', 'Central Health', 'Downtown');


CREATE TABLE L4_products (
    product_id VARCHAR(255) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10, 2)
);


INSERT INTO L4_products (product_id, product_name, category, price) VALUES
('PR001', 'T-Shirt', 'Apparel', 29.99),
('PR002', 'Blender', 'Appliances', 49.99),
('PR003', 'Running Shoe', 'Footwear', 79.99),
('PR004', 'Coffee Maker', 'Appliances', 89.99),
('PR005', 'Baseball Cap', 'Apparel', 19.99);


CREATE TABLE L4_sales (
    sale_id VARCHAR(255) PRIMARY KEY,
    product_id VARCHAR(255),
    store_id VARCHAR(255),
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES L4_products(product_id)
);


INSERT INTO L4_sales (sale_id, product_id, store_id, sale_date, quantity) VALUES
('S001', 'PR001', 'ST001', '2024-03-15', 10),
('S002', 'PR002', 'ST002', '2024-03-18', 5),
('S003', 'PR003', 'ST003', '2024-03-20', 8),
('S004', 'PR004', 'ST001', '2024-03-22', 4),
('S005', 'PR005', 'ST002', '2024-03-25', 15);


CREATE TABLE L4_stores (
    store_id VARCHAR(255) PRIMARY KEY,
    store_name VARCHAR(255),
    region VARCHAR(255)
);


INSERT INTO L4_stores (store_id, store_name, region) VALUES
('ST001', 'City Plaza', 'North'),
('ST002', 'Town Mall', 'East'),
('ST003', 'Ocean View', 'West'),
('ST004', 'Mountain Ridge', 'North'),
('ST005', 'Valley Square', 'South');



select * from l1_maintenance_records;
select avg(cost) from l1_maintenance_records group by monthname(maintenance_date) ;
select machine_id,monthname(maintenance_date) from l1_maintenance_records where monthname(maintenance_date)='March'and cost in (select avg(cost) from l1_maintenance_records group by monthname(maintenance_date));


create view secondone from l1_maintenance_records
CREATE OR REPLACE VIEW secondone AS select * from l1_maintenance_records where monthname(maintenance_date)='March';

CREATE OR REPLACE VIEW second_one AS
SELECT * FROM l1_maintenance_records where monthname(maintenance_date)='March';
select * from second_one;
select machine_id,avg(cost) as avgcost from second_one where cost>537 ;


select maintenance_type,count(maintenance_type) from  second_one group by maintenance_type;
select technician_name, sum(cost) from  second_one group by technician_name;
select * from l2_updates;

select avg(incident_count_pre_update-incident_count_post_update) as average_reduction from l2_updates;
select update_id,user_feedback_score from l2_updates order by  user_feedback_score desc limit 1;
select * from l2_updates order by  user_feedback_score desc limit 1;
select product_id, incident_count_pre_update-incident_count_post_update as diff  from l2_updates order by diff desc limit 1 ;



select * from l3_facilities;
select * from l3_patients;
select * from l3_treatments;
select * from l3_visits;

select p.patient_name, f.facility_name, v.reason_for_visit,t.outcome 
from l3_patients p
join l3_visits v on p.patient_id= v.patient_id
join l3_treatments t on t.visit_id=v.visit_id
join l3_facilities f on v.facility_id = f.facility_id;


select f.facility_name, v.facility_id,count(v.facility_id) 
from l3_visits v 
join l3_facilities f on v.facility_id = f.facility_id
 where reason_for_visit='Emergency' group by f.facility_id ;


select p.insurance_provider, count(p.insurance_provider)
from l3_patients p
join l3_visits v on p.patient_id= v.patient_id
join l3_treatments t on t.visit_id=v.visit_id
where t.outcome='Complicated' group by  p.insurance_provider ;







select * from l4_products;
select * from l4_sales;
select * from l4_stores;


CREATE OR REPLACE VIEW l4_sales1 AS select * from l4_sales where monthname(sale_date)='March';
select * from l4_sales1;
select p.product_name, p.category, sa.quantity from 
l4_products p
join l4_sales1 sa on sa.product_id = p.product_id 
join l4_stores s on sa.store_id = s.store_id;


CREATE OR REPLACE VIEW l4_sales2 AS select s.region, sa.sale_id, sa.product_id,sa.store_id, sa.sale_date,p.price*sa.quantity as total_sales
from l4_sales sa join  l4_products p on sa.product_id = p.product_id join l4_stores s on sa.store_id = s.store_id  order by s.region desc ;
select * from l4_sales2;

select region,sum(total_sales) from l4_sales2  where monthname(sale_date)='March' group by  region;

















SELECT table_name,table_rows
FROM information_schema.tables 
WHERE table_schema = 'inttest2';
