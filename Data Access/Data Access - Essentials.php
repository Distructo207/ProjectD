<?php
function checkResult(mysqli $database,mysqli_result $result) {
    return !$result ? "Query failed: " . $database->connect_error : $result;
}

function getDatabase($username,$password) {
    $mysqli = new mysqli('localhost',$username,$password,'projectschool');

    if ($mysqli->connect_errno) {
        return "Connection error: ".$mysqli->connect_error;
    } else if ($mysqli->autocommit(false)) {
        return $mysqli;
    } else {
        return "Failed to turn off autocommit.";
    }
}
