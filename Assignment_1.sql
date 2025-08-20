CREATE DATABASE Assignment_1
USE Assignment_1
-- Salesman table creation
 CREATE TABLE Salesman (
 SalesmanId INT,
 Name VARCHAR(255),
 Commission DECIMAL(10, 2),
 City VARCHAR(255),
 Age INT
 );
 -- Salesman table record insertion
 INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
 VALUES
 (101, 'Joe', 50, 'California', 17),
 (102, 'Simon', 75, 'Texas', 25),
 (103, 'Jessie', 105, 'Florida', 35),
 (104, 'Danny', 100, 'Texas', 22),
 (105, 'Lia', 65, 'New Jersey', 30);
 -- Customer table creation
  CREATE TABLE Customer (
 SalesmanId INT,
 CustomerId INT,
 CustomerName VARCHAR(255),
 PurchaseAmount INT,
 );
 -- Customer table record insertion
 INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
 VALUES
 (101, 2345, 'Andrew', 550),
 (103, 1575, 'Lucky', 4500),
 (104, 2345, 'Andrew', 4000),
 (107, 3747, 'Remona', 2700),
 (110, 4004, 'Julia', 4545);
 -- Orders table Creation
 CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount
 money)
 -- Orders table record insertion
 INSERT INTO Orders Values
 (5001,2345,101,'2021-07-04',550),
 (5003,1234,105,'2022-02-15',1500)

 --(1) Insert a new record in your Orders table.
 --ANSWER ->
  INSERT INTO Orders (OrderId, CustomerId, SalesmanId, Orderdate, Amount)
  Values(5005,2435,103,'2021-07-08',1450);
 --(2) Add Primary key constraint for SalesmanId column in Salesman table. Add default 
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId 
--column in Customer table. Add not null constraint in Customer_name column for the 
--Customer table.
--ANSWER ->
 ALTER TABLE Salesman
 ALTER COLUMN SalesmanId INT NOT NULL;

 ALTER TABLE Salesman
 ADD CONSTRAINT PK_SalesmanId PRIMARY KEY (SalesmanId);
 
 ALTER TABLE Salesman
 ADD CONSTRAINT DF_Selsman_City DEFAULT 'Unknown' FOR City;

 DELETE FROM Customer
 WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);
 ALTER TABLE Customer
 ADD CONSTRAINT FK_Customer_Salesman FOREIGN KEY (SalesmanId) REFERENCES Salesman (SalesmanId);

 ALTER TABLE Customer
 ALTER COLUMN CustomerName VARCHAR(100) NOT NULL;
--(3) Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase 
--amount value greater than 500.
--ANSWER ->
 SELECT CustomerName, PurchaseAmount FROM Customer
 WHERE CustomerName LIKE '%N' AND PurchaseAmount > 500;

--(4) Using SET operators, retrieve the first result with unique SalesmanId values from two 
--tables, and the other result containing SalesmanId with duplicates from two tables. 
--ANSWER ->
 SELECT SalesmanId FROM Salesman
 UNION
 SELECT SalesmanId FROM Customer;

 SELECT SalesmanId FROM Salesman
 INTERSECT
 SELECT SalesmanId FROM Customer;

--(5) Display the below columns which has the matching data. 
--Orderdate, Salesman Name, Customer Name, Commission, and City which has the 
--range of Purchase Amount between 500 to 1500.
--ANSWER ->
 SELECT O.OrderDate, S.Name AS SalesmanName, C.CustomerName AS CustomerName, S.Commission, S.City
FROM Orders O
INNER JOIN Salesman S ON O.SalesmanId = s.SalesmanId
INNER JOIN Customer C ON O.CustomerId = c.CustomerId
WHERE C.PurchaseAmount BETWEEN 500 AND 1500;

--(6) Using right join fetch all the results from Salesman and Orders table. 
--ANSWER ->
 SELECT S.*, O.*
 FROM Salesman S RIGHT JOIN Orders O
 ON (S.SalesmanId = O.SalesmanId)
