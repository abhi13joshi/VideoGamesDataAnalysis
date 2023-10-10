/* View full table */
SELECT * FROM dbo.Video_Games;

/*View data types of the columns in the video games table*/
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Video_Games';

/*View which gaming console platform produced the most games*/
SELECT 
	Platform, 
	Count(*) AS Total 
From 
	Video_Games
GROUP BY 
	Platform
ORDER BY 
	Count(*) DESC;

/*View which genre produced the most games*/
SELECT 
	Genre, 
	Count(*) AS Total 
From 
	Video_Games
GROUP BY 
	Genre
ORDER BY 
	Count(*) DESC;

/*View number of game releases by year*/
SELECT 
	Year_of_Release, 
	Count(*) AS Total_Games
From 
	Video_Games
GROUP BY 
	Year_of_Release
ORDER BY 
	Year_of_Release ASC;

/*View which publisher produced the most games*/
SELECT 
	Publisher, 
	Count(*) AS Total 
From 
	Video_Games
GROUP BY 
	Publisher
ORDER BY 
	Count(*) DESC;

/*Count the number of game publishers */
SELECT 
	Count(DISTINCT Publisher) AS Num_of_Publisher
From 
	Video_Games;

/*Execute stored procedure that calculates sales by region and genre*/
EXEC CalculateSalesByRegionAndGenre;

/*View top 10 video games in sales in North America*/
SELECT TOP 10 
	Name, 
	NA_Sales * 1000000 AS NA_Sales, 
	Platform, 
	Year_of_Release, 
	Genre, 
	Publisher
FROM 
	Video_Games
ORDER BY 
	NA_Sales DESC;

/*View top 10 video games in sales in Japan*/
SELECT TOP 10 
	Name, 
	JP_Sales * 1000000 AS JP_Sales, 
	Platform, 
	Year_of_Release, 
	Genre, 
	Publisher
FROM 
	Video_Games
ORDER BY 
	JP_Sales DESC;

/*View top 10 video games in sales in Europe*/
SELECT TOP 10 
	Name, 
	EU_Sales * 1000000 AS EU_Sales, 
	Platform, 
	Year_of_Release, 
	Genre, 
	Publisher
FROM 
	Video_Games
ORDER BY 
	EU_Sales DESC;

/*View top 10 video games in sales globally*/
SELECT TOP 10 
	Name, 
	Global_Sales * 1000000 AS Global_Sales, 
	Platform, 
	Year_of_Release, 
	Genre, 
	Publisher
FROM 
	Video_Games
ORDER BY 
	Global_Sales DESC;

/*Use the ROW_NUMBER() window function to rank games that have reached 1 million in global sales in descending order*/
SELECT 
	ROW_NUMBER() OVER(ORDER BY Global_Sales DESC) AS Rank,
	Name,
	Platform, 
	Global_Sales
FROM
	Video_Games
WHERE
	Global_Sales * 1000000 > 1000000
ORDER BY 
	Global_Sales DESC;

/*Display all Pokemon games and order by global sales*/
/*This query shows a few games that aren't Pokemon games*/
Select 
	*
FROM
	Video_Games
WHERE
	Name LIKE 'Pok'
ORDER BY 
	Global_Sales DESC;

/*This query shows specifically Pokemon games*/
Select 
	*
FROM
	Video_Games
WHERE
	Name LIKE 'Pok%mon%'
ORDER BY 
	Global_Sales DESC;

/*Check which games are not in the original query. Since there are a couple Pokemon games that pop up the original query
needs to be changed */
Select 
	*
FROM
	Video_Games
WHERE 
	Name LIKE 'Pok%' AND Name NOT IN (Select Name FROM Video_Games WHERE Name LIKE 'Pok%mon%');

/*View all Pokemon games and see which ones were the most popular globally*/
Select 
	*
FROM
	Video_Games
WHERE
	Name LIKE 'Pok%mon%' OR Name LIKE 'Pok%park%'
ORDER BY 
	Global_Sales DESC;

/*View all of the FIFA games and see which ones were the most popular globally*/
Select
	*
FROM
	Video_Games
WHERE
	Name LIKE '%FIFA%'
ORDER BY
	Global_Sales DESC;

/*View the total sales of all the games and group them so it adds the sales across multiple platforms*/
SELECT
	Name,
	Sum(NA_Sales) AS NA_Sales,
	Sum(EU_Sales) AS EU_Sales,
	Sum(JP_Sales) AS JP_Sales,
	Sum(Other_Sales) AS Other_Sales,
	Sum(Global_Sales) AS Global_Sales
FROM 
	Video_Games
GROUP BY 
	Name
ORDER BY 
	Global_Sales DESC;

/*View top 100 games regardless of platform*/
SELECT TOP 100
	Name,
	Sum(NA_Sales) AS NA_Sales,
	Sum(EU_Sales) AS EU_Sales,
	Sum(JP_Sales) AS JP_Sales,
	Sum(Other_Sales) AS Other_Sales,
	Sum(Global_Sales) AS Global_Sales
FROM 
	Video_Games
GROUP BY 
	Name
ORDER BY 
	Global_Sales DESC;

/*View the most popular sports games*/
SELECT
	Name,
	Platform,
	Year_of_Release,
	Genre,
	Global_Sales,
	Publisher,
	Developer,
	Rating
FROM
	Video_Games
WHERE
	Genre = 'Sports'
ORDER BY
	Global_Sales DESC;

/*View top 10 Nintendo games in global sales excluding Wii games*/
SELECT TOP 10
	*
FROM
	Video_Games
WHERE
	Publisher = 'Nintendo'
	AND Platform != 'Wii'
ORDER BY
	Global_Sales DESC;

/*Display average sales in each market and globally for each publisher and the number of games they produced*/
SELECT
	Publisher,
	ROUND(AVG(NA_Sales),2) AS NA_Sales,
	ROUND(AVG(EU_Sales),2) AS EU_Sales,
	ROUND(AVG(JP_Sales),2) AS JP_Sales,
	ROUND(AVG(Other_Sales),2) AS Other_Sales,
	ROUND(AVG(Global_Sales),2) AS Global_Sales,
	COUNT(Global_Sales) AS Total_Count
FROM 
	Video_Games
GROUP BY 
	Publisher
ORDER BY 
	Global_Sales DESC;