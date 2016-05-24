<?php
/**
 * Generated a random ID of 16 unique characters.
 *
 * @return string Random string of 16 unique characters.
 */
function generateID() {
    return substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 16);
}

/**
 * Add a subject to the DB.
 *
 * @param mysqli $database - The database.
 * @param $name - Name of the subject to be added.
 * @param $desc - Description of the subject to be added.
 * @return bool - Whether or not the subject was correctly added.
 */
function addSubject(mysqli $database,$name,$desc) {
    //Check types of the variables to be added to DB.
    if (gettype($name) !== 'string' || $name === '') return false;
    if (gettype($desc) !== 'string' || $desc !== null) return false;

    //Escape all strings to be added to the DB.
    $name = $database->real_escape_string($name);
    $desc = $database->real_escape_string($desc);

    //Define and run checkQuery to see if this subject's name is already in DB.
    $checkQuery = "SELECT count(name) FROM subject WHERE name = '$name';";
    $result = $database->query($checkQuery);
    if (!checkResult($database, $result) || $result->fetch_assoc()['`name`'] > 0) return false;

    $query = "INSERT INTO subject VALUES($name, $desc)";

    $database->begin_transaction();

    //Run query and check for errors.
    if ($database->query($query)) {

        //Run checkQuery and check if subject was correctly added to DB.
        $result = $database->query($checkQuery);
        if (checkResult($database, $result) && $result->fetch_assoc()['`name`'] === 1) {
            $database->commit();
            return true;
        }
    }
    $database->rollback();
    return false;
}

/**
 * Add a student to the DB.
 *
 * @param mysqli $database - The database.
 * @param $username - Username of the student to be added.
 * @param $password - Password of the student to be added.
 * @param $firstName - First name of the student to be added.
 * @param $lastName - Last name of the student to be added
 * @param $group - ID of the group this student should be added to.
 * @param $allowed - Whether the student to be added is allowed to use the app or not.
 * @param $middleName - Middle name of the student to be added.
 * @param $tutor - Sports tutor of the student to be added.
 * @return bool - Whether adding this student was successful or not.
 */
function addStudent(mysqli $database,$username,$password,$firstName,$lastName,$group,$allowed,$middleName,$tutor) {
    //Check for correct types of variables to be put in queries.
    if (gettype($username) !== 'string' || $username === '') return false;
    if (gettype($password) !== 'string' || $password === '') return false;
    if (gettype($firstName) !== 'string' || $firstName === '') return false;
    if (gettype($middleName) !== 'string' && $middleName !== null) return false;
    if (gettype($lastName) !== 'string' || $lastName === '') return false;
    if (gettype($group) !== 'string' || $group === '') return false;
    if (gettype($allowed) !== 'boolean' && $allowed !== null) return false;
    if (gettype($tutor) !== 'string' && $tutor !== null) return false;

    //Escape all strings to be put in queries.
    $username = $database->real_escape_string($username);
    $password = $database->real_escape_string($password);
    if ($middleName !== null) $middleName = $database->real_escape_string($middleName);
    $lastName = $database->real_escape_string($lastName);
    $group = $database->real_escape_string($group);
    if ($tutor !== null) $tutor = $database->real_escape_string($tutor);

    //Define query and checkQuery for creating an account in DB.
    $query = "INSERT INTO account VALUES ($username, $password, NULL);";
    $checkQuery = "SELECT count(username) FROM account WHERE username = '$username';";

    $database->begin_transaction();

    //Put account in DB and check for errors.
    if (!$database->query($query)) {
        $database->rollback();
        return false;
    }

    //Run checkQuery and see if account was properly added to DB.
    $result = $database->query($checkQuery);
    if (!checkResult($database, $result) || !($result->fetch_assoc()['`count(username)`'] === 1)) {
        $database->rollback();
        return false;
    }

    //Generate studentID, and make sure it's not already associated with another student.
    do {
        $id = $database->real_escape_string(generateID());
        $result = $database->query("SELECT count(studentID) FROM student WHERE studentID = '$id'");
    } while ($result->fetch_assoc()['`count(studentID)`'] > 0);

    //Define query and checkQuery for adding student to DB.
    $query = "INSERT INTO student VALUES ($id, $firstName, $middleName, $lastName, $allowed, $group, $tutor, $username)";
    $checkQuery = "SELECT count(studentID) FROM student WHERE studentID = '$id'";

    //Add student to DB and check for errors.
    if (!$database->query($query)) {
        $database->rollback();
        return false;
    }

    //Run checkQuery and see if student was properly added to DB.
    $result = $database->query($checkQuery);
    if (!checkResult($database, $result) || !($result->fetch_assoc()['`count(studentID)`'] === 1)) {
        $database->rollback();
        return false;
    }

    $database->commit();
    return true;
}
