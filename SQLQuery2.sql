CREATE DATABASE Meal

USE Meal

CREATE TABLE Meals(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(30),
Price DECIMAL)

CREATE TABLE Tables(
Id INT PRIMARY KEY IDENTITY,
[No] NVARCHAR(30))

CREATE TABLE Orders(
Id INT PRIMARY KEY IDENTITY,
[Date] DATETIME,
MealId INT,
TableId INT, 
FOREIGN KEY (MealId) REFERENCES Meals(Id),
FOREIGN KEY (TableId) REFERENCES Tables(Id))

INSERT INTO Tables(No)
VALUES(1)
INSERT INTO Tables(No)
VALUES(2)
INSERT INTO Tables(No)
VALUES(3)

INSERT INTO Meals([Name],Price)
Values('Meal3',50),
('Meal4',50)

INSERT INTO Orders ([Date], MealId, TableId)
VALUES 
('2025-06-01', 1, 2),
('2025-06-05', 3, 1),
('2025-06-18', 1, 1);


SELECT  t.*, (SELECT COUNT(o.Id) FROM Orders o WHERE o.TableId = t.Id) AS OrderCount FROM Tables t;

SELECT m.*,(SELECT COUNT(*) FROM Orders o WHERE o.Id=m.Id ) AS OrderCount FROM Meals m

SELECT o.*,m.Name FROM Orders o
JOIN Meals m ON m.Id = o.MealId

SELECT o.*,m.Name,t.No FROM Orders o
JOIN Meals m ON m.Id = o.MealId
JOIN Tables t ON t.Id = o.TableId

SELECT t.*,SUM(m.Price) AS TotalPrice FROM Tables t
JOIN Orders o ON o.TableId = t.Id
JOIN Meals m ON m.Id=o.MealId
GROUP BY t.Id, t.No

SELECT t.*,(DATEDIFF(HOUR,MIN(o.Date),MAX(o.Date))) AS DIFFERENCE FROM Tables t
JOIN Orders o ON o.TableId=t.Id
WHERE t.Id =1
GROUP BY t.Id,t.No

SELECT * FROM Orders
WHERE [Date] < DATEADD(MINUTE, -30, GETDATE());

SELECT t.* FROM Tables t
JOIN Orders o ON o.TableId=t.Id
WHERE o.TableId IS NULL

SELECT t.*FROM Tables t
JOIN Orders o ON o.TableId = t.Id AND o.[Date] >= DATEADD(MINUTE, -60, GETDATE())  
WhERE o.Id IS NULL;