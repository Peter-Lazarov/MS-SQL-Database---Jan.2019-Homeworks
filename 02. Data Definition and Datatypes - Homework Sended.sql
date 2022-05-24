//Problem 4. Insert Records in Both Tables
INSERT INTO Towns(Id, [Name])
VALUES (1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')

INSERT INTO Minions(Id, [Name], Age, TownId)
VALUES (1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)

--Problem 7
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

INSERT INTO People([Name], Picture, Height, [Weight], Gender, BirthDate, Biography)
VALUES ('Pesho', 200, 1.72, 62, 'M', '19860825', 'I''m born in Vratza'),
		('Elena', 500, 1.58, 51, 'F', '19910105', 'I''m born in Vratza'),
		('Gosho', 200, 2.00, 120, 'M', '19880105', 'I''m born in Sofia'),
		('Teodora', 200, 1.60, 60, 'F', '19980105', 'I''m born in Varna'),
		('Maria', 200, 1.55, 52, 'F', '20010105', 'I''m born in Plovdiv')

--Problem 8
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

--Problem 13
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

--PROBLEM 14 Rental cars
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

--PROBLEM 19
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--PROBLEM 20
SELECT * FROM Towns
ORDER BY [Name];

SELECT * FROM Departments
ORDER BY [Name];

SELECT * FROM Employees
ORDER BY Salary DESC;

--PROBLEM 21
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

--PROBLEM 23
UPDATE Payments
SET TaxRate = TaxRate * 0.97

SELECT TaxRate FROM Payments

--PROBLEM 24
TRUNCATE TABLE Occupancies

