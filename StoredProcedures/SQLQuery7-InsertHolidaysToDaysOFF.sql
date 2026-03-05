--SQLQuery7-InsertHolidaysToDaysOFF.sql
use PV_521_Import;
GO

CREATE OR ALTER PROCEDURE sp_InsertHolidaysToDaysOFF(@year AS SMALLINT)
AS
BEGIN
DECLARE @duration	AS INT;
DECLARE @month		AS TINYINT;
DECLARE @day		AS TINYINT;
DECLARE @id_num		AS INT = (SELECT COUNT(holiday_id) FROM Holidays);
DECLARE @i			AS INT = 0;
DECLARE @name Nvarchar(150);
WHILE @i < @id_num
BEGIN
	SET @i = @i + 1;
	SELECT @name = holiday_name, @duration = duration, @day = [day], @month = [month] FROM Holidays WHERE @i = holiday_id;
	IF @day IS NULL AND @month IS NULL
	BEGIN
		DECLARE @holi_date AS DATE;
		IF @name = 'Новогодние каникулы'
		BEGIN
			SET @holi_date = DATEFROMPARTS(@year-1, 12, 30);
		END 
		IF @name = 'Пасха'
		BEGIN
			SET @holi_date = DATEFROMPARTS(@year, 04, 12);
		END
		IF @name = 'Летние каникулы'
		BEGIN 
			SET @holi_date = DATEFROMPARTS(@year, 05, 27);
		END
	END
	ELSE
	BEGIN
		SET @holi_date = DATEFROMPARTS(@year, @month, @day);
	END
	WHILE @duration > 0
	BEGIN
		DECLARE @date_num AS INT = (SELECT COUNT([date]) FROM DaysOFF WHERE [date] = @holi_date);
		IF @date_num = 0
		BEGIN
			INSERT INTO DaysOFF([date], holiday) VALUES(@holi_date, @i);
			--(date, holiday) - поля для вставки значений
			--VALUES(@holi_date, @i) - значения которые мы вставляем
		END
		SET @duration = @duration-1;
		SET @holi_date = DATEADD(DAY, 1, @holi_date);
	END
END
END