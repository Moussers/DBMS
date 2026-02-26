--SQLQuery4 - Numbrer Disciplines for every Teacher.sql

USE PV_521_Import;

SELECT
	discipline_name					AS	N'Названия направлений'
	,COUNT(DISTINCT tdr.teacher)	AS	N'Количество преподователей'
FROM Disciplines
INNER JOIN TeachersDisciplinesRelation AS tdr ON Disciplines.discipline_id = tdr.discipline
GROUP BY discipline_id, discipline_name
ORDER BY discipline_name
;