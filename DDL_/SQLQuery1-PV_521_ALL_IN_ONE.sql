--SQLQuery1-PV_521_ALL_IN_ONE.sql

--request create a DataBase
CREATE DATABASE PV_521_DDL
ON
(
	NAME		=	PV_521_DDL,
	FILENAME	=	'E:\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_521_DDL.mdf',
	SIZE		=	8 MB,
	MAXSIZE		=	500 MB,
	FILEGROWTH	=	8 MB
)
LOG ON
(
	NAME		= PV_521_DDL_log,
	FILENAME	= 'E:\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_521_DDL.ldf',
	SIZE		= 8 MB,
	MAXSIZE		= 500 MB,
	FILEGROWTH	= 8 MB
);
GO
--------------------------------------------------------------------------------------------------------------------

--request create Table Directions
CREATE TABLE Directions
(
	direction_id	TINYINT	PRIMARY KEY,
	direction_name	NVARCHAR(150)	NOT NULL
);
GO

--request create Table Groups
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
	date_start		DATE				NOT NULL
);
GO

--request create Type learning
CREATE TABLE TypeLearning
(
	[type_id]					SMALLINT	PRIMARY KEY,
	name_of_learning			NVARCHAR	NOT NULL,
	number_of_learning_types	TINYINT		NOT NULL,
);
GO

--request create Table Relation between  type learming and groups
CREATE TABLE TypeLearningGroupsRelation
(
	[group]			INT			CONSTRAINT FK_TDR_Groups		FOREIGN KEY REFERENCES Groups(group_id),
	type_learning	SMALLINT	CONSTRAINT FK_TDR_TypeLearning	FOREIGN KEY REFERENCES TypeLearning([type_id]),
);

--request create Table Students
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
GO

--DROP TABLE Students,Groups,Directions;

--------------------------------------------------------------------------------------------------------------------------

--request create Table Teachers

CREATE TABLE Teacher
(
	teacher_id	INT				PRIMARY KEY,
	last_name	NVARCHAR(50)	NOT NULL,
	first_name	NVARCHAR(50)	NOT NULL,
	middle_name NVARCHAR(50),
	birth_date	DATE			NOT NULL
);
GO

--request create Table Disciplines
CREATE TABLE Discipline
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(256)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
);
GO

--request create Table DisciplinesDirectionsRelation
CREATE TABLE DisciplinesDirectionsRelation
(
	discipline		SMALLINT,
	direction		TINYINT,
	PRIMARY KEY	(discipline, direction),
	CONSTRAINT	FK_DDR_Disciplines	FOREIGN KEY (discipline)	REFERENCES	Discipline(discipline_id),
	CONSTRAINT	FK_DDR_DIRECTION	FOREIGN KEY (direction)		REFERENCES	Directions(direction_id)
);

--request create Table DisciplinesDirectionsRelation
CREATE TABLE TeachersDisciplinesRelation
(
	teacher		INT,
	discipline	SMALLINT,
	PRIMARY KEY (teacher, discipline),
	CONSTRAINT FK_TDR_Teacher		FOREIGN KEY (teacher)		REFERENCES	Teacher(teacher_id),
	CONSTRAINT FK_TDR_Disciplines	FOREIGN KEY (discipline)	REFERENCES Discipline(discipline_id)
);
GO

--request create Table RequiredDisciplines
CREATE TABLE RequiredDisciplines
(
	discipline				SMALLINT,
	required_discipline		SMALLINT,
	PRIMARY KEY(discipline,required_discipline),
	CONSTRAINT FK_RD_Discipline		FOREIGN KEY (discipline)			REFERENCES	Discipline(discipline_id),
	CONSTRAINT FK_RD_Required		FOREIGN KEY (required_discipline)	REFERENCES	Discipline(discipline_id)
);
GO

--request create Table DependetDisciplines
CREATE TABLE DependetDisciplines
(
	discipline				SMALLINT,
	dependent_discipline	SMALLINT,
	PRIMARY KEY (discipline, dependent_discipline),
	CONSTRAINT		FK_DDR_Discipline	FOREIGN KEY		(discipline)				REFERENCES	Discipline(discipline_id),
	--CONSTRAINT - это название ограничения, FOREIGN KEY - какой тип ограничения, (discipline) - какое поле ограничиваем, REFERENCES Discipline(discipline_id) - и куда оно ссылается, на кукую таблицу и на какое поле
	CONSTRAINT		FK_DDR_Dependent		FOREIGN KEY		(dependent_discipline)		REFERENCES	Discipline(discipline_id)
);
GO

--DROP TABLE DisciplinesDirectionRelation, Discipline, Teacher, Directions;

-------------------------------------------------------------------------------------------------------------------------------

--request create Table Schedule
CREATE TABLE Schedule
(
	lesson_id	BIGINT		PRIMARY KEY,
	[date]		DATE		NOT NULL,
	[time]		TIME(0)		NOT NULL,
	[group]		INT		NOT NULL
	CONSTRAINT	FK_Schedule_Groups		FOREIGN KEY REFERENCES Groups(group_id),
	discipline	SMALLINT	NOT NULL
	CONSTRAINT	FK_Schedule_Discipline	FOREIGN KEY REFERENCES Discipline(discipline_id),
	teacher		INT			NOT NULL
	CONSTRAINT	FK_Schedule_Teacher		FOREIGN KEY REFERENCES Teacher(teacher_id),
	[subject]	NVARCHAR(256),
	spent		BIT			NOT NULL
);
GO

--request create Table Grades
CREATE TABLE Grades
(
	student			INT			CONSTRAINT	FK_Grades_Students		FOREIGN KEY REFERENCES	Students(student_id),
	lesson			BIGINT		CONSTRAINT	FK_Grades_Schedule		FOREIGN KEY REFERENCES	Schedule(lesson_id),
	PRIMARY KEY		(student, lesson),
	grade_1			TINYINT		CONSTRAINT	CK_Grade_1				CHECK	(grade_1>0 AND grade_1<=12),
	grade_2			TINYINT		CONSTRAINT	CK_Grade_2				CHECK	(grade_2>0 AND grade_2<=12)
);
GO

--request create Table Exams
CREATE TABLE Exams
(
	student			INT			CONSTRAINT	FK_EXAMS_Students		FOREIGN KEY (student)	REFERENCES	Students(student_id),
	discipline		SMALLINT	CONSTRAINT	FK_EXAMS_Disciplines	FOREIGN KEY (discipline)	REFERENCES	Discipline(discipline_id),
	grade			TINYINT		CONSTRAINT	CK_Exam_Grade				CHECK	(grade > 0 AND grade <= 12)	
);
GO

--request create Table HomeWorks
CREATE TABLE HomeWorks
(
	[group]		INT			CONSTRAINT	FK_HW_Groups	FOREIGN KEY REFERENCES Groups(group_id),
	lesson		BIGINT		CONSTRAINT	FK_WH_Schedule	FOREIGN KEY REFERENCES Schedule(lesson_id),
	[data]		VARBINARY(MAX),
	comment		NVARCHAR(1024),
	CONSTRAINT	CK_DATA_OR_COMMENT		CHECK ([data] IS NOT NULL OR comment IS NOT NULL),
	PRIMARY KEY ([group], lesson)
);
GO

--request create Table ResultsHW
CREATE TABLE ResultsHW
(
	student		INT		CONSTRAINT		FK_Results_Students		FOREIGN KEY REFERENCES	Students(student_id),
	[group]		INT,		--CONSTRAINT		FK_Results_Groups		FOREIGN KEY REFERENCES	Groups(group_id),
	lesson		BIGINT,	--CONSTRAINT		FK_Results_Schedule		FOREIGN KEY	REFERENCES	Schedule(lesson_id),
	CONSTRAINT	FK_Results_HW	FOREIGN KEY ([group], lesson)	REFERENCES HomeWorks([group], lesson),
	result		VARBINARY(MAX),
	comment		NVARCHAR(1024),
	grade		TINYINT		CONSTRAINT	CK_HW_Grade		CHECK (grade > 0 AND grade <= 12),
	CONSTRAINT	CK_ESULTS_OR_COMMENT	CHECK ([result] IS NOT NULL OR comment IS NOT NULL),
	PRIMARY KEY (student, [group], lesson)
);
GO

--DROP Schedule, Grades, Exams, HomeWorks, ResultsHW;

------------------------------------------------------------------------------------------------------------------------------

--request create Table TypeLearning
CREATE TABLE TypeLearning
(
	[type_id]		SMALLINT		PRIMARY KEY,
	name_of_type	NVARCHAR(150)	NOT NULL,
	number_of_types	TINYINT			NOT NULL
);
GO

--request create TypeLearningGroupsRealtion
CREATE TABLE TypeLearningGroupsRelation
(
	[group]			INT			NOT NULL,
	typeLearning	SMALLINT	NOT NULL,
	CONSTRAINT FK_TDR_Groups		FOREIGN KEY ([group])		REFERENCES	Groups(group_id),
	CONSTRAINT FK_TDR_TypeLearning	FOREIGN KEY (typeLearning)	REFERENCES	TypeLearning([type_id]),
	PRIMARY KEY ([group], typeLearning)
);

--DROP TABLE TypeLearning, TypeLearningGroupsRelation;