CREATE PROCEDURE TopPublishers
AS
BEGIN
	-- Create a temporary table to store the results
	CREATE TABLE #TopPublishers (
		Publisher NVARCHAR(255),
		Total_Sales FLOAT,
	);

	-- Calculate total sales and insert them into a temporary table
	INSERT INTO #TopPublishers (Publisher, Total_Sales)
	SELECT
		Publisher,
		SUM(Global_Sales * 1000000) AS Total_Sales
	FROM
		Video_Games
	GROUP BY
		Publisher;

    -- Select the results from the temporary table
    SELECT 
		*, 
		RANK() OVER (ORDER BY Total_Sales DESC) AS Total_Sales_Rank 
	FROM #TopPublishers;

    -- Drop the temporary table
    DROP TABLE #TopPublishers;
END;

