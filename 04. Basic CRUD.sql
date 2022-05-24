USE SoftUni

--String concatenation 
SELECT
	FirstName + ' ' + LastName AS 'Full Name',
	JobTitle,
	Salary
FROM Employees

--Distinct
SELECT DISTINCT JobTitle DepartmentID
FROM Employees

SELECT
	DISTINCT
	JobTitle
FROM Employees
WHERE DepartmentID = 1

--Different - Razlichno 
SELECT 
	LastName
FROM Employees
WHERE ManagerID <> 3 and ManagerID <> 4

--BETWEEN
SELECT 
	LastName,
	Salary
FROM Employees
WHERE Salary BETWEEN 20000 AND 22000

--IN/NOT IN
SELECT 
	FirstName,
	LastName,
	ManagerID
FROM Employees
WHERE ManagerID IN (109, 3 ,16) --Some of this values

--CHECK FOR NULL
SELECT 
	LastName,
	ManagerID
FROM Employees
WHERE ManagerID IS NULL -- IS NOT NULL, but = null not work

--ORDER BY
SELECT 
	LastName,
	HireDate
FROM Employees
ORDER BY HireDate DESC

USE [Geography]

--Select top rows
SELECT
	TOP(2) *
FROM Peaks
ORDER BY Elevation DESC

--CASE WHAN 
--P10 with check for null in columns
SELECT
	CASE WHEN FirstName IS NULL THEN '' ELSE FirstName END + 
	CASE WHEN MiddleName IS NULL THEN '' ELSE ' ' + MiddleName END + 
	CASE WHEN LastName IS NULL THEN '' ELSE ' ' + LastName END  
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)


--UPDATE AND GETDATE
UPDATE Projects
SET EndDate = GETDATE()
WHERE EndData IS NULL

UPDATE Projects
SET EndDate = '2017-01-23'
WHERE EndDate IS NULL

--ISO DATE FORMATE - SMALLDATETIME is minute precision, must be DATETIME OR DATETIME2
UPDATE Projects
SET EndDate = '2019-01-16T10:23:32.989'
WHERE EndDate IS NULL

