--SQLQuery2 - SELECT Students.sql
USE PV_521_Import;

SELECT 
		--last_name		AS N'Фамиия',
		--first_name	AS N'Имя',
		--middle_name	AS N'Отчество',
		[Студент] = FORMATMESSAGE(N'%s %s %s',last_name,first_name,middle_name),
		--FORMATMESSAGE - работает по такому же принципу, как и printf / sprintf 
		--в языке C, как форматирование строк в C#, или же интерполяция строк в C#
		Students.birth_date			AS	N'Дата рождения',
		Groups.group_name			AS	N'Группа',
		Directions.direction_name	AS	N'Направление обучения'
FROM	Students, Groups, Directions
WHERE	[group]		= group_id
AND		direction	= direction_id
;