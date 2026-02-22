--SQLQuery1 - Select Schedule.sql

USE	PV_521_Import;
SET DATEFIRST 1;	--Для правильной интерпритации дней недели (Пн-1б Вт-2, ..., Вс-7)

--Объявляем перменные:
DECLARE @group				AS	INT		=	(SELECT group_id FROM Groups WHERE group_name=N'PV_521');
--DECLARE - это синтаксис переменной.
DECLARE	@discipline			AS	SMALLINT=	(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%MS SQL%');
DECLARE @number_of_lessons	AS	TINYINT	=	(SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline);
DECLARE @teacher			AS	INT		=	(SELECT teacher_id FROM Teachers WHERE first_name = N'Олег');
DECLARE @start_date			AS	DATE	=	N'2025-12-24';
DECLARE	@start_time			AS	TIME	=	(SELECT start_time FROM Groups	WHERE group_id=@group);

PRINT(@group);
PRINT(@discipline);
PRINT(@number_of_lessons);
PRINT(@teacher);
PRINT(@start_date);
PRINT(@start_time);

--В цикле перебираем занятие по номеру, определяем датту и время каждого
DECLARE @date			AS DATE = @start_date;	--Счиать даты;
DECLARE @lesson_number	AS TINYINT = 1;			--Считать уроки;
DECLARE @time			AS TIME  = @start_time;
WHILE	(@lesson_number < @number_of_lessons)
BEGIN
		SET @time = @start_time;
		PRINT(FORMATMESSAGE(N'%i   %s    %s    %s', @lesson_number, CAST(@date AS VARCHAR(24)), DATENAME(WEEKDAY,@date), CAST(@time AS VARCHAR(24))));
		--CAST - переобразование типов, как оператор as в C#;
		IF NOT EXISTS(SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time] = @time AND [group] = @group)
		--NOT EXISTS - не существует. Если не существует SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time] = @time AND [group] = @group
		--тогда выполняем INSERT, в противном случяе код не выполняется.
			INSERT Schedule VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date < GETDATE(), 1, 0));
		SET @lesson_number = @lesson_number + 1;
		--SET - устанавливает значение перемененой;
		SET @time = DATEADD(MINUTE, 95, @start_time);
		PRINT(FORMATMESSAGE(N'%i   %s    %s    %s', @lesson_number, CAST(@date AS VARCHAR(24)), DATENAME(WEEKDAY,@date), CAST(@time AS VARCHAR(24))));
		--95 разница между началом и концом урока;
		IF NOT EXISTS(SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time] = @time AND [group] = @group)
			INSERT Schedule VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date < GETDATE(), 1, 0));
		SET @lesson_number = @lesson_number + 1;

		DECLARE @day	AS TINYINT = DATEPART(WEEKDAY, @date);		--определяем текущий день недели . (Как раз для этого више написано 'SET DATEFIRST 1');
		--PRINT(@day);
		SET @date	=	DATEADD(DAY, IIF(@day = 5, 3, 2), @date);	--если день равен 5 (пятнице), прибавляем 3, потому что переходим к поенедельну.
																	--Во всех остальных случаях, то есть понедельник или среда, мы сдвигаем на 2 дня.
END
--BEGIN \ END - вместо фигурных скобок

PRINT(@time);