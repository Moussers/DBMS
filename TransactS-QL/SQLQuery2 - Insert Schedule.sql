--SQLQuery2 - Setting Schedule.sql
USE PV_521_Import;
--В начале всегда подключать базу данных;

DECLARE @group						AS INT			= (SELECT group_id			FROM Groups			WHERE group_name = N'PV_521');
DECLARE @discipline_imperative		AS SMALLINT		= (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Процедурное%C++%');
DECLARE @discipline_OOP				AS SMALLINT		= (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Hardware%');
DECLARE @number_lesson				AS TINYINT		= (SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id = @discipline_imperative);
DECLARE @start_date					AS DATE			= N'2025-12-24';
DECLARE @time						AS TIME			= (SELECT start_time		FROM Groups			WHERE @group = group_id);
DECLARE @imperative					AS VARCHAR(150)	= (SELECT discipline_name	FROM Disciplines	WHERE discipline_id = @discipline_imperative);
DECLARE @hardware					AS VARCHAR(150)	= (SELECT discipline_name	FROM Disciplines	WHERE discipline_id = @discipline_OOP);

PRINT(@group);
PRINT(@discipline_imperative);
PRINT(@discipline_OOP);
PRINT(@number_lesson);
PRINT(@time);

DECLARE @start_time AS TIME = @time;
DECLARE @start_lesson AS TINYINT = 1;
WHILE (@start_lesson < @number_lesson)
BEGIN
PRINT(FORMATMESSAGE(N'%i %s %s %s %s %s %s %s %s', @start_lesson, N'|', @imperative, N'|', @hardware, N'|', @hardware, N'|', CAST(@start_time AS VARCHAR(24))))
SET @start_lesson = @start_lesson + 1;
PRINT(FORMATMESSAGE(N'%i %s %s %s %s %s %s %s %s', @start_lesson, N'|', @imperative, N'|', @imperative, N'|', @hardware, N'|', CAST(@start_time AS VARCHAR(24))))
SET @start_lesson = @start_lesson + 1;
END;