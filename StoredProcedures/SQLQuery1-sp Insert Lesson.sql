--SQLQuery1-sp Insert Lesson.sql

USE PV_521_Import;
GO

ALTER PROCEDURE sp_InsertLesson
--CREATE PROCEDURE sp_InsertLesson
--параметры процедуры
	@lesson_number	AS TINYINT OUTPUT
	,@group			AS INT
	,@discipline	AS SMALLINT
	,@teacher		AS INT
	,@date			AS DATE
	,@time			AS TIME OUTPUT
AS
BEGIN
	PRINT(FORMATMESSAGE(N'%i   %s    %s    %s', @lesson_number, CAST(@date AS VARCHAR(24)), DATENAME(WEEKDAY,@date), CAST(@time AS VARCHAR(24))));
	IF NOT EXISTS(SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time] = @time AND [group] = @group)
		INSERT Schedule VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date < GETDATE(), 1, 0));
	SET @lesson_number = @lesson_number + 1;
END;