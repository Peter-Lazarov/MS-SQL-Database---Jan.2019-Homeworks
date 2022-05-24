CREATE DATABASE SoftUniBank
USE SoftUniBank

CREATE TABLE Accounts
(
	AccountId INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	[Balance] DEC(18,4)
)

INSERT INTO Accounts ([Name], Balance)
VALUES ('Pesho', 100),
	('Kiril', 50)




CREATE PROCEDURE usp_SendMoney @senderAccountId INT, 
@recieverAccountId INT, @amount DECIMAL(15,2)
AS
BEGIN TRANSACTION
	DECLARE @senderAccount INT = (SELECT AccountId FROM Accounts WHERE AccountId = @senderAccountId)
	DECLARE @recieverAccount INT = (SELECT AccountId FROM Accounts WHERE AccountId = @recieverAccountId)

	IF(@senderAccount IS NULL OR @recieverAccountId IS NULL)
	BEGIN
		ROLLBACK
		RAISERROR('Account doesn''t exist!', 16, 1)
		RETURN
	END

	DECLARE @currentAmount DECIMAL(15,2) = (SELECT Balance FROM Accounts WHERE AccountId = @senderAccountId )
	IF (@currentAmount - @amount < 0)
	BEGIN
		ROLLBACK
		RAISERROR('Insufficient funds!', 16, 2)
		RETURN
	END

	UPDATE Accounts
	SET Balance -= @amount
	WHERE AccountId = @senderAccountId

	UPDATE Accounts
	SET Balance += @amount
	WHERE AccountId = @recieverAccountId
	
	COMMIT

SELECT
*
FROM Accounts

EXEC usp_SendMoney 1, 2, 97


--
CREATE TRIGGER tr_TownsUpdate ON Towns FOR UPDATE
AS
	IF(EXISTS(
		SELECT * FROM inserted
		WHERE [Name] IS NULL OR LEN([Name]) = 0))
	BEGIN
		RAISERROR('Town Name can''not be empty', 16, 1)
		ROLLBACK
		RETURN
	END

UPDATE Towns SET Name = '' WHERE TownID = 1

SELECT * FROM Towns

--
CREATE DATABASE AnotherBank
USE AnotherBank

DROP TABLE Accounts

CREATE TABLE Accounts
(
	Username VARCHAR(10) NOT NULL PRIMARY KEY,
	[Password] VARCHAR(20) NOT NULL,
	Active CHAR(1) NOT NULL DEFAULT 'Y'
)

INSERT INTO Accounts(Username, [Password], Active)
VALUES('Pesho', '123456', 'Y'),
	('Gosho', '123456', 'N')

CREATE TRIGGER tr_AccountDelete ON Accounts
INSTEAD OF DELETE
AS
UPDATE a SET Active = 'N'
	FROM Accounts AS a 
	JOIN DELETED AS d ON d.Username = a.Username
	WHERE a.Active = 'Y'

SELECT * FROM Accounts


DELETE FROM Accounts WHERE Accounts.Username = 'Pesho'

SELECT 
*
FROM Accounts AS a 
	JOIN DELETED AS d ON d.Username = a.Username

--2:40
