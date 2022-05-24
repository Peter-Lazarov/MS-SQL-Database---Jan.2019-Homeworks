USE SoftUni
--P2
SELECT * FROM Departments

--P3 
SELECT [Name] FROM Departments

--P4
SELECT FirstName, LastName, Salary FROM Employees

--P5
SELECT FirstName, MiddleName, LastName FROM Employees

--P6
SELECT
	FirstName + '.' + LastName + '@softuni.bg' AS 'Full Email Address'
FROM Employees

--P7
SELECT
	DISTINCT
	Salary
FROM Employees

--P8
SELECT
	*
FROM Employees
WHERE JobTitle IN ('Sales Representative')

--P9
SELECT
	FirstName,
	LastName,
	JobTitle
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

--P10
SELECT
	FirstName + ' ' + MiddleName + ' ' + LastName AS 'Full Name'	
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)

SELECT * FROM Employees

--P10 with check for null in columns
SELECT
	CASE WHEN FirstName IS NULL THEN '' ELSE FirstName END + 
	CASE WHEN MiddleName IS NULL THEN '' ELSE ' ' + MiddleName END + 
	CASE WHEN LastName IS NULL THEN '' ELSE ' ' + LastName END  
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)

--P11
SELECT
	FirstName,
	LastName
FROM Employees
WHERE ManagerID IS NULL

--P12
SELECT 
	FirstName,
	LastName,
	Salary
FROM Employees
WHERE Salary >= 50000
ORDER BY Salary DESC

--P13
SELECT 
	TOP(5)
	FirstName,
	LastName
FROM Employees
WHERE Salary >= 50000
ORDER BY Salary DESC

--P14
SELECT 
	FirstName,
	LastName
FROM Employees
WHERE DepartmentID <> 4

--P15
SELECT 
	*
FROM Employees
ORDER BY Salary DESC,
	FirstName ASC,
	LastName DESC,
	MiddleName ASC

GO
--P16
CREATE VIEW V_EmployeesSalaries AS
SELECT 
	FirstName,
	LastName,
	Salary
FROM Employees

GO
SELECT * FROM V_EmployeesSalaries

GO
--P17
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT
	FirstName + ' ' +
	CASE WHEN MiddleName IS NULL THEN '' ELSE MiddleName END + ' ' + 
	LastName
	AS 'Full Name',
	JobTitle  
FROM Employees

GO
DROP VIEW V_EmployeeNameJobTitle

GO
SELECT * FROM V_EmployeeNameJobTitle

--P18
SELECT 
	DISTINCT
	JobTitle	
FROM Employees

--P19
SELECT 
	TOP(10)
	*	
FROM Projects
ORDER BY [StartDate], [Name]

--P20
SELECT 
	TOP(7)
	FirstName,
	LastName,
	HireDate	
FROM Employees
ORDER BY HireDate DESC

--P21
UPDATE Employees
SET Salary = Salary * 1.12
WHERE DepartmentID IN(11, 4, 2, 1)

SELECT Salary FROM Employees

USE SoftUni

--P22
USE [Geography]

SELECT
	DISTINCT
	PeakName
FROM Peaks

--P23
SELECT
	TOP(30)
	[CountryName],
	[Population]
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY [Population] DESC,
CountryName ASC

SELECT * FROM Countries

--P24
SELECT
CountryName,
CountryCode,
CASE WHEN CurrencyCode = 'EUR' THEN 'Euro' ELSE 'Not Euro' END AS 'Currency'
FROM Countries
ORDER BY CountryName

--P25
USE Diablo
SELECT
[Name]
FROM Characters
ORDER BY [Name]

