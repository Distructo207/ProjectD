<?php
function getAllStudents(mysqli $database) {
    $result = $database->query("SELECT stu.studentid, stu.firstname as stfina, stu.middlename as stmina,
                                       stu.lastname as stfina, stu.allowed, stu.tutor as sportstutor, g.course, g.year
                                FROM student stu INNER JOIN `group` g ON stu.group = g.groupid;");

    return checkResult($database,$result);
}

function getClasses(mysqli $database,$studentId) {
    $studentId = $database->real_escape_string($studentId);

    $result = $database->query("SELECT c.timestart,c.duration,c.subject,sub.description,
                                       s.firstname as teacherfirstname, s.middlename as teachermiddlename,
                                       s.lastname as teacherlastname FROM student
                                INNER JOIN `group` ON student.`group` = `group`.groupID
                                INNER JOIN class c ON `group`.groupID = c.`group`
                                INNER JOIN staff s ON c.teacher = s.staffID
                                INNER JOIN subject sub ON c.subject = sub.name
                                WHERE student.studentID = '$studentId';");

    return checkResult($database,$result);
}

function getStudentIdFromUsername(mysqli $database,$username) {
    $username = $database->real_escape_string($username);

    $result = $database->query("SELECT * FROM student s INNER JOIN account ON s.username = account.username
                                WHERE s.username = '$username';");

    return checkResult($database,$result);
}

function getStaffIdFromUsername(mysqli $database,$username) {
    $username = $database->real_escape_string($username);

    $result = $database->query("SELECT * FROM staff s INNER JOIN account ON s.username = account.username
                                WHERE s.username = '$username';");

    return checkResult($database,$result);
}

/**
 * Get all the students under the care of a sports tutor.
 *
 * @param mysqli $database - The database.
 * @param $tutorId - ID of the sports tutor you want to know the students of.
 * @return mysqli_result|string - The result, otherwise an error string.
 */
function getStudentsOfSportsTutor(mysqli $database,$tutorId) {
    $tutorId = $database->real_escape_string($tutorId);

    $result = $database->query("SELECT s.studentid, s.firstname, s.middlename, s.lastname, s.allowed, g.groupid
                                FROM student s INNER JOIN sportstutor t ON t.tutorID = s.tutor
                                INNER JOIN `group` g ON s.`group` = g.groupID
                                WHERE t.tutorID = '$tutorId';");

    return checkResult($database,$result);
}

/**
 * Get all the students under the care of an academic tutor.
 *
 * @param mysqli $database - The database.
 * @param $tutorId - ID of the academic tutor you want to know the students of.
 * @return mysqli_result|string - The result, otherwise an error string.
 */
function getStudentsOfAcademicTutor(mysqli $database,$tutorId) {
    $tutorId = $database->real_escape_string($tutorId);

    $result = $database->query("SELECT s.studentid, s.firstname, s.middlename, s.lastname, s.allowed, g.groupid
                                FROM student s INNER JOIN `group` g ON s.`group` = g.groupID
                                INNER JOIN academictutor ON g.tutor = academictutor.tutorID
                                WHERE academictutor.tutorID = '$tutorId';");

    return checkResult($database,$result);
}
