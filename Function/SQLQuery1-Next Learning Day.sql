--SQLQuery1-Get Next Learning Day.sql
USE PV_521_Import;
GO

CREATE OR ALTER FUNCTION GetNextLearningDay(@date AS DATE, @time AS TIME) RETURNS DATE
	
AS
BEGIN
	DECLARE @current_lesson AS DATE;
	SELECT TOP 1 @current_lesson = [date]
	FROM Schedule
	WHERE [date] > @date OR [date] = @date AND [time] > @time
	ORDER BY [date], [time];
	RETURN (@current_lesson);
	--Если ближайшая занятие на неделе не найдено
	IF(@current_lesson IS NULL)
	BEGIN
		SELECT TOP 1 @current_lesson = [date]
		FROM Schedule
		WHERE [date] > DATEADD(WEEK, 1, @date) OR [date] = DATEADD(WEEK, 1, @date) AND [time] > @time
		ORDER BY [date], [time]
	END
	RETURN (@current_lesson);
END;