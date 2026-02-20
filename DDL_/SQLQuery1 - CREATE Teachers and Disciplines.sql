--SQLQuery1 - CREATE Teachers and Disciplines.sql

USE PV_521_DDL

CREATE TABLE Teacher
(
	teacher_id	INT				PRIMARY KEY,
	last_name	NVARCHAR(50)	NOT NULL,
	first_name	NVARCHAR(50)	NOT NULL,
	middle_name NVARCHAR(50),
	birth_date	DATE			NOT NULL
);

CREATE TABLE Discipline
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(256)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
);

CREATE TABLE DisciplinesDirectionsRelation
(
	discipline		SMALLINT,
	direction		TINYINT,
	PRIMARY KEY	(discipline, direction),
	CONSTRAINT	FK_DDR_Disciplines	FOREIGN KEY (discipline)	REFERENCES	Discipline(discipline_id),
	CONSTRAINT	FK_DDR_DIRECTION	FOREIGN KEY (direction)		REFERENCES	Directions(direction_id)
);

CREATE TABLE TeachersDisciplinesRelation
(
	teacher		INT,
	discipline	SMALLINT,
	PRIMARY KEY (teacher, discipline),
	CONSTRAINT FK_TDR_Teacher		FOREIGN KEY (teacher)		REFERENCES	Teacher(teacher_id),
	CONSTRAINT FK_TDR_Disciplines	FOREIGN KEY (discipline)	REFERENCES Discipline(discipline_id)
);

CREATE TABLE RequiredDisciplines
(
	discipline				SMALLINT,
	required_discipline		SMALLINT,
	PRIMARY KEY(discipline,required_discipline),
	CONSTRAINT FK_RD_Discipline		FOREIGN KEY (discipline)			REFERENCES	Discipline(discipline_id),
	CONSTRAINT FK_RD_Required		FOREIGN KEY (required_discipline)	REFERENCES	Discipline(discipline_id)
);

CREATE TABLE DependetDisciplines
(
	discipline				SMALLINT,
	dependent_discipline	SMALLINT,
	PRIMARY KEY (discipline, dependent_discipline),
	CONSTRAINT		FK_DDR_Discipline	FOREIGN KEY		(discipline)				REFERENCES	Discipline(discipline_id),
	--CONSTRAINT - это название ограничения, FOREIGN KEY - какой тип ограничения, (discipline) - какое поле ограничиваем, REFERENCES Discipline(discipline_id) - и куда оно ссылается, на кукую таблицу и на какое поле
	CONSTRAINT		FK_DDR_Dependent		FOREIGN KEY		(dependent_discipline)		REFERENCES	Discipline(discipline_id)
);

--DROP TABLE DisciplinesDirectionsRelation,Discipline,Teacher,Directions;