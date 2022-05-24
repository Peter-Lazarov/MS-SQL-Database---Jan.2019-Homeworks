USE [Geography]

SELECT * FROM Mountains
SELECT * FROM Peaks
SELECT * FROM MountainsCountries
SELECT * FROM Countries

SELECT 
	MountainRange,
	PeakName,
	Elevation
FROM Mountains AS m
JOIN Peaks AS p ON m.Id = p.MountainId
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC

--

SELECT 
	c.CountryName,
	MountainRange,
	PeakName,
	Elevation
FROM Mountains AS m
JOIN Peaks AS p ON m.Id = p.MountainId
JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
JOIN Countries AS c ON mc.CountryCode = c.CountryCode
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC


CREATE DATABASE ForTry

CREATE TABLE Drivers(
	DriverID INT PRIMARY KEY,
	DriverName VARCHAR(50)
)

CREATE TABLE Cars(
	CarID INT PRIMARY KEY,
	DriverID INT,
	CONSTRAINT FK_Car_Driver FOREIGN KEY(DriverID)
	REFERENCES Drivers(DriverID)
)

SELECT
	*
FROM Cars AS c
JOIN Drivers AS d ON c.DriverID = d.DriverID

ALTER TABLE Cars DROP CONSTRAINT FK_Car_Driver

ALTER TABLE Cars ADD CONSTRAINT FK_Car_Driver FOREIGN KEY(DriverID)
REFERENCES Drivers(DriverID) ON DELETE CASCADE

DELETE FROM Drivers
WHERE DriverID = 3

SELECT * FROM Cars

