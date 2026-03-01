--SQLQuery1-Next Learning Data.sql
USE PV_521_Import;
GO

--Поиск ближайшей даты 
CREATE OR ALTER FUNCTION GetNextLearningDate(@date AS DATE, @time AS TIME) RETURNS DATE
	
AS
BEGIN
	--В этой неделе 
	DECLARE @current_lesson AS DATE;
	SELECT TOP 1 @current_lesson = [date]
	FROM Schedule
	WHERE [date] > @date OR [date] = @date AND [time] > @time
	ORDER BY [date], [time];
	RETURN @current_lesson;
	--На следующей
	IF(@current_lesson IS NULL)
	BEGIN
		SELECT TOP 1 @current_lesson = [date]
		FROM Schedule
		WHERE [date] > DATEADD(WEEK, 1, @date) OR [date] = DATEADD(WEEK, 1, @date) AND [time] > @time
		ORDER BY [date], [time]
	END
	RETURN (@current_lesson);
END;