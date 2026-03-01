--SQLQuery1-Get Next Learning Day.sql
USE PV_521_Import;
GO

CREATE OR ALTER FUNCTION GetNextLearningDay(@date AS DATE, @time AS TIME) RETURNS DATE
	
AS
BEGIN
	DECLARE @current AS DATE;
	SELECT TOP 1 @current = [date]
	FROM Schedule
	WHERE [date] > @date OR [date] = @date AND [time] > @time
	ORDER BY [date], [time];
	RETURN (@current);
END;