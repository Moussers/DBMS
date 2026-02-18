--SQLQuery4 - SELECT AggreagateStudentsAndGroups.sql

USE PV_521_Import;

SELECT
	direction_name				AS 'Направление обучения'
	,COUNT(DISTINCT group_id)	AS 'Количество групп'
	,COUNT(stud_id)
FROM Students,Groups,Directions
WHERE	[group] = group_id
AND		direction = direction_id
GROUP BY direction_name
;

SELECT
	direction_name				AS N'Напрвление обучение'
	--,COUNT(stud_id)				AS N'Количество студентов'
	--,COUNT(DISTINCT group_id)	AS N'Количество групп'
	--DISTINCT выбирает только уникальные значения в таблице
	,(SELECT COUNT(group_id) FROM Groups, Directions WHERE direction=direction_id) AS N'Количство групп'
	,(
		SELECT COUNT (stud_id) 
		FROM Students, Groups--, Directions 
		WHERE [group] = group_id
		AND direction = direction_id
	)	AS N'Количество студентов'
FROM Directions
;