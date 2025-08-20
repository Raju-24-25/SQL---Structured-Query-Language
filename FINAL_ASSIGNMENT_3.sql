-- (1) Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
--ANSWER ->
CREATE OR ALTER PROCEDURE Get_Bookable_Restaurants
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM Jomato
    WHERE TableBooking IS NOT NULL AND TableBooking <> 0;
END;

EXECUTE Get_Bookable_Restaurants;

-- (2) Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
--ANSWER ->
BEGIN TRANSACTION;

UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

SELECT * FROM Jomato WHERE CuisinesType = 'Cafeteria';

ROLLBACK;

-- (3) Generate a row number column and find the top 5 areas with the highest rating of restaurants.
--ANSWER ->
SELECT Area, Rating, 
ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Rating DESC) RN
FROM Jomato;

SELECT TOP 5 Area, AVG(Rating) Avg_Rating
FROM Jomato
GROUP BY Area
ORDER BY Avg_Rating DESC;

-- (4) Use the while loop to display the 1 to 50.
--ANSWER ->
DECLARE @a INT = 1;

WHILE @a <= 50
BEGIN
    PRINT @a;
    SET @a = @a + 1;
END;

-- (5) Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
--ANSWER ->
CREATE VIEW Top_Rated_Restaurants 
AS
SELECT TOP 5 RestaurantName, Rating
FROM Jomato
ORDER BY Rating DESC;

SELECT * FROM Top_Rated_Restaurants;

-- (6) Create a trigger that give an message whenever a new record is inserted.
--ANSWER ->
CREATE OR ALTER TRIGGER T1
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT 'New restaurant record inserted into Jomato table.';
END;
