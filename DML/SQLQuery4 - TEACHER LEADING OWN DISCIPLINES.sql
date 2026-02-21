--SQLQuery1 - TEACHER LEADING OWN DISCIPLINES.sql

USE PV_521_Import;

SELECT 
	last_name				AS		N'‘амили€'
	,first_name				AS		N'»м€'
	,middle_name			AS		N'ќтчество'
	,COUNT(tdr.discipline)	AS		N' оличество дисциплин которые ведЄт преподаватель'
FROM Teachers
INNER JOIN TeachersDisciplinesRelation AS tdr ON teacher_id = teacher 
GROUP BY Teachers.teacher_id , Teachers.last_name, Teachers.first_name, Teachers.middle_name
ORDER BY Teachers.last_name DESC
--
------------------------------------------------------------------------------------------------
--ORDER BY Ц упор€дочить (отсортировать) по;
--ASC Ц (сокращение от ascending Ц восход€щий) пор€док то есть сортировка от меньшего к большему (0, 1, 2, 3 .. )
--в случае сортировки слов Ц по алфавиту (ј -> я);
--DESC - (сокращение от descending Ц нисход€щий) пор€док то есть сортировка от большего к меньшему (100, 99, 98 Е). 
--—лова в этом случае сортируютс€ в пор€дке обратном алфавитному (я -> ј).
;