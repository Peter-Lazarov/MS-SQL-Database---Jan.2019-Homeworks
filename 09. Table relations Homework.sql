CREATE DATABASE TableRelations

USE TableRelations

--P1
DROP TABLE Persons
DROP TABLE Passports

CREATE TABLE Persons (
	PersonID INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(20) NOT NULL,
	Salary DECIMAL(15,2),
	PassportID INT NOT NULL
)

CREATE Table Passports(
	PassportID INT PRIMARY KEY,
	PassportNumber CHAR(8) NOT NULL
)

INSERT INTO Persons([FirstName], Salary, PassportID)
VALUES ('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

INSERT INTO Passports(PassportID, PassportNumber)
VALUES (101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')

SELECT * FROM Persons
SELECT * FROM Passports	

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)

ALTER TABLE Persons
ADD UNIQUE (PassportID)

ALTER TABLE Passports
ADD UNIQUE (PassportNumber)

--P2
DROP TABLE Models
DROP TABLE Manufacturers

CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	EstablishedOn DATE NOT NULL
)

CREATE TABLE Models (
	ModelID INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(20) NOT NULL UNIQUE,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers([Name], EstablishedOn)
VALUES ('BMW', '07/03/1916'),
	('Tesla', '01/01/2003'),
	('Lada', '01/05/1966')

INSERT INTO Models([Name], ManufacturerID)
VALUES ('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

SELECT * FROM Manufacturers
SELECT * FROM Models

--P3
USE ForTry

CREATE TABLE Students(
	StudentID INT,
	[Name] NVARCHAR(20)
)

CREATE TABLE Exams(
	ExamID INT,
	[Name] NVARCHAR(20)
)

CREATE TABLE StudentsExams(
	StudentID INT,
	ExamID INT
)

ALTER TABLE Students
ALTER COLUMN StudentID INT NOT NULL

ALTER TABLE Students
ADD CONSTRAINT PK_Student PRIMARY KEY (StudentID)


ALTER TABLE Exams
ALTER COLUMN ExamID INT NOT NULL

ALTER TABLE Exams
ADD CONSTRAINT PK_Exam PRIMARY KEY (ExamID)

ALTER TABLE StudentsExams
ALTER COLUMN StudentID INT NOT NULL

ALTER TABLE StudentsExams
ALTER COLUMN ExamID INT NOT NULL

ALTER TABLE StudentsExams
ADD CONSTRAINT PK_StudentExams PRIMARY KEY (StudentID, ExamID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentExams_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_StudentExams_Exams FOREIGN KEY (ExamID) REFERENCES Exams (ExamID)

INSERT INTO Exams([Name])
VALUES('SpringMVC'),
	('Neo4j'),
	('Oracle 11g')

INSERT INTO Students([Name])
VALUES('Mila'),
	('Toni'),
	('Ron')

INSERT INTO StudentsExams(StudentID, ExamID)
VALUES(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

SELECT * FROM StudentsExams

DROP TABLE StudentsExams
DROP TABLE Students
DROP TABLE Exams

--P4
USE TableRelations
DROP TABLE Teachers

CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers (TeacherID, [Name], ManagerID)
VALUES (101, 'John', NULL),
	(102, 'Maya', 106),
	(103, 'Silvia', 106),
	(104, 'Ted', 105),
	(105, 'Mark', 101),
	(106, 'Greta', 101)

--P9
USE Geography

SELECT * FROM Mountains
SELECT * FROM Peaks

SELECT 
	MountainRange,
	PeakName,
	Elevation
FROM Mountains AS m
JOIN Peaks AS p ON m.Id = p.MountainId
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC

