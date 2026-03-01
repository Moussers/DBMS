--SQLQuery1 - Check function.sql

USE PV_521_Import;

--GetNextLearningDay(@date AS DATE, @time AS TIME)
DECLARE @group						AS INT			= (SELECT group_id			FROM Groups			WHERE group_name = N'PV_521');
DECLARE @date			AS	DATE	=	N'2024-12-29';
DECLARE	@time			AS	TIME	=	(SELECT start_time FROM Groups	WHERE group_id=@group);

PRINT(@group);
PRINT(@date);
PRINT(@time);
DECLARE @day AS TINYINT = dbo.GetNextLearningDay(@date, @time); 
DECLARE @date_lesson AS DATE = dbo.GetNextLearningDate(@date, @time);
PRINT(@day);
PRINT(@date_lesson);



