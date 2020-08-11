<?php

$conn=new mysqli("localhost", "root", "testdb");
if($conn){
    echo "success";

}else{
    echo "fail";
}

?>