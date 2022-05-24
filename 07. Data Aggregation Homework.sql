USE Gringotts

--P1
SELECT 
	COUNT(*) AS [Count]
FROM WizzardDeposits

--P2
SELECT
	MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits

--P3
SELECT
	DepositGroup,
	MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits
GROUP BY DepositGroup

--P4
SELECT
	TOP(2)
	DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

--P5
SELECT
	DepositGroup,
	SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup

--P6
--Select all deposit groups and their total deposit sums but only for the wizards who have their 
--magic wands crafted by Ollivander family.
SELECT
	DepositGroup,
	SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
HAVING MagicWandCreator = 'Ollivander family'

--P7
SELECT
	DepositGroup,
	SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
HAVING MagicWandCreator = 'Ollivander family' AND SUM(DepositAmount) < 150000
ORDER BY SUM(DepositAmount) DESC

--P8
SELECT
	DepositGroup,
	MagicWandCreator,
	MIN(DepositCharge) AS [MinDepositCharge]
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--P9
SELECT
	CASE
	WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
	END AS AgeGroup,
	COUNT(*) AS [Count]
	FROM WizzardDeposits
	GROUP BY 
	(
		CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		ELSE '[61+]'
		END
	)

SELECT	AgeGroupTable.AgeGroup,
	COUNT(AgeGroupTable.AgeGroup) AS [WizardCount]
FROM (
	SELECT
		CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		ELSE '[61+]'
		END AS AgeGroup
	FROM WizzardDeposits
) AS AgeGroupTable
GROUP BY AgeGroupTable.AgeGroup

SELECT
	*
FROM WizzardDeposits

USE Gringotts

--P10
SELECT 
	LEFT(FirstName, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)

--P11
SELECT 
	DepositGroup,
	IsDepositExpired,
	AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE YEAR(DepositStartDate) > 1984
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--P12
SELECT 
	wd.FirstName,
	wd.DepositAmount,
	(
		SELECT 
			wd.DepositAmount
		FROM WizzardDeposits AS w 
		WHERE w.Id = wd.Id + 1
	) AS NextRecord
FROM WizzardDeposits AS wd

SELECT SUM(k.Diff) AS SumDifference
FROM(
	SELECT 
	wd.DepositAmount - (
		SELECT 
			w.DepositAmount 
		FROM WizzardDeposits AS w 
		WHERE w.Id = wd.Id + 1
	) AS Diff
	FROM WizzardDeposits AS wd
) AS k

--P13
USE SoftUni

SELECT
	DepartmentID,
	SUM(Salary) AS TotalSum
FROM Employees
GROUP BY DepartmentID

--P14
SELECT
	DepartmentID,
	MIN(Salary) AS TotalSum
FROM Employees
WHERE DepartmentID IN (2, 5, 7) AND HireDate > '01/01/2000'
GROUP BY DepartmentID

--P15
SELECT
	*
	INTO NewEmployeeTable
FROM Employees
WHERE Salary > 30000

DELETE FROM NewEmployeeTable
WHERE ManagerID = 42

UPDATE NewEmployeeTable
SET Salary = Salary + 5000
WHERE DepartmentID = 1

SELECT 
	DepartmentID,
	AVG(Salary) AS [AverageSalary]
FROM NewEmployeeTable
GROUP BY DepartmentID

--P16
SELECT
	DepartmentID,
	MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--P17
SELECT
	COUNT(*)
FROM Employees
WHERE ManagerID IS NULL

--P18
SELECT
	DISTINCT 
	k.DepartmentID,
	k.Salary
FROM (
		SELECT
			DepartmentID,
			Salary,
			DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
		FROM Employees 
	) AS k
WHERE k.SalaryRank = 3

--P19
SELECT
	TOP(10)
	FirstName,
	LastName,
	DepartmentID
FROM Employees AS e
WHERE Salary > (SELECT AVG(Salary) FROM Employees AS em WHERE em.DepartmentID = e.DepartmentID)
ORDER BY DepartmentID

