--P1
USE SoftUni

SELECT 
	FirstName,
	LastName
FROM Employees
WHERE LEFT(FirstName, 2) = 'SA'

--P2
SELECT 
	FirstName,
	LastName  
FROM Employees  
WHERE LastName LIKE '%ei%' 

--P3
SELECT 
	FirstName
FROM Employees  
WHERE Employees.DepartmentID IN (3, 10) 
	AND YEAR(Employees.HireDate) BETWEEN 1995 AND 2005

--P4
SELECT
	FirstName,
	LastName
FROM Employees
WHERE Employees.JobTitle NOT LIKE '%engineer%'

--P5
SELECT
	Towns.[Name]
FROM Towns
WHERE LEN(Towns.[Name]) IN (5,6)
ORDER BY Towns.[Name]

--P6
SELECT
	Towns.TownID,
	Towns.[Name]
FROM Towns
WHERE LEFT(Towns.[Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY Towns.[Name]

--P7
SELECT
	Towns.TownID,
	Towns.[Name]
FROM Towns
WHERE LEFT(Towns.[Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY Towns.[Name]

--P8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT 
	FirstName,
	LastName
FROM Employees  
WHERE YEAR(Employees.HireDate) > 2000

SELECT * FROM V_EmployeesHiredAfter2000

--P9
SELECT 
	FirstName,
	LastName
FROM Employees  
WHERE LEN(Employees.LastName) = 5

--P10
SELECT
	EmployeeID,
	FirstName,
	LastName,
	Salary,
	DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeId) AS Rank
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--P11
SELECT *
FROM (
	SELECT
		EmployeeID,
		FirstName,
		LastName,
		Salary,
		DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeId) AS Rank
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
) AS Subquery
WHERE Subquery.Rank = 2
ORDER BY Salary DESC

--P12
USE [Geography]

SELECT 
	CountryName,
	IsoCode
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

SELECT
	CountryName,
	IsoCode
FROM Countries
WHERE LEN(CountryName) - LEN(REPLACE(CountryName, 'a', '')) > 2
ORDER BY IsoCode

--P13
SELECT
	PeakName,
	RiverName,
	LOWER(PeakName + SUBSTRING(RiverName,2 , LEN(RiverName))) AS Mix
FROM Peaks, Rivers
WHERE RIGHT(PeakName,1) = LEFT(RiverName,1)
ORDER BY Mix

--P14
USE Diablo

SELECT
	TOP(50)
	[Name],
	FORMAT([Start], 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE YEAR([Start]) >= 2011 AND YEAR([Start]) <= 2012
ORDER BY [Start], [Name]

--P15
SELECT
	Username,
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS 'Email Provider'
FROM Users
ORDER BY [Email Provider], Username

--P16
SELECT
	Username,
	IpAddress
FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username

--P17
SELECT
	[Name] AS 'Game',
	CASE
	WHEN DATEPART(HOUR,[Start]) >= 0 AND DATEPART(HOUR,[Start]) < 12 THEN 'Morning'
	WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
	WHEN DATEPART(HOUR, [Start]) >= 18 AND DATEPART(HOUR, [Start]) < 24 THEN 'Evening'
	END AS 'Part of the Day',
	CASE
	WHEN Duration >= 0 AND Duration <= 3 THEN 'Extra Short'
	WHEN Duration >= 4 AND Duration <= 6 THEN 'Short'
	WHEN Duration > 6 THEN 'Long'
	WHEN Duration IS NULL THEN 'Extra Long'
	END AS 'Duration'
FROM Games
ORDER BY [Name], Duration, [Part of the Day]


SELECT
	*
FROM Games

CREATE TABLE [Orders Table](
	Id INT PRIMARY KEY IDENTITY,
	ProductName NVARCHAR(50),
	OrderDate DATETIME
)

INSERT INTO [Orders Table](ProductName, OrderDate)
VALUES ('Butter', '2016-09-19 00:00:00.000'),
	('Milk', '2016-09-30 00:00:00.000'),
	('Cheese', '2016-09-04 00:00:00.000'),
	('Bread', '2015-12-20 00:00:00.000'),
	('Tomatoes', '2015-12-30 00:00:00.000')

SELECT
	ProductName,
	OrderDate,
	DATEADD(DAY, 3, OrderDate) AS 'Pay Due',
	DATEADD(MONTH, 1, OrderDate) AS 'Deliver Due'
FROM [Orders Table]

--1:41
--2:34:00
