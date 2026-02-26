--SQLQuery2 - Insert Schedule.sql
USE PV_521_Import;

SELECT 
		[Время] = start_time
		,[Дисциплина] = discipline_name
		,[Группа] = [group]
		--Руссое слово в квадратных скобках, выводится как и через оператор AS
		,[Фамилия преподователя] = last_name
		,[Имя преподователя] = first_name
		,[Отчество] = middle_name
FROM Schedule, Disciplines, Teachers, Groups;
--GROUP BY lesson_id
;