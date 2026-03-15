--SQLQuery2-sp_Insert Schedule1221.sql
USE PV_521_Import
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE sp_InsertSchedule1221
	@group_name			AS		NCHAR(10),
	@dicipline_name		AS		NVARCHAR(150),
	@teacher_name		AS		NVARCHAR(50),
	@start_date			AS		DATE,
	@constant_day		AS		TINYINT,
	@alternate_day		AS		TINYINT,
	@first_week_present AS		BIT
AS
BEGIN
	DECLARE @group				AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = @group_name);
	DECLARE @discipline			AS SMALLINT	= (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @dicipline_name);
	DECLARE @number_of_lessons	AS TINYINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_name LIKE @dicipline_name);
	DECLARE @lesson_number		AS TINYINT	= (SELECT COUNT(lesson_id)	FROM Schedule		WHERE discipline=@discipline AND [group] = @group);------------Нужно учитывать проведённые занятия по выставляемой дисциплине
	DECLARE @teacher			AS SMALLINT	= (SELECT teacher_id		FROM Teachers		WHERE last_name LIKE @teacher_name OR first_name LIKE @teacher_name);
	--DECLARE @start_date			AS DATE		= (SELECT MAX([date])		FROM Schedule		WHERE [group] = @group);
	IF @start_date IS NULL SET @start_date	= (SELECT [start_date]		FROM Groups			WHERE group_id = @group);
	DECLARE @start_time			AS TIME		= (SELECT start_time		FROM Groups			WHERE group_id = @group);
	DECLARE @date				AS DATE		= @start_date;
	DECLARE @time				AS TIME		= @start_time;

	DECLARE @previos_week_present  AS BIT		= IIF(@first_week_present = 1, 0, 1);

	WHILE @lesson_number < @number_of_lessons
	BEGIN
			--PRINT FORMATMESSAGE(N'%s %d',N'Lesson number:\t',CAST(@previos_week_present AS INT));
			--PRINT FORMATMESSAGE(N'%s %d',N'Prev week present:\t',CAST(@previos_week_present AS INT));
			SET	@time = @start_time;
			IF DATEPART(WEEKDAY, @date) = @constant_day OR (DATEPART(WEEKDAY, @date) = @alternate_day AND @previos_week_present = 0)
			BEGIN
				EXEC sp_InsertLesson @group, @discipline, @teacher, @date, @time OUTPUT, @lesson_number OUTPUT;
				EXEC sp_InsertLesson @group, @discipline, @teacher, @date, @time OUTPUT, @lesson_number OUTPUT;
			END
			IF		DATEPART(WEEKDAY, @date) = @alternate_day
			--BEGIN
				SET @previos_week_present = IIF(@previos_week_present = 1, 0, 1);
			--END
			SET @date = dbo.GetNextLearningDate(@group_name, @date);
	END
END