CREATE TABLE ASubject (
	Aname VARCHAR(250) NOT NULL,
	description VARCHAR(250),
	CONSTRAINT pk_subject PRIMARY KEY (Aname)
);

CREATE TABLE AClass (
	groupID INTEGER NOT NULL,
	timeStart DATETIME NOT NULL,
	duration TIME NOT NULL,
    teacherID INTEGER NOT NULL,
    ASubject VARCHAR(250) NOT NULL,
    CONSTRAINT pk_class PRIMARY KEY (groupID, timeStart)
);

CREATE TABLE Staff (
	staffID INTEGER NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50),
    lastName VARCHAR(200) NOT NULL,
    admin BOOL NOT NULL,
    CONSTRAINT pk_staff PRIMARY KEY (staffID)
);

CREATE TABLE AGroup ( 
	groupID INTEGER NOT NULL,
    course VARCHAR(200) NOT NULL,
    AYear YEAR NOT NULL, 
    tutorID INTEGER NOT NULL,
    CONSTRAINT pk_group PRIMARY KEY(groupID)
);

CREATE TABLE Student (
	studentID INTEGER NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50),
    lastName VARCHAR(200) NOT NULL,
    groupID INTEGER NOT NULL,
    tutorID INTEGER NOT NULL,
    CONSTRAINT pk_student PRIMARY KEY(studentID)
);

CREATE TABLE Teacher (
	teacherID INTEGER NOT NULL,
	CONSTRAINT pk_teacher PRIMARY KEY(teacherID)
);

CREATE TABLE SportsTutor (
	tutorID INTEGER NOT NULL,
	CONSTRAINT pk_sportstutor PRIMARY KEY(tutorID)
);

CREATE TABLE AcademicTutor (
	tutorID INTEGER NOT NULL,
	CONSTRAINT pk_academictutor PRIMARY KEY(tutorID)
);

ALTER TABLE AClass 
ADD CONSTRAINT fk_AGroup_AClass
	FOREIGN KEY (groupID) REFERENCES AGroup (groupID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;
    
ALTER TABLE AClass 
ADD CONSTRAINT fk_Teacher_AClass
	FOREIGN KEY (teacherID) REFERENCES Teacher (teacherID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;

ALTER TABLE AClass 
ADD CONSTRAINT fk_ASubject_AClass
	FOREIGN KEY (ASubject) REFERENCES Asubject (Aname)
    ON UPDATE CASCADE
	ON DELETE CASCADE;

ALTER TABLE AGroup
ADD CONSTRAINT fk_AcademicTutor_AGroup
	FOREIGN KEY (tutorID) REFERENCES AcademicTutor (tutorID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;
    
ALTER TABLE Student
ADD CONSTRAINT fk_AGroup_Student
	FOREIGN KEY (groupID) REFERENCES AGroup (groupID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;

ALTER TABLE Student
ADD CONSTRAINT fk_SportsTutor_Student
	FOREIGN KEY (tutorID) REFERENCES SportsTutor (tutorID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;
    
ALTER TABLE Teacher
ADD CONSTRAINT fk_Staff_Teacher
	FOREIGN KEY (teacherID) REFERENCES Staff (staffID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;
    
ALTER TABLE SportsTutor
ADD CONSTRAINT fk_Staff_SportsTutor
	FOREIGN KEY (tutorID) REFERENCES Staff (staffID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;
    
ALTER TABLE AcademicTutor
ADD CONSTRAINT fk_Staff_AcademicTutor
	FOREIGN KEY (tutorID) REFERENCES Staff (staffID)
    ON UPDATE CASCADE
	ON DELETE CASCADE;