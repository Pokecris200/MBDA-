/*CREACION DE TABLAS*/
CREATE TABLE Shift(Shift_date DATE, Shift_type VARCHAR(5),Manager VARCHAR(3), Operator VARCHAR(3), Engineer1 VARCHAR(3), Engineer2 VARCHAR(3));
CREATE TABLE Shift_type(Shift_type VARCHAR(5), Start_time DATE,End_time DATE);
CREATE TABLE Staff(Staff_code VARCHAR(3), First_name VARCHAR(10),Last_name VARCHAR(10), Level_code NUMBER(1)NOT NULL);
CREATE TABLE Levels(Level_code NUMBER(1) NOT NULL , Manager VARCHAR(1),Operator VARCHAR(1), Engineer VARCHAR(1));
CREATE TABLE Issue(Call_date DATE, Call_ref NUMBER(4) NOT NULL,Caller_id NUMBER(5) NOT NULL, Detail VARCHAR(250),
Taken_by VARCHAR(3), Assigned_to VARCHAR(3), Status VARCHAR(5));
CREATE TABLE Caller(Caller_id NUMBER(5) NOT NULL, Company_ref NUMBER(5) NOT NULL, First_name VARCHAR(20), Last_name VARCHAR(20));
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
										
/*TABLA Issue*/
ALTER TABLE Issue ADD CONSTRAINT FK_Caller_id FOREIGN KEY(Caller_id) REFERENCES Caller(Caller_id);
ALTER TABLE Issue ADD CONSTRAINT FK_Taken_by FOREIGN KEY(Taken_by) REFERENCES Staff(Staff_code);
ALTER TABLE Issue ADD CONSTRAINT FK_Assigned_to FOREIGN KEY(Assigned_to) REFERENCES Staff(Staff_code);
										
/*TABLA Caller*/
ALTER TABLE Caller ADD CONSTRAINT FK_Company_ref FOREIGN KEY(Company_ref) REFERENCES Customer(Company_ref);
										
/*TABLA Customer*/
ALTER TABLE Customer ADD CONSTRAINT FK_Contact_id FOREIGN KEY(Contact_id) REFERENCES Caller(Caller_id);	
										
										
/*Automatizacion INSERT Shift*/										
SELECT 
CONCAT(
'INSERT INTO Shift VALUES(',Shift_date,',', Shift_type,',',Manager,',',Operator,',',Engineer1,',',Engineer2,');'
) 
FROM Shift
/*INSERT Shift*/									
INSERT INTO Shift VALUES(TO_DATE('2017/08/12','YYYY/MM/DD'), 'Early','LB1', 'AW1', 'AE1', 'JE1');
INSERT INTO Shift VALUES(TO_DATE('2017/08/12','YYYY/MM/DD'), 'Late','AE1', 'IM1', 'AL1', 'BJ1');
INSERT INTO Shift VALUES(TO_DATE('2017/08/13','YYYY/MM/DD'), 'Early','AE1', 'MM1', 'MW1',null);
INSERT INTO Shift VALUES(TO_DATE('2017/08/13','YYYY/MM/DD'), 'Late','AE1', 'AE1', 'EB1', null);
INSERT INTO Shift VALUES(TO_DATE('2017/08/14','YYYY/MM/DD'), 'Late','LB1', 'AB1', 'DJ1', 'JP1');	
										
/*Automatizacion INSERT Shift_type*/										
SELECT 
CONCAT(
'INSERT INTO Shift_type VALUES(',Shift_type,',', Start_time,',',End_time,');'
) 
FROM Shift_type
/*INSERT Shift_type*/										
INSERT INTO Shift_type VALUES('Early','08:00', '14:00');
INSERT INTO Shift_type VALUES('Late','14:00', '20:00');										
										
/*Automatizacion INSERT Staff*/										
SELECT 
CONCAT(
'INSERT INTO Staff VALUES(',Staff_code,',', First_name,',',Last_name,',',Level_code,');'
) 
FROM Staff
/*INSERT Staff*/			 
INSERT INTO Staff VALUES('AB1','Anthony', 'Butler',1);
INSERT INTO Staff VALUES('AB2','Alexis', 'Butler',3);
INSERT INTO Staff VALUES('AE1','Ava', 'Ellis',7);
INSERT INTO Staff VALUES('AL1','Alexander', 'Lawson',3);
INSERT INTO Staff VALUES('AW1','Alyssa', 'White',1);		
			 
/*Automatizacion INSERT Levels*/			 
SELECT 
CONCAT(
'INSERT INTO Levels VALUES(',Level_code,',',Manager,',',Operator,',',Engineer,');'
) 
/*Insert Level*/			 
FROM Levels
INSERT INTO Levels VALUES(1,null, 'Y',null);
INSERT INTO Levels VALUES(2,null, null,'Y');
INSERT INTO Levels VALUES(3,null, 'Y','Y');
INSERT INTO Levels VALUES(4,'Y', null,null);
INSERT INTO Levels VALUES(5,'Y', 'Y',null);
INSERT INTO Levels VALUES(7,'Y', 'Y','Y');			 
			 
/*Automatizacion INSERT Issue*/										
SELECT 
CONCAT(
'INSERT INTO Issue VALUES(',Call_date,',',Call_ref,',',Caller_id,',',Detail,',',Taken_by,',',Assigned_to,',',Status,');'
) 
FROM Issue
/*INSERT Issue*/									
INSERT INTO Issue VALUES(TO_DATE('2017/08/12 08:16:00 ','YYYY/MM/DD/HH24/MI/SS'), 1237,9, 'How can I guarantee a digital communication in Oracle ?', 'AW1', 'AE1', 'Closed');
INSERT INTO Issue VALUES(TO_DATE('2017/08/12 08:24:00','YYYY/MM/DD/HH24/MI/SS'), 1238,10, 'How can I vanish a task-based documentation in Adobe Acrobat ?', 'AW1', 'JE1', 'Closed');
INSERT INTO Issue VALUES(TO_DATE('2017/08/12 08:29:00','YYYY/MM/DD/HH24/MI/SS'), 1239,12, 'How can I request a usability in Microsoft Powerpoint ?', 'AW1', 'AE1', 'Closed');
INSERT INTO Issue VALUES(TO_DATE('2017/08/12 08:43:00','YYYY/MM/DD/HH24/MI/SS'), 1240,13, 'How can I skip a aspect ratio in Oracle ?', 'AW1', 'JE1', 'Closed');
INSERT INTO Issue VALUES(TO_DATE('2017/08/12 08:48:00','YYYY/MM/DD/HH24/MI/SS'), 1241,14, 'Im trying to train a locator in SQL Server but the Information Mapping is too wacky', 'AW1', 'AE1', 'Closed');

/*Automatizacion INSERT Caller*/										
SELECT 
CONCAT(
'INSERT INTO Caller VALUES(',Caller_id,',', Company_ref,',',First_name,',',Last_name,');'
) 
FROM Caller
/*INSERT Caller*/			 
INSERT INTO Caller VALUES(1,111, 'Ava','Clarke');
INSERT INTO Caller VALUES(2,134, 'Ava',,'Edwards');
INSERT INTO Caller VALUES(3,129, 'John','Green');
INSERT INTO Caller VALUES(4,108, 'Ryan','White');
INSERT INTO Caller VALUES(5,114, 'Noah','Evans');
										
/*Automatizacion INSERT Customer*/										
SELECT 
CONCAT(
'INSERT INTO Customer VALUES(',Company_ref,',', Company_name,',',Contact_id,',',Address_1,',',Address_2,',',Town,',',Postcode,',', Telephone,');'
) 
FROM Customer
/*INSERT Customer*/			 
INSERT INTO Customer VALUES(100,'Haunt Services',112,'53 Finger Gate',null,'Dartford','DA48 5WU',01001722832);
INSERT INTO Customer VALUES(101,'Genus Ltd.',33,,'	34 Pyorrhea Green',null,'Guildford','GY34 4ZH',01004256920);
INSERT INTO Customer VALUES(102,'Corps Ltd.',111,'67 Napery Green',null,'Harrow','HA32 6PP',01012384042);
INSERT INTO Customer VALUES(103,'Train Services',115,'30 Crizzel Parkway',null,'Hemel Hempstead','HP38 6DU',01012979358);
INSERT INTO Customer VALUES(104,'Somebody Logistics',127,'93 Calculated Oval',null,'Hull','	HX16 1IF',01013707879);											
			 		 
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
										
/*Consultas NoOK*/	
INSERT INTO Shift VALUES(null, 'Early','AE1', 'MM1', 'MW1',null);									
INSERT INTO Shift_type VALUES(null,'14:00', 3);	
INSERT INTO Staff VALUES(4,'Alexis', 'Butler',null);										
INSERT INTO Levels VALUES(null,'Y', 20,5);										
INSERT INTO Issue VALUES(null, null,null, 257, 'AW1', 'AE1', 'Closed');										
INSERT INTO Caller VALUES(null,129, 'John','Green');
INSERT INTO Customer VALUES(null,'Corps Ltd.',null,'67 Napery Green',null,'Harrow','HA32 6PP',01012384042);										
										
										
/*Despoblar tablas*/
DELETE FROM Shift;
DELETE FROM Shift_type;
DELETE FROM Staff;
DELETE FROM Levels
DELETE FROM Issue;
DELETE FROM Caller; 
DELETE FROM Customer;
	
/*Eliminacion de tablas*/
DROP TABLE Shift CASCADE CONSTRAINTS;
DROP TABLE Shift_type CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Levels CASCADE CONSTRAINTS;
DROP TABLE Issue CASCADE CONSTRAINTS;
DROP TABLE Caller CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;

