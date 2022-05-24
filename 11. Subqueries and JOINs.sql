SELECT
	*
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
--that is INNER JOIN only JOIN


SELECT
	*
FROM Employees AS e
LEFT OUTER JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE e.EmployeeID IS NULL


SELECT
	TOP(50)
	e.FirstName,
	e.LastName,
	[Name]
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY FirstName, LastName

