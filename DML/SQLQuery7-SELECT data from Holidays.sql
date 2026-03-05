--SQLQuery7-SELECT data from Holidays

USE PV_521_Import;


SELECT
	[ID] = holiday_id
	,[Праздники] = holiday_name
	,[Продолжительность] = duration
	,[Месяц] = [month]
	,[День] = [day]
FROM Holidays