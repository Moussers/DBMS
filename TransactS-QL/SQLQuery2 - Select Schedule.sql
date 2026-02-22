--SQLQuery2 - Insert Schedule.sql
USE PV_521_Import;

SELECT 
		[id] = lesson_id
		,[Дисциплина] = discipline_name
		,[Группа] = [group]
		--Руссое слово в квадратных скобках, выводится как и через оператор AS
		,[Количество дисциплин] = number_of_lessons
FROM Schedule, Disciplines
--GROUP BY lesson_id
;