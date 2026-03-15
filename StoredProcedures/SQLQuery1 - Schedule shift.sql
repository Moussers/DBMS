--SQLQuery1 - Schedule shift.sql

USE PV_521_Import;
GO

CREATE OR ALTER PROCEDURE sp_ScheduleShift
	@discpline_name		AS NVARCHAR(150),
	@teacher_surname	AS NVARCHAR(150),
	@start_date			AS DATE,
	@number_days		AS TINYINT
AS

DECLARE @discipline		AS	SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name = @discpline_name);
DECLARE @teacher		AS	SMALLINT = (SELECT teacher_id FROM Teachers WHERE last_name = @teacher_surname);
DECLARE @lesson			AS	BIGINT = (SELECT lesson_id FROM Schedule WHERE @discipline = discipline AND @teacher = teacher AND @start_date = [date]);
DECLARE @finish_lesson	AS	BIGINT = @lesson;
WHILE @finish_lesson IS NOT NULL 
BEGIN 
	SET @finish_lesson = @finish_lesson + 1;
END
PRINT @finish_lesson;

