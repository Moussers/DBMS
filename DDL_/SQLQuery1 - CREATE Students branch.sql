--SQLQuery1 - CREATE Students branch.sql

USE PV_521_DDL;

CREATE TABLE Directions
(
	direction_id	TINYINT			PRIMARY KEY,
	direction_name	NVARCHAR(150)	NOT NULL
)

CREATE TABLE Groups
(
	group_id	INT					PRIMARY KEY,
	group_name	NVARCHAR(24)		NOT NULL,
	direction	TINYINT				NOT NULL	--описание поля
	CONSTRAINT	FK_Group_Direction	FOREIGN KEY REFERENCES Directions(direction_id),
--	CONSTRAINT FK_Имя_ВнешнегоКлюча	FOREIGN KEY REFERENCES Таблица(первичный_ключ_внешней_таблицы)
	type_learning	TINYINT				NOT NULL,
	learning_days	TINYINT				NOT NULL,
	time_start		TIME(6)				NOT NULL,
	date_start		DATE				NOT NULL,
)

CREATE TABLE Students
(
	student_id		INT					PRIMARY KEY IDENTITY(1,1),	--IDENTITY - Autoincrement--
	last_name		NVARCHAR(50)		NOT NULL,
	first_name		NVARCHAR(50)		NOT NULL,
	middle_name		NVARCHAR(50),
	birth_date		DATE				NOT NULL,
	--group - это ключевое слово языка Transact-SQL. Ключевое слово можно использовать для именования полей,
	--		  но в таком мслучае их нужно брать в квадратные скобки. 
	[group]			INT					NOT NULL
	CONSTRAINT		FK_Student_Group	FOREIGN KEY REFERENCES Groups(group_id)
);

CREATE TABLE TypeLearning
(
	[type_id]					SMALLINT	PRIMARY KEY,
	name_of_learning			NVARCHAR	NOT NULL,
	number_of_learning_types	TINYINT		NOT NULL,
);

CREATE TABLE TypeLearningGroupsRelation
(
	[group]			INT			CONSTRAINT FK_TDR_Groups		FOREIGN KEY REFERENCES Groups(group_id),
	type_learning	SMALLINT	CONSTRAINT FK_TDR_TypeLearning	FOREIGN KEY REFERENCES TypeLearning([type_id]),
);

--DROP TABLE Students,Groups,Directions, TypeLearning, TypeLearningGroupsRelation;