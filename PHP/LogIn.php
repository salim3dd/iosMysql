<?php 
include("config.php");


$UserName = strip_tags(trim($_POST["UserName"]));
$PassWord = strip_tags(trim($_POST["PassWord"]));


$check = "";

if ($UserName <> "" && $PassWord <> "")
    {
	        
$md5Pass = md5($PassWord); 

$sql_UsersLogIn = "SELECT * FROM Users WHERE UserName LIKE '$UserName' AND Password LIKE '$md5Pass' LIMIT 1";
	
	$uLogInCheck = $conn->query($sql_UsersLogIn);    
    if ($uLogInCheck->num_rows > 0) {    
            
            while($rowLogIn = $uLogInCheck->fetch_assoc()) {			 
                 $user_name = $rowLogIn['UserName'];
                 $user_pass = $rowLogIn['Password']; 
                
                if ($user_name === $UserName && $user_pass === $md5Pass){                   
                    $check = "LogIn_OK"; 
                }else{
                $check = "LogIn_Error";
                }
	           	           
            }
            
	    }else{
	    $check = "LogIn_Error"; 
	    }

}
    
    echo json_encode(array("success"=>$check));  
        
mysql_close($conn);
?> 
