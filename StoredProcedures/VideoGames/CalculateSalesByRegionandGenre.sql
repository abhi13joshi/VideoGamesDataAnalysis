CREATE PROCEDURE CalculateSalesByRegionAndGenre
AS
BEGIN
    -- Create a temporary table to store the results
    CREATE TABLE #SalesByRegionAndGenre (
        Genre NVARCHAR(255),
        NA_Sales FLOAT,
        EU_Sales FLOAT,
        JP_Sales FLOAT,
        Other_Sales FLOAT,
        Global_Sales FLOAT
    );

    -- Calculate sales by region and genre and insert into the temporary table
    INSERT INTO #SalesByRegionAndGenre (Genre, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales)
    SELECT
        Genre,
        SUM(NA_Sales * 1000000) AS NA_Sales,
        SUM(EU_Sales * 1000000) AS EU_Sales,
        SUM(JP_Sales * 1000000) AS JP_Sales,
        SUM(Other_Sales * 1000000) AS Other_Sales,
        SUM(Global_Sales * 1000000) AS Global_Sales
    FROM
        Video_Games
    GROUP BY
        Genre;

    -- Select the results from the temporary table
    SELECT * FROM #SalesByRegionAndGenre;

    -- Drop the temporary table
    DROP TABLE #SalesByRegionAndGenre;
END;
