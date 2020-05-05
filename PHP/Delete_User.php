<?php

include("config.php");


$id = strip_tags(trim($_POST["id"]));

if ($id<>""){

$sql_query = "DELETE FROM Users WHERE id LIKE '$id'";
	$dbResult = $conn->query($sql_query);
	if ($dbResult === TRUE) {
		$check = "Delete_OK";  
		} else {
		 $check = "Error"; 
		}
}

echo json_encode(array("success"=>$check));

mysql_close($conn);

?>
