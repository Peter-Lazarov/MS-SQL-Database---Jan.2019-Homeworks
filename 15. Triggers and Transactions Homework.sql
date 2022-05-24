--P14
CREATE TABLE Logs(
	LogId INT PRIMARY KEY IDENTITY,
	AccountId INT FOREIGN KEY REFERENCES Accounts(Id),
	OldSum DECIMAL(15,2),
	NewSum DECIMAL(15,2)
)


CREATE TRIGGER tr_InsertAccountInfo ON Accounts FOR UPDATE
AS
DECLARE @newSum DECIMAL(15,2) = (SELECT Balance FROM inserted)
DECLARE @oldSum DECIMAL(15,2) = (SELECT Balance FROM deleted)
DECLARE @accountId INT = (SELECT Id FROM inserted)

INSERT INTO Logs (AccountId, NewSum, OldSum)
VALUES (@accountId, @newSum, @oldSum)

UPDATE Accounts
SET Balance += 10
WHERE Id = 1

SELECT
*
FROM Accounts WHERE Id = 1

SELECT
*
FROM Logs


--P15
CREATE TABLE NotificationEmails
(
	Id INT PRIMARY KEY IDENTITY,
	Recipient INT FOREIGN KEY REFERENCES Accounts(Id),
	[Subject] VARCHAR(50),
	Body VARCHAR(MAX)
)


CREATE TRIGGER tr_LogEmail ON Logs FOR INSERT
AS
DECLARE @accountId INT = (SELECT TOP(1) AccountId FROM inserted)
DECLARE @oldSum DECIMAL(15,2) = (SELECT TOP(1) OldSum FROM inserted)
DECLARE @newSum DECIMAL(15,2) = (SELECT TOP(1) NewSum FROM inserted)

INSERT INTO NotificationEmails (Recipient, [Subject], Body)
VALUES(
	@accountId, 'Balance change for account: ' + CAST(@accountId AS VARCHAR(20)), 'On ' + CONVERT(varchar(30), GETDATE(), 103) + ' your balance was changed from ' + CAST(@oldSum AS VARCHAR(20)) + ' to ' + CAST(@newSum AS VARCHAR(20))
)

UPDATE Accounts
SET Balance +=100
WHERE Id = 1

SELECT
*
FROM Accounts WHERE Id = 1

SELECT
*
FROM Logs

SELECT
*
FROM NotificationEmails

--P16
CREATE PROCEDURE usp_DepositMoney @accountId INT, @moneyAmount DECIMAL(15,4)
AS
BEGIN TRANSACTION
DECLARE @account INT = (SELECT Id FROM Accounts WHERE Id = @accountId)

IF (@account IS NULL)
BEGIN 
	ROLLBACK
	RAISERROR('Invalid account id!', 16, 1)
	RETURN
END

IF (@moneyAmount < 0)
BEGIN
	ROLLBACK
	RAISERROR('Negative amount!', 16, 1)
	RETURN
END

UPDATE Accounts
SET Balance += @moneyAmount
WHERE Id = @accountId
COMMIT

EXECUTE usp_DepositMoney 1, 247.78
SELECT * FROM Accounts WHERE Id = 1


--P17
CREATE PROCEDURE usp_WithdrawMoney @accountId INT, @moneyAmount DECIMAL(15,4)
AS
BEGIN TRANSACTION
DECLARE @account INT = (SELECT Id FROM Accounts WHERE Id = @accountId)
DECLARE @balance INT = (SELECT Balance FROM Accounts WHERE Id = @accountId)

IF (@account IS NULL)
BEGIN 
	ROLLBACK
	RAISERROR('Invalid account id!', 16, 1)
	RETURN
END

IF (@moneyAmount < 0)
BEGIN
	ROLLBACK
	RAISERROR('Negative amount!', 16, 1)
	RETURN
END

IF (@balance < @moneyAmount)
BEGIN
	ROLLBACK
	RAISERROR('Insufficient money', 16, 1)
	RETURN
END

UPDATE Accounts
SET Balance -= @moneyAmount
WHERE Id = @accountId
COMMIT

EXECUTE usp_DepositMoney 1, 247.78
SELECT * FROM Accounts WHERE Id = 1


--P18
CREATE PROCEDURE usp_TransferMoney(@senderId INT, @receiverId INT, @amount DECIMAL(15,4))
AS
BEGIN TRANSACTION
EXECUTE usp_WithdrawMoney @senderId, @amount
EXECUTE usp_DepositMoney @receiverId, @amount
COMMIT

SELECT * FROM Accounts WHERE Id = 1 OR Id = 2
EXECUTE usp_TransferMoney 1, 2, 100


--P20
DECLARE @userGameId INT = (SELECT Id FROM UsersGames WHERE UserId = 9 AND GameId = 87)
DECLARE @stamatCash DECIMAL(15,2) = (SELECT Cash FROM UsersGames WHERE Id = @userGameId)
DECLARE @itemsPrice DECIMAL(15,2) = (SELECT SUM(Price) AS TotalPrice FROM Items WHERE MinLevel BETWEEN 11 AND 12)

IF (@stamatCash >= @itemsPrice)
BEGIN
	BEGIN TRANSACTION
	UPDATE UsersGames
	SET Cash -= @itemsPrice
	WHERE Id = @userGameId

	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT Id, @userGameId FROM Items WHERE MinLevel BETWEEN 11 AND 12
	COMMIT
END

SET @stamatCash = (SELECT Cash FROM UsersGames WHERE Id = @userGameId)
SET @itemsPrice = (SELECT SUM(Price) AS TotalPrice FROM Items WHERE MinLevel BETWEEN 19 AND 21)

IF (@stamatCash >= @itemsPrice)
BEGIN
	BEGIN TRANSACTION
	UPDATE UsersGames
	SET Cash -= @itemsPrice
	WHERE Id = @userGameId

	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT Id, @userGameId FROM Items WHERE MinLevel BETWEEN 19 AND 21
	COMMIT
END

SELECT 
	i.[Name]
FROM Users AS u
JOIN UsersGames AS ug ON ug.UserId = u.Id
JOIN Games AS g ON g.Id = ug.GameId
JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
JOIN Items AS i ON i.Id = ugi.ItemId
WHERE u.Username = 'Stamat' AND g.[Name] = 'Safflower'
ORDER BY i.[Name]

--P21
USE SoftUni

CREATE PROCEDURE usp_AssignProject(@employeeId INT, @projectID INT)
AS
BEGIN TRANSACTION
DECLARE @employee INT = (SELECT EmployeeID FROM Employees WHERE EmployeeID = @employeeId)
DECLARE @project INT = (SELECT ProjectID FROM Projects WHERE ProjectID = @projectID)

IF(@employee IS NULL OR @project IS NULL)
BEGIN
	ROLLBACK
	RAISERROR('Invalid employee id or project id!', 16, 1)
	RETURN
END

DECLARE @employeeProjects INT = (SELECT COUNT(*) FROM EmployeesProjects WHERE EmployeeID = @employeeId)
IF(@employeeProjects >=3)
BEGIN
	ROLLBACK
	RAISERROR('The employee has too many projects!', 16, 2)
	RETURN
END

INSERT INTO EmployeesProjects (EmployeeID, ProjectID)
VALUES (@employeeId, @projectID)
COMMIT

SELECT * FROM EmployeesProjects WHERE EmployeeID = 2
EXECUTE usp_AssignProject 2, 1

--P22
CREATE TABLE Deleted_Employees
(
	EmployeeId INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	MiddleName NVARCHAR(20) NOT NULL,
	JobTitle NVARCHAR(20) NOT NULL,
	DepartmentId INT,
	Salary DEC(10, 2)
)


CREATE TRIGGER tr_Deleted_Employees ON Employees FOR DELETE
AS
INSERT INTO Deleted_Employees ( FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary)
SELECT FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary FROM deleted




