--SQLQuery1 - Select Schedule.sql

USE PV_521_Import

--DELETE FROM Schedule WHERE [group]=(SELECT group_id FROM Groups WHERE group_name = N'PV_521');
--DELETE - удаляет таблицу

SELECT 
		[Группа]			=	[group]
		,[Дисциплина]		= discipline_name
		,[Преподователь]	= FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name)
		,[День]				= DATENAME(WEEKDAY, [date])
		,[Дата]				= [date]
		,[Время]			= [time]
		,[Статус]			= IIF(spent=1, N'Проведено', N'Запланировано')
--		Тернарный оператор: IFF(condition, value_1, value_2)
FROM	Schedule, Groups, Teachers, Disciplines
WHERE	[group]		= group_id
AND		discipline	= discipline_id
AND		teacher		= teacher_id
AND		[group]		= (SELECT group_id FROM Groups WHERE group_name = N'PV_521')
;