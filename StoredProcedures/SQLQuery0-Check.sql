--SQLQuery0-Check.sql
USE PV_521_Import;
SET DATEFIRST 1;

DELETE FROM Schedule WHERE [group]=521 --AND [date] >= N'2026-09-16'
--DELETE FROM Schedule WHERE discipline = (SELECT discipline_id FROM Disciplines  WHERE discipline_name LIKE N'Сетевое')
EXEC sp_InsertSchedule1221 N'PV_521', N'Hardware%', N'Свищев', N'2025-01-20', 1, 3, 1;
EXEC sp_InsertSchedule1221 N'PV_521', N'%Windows', N'Свищев', N'2025-04-30', 1, 3, 1;
EXEC sp_InsertSchedule1221 N'PV_521', N'Процедурное%C++', N'Ковтун', N'2025-01-20', 5, 3, 0;
--UPDATE Schedule SET teacher=1 WHERE discipline=1;		--UPDATE обновляет название преподователя находя предмет по id благодаря конструкции WHERE
--EXEC sp_InsertScheduleStacionar N'PV_521', N'%MS SQL Server', N'Олег', N'2025-12-24';
--EXEC sp_InsertScheduleStacionar N'PV_521', N'%ADO.NET%', N'Олег', N'2026-02-04';
--EXEC sp_InsertScheduleStacionar N'PV_521', N'Сетевое%', N'Олег', N'2026-03-09';
--EXEC sp_InsertScheduleStacionar N'PV_521', N'HTML/CSS', N'Олег', DEFAULT;
--EXEC sp_InsertScheduleStacionar N'PV_521', N'JavaScript', N'Олег', DEFAULT;
--EXEC sp_InsertScheduleStacionar N'PV_521', N'ReactJS', N'Олег', DEFAULT;
--EXEC sp_InsertScheduleStacionar N'PV_521', N'%ASP.NET', N'Олег', DEFAULT;
--EXEC sp_InsertScheduleStacionar N'PV_521', N'Системное%', N'Олег', DEFAULT;
--EXEC sp_InsertScheduleStacionar N'PV_521', N'%ADO.NET%', N'Олег', N'2026-01-21';
--EXEC sp_InsertScheduleStacionar N'PV_521', N'Сетевое%', N'Олег', N'2026-01-18';
EXEC sp_SelectScheduleFor N'PV_521'; 

-----------------------------------------	Holidays ----------------------------------------------------------------

--EXEC sp_InsertAllHolidaysFor 2027;

--SELECT
--	[Дата] = date,
--	[Праздник] = holiday_name
--FROM DaysOFF, Holidays
--WHERE holiday=holiday_id
--AND [date] > DATEFROMPARTS(2026, 12, 20);
--;

	--DECLARE @group_id AS INT =  521; --(SELECT group_id FROM Groups WHERE group_name LIKE @group);
	--PRINT @group_id
	--SELECT
	--		[Группа]	= group_name,
	--		[Дисциплина]= discipline_name,
	--		[Дата]		= [date],
	--		[Время]		= [time],
	--		[День]		= DATENAME(WEEKDAY,[date]),
	--		[Препод]	= FORMATMESSAGE(N'%s %s %s',last_name, first_name, middle_name),
	--		[Статус]	= IIF(spent = 1, N'Проведено', N'Запланировано')
	--FROM Schedule, Groups, Teachers, Disciplines
	--WHERE	[group] = group_id
	--AND		[group] = @group_id
	--AND		discipline = discipline_id
	--AND		teacher = teacher_id
	--AND		DATEPART(WEEKDAY,[date]) = 3
	--ORDER BY [date]

--DECLARE @discipline AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Объектно%');
--PRINT(@discipline);
--SELECT 
--[Teacher id] = FORMATMESSAGE(N'%s', last_name, first_name, middle_name),
--[Предмет] = discipline_name
--FROM Teachers
--INNER JOIN TeachersDisciplinesRelation ON teacher_id = teacher
--INNER JOIN Disciplines ON discipline_id =  discipline
--WHERE discipline_id = @discipline

DECLARE @number_days		AS	TINYINT = 5;
DECLARE @start_date			AS	DATE = N'2025-07-18';
DECLARE @discpline_name		AS	NVARCHAR(150) = N'Процедурное%';
DECLARE @teacher_surname	AS	NVARCHAR(150) = N'Ковтун';
DECLARE @discipline			AS	SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE @discpline_name);
DECLARE @teacher			AS	SMALLINT = (SELECT teacher_id FROM Teachers WHERE last_name LIKE @teacher_surname);
PRINT(@discipline);
PRINT(@teacher);
DECLARE @lesson			AS	BIGINT = (SELECT TOP 1 lesson_id FROM Schedule WHERE @discipline = discipline AND @teacher = teacher AND @start_date = [date]);
DECLARE @finish_lesson	AS	BIGINT = @lesson;
--SELECT TOP 1 [Дата] = [date] FROM Schedule WHERE @discipline = discipline AND @teacher = teacher; --AND @start_date = [date];

WHILE @finish_lesson IS NOT NULL 
BEGIN 
	SET @finish_lesson = @finish_lesson + 1;
END
PRINT @finish_lesson;