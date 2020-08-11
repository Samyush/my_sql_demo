<?php


$servername= "localhost";
$username="root";
$password = "";
$dbname = "testdb";
$table = "Employees"; //lets create a table Employees

// we will get action from the app to do operations in the database
// $action = $_POST["action"];
$action = ( array_key_exists( 'action', $_REQUEST) ? $_REQUEST['action'] : "" );


// create new connection
$conn = new mysqli($servername, $username, $password, $dbname);

// check connection
// this below will also effect the response.body on flutter will come combined as success_good
if($conn){
    echo "success_";
}else{
    echo "failed";
}
if($conn->connect_error){
    die("connection failed". $conn->connect_error);
    return;
}

// if conn is ok


// if the app sends an aciton

if("CREATE_TABLE" == $action){
    $sql = "CREATE TABLE IF NOT EXISTS $table ( id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL)";

    if($conn->query($sql) === TRUE){
        // send back success message
        echo "good";

    }
    else{
        echo "error";

    }
    $conn->close();
    return;
}

// next action to get all employee records form the database
if("GET_ALL" == $action){
    $db_data = array();
    $sql = "SELECT id, first_name, last_name from $table ORDER BY id DESC";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;

        }

        // send back the complete records as a json
        echo json_encode($db_data);
    }
    else{
        echo"error";
    }
    $conn->close();
    return;
}


// Add an Emploee
if("ADD_EMP" == $action){
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $sql = "INSERT INTO $table(first_name, last_name) VALUES ('$first_name', '$last_name')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return; 
}

// update an Employee
if("UPDATE_EMP" == $action){
    // App will be posting these values to this server
   $emp_id = $_POST['$emp_id'];
   $first_name = $_POST["last_name"];
   $last_name = $_POST["last_name"];
   $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = '$emp_id' ";
   if($conn->query($sql) === TRUE){
       echo "success";
   }else{
       echo"error";
   }
   $conn->close();
   return;
}


// delete an employee
if('DELETE_EMP' === $action){
    $emp_id = $_POST['$emp_id'];
    $sql = "DELETE FROM $table where id = $emp_id";  //dont need quotes since id is an integer.
    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo"error";
    }
    $conn->close();
    return;
}

?>