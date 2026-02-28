--SQLQuery2 - Insert Schedule.sql
USE PV_521_Import;

SELECT 
		[Дисциплина] = discipline_name
		,[Группа] = [group]
		--Русское слово в квадратных скобках, выводится как и через оператор AS
		,[Преподователь] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name)
		,[Время] = start_time
		,[День] = DATENAME(WEEKDAY, [date])
		,[Дата] = [date]
		,[Время] = [time]
		,[]
FROM Schedule, Disciplines, Teachers, Groups;
--GROUP BY lesson_id
;