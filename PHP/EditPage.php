<?php

include("config.php");


$id = strip_tags(trim($_POST["id"]));
$UserName = strip_tags(trim($_POST["UserName"]));
$Email = strip_tags(trim($_POST["Email"]));


if ($id<>"" && $UserName<>""  && $Email<>""){

$sql_query = "UPDATE Users SET UserName='$UserName' , Email='$Email' WHERE id LIKE '$id'";
	$dbResult = $conn->query($sql_query);
	if ($dbResult === TRUE) {
		$check = "Update_OK";  
		} else {
		 $check = "Error"; 
		}
}

echo json_encode(array("success"=>$check));

mysql_close($conn);

?>
