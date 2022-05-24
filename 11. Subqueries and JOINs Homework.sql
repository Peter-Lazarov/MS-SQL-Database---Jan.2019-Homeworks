--P1
SELECT
	TOP 5
	EmployeeID,
	JobTitle,
	e.AddressID,
	a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
ORDER BY AddressID

--P2
SELECT
	TOP(50)
	e.FirstName,
	e.LastName,
	t.[Name] AS Town,
	AddressText
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY FirstName, LastName

--P3
SELECT
	EmployeeID,
	FirstName,
	LastName,
	d.[Name]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY EmployeeID

--P4
SELECT
	TOP 5
	EmployeeID,
	FirstName,
	Salary,
	d.[Name]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary >= 15000
ORDER BY d.DepartmentID

--P5
SELECT
	TOP 3
	e.EmployeeID,
	FirstName
FROM Employees AS e
LEFT OUTER JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
LEFT OUTER JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE p.[Name] IS NULL
ORDER BY e.EmployeeID

--P6
SELECT
	FirstName,
	LastName,
	HireDate,
	d.[Name]
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE HireDate > '1999/1/1' AND d.[Name] = 'Sales' OR d.[Name] = 'Finance'
ORDER BY HireDate

--P7
SELECT
	TOP 5
	e.EmployeeID,
	FirstName,
	p.[Name]
FROM Employees AS e
LEFT OUTER JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
LEFT OUTER JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE p.StartDate >= '2002/8/13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--P8
SELECT
	e.EmployeeID,
	FirstName,
	CASE WHEN p.StartDate >= '2005/1/1' THEN NULL ELSE p.[Name] END
FROM Employees AS e
	JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
	JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--P9
SELECT
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	mng.FirstName AS [ManagerName]
FROM Employees AS e
JOIN Employees AS mng ON mng.EmployeeID = e.ManagerID
WHERE e.ManagerID IN(3, 7)
ORDER BY e.EmployeeID

--P10
SELECT
	TOP(50)
	e.EmployeeID,
	CASE WHEN e.FirstName IS NULL THEN '' ELSE e.FirstName END + 
	CASE WHEN e.LastName IS NULL THEN '' ELSE ' ' + e.LastName END AS [EmployeeName],
	CASE WHEN mng.FirstName IS NULL THEN '' ELSE mng.FirstName END + 
	CASE WHEN mng.LastName IS NULL THEN '' ELSE ' ' + mng.LastName END AS [ManagerName],
	d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Employees AS mng ON mng.EmployeeID = e.ManagerID
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID

--P11
SELECT 
	TOP 1
	AVG(Salary) AS [MinAverageSalary]
FROM Employees
GROUP BY DepartmentID
ORDER BY AVG(Salary)

--P12
USE [Geography]

SELECT
	c.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
JOIN Peaks AS p ON p.MountainId = mc.MountainId
JOIN Mountains AS m ON m.Id = mc.MountainId
WHERE p.Elevation >= 2835 AND c.CountryCode = 'BG'
ORDER BY p.Elevation DESC

--P13
SELECT
	mc.CountryCode,
	COUNT(mc.CountryCode)
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
WHERE mc.CountryCode IN ('BG', 'RU', 'US')
GROUP BY mc.CountryCode

--P14
SELECT
	TOP 5
	c.CountryName,
	r.RiverName
FROM Countries AS c
LEFT OUTER JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT OUTER JOIN Rivers AS r ON r.Id = cr.RiverId 
WHERE c.ContinentCode IN ('AF')
ORDER BY c.[CountryName] ASC

--P15
SELECT MostUsedCurrency.ContinentCode,
	 MostUsedCurrency.CurrencyCode,
	 MostUsedCurrency.CurrencyUsage
FROM (
	SELECT
		c.ContinentCode,
		c.CurrencyCode,
		COUNT(c.ContinentCode) AS CurrencyUsage,
		DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS [CurrencyRank]
	FROM Countries AS c
	GROUP BY c.ContinentCode, c.CurrencyCode
		HAVING COUNT(c.CurrencyCode) > 1
	) AS MostUsedCurrency
WHERE MostUsedCurrency.CurrencyRank = 1
ORDER BY MostUsedCurrency.ContinentCode, MostUsedCurrency.CurrencyUsage

--P16
SELECT
	COUNT(CountryWithoutMountain.CountryCode) AS [CountryCode]
FROM(
	SELECT
		c.CountryCode,
		m.MountainRange,
		mc.MountainId
	FROM Countries AS c
	LEFT OUTER JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT OUTER JOIN Mountains AS m ON m.Id = mc.MountainId
	WHERE MountainId IS NULL
) AS CountryWithoutMountain

--P17
SELECT
	TOP 5
	c.CountryName,
	MAX(p.Elevation) AS HighestPeakElevation,
	MAX(r.[Length]) AS LongestRiverLength
FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
	LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
	LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName 

--P18
SELECT
	TOP 5
	c.CountryName,
	ISNULL(p.PeakName, '(no highest peak)') AS [Highest Peak Name],
	ISNULL(MAX(p.Elevation),0) AS [Highest Peak Elevation],
	ISNULL(m.MountainRange, '(no mountain)') AS [Mountain]
FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
	LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
GROUP BY c.CountryName, p.PeakName, m.MountainRange
ORDER BY c.CountryName, p.PeakName


