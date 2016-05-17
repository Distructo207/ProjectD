--
-- Current Database: `projectSchool`
--

DROP DATABASE IF EXISTS projectSchool;
CREATE DATABASE projectSchool;
USE projectSchool;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS account;
CREATE TABLE account (
	username VARCHAR(50) NOT NULL,
	`type` enum('student', 'staff', 'admin') NOT NULL DEFAULT 'student',
	password VARCHAR(255) NOT NULL,
	CONSTRAINT pk_account PRIMARY KEY (username)
);

--
-- Dumping data into table `account`
--

LOCK TABLES account WRITE;
INSERT INTO account VALUES ('a','student','a'),('b','staff','b'),('c','admin','c'),('d','student','d');
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	staffID VARCHAR(16) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(200) NOT NULL,
	username VARCHAR(50) NOT NULL,
    CONSTRAINT pk_staff PRIMARY KEY (staffID),
	CONSTRAINT staff_ibfk_1 FOREIGN KEY (username) REFERENCES account(username) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT uc_username UNIQUE (username)
);

--
-- Dumping data into table `staff`
--

LOCK TABLES staff WRITE;
INSERT INTO staff VALUES ('1','Kanbei','Yellow','Commet','b'),('2','Bert','','Uil','c');
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher (
	teacherID VARCHAR(16) NOT NULL,
	CONSTRAINT pk_teacher PRIMARY KEY(teacherID),
	CONSTRAINT teacher_ibfk_1 FOREIGN KEY (teacherID) REFERENCES staff(staffID) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Dump data into table `teacher`
--

LOCK TABLES teacher WRITE;
INSERT INTO teacher VALUES ('1'),('2');
UNLOCK TABLES;

--
-- Table structure for table `sportsTutor`
--

DROP TABLE IF EXISTS sportsTutor;
CREATE TABLE sportsTutor (
	tutorID VARCHAR(16) NOT NULL,
	CONSTRAINT pk_sportsTutor PRIMARY KEY(tutorID),
	CONSTRAINT sportsTutor_ibfk_1 FOREIGN KEY (tutorID) REFERENCES staff(staffID) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Dump data into table `sportsTutor`
--

LOCK TABLES sportsTutor WRITE;
INSERT INTO sportsTutor VALUES ('1');
UNLOCK TABLES;

--
-- Table structure for table `academicTutor`
--

DROP TABLE IF EXISTS academicTutor;
CREATE TABLE academicTutor (
	tutorID VARCHAR(16) NOT NULL,
	CONSTRAINT pk_academictutor PRIMARY KEY(tutorID),
	CONSTRAINT academicTutor_ibfk_1 FOREIGN KEY (tutorID) REFERENCES staff(staffID) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Dump data into table `academicTutor`
--

LOCK TABLES academicTutor WRITE;
INSERT INTO academicTutor VALUES ('2');
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS subject;
CREATE TABLE subject (
	name VARCHAR(64) NOT NULL,
	description VARCHAR(255) DEFAULT 'Sorry, no description for this subject is available.',
	CONSTRAINT pk_subject PRIMARY KEY (name)
);

--
-- Dump data into table `subject`
--

LOCK TABLES subject WRITE;
INSERT INTO subject VALUES ('Mathematics','Really now, you don\'t know what mathematics means?');
INSERT INTO subject(name) VALUES ('Preaching to the Choir');
INSERT INTO subject VALUES ('','Let\'s see what happens.'),('Cultural Marxism','No, really, this is being taught to children in the US and UK.');
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
	groupID VARCHAR(16) NOT NULL,
    course VARCHAR(200) NOT NULL,
    year INTEGER NOT NULL,
    tutor VARCHAR(16) NOT NULL,
    CONSTRAINT pk_group PRIMARY KEY(groupID),
	CONSTRAINT group_ibfk_1 FOREIGN KEY (tutor) REFERENCES academicTutor(tutorID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT chk_group CHECK (year > 0 AND year < 7)
);

--
-- Dump data into table `group`
--

LOCK TABLES `group` WRITE;
INSERT INTO `group` VALUES ('1','HAVO/VWO',3,'2'),('2','HAVO',5,'2');
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS class;
CREATE TABLE class (
	`group` VARCHAR(16) NOT NULL,
	timeStart DATETIME NOT NULL,
	duration INTEGER NOT NULL DEFAULT 45,
    teacher VARCHAR(16) NOT NULL,
    subject VARCHAR(64) NOT NULL,
    CONSTRAINT pk_class PRIMARY KEY (`group`, timeStart),
	CONSTRAINT class_ibfk_1 FOREIGN KEY (`group`) REFERENCES `group`(groupID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT class_ibfk_2 FOREIGN KEY (teacher) REFERENCES teacher(teacherID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT class_ibfk_3 FOREIGN KEY (subject) REFERENCES subject(name) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Dump data into table `class`
--

LOCK TABLES class WRITE;
INSERT INTO class VALUES ('1',now(),45,'1','Preaching to the Choir'),('2',now(),50,'2','');
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS student;
CREATE TABLE student (
	studentID VARCHAR(16) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(200) NOT NULL,
    `group` VARCHAR(16) NOT NULL,
    tutor VARCHAR(16),
	username VARCHAR(50) NOT NULL,
    CONSTRAINT pk_student PRIMARY KEY(studentID),
	CONSTRAINT student_ibfk_1 FOREIGN KEY (`group`) REFERENCES `group`(groupID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT student_ibfk_2 FOREIGN KEY (tutor) REFERENCES sportsTutor(tutorID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT student_ibfk_3 FOREIGN KEY (username) REFERENCES account(username) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT uc_username UNIQUE (username)
);

--
-- Dump data into table `group`
--

LOCK TABLES student WRITE;
INSERT INTO student VALUES ('1','Marik','','Ishtar','1','1','a'),('2','Michael','Skitch','Schiciano','2',NULL,'d');
UNLOCK TABLES;
