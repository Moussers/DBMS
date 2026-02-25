--SQLQuery2 - Setting Schedule.sql
USE PV_521_Import;
--В начале всегда подключать базу данных;

DECLARE @group						AS INT			= (SELECT group_id			FROM Groups			WHERE group_name = N'PV_521');
DECLARE @discipline_imperative		AS SMALLINT		= (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Процедурное%C++%');
DECLARE @discipline_OOP				AS SMALLINT		= (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @number_lesson				AS TINYINT		= (SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id = @discipline_imperative);
DECLARE @date						AS DATE			= N'2025-12-22';
DECLARE @time						AS TIME			= (SELECT start_time		FROM Groups			WHERE @group = group_id);
DECLARE @imperative					AS VARCHAR(150)	= (SELECT discipline_name	FROM Disciplines	WHERE discipline_id = @discipline_imperative);
DECLARE @hardware					AS VARCHAR(150)	= (SELECT discipline_name	FROM Disciplines	WHERE discipline_id = @discipline_OOP);
DECLARE @teacherImperSurname		AS VARCHAR(150) = (SELECT last_name FROM Teachers WHERE last_name = 'Ковтун');
DECLARE @teacherHardSurname			AS VARCHAR(150) = (SELECT last_name FROM Teachers WHERE last_name = 'Кобылинский');
DECLARE @teacherImperFirstName		AS VARCHAR(150) = (SELECT first_name FROM Teachers WHERE last_name = @teacherImperSurname);
DECLARE @teacherHardFirstName		AS VARCHAR(150) = (SELECT first_name FROM Teachers WHERE last_name = @teacherHardSurname);
--PRINT(@group);
--PRINT(@discipline_imperative);
--PRINT(@discipline_OOP);
--PRINT(@number_lesson);
--PRINT(@time);
--PRINT(@teacherImperSurname);
--PRINT(@teacherHardSurname);
--PRINT(@teacherImperFirstName);
--PRINT(@teacherHardFirstName);

DECLARE @start_date AS DATE = @date; 
DECLARE @start_time AS TIME = @time;
DECLARE @start_day AS TINYINT = 0;
DECLARE @days_in_Month AS TINYINT = (4 / 2);
DECLARE @temp_date AS DATE = @date;
SET @start_date = @date;
WHILE (@start_day < @days_in_Month)
BEGIN
PRINT(@temp_date);
PRINT(FORMATMESSAGE(N'%s', N'__________________________________________________________________________________________________________'))
PRINT(FORMATMESSAGE(N'%s %s %s                               %s %s %s %s %s    %s %s', CAST(@start_date AS VARCHAR(24)), N'|', @hardware, N'|', @teacherHardSurname, @teacherHardFirstName, N'|', CAST(DATENAME(WEEKDAY, @start_date) AS VARCHAR(24)), N'|',CAST(@start_time AS VARCHAR(24)), N'|'))
PRINT(FORMATMESSAGE(N'%s', N'-----------|-------------------------------------------|--------------------|-----------|-----------------'))
SET @start_date = DATEADD(DAY, 2, @start_date);
SET @temp_date = DATEADD(DAY, 7,@temp_date);
PRINT(FORMATMESSAGE(N'%s %s %s %s %s %s        %s %s %s %s', CAST(@start_date AS VARCHAR(24)), N'|', @imperative, N'|',@teacherImperSurname, @teacherImperFirstName, N'|', CAST(DATENAME(WEEKDAY, @start_date) AS VARCHAR(24)), N'|',CAST(@start_time AS VARCHAR(24)), N'|'))
PRINT(FORMATMESSAGE(N'%s', N'-----------|-------------------------------------------|--------------------|-----------|-----------------'))
SET @start_date = DATEADD(DAY, 2, @start_date);
PRINT(FORMATMESSAGE(N'%s %s %s %s %s %s        %s %s    %s %s', CAST(@start_date AS VARCHAR(24)), N'|', @imperative, N'|',@teacherImperSurname, @teacherImperFirstName, N'|', CAST(DATENAME(WEEKDAY, @start_date) AS VARCHAR(24)), N'|',CAST(@start_time AS VARCHAR(24)), N'|'))
PRINT(FORMATMESSAGE(N'%s', N'----------------------------------------------------------------------------------------------------------'))
SET @temp_date = DATEADD(DAY, 7,@temp_date);
PRINT(FORMATMESSAGE(N'%s', N'__________________________________________________________________________________________________________'))
PRINT(FORMATMESSAGE(N'%s %s %s                               %s %s %s %s %s    %s %s', CAST(@start_date AS VARCHAR(24)), N'|', @hardware, N'|', @teacherHardSurname, @teacherHardFirstName, N'|', CAST(DATENAME(WEEKDAY, @start_date) AS VARCHAR(24)), N'|',CAST(@start_time AS VARCHAR(24)), N'|'))
PRINT(FORMATMESSAGE(N'%s', N'-----------|-------------------------------------------|--------------------|-----------|-----------------'))
SET @start_date = DATEADD(DAY, 2, @start_date);
SET @temp_date = DATEADD(DAY, 7,@temp_date);
PRINT(FORMATMESSAGE(N'%s %s %s                               %s %s %s %s %s    %s %s', CAST(@start_date AS VARCHAR(24)), N'|', @hardware, N'|', @teacherHardSurname, @teacherHardFirstName, N'|', CAST(DATENAME(WEEKDAY, @start_date) AS VARCHAR(24)), N'|',CAST(@start_time AS VARCHAR(24)), N'|'))
PRINT(FORMATMESSAGE(N'%s', N'-----------|-------------------------------------------|--------------------|-----------|-----------------'))
SET @start_date = DATEADD(DAY, 2, @start_date);
SET @temp_date = DATEADD(DAY, 7,@temp_date);
PRINT(FORMATMESSAGE(N'%s %s %s %s %s %s        %s %s   %s %s', CAST(@start_date AS VARCHAR(24)), N'|', @imperative, N'|',@teacherImperSurname, @teacherImperFirstName, N'|', CAST(DATENAME(WEEKDAY, @start_date) AS VARCHAR(24)), N'|',CAST(@start_time AS VARCHAR(24)), N'|'))
PRINT(FORMATMESSAGE(N'%s', N'-----------|-------------------------------------------|--------------------|-----------|-----------------'))
SET @start_day = @start_day + 1;
END;