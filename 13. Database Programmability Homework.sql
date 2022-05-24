USE SoftUni
--P1
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	SELECT
		FirstName,
		LastName
	FROM Employees AS ac
	WHERE Salary >= 35000

EXECUTE usp_GetEmployeesSalaryAbove35000

--P2
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber @GivenSalary DEC(18,4)
AS
	SELECT
		FirstName,
		LastName
	FROM Employees
	WHERE Salary >= @GivenSalary

EXECUTE usp_GetEmployeesSalaryAboveNumber 41800

--P3
CREATE PROCEDURE usp_GetTownsStartingWith @input VARCHAR(10)
AS
	SELECT
		[Name]
	FROM Towns
	WHERE [Name] LIKE @input + '%'

EXECUTE usp_GetTownsStartingWith 'b'

--P4
CREATE PROCEDURE usp_GetEmployeesFromTown @town_name VARCHAR(20)
AS
	SELECT
		e.FirstName,
		e.LastName
	FROM Towns AS t
	JOIN Addresses AS a ON a.TownID = t.TownID
	JOIN Employees AS e ON e.AddressID = a.AddressID
	WHERE t.[Name] = @town_name

EXECUTE usp_GetEmployeesFromTown 'Sofia'

--P5
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @result NVARCHAR(20)
	IF(@salary < 30000)
	SET @result = 'Low'
	ELSE IF(@salary BETWEEN 30000 AND 50000)
	SET @result = 'Average'
	ELSE IF(@salary > 50000)
	SET @result = 'High'
	RETURN @result
END

SELECT
	FirstName,
	LastName,
	Salary,
	dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevel
FROM Employees

USE SoftUni

--P6
CREATE PROCEDURE usp_EmployeesBySalaryLevel @levelOfSalary NVARCHAR(10)
AS
	SELECT 
		FirstName,
		LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @levelOfSalary

EXEC usp_EmployeesBySalaryLevel 'Low'

--P7
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
BEGIN
	DECLARE @count INT
	SET @count = 1

	WHILE(@count <= LEN(@word))
	BEGIN
		DECLARE @currentLetter CHAR(1) = SUBSTRING(@word, @count, 1)
		DECLARE @charIndex INT = CHARINDEX(@currentLetter, @setOfLetters)

		IF(@charIndex = 0)
		BEGIN
			RETURN 0
		END

		SET @count += 1
	
	END
	RETURN 1
END

SELECT dbo.ufn_IsWordComprised('bobr', 'Rob')


--P8
CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT 

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

	UPDATE Departments
	SET ManagerID = NULL
	WHERE DepartmentID = @departmentId

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT 
		COUNT(*)
	FROM Employees
	WHERE DepartmentID = @departmentId

EXECUTE usp_DeleteEmployeesFromDepartment 1

--P9

CREATE PROCEDURE usp_GetHoldersFullName
AS
	SELECT
		FirstName + ' ' + LastName AS [Full Name]
	FROM AccountHolders

EXECUTE usp_GetHoldersFullName

--P10
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan @givenMoneyCount DEC(18,4)
AS
	SELECT
		FirstName,
		LastName
	FROM AccountHolders AS h
	JOIN Accounts AS a ON h.Id = a.AccountHolderId 
	GROUP BY h.Id, FirstName, LastName
	HAVING SUM(Balance) >= @givenMoneyCount
	ORDER BY h.FirstName

GO
--P11
CREATE FUNCTION ufn_CalculateFutureValue(@sum DEC(18, 4), @interestRateForYear FLOAT, @yearNumber INT)
RETURNS DEC(18,4)
BEGIN
	DECLARE @fv DEC(18,4)
	SET @fv = @sum * POWER((1 + @interstRateForYear), @yearNumber)
		
	RETURN @fv
END

GO
SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)

GO
--P12
CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount (@accountId INT, @interestRate FLOAT)
AS
	SELECT
		a.Id AS [Account Id],
		h.FirstName AS [First Name],
		h.LastName AS [Last Name],
		a.Balance AS [Current Balance],
		dbo.ufn_CalculateFutureValue(a.Balance, @interestRate, 5) AS [Balance in 5 years]
	FROM Accounts AS a
	JOIN AccountHolders AS h ON h.Id = a.AccountHolderId
	WHERE a.Id = @accountId

EXECUTE usp_CalculateFutureValueForAccount 1, 0.1


--P13
USE Diablo
CREATE FUNCTION ufn_CashInUsersGames(@gameName VARCHAR(MAX))
RETURNS TABLE
RETURN (
SELECT
	SUM(k.Cash) AS TotalCash
FROM (
	SELECT
	g.[Name],
	ug.Cash,
	ROW_NUMBER() OVER (ORDER BY Cash DESC) AS RowNumber
	FROM Games AS g
	JOIN UsersGames AS ug ON ug.GameId = g.Id
	WHERE g.[Name] = @gameName
) AS k
WHERE k.RowNumber % 2 = 1)

SELECT * FROM dbo.ufn_CashInUsersGames('Love in a mist')

