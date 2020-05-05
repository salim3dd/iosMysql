<?php

include("config.php");

date_default_timezone_set("Asia/Muscat");
$RegDate = date("Y/m/d - h:i a");


$UserName = strip_tags(trim($_POST["UserName"]));
$Password = strip_tags(trim($_POST["PassWord"]));
$Email = strip_tags(trim($_POST["Email"]));
$eimg = strip_tags(trim($_POST["ImagCode_Avatar"]));



if ($UserName<>"" && $Password<>"" && $Email<>""){


$dateeCode=date("Ymdhi");
$randomletter = substr(str_shuffle("abcdefghijklmnopqrstuvwxyz"), 0, 5);
$milliseconds = round(microtime(true));
$User_key = "U".$randomletter.$dateeCode.$milliseconds;


$Avatar = $User_key.".jpg";
if ($eimg<>"") {   	
    	$img = str_replace('data:image/png;base64,', '', $eimg);
		$img = str_replace(' ', '+', $img);						
		$decodimg = base64_decode("$img");
		file_put_contents("Images/".$Avatar,$decodimg);
}

$newPass = md5($Password);

$sql_query = "INSERT INTO Users (UserName, Password, Email, RegDate, Avatar)VALUES('$UserName','$newPass','$Email','$RegDate','$Avatar')";
	$dbResult = $conn->query($sql_query);
	if ($dbResult === TRUE) {
		$check = "Reg_OK";  
		} else {
		 $check = "Error"; 
		}
}

echo json_encode(array("success"=>$check));

mysql_close($conn);

?>
