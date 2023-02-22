-- Objective is to find out :
--How many times have I ordered from each restaurant?
--Which months had the highest number of orders?
--Which days of the week had the highest total number of orders?
--When am I ordering food?
--Which food items are the most frequently ordered?



--Let's look at the data without the null values and extracting the year, month, and day from Date_Delivered

SELECT Restaurant_ID, Date_Delivered, Time_Delivered 
FROM dbo.Restaurant_Data$ 
WHERE Restaurant_ID IS NOT NULL


--Counting the order frequency by restaurant, naming the new column, and having it ordered from most to least. Pretending I'm surprised at the results o_O

SELECT Restaurant_ID, COUNT(*) AS Times_Ordered
FROM Restaurant_Data$
GROUP BY Restaurant_ID
ORDER BY Times_Ordered DESC

--Counting which months had the highest orders

SELECT DATENAME(month,Date_Delivered) AS Month_Delivered,
COUNT(*) AS Count
FROM dbo.Restaurant_Data$
GROUP BY DATENAME(month,Date_Delivered)
Order BY Count DESC



--Converting Date_Delivered column into a new column showing the weekday the order was placed and how frequently I ordered on that weekday

SELECT DATENAME(dw,Date_Delivered) AS Weekday, COUNT(*) AS Number_Of_Orders
FROM dbo.Restaurant_Data$
GROUP BY DATENAME(dw, Date_Delivered)
ORDER BY Number_Of_Orders DESC

--Seeing how many times I received food orders after 2PM (70% of total orders were after 2PM!)

SELECT Time_Delivered
FROM dbo.Restaurant_Data$
WHERE Time_Delivered > '14:00:00:000'

--How many of each food item did I order over the past 2 years?

SELECT Items_Ordered, COUNT(*) AS How_Many_Noms
FROM dbo.['Corrected Comprehensive Data$']
GROUP BY Items_Ordered
ORDER BY How_Many_Noms DESC
