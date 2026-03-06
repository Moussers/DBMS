--SQLQuery0-Check.sql
USE PV_521_Import;
SET DATEFIRST 1;

--DELETE FROM Schedule WHERE discipline = (SELECT discipline_id FROM Disciplines  WHERE discipline_name LIKE N'Сетевое')
--EXEC sp_InsertScheduleStacionar N'PV_521', N'%ADO.NET%', N'Олег', N'2026-01-21';
--EXEC sp_InsertScheduleStacionar N'PV_521', N'Сетевое%', N'Олег', N'2026-01-18';
--EXEC sp_SelectScheduleFor N'PV_521';
--DELETE FROM DaysOFF WHERE [date] = N'2025-12-30';
--EXEC sp_InsertAllHolidaysFor 2027;

SELECT
	[Дата] = date,
	[Праздник] = holiday_name
FROM DaysOFF, Holidays
WHERE holiday=holiday_id
AND [date] > DATEFROMPARTS(2026, 12, 20);
;