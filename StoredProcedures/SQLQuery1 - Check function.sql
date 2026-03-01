--SQLQuery1 - Check function.sql

USE PV_521_Import;

--GetNextLearningDay(@date AS DATE, @time AS TIME)
DECLARE @group						AS INT			= (SELECT group_id			FROM Groups			WHERE group_name = N'PV_521');
DECLARE @date			AS	DATE	=	N'2027-12-27';
DECLARE	@time			AS	TIME	=	(SELECT start_time FROM Groups	WHERE group_id=@group);

DECLARE @day AS DATE = dbo.GetNextLearningDay(@date, @time)
PRINT(@day);
PRINT(DATENAME(WEEKDAY, @day));