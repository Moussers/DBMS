--SQLQuery1 - TEACHER LEADING OWN DISCIPLINES.sql

USE PV_521_Import;

SELECT 
	last_name				AS		N'Фамилия'
	,first_name				AS		N'Имя'
	,middle_name			AS		N'Отчество'
	,COUNT(tdr.discipline)	AS		N'Количество дисциплин которые ведёт преподаватель'
FROM Teachers
INNER JOIN TeachersDisciplinesRelation AS tdr ON teacher_id = teacher 
GROUP BY Teachers.teacher_id , Teachers.last_name, Teachers.first_name, Teachers.middle_name
ORDER BY Teachers.last_name DESC
--
------------------------------------------------------------------------------------------------
--ORDER BY – упорядочить (отсортировать) по;
--ASC – (сокращение от ascending – восходящий) порядок то есть сортировка от меньшего к большему (0, 1, 2, 3 .. )
--в случае сортировки слов – по алфавиту (А -> Я);
--DESC - (сокращение от descending – нисходящий) порядок то есть сортировка от большего к меньшему (100, 99, 98 …). 
--Слова в этом случае сортируются в порядке обратном алфавитному (Я -> А).
;