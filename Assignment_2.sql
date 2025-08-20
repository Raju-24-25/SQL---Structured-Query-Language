--(1) Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick  Chicken Bites’.
--ANSWER ->
CREATE OR ALTER FUNCTION fn_StuffChicken (@RestaurantName VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    RETURN STUFF(@RestaurantName, CHARINDEX('Quick Bites', @RestaurantName), 11, 'Quick Chicken Bites');
END;

--(2) Use the function to display the restaurant name and cuisine type which has the maximum number of rating.
--ANSWER ->
SELECT RestaurantName, CuisinesType
FROM Jomato
WHERE No_of_Rating = (SELECT MAX(No_of_Rating) FROM Jomato);

--(3) Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4start rating, ‘Good’ if it has above 3.5
--    and below 5 star rating, ‘Average’ if it is above 3and below 3.5 and ‘Bad’ if it is below 3 star rating.
--ANSWER ->
CREATE OR ALTER FUNCTION fn_GetRatingStatus (@rating FLOAT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @status VARCHAR(20);

    IF @rating > 4
        SET @status = 'Excellent';
    ELSE IF @rating > 3.5
        SET @status = 'Good';
    ELSE IF @rating > 3
        SET @status = 'Average';
    ELSE
        SET @status = 'Bad';

    RETURN @status;
END;

SELECT RestaurantName, Rating, dbo.fn_GetRatingStatus(Rating) RatingStatus
FROM Jomato;


--(4) Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.
--ANSWER ->
SELECT RestaurantName, Rating,
       CEILING(Rating) Ceiling_Rating,
       FLOOR(Rating) Floor_Rating,
       ABS(Rating) Absolute_Rating,
       GETDATE() CurrentDate,
       YEAR(GETDATE()) Year,
       DATENAME(MONTH, GETDATE()) Month_Name,
       DAY(GETDATE()) Day
FROM Jomato;

--(5) Display the restaurant type and total average cost using rollup.
--ANSWER ->
SELECT RestaurantType, SUM(AverageCost) TotalAvgCost
FROM Jomato
GROUP BY ROLLUP(RestaurantType);
