--SQLQuery1-Get Next Learning Day.sql
USE PV_521_Import;
GO

CREATE OR ALTER FUNCTION GetNextLearningDay(@date AS DATE, @time AS TIME) RETURNS TINYINT
	
AS
BEGIN
	DECLARE @current_lesson INT; 
	SELECT TOP 1 @current_lesson = DATEPART(WEEKDAY,[date])		--DATEPART берет номер дня начиная с 0 до 6, благодаря ключу WEEKDAY
	FROM Schedule 
	WHERE [date] > @date OR [date] = @date AND [time] > @time
	ORDER BY [date], [time];
	RETURN (@current_lesson);
END;