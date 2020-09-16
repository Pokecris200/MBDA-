/*CREACION DE TABLAS*/
CREATE TABLE Shift(Shift_date DATE, Shift_type VARCHAR(5),Manager VARCHAR(3), Operator VARCHAR(3), Engineer1 VARCHAR(3), Engineer2 VARCHAR(3));
CREATE TABLE Shift_type(Shift_type VARCHAR(5), Start_time DATE,End_time DATE);
CREATE TABLE Staff(Staff_code VARCHAR(3), First_name VARCHAR(10),Last_name VARCHAR(10), Level_code NUMBER(1)NOT NULL);
CREATE TABLE Levels(Level_code NUMBER(1) NOT NULL , Manager VARCHAR(1),Operator VARCHAR(1), Engineer VARCHAR(1));
CREATE TABLE Issue(Call_date DATE, Call_ref NUMBER(4) NOT NULL,Caller_id NUMBER(5) NOT NULL, Detail VARCHAR(250),
Taken_by VARCHAR(3), Assigned_to VARCHAR(3), Status VARCHAR(5));
CREATE TABLE Caller(Caller_id NUMBER(5) NOT NULL, Company_ref NUMBER(5) NOT NULL, First_name VARCHAR(10), Last_name VARCHAR(10));
CREATE TABLE Customer(Company_ref NUMBER(5) NOT NULL, Company_name VARCHAR(50),Contact_id NUMBER(5) NOT NULL, Address_1 VARCHAR(50),
Address_2 VARCHAR(50), Town VARCHAR(20), Postcode VARCHAR(20), Telephone NUMBER(11));

/*LLAVES PRIMARIAS*/
ALTER TABLE Shift ADD CONSTRAINT PK_Shift_date PRIMARY KEY(Shift_date);
ALTER TABLE Shift_type ADD CONSTRAINT PK_Shift_type PRIMARY KEY(Shift_type);
ALTER TABLE Staff ADD CONSTRAINT PK_Staff_code PRIMARY KEY(Staff_code);
ALTER TABLE Levels ADD CONSTRAINT PK_Level_code PRIMARY KEY(Level_code);
ALTER TABLE Issue ADD CONSTRAINT PK_Call_ref PRIMARY KEY(Call_ref);
ALTER TABLE Caller ADD CONSTRAINT PK_Caller_id PRIMARY KEY(Caller_id);
ALTER TABLE Customer ADD CONSTRAINT PK_Company_ref PRIMARY KEY(Company_ref);

/*LLAVES UNICAS */
ALTER TABLE Shift_type ADD CONSTRAINT UK_Start_time UNIQUE(Start_time);
ALTER TABLE Shift_type ADD CONSTRAINT UK_End_time UNIQUE(End_time);                                                                                 
ALTER TABLE Customer ADD CONSTRAINT UK_Company_name UNIQUE(Company_name);
ALTER TABLE Customer ADD CONSTRAINT UK_Contact_id UNIQUE(Contact_id);     
ALTER TABLE Customer ADD CONSTRAINT UK_Address_1 UNIQUE(Address_1); 
ALTER TABLE Customer ADD CONSTRAINT UK_Postcode UNIQUE(Postcode);
ALTER TABLE Customer ADD CONSTRAINT UK_Telephone UNIQUE(Telephone);
ALTER TABLE Issue ADD CONSTRAINT UK_Detail UNIQUE(Detail);

/*LLAVES FORANEAS*/
																																								
/*TABLA Shift*/
ALTER TABLE Shift ADD CONSTRAINT FK_Manager FOREIGN KEY(Manager) REFERENCES Staff(Staff_code);
ALTER TABLE Shift ADD CONSTRAINT FK_Operator FOREIGN KEY(Operator) REFERENCES Staff(Staff_code);
ALTER TABLE Shift ADD CONSTRAINT FK_Engineer1 FOREIGN KEY(Engineer1) REFERENCES Staff(Staff_code);
ALTER TABLE Shift ADD CONSTRAINT FK_Engineer2 FOREIGN KEY(Engineer2) REFERENCES Staff(Staff_code);                                                                                      

/*TABLA Staff*/
ALTER TABLE Staff ADD CONSTRAINT FK_Level_code FOREIGN KEY(Level_code) REFERENCES Levels(Level_code);																																								

/*CONSULTAS*/
/*EASY QUESTIONS */
SELECT Level_code, COUNT(Level_code)AS Total_Employee
FROM Staff
GROUP BY Level_code;

SELECT DISTINCT Detail
FROM Issue
LIMIT 5;

SELECT Status, COUNT(Status) AS Total_
FROM Issue
GROUP BY Status;

SELECT Shift_date, Shift_type, First_name, Last_name
FROM Shift
INNER JOIN Staff 
ON Shift.Manager = Staff.Staff_code;

/*MEDIUM QUESTIONS*/

SELECT Company_name, COUNT(Caller.Caller_id)AS cc
FROM Issue
INNER JOIN Caller ON Issue.Caller_id = Caller.Caller_id
INNER JOIN Customer ON Caller.Company_ref = Customer.Company_ref
GROUP BY Customer.Company_name
HAVING COUNT(Caller.Caller_id) > 18;

SELECT First_name, Last_name 
FROM Caller
WHERE Caller_id NOT IN (
SELECT Caller_id
FROM Issue
);

SELECT x. Company_name, b.First_name, b.Last_name, x.nc
FROM(
SELECT Customer.Company_name,Customer.Contact_id,COUNT(*) AS nc
FROM CUSTOMER
JOIN Caller ON Customer.Company_ref = Caller.Company_ref
JOIN Issue ON Caller.Caller_id = Issue.Caller_id
GROUP BY Customer.Company_name,Customer.Contact_id
HAVING COUNT(*) < 5
)AS x
JOIN(
SELECT *
FROM Caller
)AS b
ON(x.Contact_id = b.Caller_id);

SELECT x.Shift_date,x.Shift_type, COUNT(DISTINCT works) AS cw
FROM(
SELECT Shift_date,Shift_type, Manager AS works FROM Shift
UNION ALL
SELECT Shift_date,Shift_type,Operator AS works FROM Shift
UNION ALL
SELECT Shift_date,Shift_type,Engineer1 AS works FROM Shift
UNION ALL
SELECT Shift_date,Shift_type,Engineer2 AS works FROM Shift
) AS x
GROUP BY Shift_date,Shift_type;

SELECT Staff.first_name,Staff.Last_name,Call_date
FROM Issue
INNER JOIN Caller ON Issue.Caller_id = Caller.Caller_id
INNER JOIN Staff ON Issue.Taken_by = Staff.Staff_code
WHERE Caller.First_name = 'Harry'
ORDER BY Call_date DESC
LIMIT 1;

/*HARD QUESTIONS*/

SELECT Manager,a.hour,COUNT(*) AS cc
FROM(
SELECT DATE_FORMAT(call_date, '%Y-%m-%d %H') hour,
DATE_FORMAT(call_date, '%Y-%m-%d') only_date
FROM Issue
WHERE YEAR(call_date) = '2017' AND MONTH(call_date) = '08' AND DAY(call_date) = '12'
)AS a
JOIN Shift ON a.only_date = DATE_FORMAT(Shift_date, '%Y-%m-%d')
WHERE EXTRACT(HOUR FROM a.hour) <= 13 AND Shift_type = 'Early'
OR EXTRACT(HOUR FROM a.hour) > 13 AND Shift_type = 'Late'
GROUP BY Manager,a.hour
ORDER BY a.hour;

/*Para despoblar las tablas*/
DELETE FROM Shift;
DELETE FROM Shift_type;
DELETE FROM Staff;
DELETE FROM Levels
DELETE FROM Issue;
DELETE FROM Caller; 
DELETE FROM Customer;

/*Para eliminar las tablas en sql developer se usa CASCADE CONSTRAINTS*/
/*para eliminar las llaves foraneas dadas por el usuarioo y ahi si eliminar del todo la tabla*/
DROP TABLE Shift CASCADE CONSTRAINTS;
DROP TABLE Shift_type CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Levels CASCADE CONSTRAINTS;
DROP TABLE Issue CASCADE CONSTRAINTS;
DROP TABLE Caller CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;

