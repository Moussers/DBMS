--SQLQuery3 - SELECT Teachers.sql
USE PV_521_Import;

SELECT
		[Преподователь]		=	FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name)
		,[Дата рождения]	=	birth_date
		,[Возраст]			=	CAST(DATEDIFF(DAY, birth_date, GETDATE())/365.25 AS TINYINT) 
		--GETDATE возвращает текущую дату и время
FROM	Teachers
WHERE		CAST(DATEDIFF(DAY, birth_date, GETDATE())/365.25 AS TINYINT) BETWEEN 38 AND 44
ORDER BY	[Возраст]	ASC
--ASC - Ascinding (По возрастанию);
--DESC - Desending (По убыванию);
;