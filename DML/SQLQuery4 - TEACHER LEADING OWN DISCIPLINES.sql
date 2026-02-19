--SQLQuery1 - TEACHER LEADING OWN DISCIPLINES.sql

USE PV_521_Import;

SELECT 
	last_name				AS		N'Фамилия'
	,first_name				AS		N'Имя'
	,middle_name			AS		N'Отчество'
	,COUNT(tdr.discipline)	AS		N'Количество дисциплин которые ведёт преподаватель'
FROM Teachers
JOIN TeachersDisciplinesRelation AS tdr ON teacher_id = teacher 
GROUP BY Teachers.last_name
;