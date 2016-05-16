--
--Current Database: projectSchool
--

CREATE DATABASE projectSchool;
USE projectSchool;

--
--Table structure for table 'account'
--

DROP TABLE IF EXISTS account;
CREATE TABLE account {
	username VARCHAR(50) NOT NULL,
	'type' enum('student', 'staff', 'admin') NOT NULL DEFAULT 'student',
	password VARCHAR(255) NOT NULL,
	CONSTRAINT pk_account PRIMARY KEY (username)
}

--
--Table structure for table 'subject'
--

DROP TABLE IF EXISTS subject;
CREATE TABLE subject (
	name VARCHAR(50) NOT NULL,
	description VARCHAR(255) DEFAULT 'Sorry, no description for this subject is available.',
	CONSTRAINT pk_subject PRIMARY KEY (name)
);

--
--Table structure for table 'class'
--

DROP TABLE IF EXISTS class;
CREATE TABLE class (
	'group' INTEGER NOT NULL,
	timeStart DATETIME NOT NULL,
	duration TIME NOT NULL DEFAULT 45,
    teacher INTEGER NOT NULL,
    subject VARCHAR(50) NOT NULL,
    CONSTRAINT pk_class PRIMARY KEY (groupID, timeStart),
	CONSTRAINT class_ibfk_1 FOREIGN KEY ('group') REFERENCES 'group'(groupID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT class_ibfk_2 FOREIGN KEY (teacher) REFERENCES teacher(teacherID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT class_ibfk_3 FOREIGN KEY (subject) REFERENCES subject(name) ON UPDATE CASCADE ON DELETE CASCADE
);

--
--Table structure for table 'staff'
--

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	staffID INTEGER NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(200) NOT NULL,
	username VARCHAR(50) NOT NULL,
    CONSTRAINT pk_staff PRIMARY KEY (staffID),
	CONSTRAINT staff_ibfk_1 FOREIGN KEY (username) REFERENCES account(username) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Table structure for table 'group'
--

DROP TABLE IF EXISTS 'group';
CREATE TABLE 'group' (
	groupID INTEGER NOT NULL,
    course VARCHAR(200) NOT NULL,
    year YEAR NOT NULL,
    tutor INTEGER NOT NULL,
    CONSTRAINT pk_group PRIMARY KEY(groupID),
	CONSTRAINT group_ibfk_1 FOREIGN KEY (tutor) REFERENCES academicTutor(tutorID) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Table structure for table 'student'
--

DROP TABLE IF EXISTS student;
CREATE TABLE student (
	studentID INTEGER NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(200) NOT NULL,
    'group' INTEGER NOT NULL,
    tutor INTEGER,
	usename VARCHAR(50) NOT NULL,
    CONSTRAINT pk_student PRIMARY KEY(studentID),
	CONSTRAINT student_ibfk_1 FOREIGN KEY ('group') REFERENCES 'group'(groupID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT student_ibfk_2 FOREIGN KEY (tutor) REFERENCES sportsTutor(tutorID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT student_ibfk_3 FOREIGN KEY (username) REFERENCES account(username) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Table structure for table 'teacher'
--

DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher (
	teacherID INTEGER NOT NULL,
	CONSTRAINT pk_teacher PRIMARY KEY(teacherID),
	CONSTRAINT teacher_ibfk_1 FOREIGN KEY (teacherID) REFERENCES staff(staffID) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Table structure for table 'sportsTutor'
--

DROP TABLE IF EXISTS sportsTutor;
CREATE TABLE sportsTutor (
	tutorID INTEGER NOT NULL,
	CONSTRAINT pk_sportsTutor PRIMARY KEY(tutorID),
	CONSTRAINT sportsTutor_ibfk_1 FOREIGN KEY (tutorID) REFERENCES staff(staffID) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Table structure for table 'academicTutor'
--

DROP TABLE IF EXISTS academicTutor;
CREATE TABLE academicTutor (
	tutorID INTEGER NOT NULL,
	CONSTRAINT pk_academictutor PRIMARY KEY(tutorID),
	CONSTRAINT academicTutor_ibfk_1 FOREIGN KEY (tutorID) REFERENCES staff(staffID) ON UPDATE CASCADE ON DELETE CASCADE
);
