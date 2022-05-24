SELECT 
	DepartmentID,
	SUM(Salary) AS S
FROM Employees
GROUP BY DepartmentID
ORDER BY S DESC

SELECT
	e.DepartmentID,
	COUNT(e.Salary) AS SalaryCount
FROM Employees AS e
GROUP BY e.DepartmentID

SELECT
	Employees.DepartmentID,
	COUNT(Employees.Salary) AS SalaryCount
FROM Employees
GROUP BY Employees.DepartmentID

--
SELECT
	DepartmentID,
	ManagerID,
	MAX(Salary) AS MAXSalary,
	MIN(Salary) AS MINSalary,
	MAX(Salary) - MIN(Salary) AS Diff,
	COUNT(EmployeeID) AS EmployeesCount,
	AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY ManagerID, DepartmentID

USE SoftUni

SELECT
	DepartmentID,
	SUM(Salary) AS TotalSalary
FROM Employees
WHERE DepartmentID IN (1, 3, 15)
GROUP BY DepartmentID
HAVING SUM(Salary) > 30000

SELECT *
FROM Employees


--Pivot
SELECT
	'Average Salary' AS AVGSalary,	[1], [7], [16]
FROM 
	(
		SELECT 
			DepartmentID, 
			Salary
		FROM Employees 
	) AS ab
PIVOT
(
	AVG(Salary)
	FOR DepartmentID IN ([1], [7], [16])
) AS PivotTable

--Normal table
SELECT
	DepartmentID,
	AVG(Salary)
FROM Employees
GROUP BY DepartmentID

