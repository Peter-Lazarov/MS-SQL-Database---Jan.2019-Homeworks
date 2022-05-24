--Scalar function

CREATE FUNCTION udf_ProjectDurationWeeks(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @projectDuration INT
	IF(@EndDate IS NULL)
	BEGIN
		SET @EndDate = GETDATE()
	END
	SET @projectDuration = DATEDIFF(WEEK, @StartDate, @EndDate)
	RETURN @projectDuration
END

SELECT
	[Name],
	dbo.udf_ProjectDurationWeeks(StartDate, EndDate) AS Duration
FROM Projects

--inline table-valued function (TVF)

GO
CREATE FUNCTION udf_AverageSalaryByDepartment()
RETURNS TABLE
AS
RETURN
(
	SELECT d.[Name], AVG(e.Salary) AS AverageSalary
	FROM Departments AS d
	JOIN Employees AS e ON d.DepartmentID = e.DepartmentID
	GROUP BY d.DepartmentID, d.[Name]
)
SELECT
	*
FROM dbo.udf_AverageSalaryByDepartment()

--multi-statement table-valued function (MSTVF)
CREATE FUNCTION udf_EmployeeListByDepartment(@depName nvarchar(20))
RETURNS @result TABLE(   
    FirstName nvarchar(50) NOT NULL,  
    LastName nvarchar(50) NOT NULL,  
    DepartmentName nvarchar(20) NOT NULL) AS
BEGIN
    WITH Employees_CTE (FirstName, LastName, DepartmentName)
    AS(
        SELECT e.FirstName, e.LastName, d.[Name]
        FROM Employees AS e 
        LEFT JOIN Departments AS d ON d.DepartmentID = e.DepartmentID)

    INSERT INTO @result SELECT FirstName, LastName, DepartmentName 
      FROM Employees_CTE WHERE DepartmentName = @depName
    RETURN
END

SELECT 
	[ProjectID],
    [StartDate],
    [EndDate],
    dbo.udf_ProjectDurationWeeks([StartDate],[EndDate]) AS ProjectWeeks
FROM [SoftUni].[dbo].[Projects]

SELECT * FROM dbo.udf_EmployeeListByDepartment('Production')


--
CREATE FUNCTION udf_GetSalaryLevel(@Salary MONEY)
RETURNS varchar(10)
AS
BEGIN
	DECLARE @result varchar(10)
	IF(@Salary < 30000)
		SET @result = 'Low'
	ELSE IF(@Salary <= 50000)
		SET @result = 'Average'
	ELSE
		SET @result = 'High'
	RETURN @result
END

SELECT
	FirstName,
	LastName,
	Salary,
	dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel 
FROM Employees


--Procedure
USE SoftUni
CREATE PROCEDURE usp_GetSeniorEmployees
AS
	SELECT
	*
	FROM Employees
	WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 18


EXEC dbo.usp_GetSeniorEmployees

--check if any object depend on procedure
EXEC sp_depends 'usp_GetSeniorEmployees'

--store procedure with parameters
CREATE OR ALTER PROCEDURE usp_GetSeniorEmployees @YearsOfService INT = 5
AS
	SELECT
		FirstName,
		LastName,
		DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
	FROM Employees
	WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > @YearsOfService
	ORDER BY HireDate

EXECUTE usp_GetSeniorEmployees

EXECUTE usp_GetSeniorEmployees 19



--
CREATE PROCEDURE usp_AddNumbers
	@FirstNumber INT,
	@SecondNumber INT,
	@Result INT OUT
AS
	SET @Result = @FirstNumber + @SecondNumber



DECLARE @res INT
EXECUTE usp_AddNumbers 8, 12, @res OUT
SELECT @res AS Result
