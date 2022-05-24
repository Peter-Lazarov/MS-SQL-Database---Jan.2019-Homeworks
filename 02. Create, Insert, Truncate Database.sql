CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	Age INT
)

CREATE TABLE Towns(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(20) NOT NULL
)

ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)


INSERT INTO Towns(Id, [Name])
VALUES (1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')

SELECT * FROM Towns

INSERT INTO Minions([Name], Age, TownId)
VALUES ('Kevin', 22, 1),
		('Bob', 15, 3),
		('Steward', NULL, 2)

SELECT * FROM Minions

TRUNCATE TABLE Minions

DROP TABLE Minions
DROP TABLE Towns

CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	CONSTRAINT CHK_Picture CHECK (DATALENGTH(Picture) <= 2000 * 1024),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
	CONSTRAINT CHK_Gender CHECK(Gender = 'm' OR Gender = 'f'),
	BirthDate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)
DROP TABLE People

INSERT INTO People([Name], Picture, Height, [Weight], Gender, BirthDate, Biography)
VALUES ('Pesho', 200, 1.72, 62, 'M', '19860825', 'I''m born in Vratza'),
		('Elena', 500, 1.58, 51, 'F', '19910105', 'I''m born in Vratza'),
		('Gosho', 200, 2.00, 120, 'M', '19880105', 'I''m born in Sofia'),
		('Teodora', 200, 1.60, 60, 'F', '19980105', 'I''m born in Varna'),
		('Maria', 200, 1.55, 52, 'F', '20010105', 'I''m born in Plovdiv')

SELECT * FROM People

TRUNCATE TABLE People

CREATE TABLE Users(
	Id BIGINT PRIMARY KEY IDENTITY,
	UserName VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	CONSTRAINT CHK_ProfilePicture CHECK(DATALENGTH(ProfilePicture) <= 900 * 1024),
	LastLoginTime DATETIME,
	IsDeleted BIT
)

INSERT INTO Users(UserName, [Password], ProfilePicture, LastLoginTime, IsDeleted)
VALUES('Pesho Todorov', 'secure100', 200, '2006-12-30 00:38:54.000', 1),
	('Gosho Todorov', 'secure2100', 400, '2012-12-30 00:38:54.000', 0),
	('Ivan Todorov', 'secure3100', 600, '2008-12-30 00:38:54.000', 0),
	('Maria Sotianova', 'secure5100', 500, '2009-12-30 00:38:54.000', 1),
	('Galia Ivanova', 'secure6100', 300, '2004-12-30 00:38:54.000', 1)

SELECT * FROM Users

TRUNCATE TABLE Users



CREATE DATABASE Movies

CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName, Notes)
VALUES ('Pesho Ivanov', 'Some note...'),
		('Gosho Ivanov', NULL),
		('Stoyan Ivanov', NULL),
		('Maria Todorova', 'Some note...'),
		('Iliana Ignatova', 'Some note...')

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Genres(GenreName, Notes)
VALUES ('Comedy', 'Some note...'),
		('Action', NULL),
		('Drama', NULL),
		('Science', 'Some note...'),
		('History', 'Some note...')

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName, Notes)
VALUES ('Art film', 'Some note...'),
		('Film studies', NULL),
		('Literary adaptation', NULL),
		('Nudity clause', 'Some note...'),
		('Screenwriting', 'Some note...')

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) NOT NULL,
	DirectorId INT NOT NULL FOREIGN KEY REFERENCES Directors(Id),
	CopyrightYear SMALLINT,
	[Length] TIME,
	GenreId INT NOT NULL FOREIGN KEY REFERENCES Genres(Id),
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	Rating NVARCHAR(10),
	Notes NVARCHAR(MAX)
)

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes)
VALUES('Looney Tunes', 1, 2018, '01:23:30', 2, 3, 'Some', 'Another notes...'),
('Fast and furious', 2, 2001, '01:33:30', 1, 2, 'Some', 'Another notes...'),
('Transporter', 3, 2004, '01:20:30', 4, 5, 'Some', 'Another notes...'),
('Lucy', 4, 2014, '01:23:30', 2, 5, 'Some', 'Another notes...'),
('Point Break', 4, 1991, '01:10:30', 2, 1, 'Some', 'Another notes...')

SELECT * FROM Directors
SELECT * FROM Categories
SELECT * FROM Genres

SELECT * FROM Movies

TRUNCATE TABLE Directors

CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(100) NOT NULL,
	DailyRate DECIMAL(6, 2) NOT NULL,
	WeeklyRate DECIMAL(6, 2) NOT NULL,
	MonthlyRate DECIMAL(6, 2) NOT NULL,
	WeekendRate DECIMAL(6, 2) NOT NULL
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES('CAR', 20, 80, 499.99, 28.5),
('VAN', 40, 160, 999.99, 48.5),
('SUV', 30, 100, 799.99, 38.5)

CREATE TABLE Cars(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber NVARCHAR(10) NOT NULL,
	Manufacturer NVARCHAR(50) NOT NULL,
	Model NVARCHAR(50) NOT NULL,
	CarYear SMALLINT,
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	Doors TINYINT,
	Picture VARBINARY(MAX),
	CONSTRAINT CHK_Picture CHECK(DATALENGTH(Picture) <= 900 * 1024),
	Condition NVARCHAR(50),
	Available BIT
)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES('BP2701', 'HONDA', 'CIVIC', 1994, 1, 4, 200, 'GOOD', 1),
('BP2704', 'HONDABB', 'CIVICA', 1994, 1, 4, 200, 'GOOD', 1),
('BP2702', 'HONDAA', 'CIVICC', 1994, 1, 4, 200, 'GOOD', 1)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes)
VALUES('Petar', 'Lazarov', 'Mechanic', 'GOOD'),
('Ivan', 'Lazarov', 'Driver', 'GOOD'),
('Petar', 'Ivanov', 'Driver', 'GOOD')

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY,
	DriverLicenceNumber INT NOT NULL UNIQUE,
	FullName NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL,
	City NVARCHAR(20) NOT NULL,
	ZIPCode INT,
	Notes NVARCHAR(MAX)
)

INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZIPCode, Notes)
VALUES(10000, 'Peter Lazarov', 'Mladost', 'Vratza', 3000, 'Some notes'),
(10001, 'Gosho Lazarov', 'Mladost', 'Vratza', 3000, 'Some notes'),
(10002, 'Spas Lazarov', 'Mladost', 'Vratza', 3000, 'Some notes')

CREATE TABLE RentalOrders(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
	CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(Id),
	CarId INT NOT NULL FOREIGN KEY REFERENCES Cars(Id),
	TankLevel NVARCHAR(20),
	KilometrageStart INT NOT NULL,
	KilometrageEnd INT NOT NULL,
	TotalKilometrage INT NOT NULL,
	StartDate DATETIME,
	EndDate DATETIME,
	TotalDays SMALLINT,
	RateApplied DECIMAL(6, 2) NOT NULL,
	TaxRate DECIMAL(6, 2) NOT NULL,
	OrderStatus BIT,
	Notes NVARCHAR(MAX)
)

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES(1, 1, 2, 'HALF', 3000, 3250, 250, '20190105', '20190107', 2, 40, 5, 1, 'Some notes'),
(2, 3, 1, 'HALF', 3000, 3250, 250, '20190105', '20190107', 2, 40, 5, 1, 'Some notes'),
(2, 1, 2, 'HALF', 3000, 3250, 250, '20190105', '20190107', 2, 40, 5, 1, 'Some notes')



--Problem 15

CREATE DATABASE HOTEL
USE HOTEL

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes)
VALUES('Petar', 'Lazarov', 'Mechanic', 'GOOD'),
('Ivan', 'Lazarov', 'Driver', 'GOOD'),
('Petar', 'Ivanov', 'Driver', 'GOOD')

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY,
	AccountNumber SMALLINT NOT NULL UNIQUE,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	PhoneNumber NVARCHAR(20) NOT NULL,
	EmergencyName NVARCHAR(100) NOT NULL,
	EmergencyNumber INT NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
VALUES(1001, 'Peter', 'Lazarov', '0888777078', 'Chicho Doktor', '150', 'Some notes'),
(1002, 'Ivan', 'Lazarov', '0888777078', 'Chicho Doktor', '150', 'Some notes'),
(1003, 'Todor', 'Lazarov', '0888777078', 'Chicho Doktor', '150', 'Some notes')

CREATE TABLE RoomStatus(
	Id INT PRIMARY KEY IDENTITY,
	RoomStatus NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO RoomStatus(RoomStatus, Notes)
VALUES('Ready', 'Some notes'),
	('Rented', 'Some notes'),
	('for Cleaning', 'Some notes')

CREATE TABLE RoomTypes(
	Id INT PRIMARY KEY IDENTITY,
	RoomType NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO RoomTypes(RoomType, Notes)
VALUES('one bed', 'Some notes'),
	('two beds', 'Some notes'),
	('apartment', 'Some notes')

CREATE TABLE BedTypes(
	Id INT PRIMARY KEY IDENTITY,
	BedType NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO BedTypes(BedType, Notes)
VALUES('common', 'Some notes'),
	('for two', 'Some notes'),
	('king size', 'Some notes')

CREATE TABLE Rooms(
	Id INT PRIMARY KEY IDENTITY,
	RoomNumber SMALLINT,
	RoomType INT NOT NULL FOREIGN KEY REFERENCES RoomTypes(Id),
	BedType INT NOT NULL FOREIGN KEY REFERENCES BedTypes(Id),
	Rate DECIMAL(7, 2) NOT NULL,
	RoomStatus INT NOT NULL FOREIGN KEY REFERENCES RoomStatus(Id),
	Notes NVARCHAR(MAX)
)

INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
VALUES(10, 1, 2, 30, 2, 'Some notes'),
	(12, 2, 1, 20, 2, 'Some notes'),
	(14, 3, 2, 50, 1, 'Some notes')

CREATE TABLE Payments(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
	PaymentDate DATE,
	AccountNumber INT NOT NULL UNIQUE,
	FirstDateOccupied DATE,
	LastDateOccupied DATE,
	TotalDays SMALLINT,
	AmountCharged DECIMAL (10, 2),
	TaxRate DECIMAL (7,2),
	TaxAmount DECIMAL (7,2),
	PaymentTotal DECIMAL (10, 2),
	Notes NVARCHAR(MAX)
)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
VALUES(1, '20190120', 2010, '20190120', '20190122', 2, 42.5, 5, 6, 53.5, 'Some notes'),
	(2, '20190119', 2011, '20190120', '20190122', 3, 42.5, 5, 6, 73.5, 'Some notes'),
	(3, '20190120', 2012, '20190105', '20190109', 4, 42.5, 5, 6, 93.5, 'Some notes')

CREATE TABLE Occupancies(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
	DateOccupied DATE,
	AccountNumber INT NOT NULL UNIQUE,
	RoomNumber INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id),
	RateApplied DECIMAL(7, 2) NOT NULL,
	PhoneCharge DECIMAL(7, 2) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
VALUES(1, '20190120', 2010, 1, 20, 2, 'Some notes'),
	(2, '20190120', 2011, 1, 20, 2, 'Some notes'),
	(3, '20190120', 2012, 1, 20, 2, 'Some notes')


CREATE DATABASE SoftUni
USE SoftUni

CREATE TABLE Towns(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50),
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY,
	AddressText NVARCHAR(200),
	TownId INT NOT NULL FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100)
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50),
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL,
	DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATE,
	Salary DECIMAL(10,2),
	AddressId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id)
)

SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

SELECT * FROM Towns
ORDER BY [Name];

SELECT * FROM Departments
ORDER BY [Name];

SELECT * FROM Employees
ORDER BY Salary DESC;

--

SELECT [Name] FROM Towns
ORDER BY [Name];

SELECT [Name] FROM Departments
ORDER BY [Name];

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC;

--PROBLEM 22
UPDATE Employees
SET Salary = Salary * 1.10

SELECT Salary FROM Employees

USE HOTEL

--PROBLEM 23
UPDATE Payments
SET TaxRate = TaxRate * 0.97

SELECT TaxRate FROM Payments

--PROBLEM 24
TRUNCATE TABLE Occupancies

