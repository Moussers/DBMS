--SQLQuery1-sp Select Schedule for Group.sql
USE PV_521_Import;
SET DATEFIRST 1;
GO

ALTER PROCEDURE sp_SelectScheduleFor @group AS NCHAR(10)
--CREATE PROCEDURE sp_SelectScheduleFor @group AS NVARCHAR(10)   --(@group AS NVARCHAR(10)) - это параметер, из которого состоит процедура. 
																 --В других програмных языках при создании функции мы указываем её параметры в скобках ().
AS
BEGIN
	DECLARE @group_id AS INT = (SELECT group_id FROM Groups WHERE group_name LIKE @group);
	PRINT @group_id
	SELECT
			[Группа]	= group_name,
			[Дисциплина]= discipline_name,
			[Дата]		= [date],
			[Время]		= [time],
			[День]		= DATENAME(WEEKDAY,[date]),
			[Препод]	= FORMATMESSAGE(N'%s %s %s',last_name, first_name, middle_name),
			[Статус]	= IIF(spent = 1, N'Проведено', N'Запланировано')
	FROM Schedule, Groups, Teachers, Disciplines
	WHERE [group] = group_id
	AND [group] = @group_id
	AND discipline = discipline_id
	AND teacher = teacher_id
END