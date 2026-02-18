--SQLQuery1-INSERT DIRECTIONS.sql
USE PV_521_DDL;

INSERT Directions
		(direction_id, direction_name)
VALUES
		(1, N'Разработка программного обеспечения')
		,(2, N'Сетевые технологии и системное администрирование')
		,(3, N'Компьютерная графика и дизайн')
;
--N - Unicode string

--INTSERT TABLE(field1, field2, ... field) - 
--TABLE - это название таблицы
--(field1, field2 ...) - это набор полей. 
--Ключевое слово VALUES 
--						(value, 1 value 2, ..., valueN)
--						,(value, 1 value 2, ..., valueN),
--						,(value, 1 value 2, ..., valueN)
--						(value, 1 value 2, ..., valueN)
--value - это один набор, то есть одна строка. Строк используя insert 
--мы можем вставить большое количество. Как правило используется одна
--строка, но при необходимости, строк со значением можнт быть много.
--Insert - перевод: вставка.
--;