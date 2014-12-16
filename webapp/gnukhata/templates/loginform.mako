
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title> GNUKhata-Login </title>
	<script language="JavaScript">
	$(document).ready(function(){ 
		 $("#username").focus();
	});
	</script>
	<script language="JavaScript">
			function validatelogin(login)
			{
					if (login.username.value.length == 0)
					{
							alert("Please enter a User Name.")
							login.username.focus()
							return false
					}
		   
					if (login.password.value.length == 0)
					{
							alert("Please enter a Password.")
							login.password.focus()
							return false
					}
			}
	</script>

	
</head>
<body class="login" OnLoad="document.frmlogin.username.focus();">
<table width="90%">
<tr align="center">
<td>&nbsp;&nbsp;<h2> ${c.orgname} for financial year from ${c.financialYear_from} to ${c.financialYear_to} </h2></td>
<td><img style="width: 350px; height:100px;" alt="logo"src="/images/finallogo.png"></td>
</tr>
</table>
<pre>
<center><h2>Kindly Login to your Account</h2></center><hr width="90%"></pre>
<center>
<div id="login">

<fieldset id="login">
				<legend id="login"><optgroup label="GNUKhata"><b>GNUKhata</b></optgroup></legend>
<form id="frmlogin" name="frmlogin" method = "post" action=${h.url_for(controller='menubar',action='dbconnect')} onsubmit="return validatelogin(login)">
<p>
	<label id="user_login">Username<br />
		<input type="text" id="username" name="username" value="admin">
	</label>
</p>
<p>
	<label id="user_pass">Password<br />
		<input type="password" id="password" name="password" value="admin">
	</label>
</p>
	<input type="submit" value="Login" name="proceed" id="proceed" src="/images/button.png" aling="right">
</form>
</fieldset>
</div>
</center>
</form>
</body>
</html>
