--Concatenation

SELECT CONCAT(FirstName, ' ', LastName) AS [Full Name]
FROM Employee
--CONCAT replaces NULL values with empty string

--With separator
SELECT CONCAT_WS(' ', FirstName, LastName) AS [Full Name]
FROM Employee

--Substring
SUBSTRING('SoftUni', 5, 3) --indexes start from 1

SELECT AtticleId, Author, Content,
	SUBSTRING(Content, 1, 200) + '...' AS Summary
FROM Articles


--Replace
REPLACE('SoftUni', 'Soft', 'Hard')

SELECT 
	REPLACE('SoftUni', 'Soft', 'Hard') AS Title
FROM Articles

USE Demo

SELECT * FROM Customers

SELECT
	CustomerID,
	FirstName,
	LastName,
	LEFT(PaymentNumber, 6) + '**********'
FROM Customers

SELECT
	CustomerID,
	FirstName,
	LastName,
	CONCAT(LEFT(PaymentNumber, 6), REPLICATE('*', LEN(PaymentNumber) - 6)) AS PaymentNumber
FROM Customers


CHARINDEX(Pattern, String, [StartIndex]) -- Start from 1

STUFF(String, StartIndex, Length, Substring) -- Length is how many characters to delete

SELECT FORMAT(CAST('2019-01-21' AS DATE), 'D', 'bg-BG')

SELECT ABS(-90)


